package com.mobilecnc.excelView;

import java.awt.Color;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.document.AbstractPdfView;

import com.lowagie.text.Chunk;
import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.FontFactory;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import com.mobilecnc.timeCards.EntryParameter;
import com.mobilecnc.timeCards.ReportOfProject;
import com.mobilecnc.timeCards.ReportOfProjectGrid;

public class ReportTimeCardByBillablePDF extends AbstractPdfView{

	@Override
	protected void buildPdfDocument(Map<String, Object> map, Document document,
			PdfWriter pdfWriter, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// TODO Auto-generated method stub
		
		@SuppressWarnings("unused")
		ReportOfProjectGrid report = (ReportOfProjectGrid) map.get("timeCardByBillableList");
		
		@SuppressWarnings("unused")
		EntryParameter entryParameter = (EntryParameter) map.get("entryParameter");
		
		List<ReportOfProject> reportList = report.getRows();
		HashMap<String,List<ReportOfProject>> mapReport = new HashMap<String,List<ReportOfProject>>();
		
		DateFormat df = new SimpleDateFormat("yyyy/MM/dd");
		float totalhour = 0;
		
		for (int i=0 ; i<reportList.size();i++){
			ReportOfProject item = reportList.get(i);
			totalhour += item.getWorkingHour();
			if(mapReport.get(item.getProjectID())== null){
				mapReport.put(item.getProjectID(), new ArrayList<ReportOfProject>());
			}
			mapReport.get(item.getProjectID()).add(item);
		}
		
		
		Font titleFont = FontFactory.getFont("Arial", 18, Font.BOLD);
		Font headerFont = FontFactory.getFont("Arial",12,Font.BOLD);
		Paragraph title = new Paragraph("TimeCard By Billable Report",titleFont); 
		title.setAlignment(Element.ALIGN_CENTER); 
		
		
		Paragraph reportDate = new Paragraph("StartDate: "+ df.format(entryParameter.getStartDate())+ "    EndDate: "+ df.format(entryParameter.getEndDate()));
		Paragraph basicReportInfor = new Paragraph("Status: " + (entryParameter.isBillable()== true ?"Billable":"Not Billable" ) + "       Total Hour: "+ totalhour);
		reportDate.setFont(headerFont);
		basicReportInfor.setFont(headerFont);
		
		PdfStyleHelper.setHeader(request, document, pdfWriter);
		PdfStyleHelper.setFooter(document, pdfWriter);
		document.open();
		document.add(title);	
		document.add(Chunk.NEWLINE);
		document.add(reportDate);
		document.add(basicReportInfor);
		document.add(Chunk.NEWLINE);
		
		
		
		for(String key : mapReport.keySet()){
			List<ReportOfProject> itemList = mapReport.get(key);
			
			PdfPTable table = new PdfPTable(4);
			table.setWidths(new int[]{45, 40, 40,50});
			table.setWidthPercentage(100);
			table.setHorizontalAlignment(Element.ALIGN_CENTER);
			if(itemList.size()>0){
				ReportOfProject itemTitle = itemList.get(0);
				PdfPCell projectIDTitle = new PdfPCell(new Phrase("ProjectID",headerFont));
				PdfPCell projectID = new PdfPCell(new Phrase(itemTitle.getProjectID(),headerFont));
				PdfPCell projectName = new PdfPCell(new Phrase(itemTitle.getProjectName(),headerFont));
				PdfPCell projectNameTitle = new PdfPCell(new Phrase("ProjectName ",headerFont));
				projectIDTitle.setBackgroundColor(new Color(237,236,236));
				projectID.setBackgroundColor(new Color(237,236,236));
				projectName.setBackgroundColor(new Color(237,236,236));
				projectNameTitle.setBackgroundColor(new Color(237,236,236));
				
				
				table.addCell(projectIDTitle);
				table.addCell(projectID);
				table.addCell(projectNameTitle);
				table.addCell(projectName);
				document.add(table);
				Paragraph blank = new Paragraph(" ");
				document.add(blank);
//				document.add(Chunk.NEWLINE);
				
				PdfPTable tableData = new PdfPTable(2);
				tableData.setWidths(new int[]{30,30});
				tableData.setWidthPercentage(50);
				tableData.setHorizontalAlignment(Element.ALIGN_CENTER);
				
				PdfPCell date = new PdfPCell(new Phrase("Date",headerFont));
				PdfPCell hour = new PdfPCell(new Phrase("Hour",headerFont));
				
				tableData.addCell(date);
				tableData.addCell(hour);
				
				float totaleachProject=0;
				for(int i=0;i<itemList.size();i++){
						ReportOfProject itemData = itemList.get(i);
						PdfPCell dateData = new PdfPCell(new Phrase(df.format(itemData.gettDate())));
						PdfPCell workHourData = new PdfPCell(new Phrase(Float.toString(itemData.getWorkingHour())));
						
						if(i % 2 !=0){
							dateData.setBackgroundColor(new Color(237,236,236));
							workHourData.setBackgroundColor(new Color(237,236,236));
						}
						
						tableData.addCell(dateData);
						tableData.addCell(workHourData);
						totaleachProject += itemData.getWorkingHour();
						
				}
				
				tableData.addCell(new PdfPCell(new Phrase("Total:",headerFont)));
				tableData.addCell(new PdfPCell(new Phrase(Float.toString(totaleachProject))));
				
				document.add(tableData);
				document.add(Chunk.NEWLINE);
			}
		}
		
	
//	document.add(table);
	document.close();	
		
		
		
	}

}
