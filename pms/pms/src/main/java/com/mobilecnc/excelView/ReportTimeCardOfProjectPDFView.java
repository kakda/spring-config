package com.mobilecnc.excelView;

import java.awt.Color;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
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
import com.lowagie.text.HeaderFooter;
import com.lowagie.text.Image;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import com.mobilecnc.timeCards.EntryParameter;
import com.mobilecnc.timeCards.ReportOfProject;
import com.mobilecnc.timeCards.TimeCardDetail;

public class ReportTimeCardOfProjectPDFView extends AbstractPdfView  {

	@Override
	protected void buildPdfDocument(Map<String, Object> map, Document document,
			PdfWriter pdfWriter, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// TODO Auto-generated method stub
//		PdfHelper helper = new PdfHelper();
		@SuppressWarnings({ "unchecked", "unused" })		
		List<ReportOfProject> list =	(List<ReportOfProject>) map.get("reportTimeCardOfProjectList");
		
		LinkedHashMap<String, List<ReportOfProject>> submap = new LinkedHashMap<String, List<ReportOfProject>>();
		for (ReportOfProject LinkMap : list) {
			String key = LinkMap.getEmployeeName();
			if(submap.get(key) == null){
				submap.put(key, new ArrayList<ReportOfProject>());
			}
			submap.get(key).add(LinkMap);
		}
		String projectID=(String) map.get("projectID");		
		String projectName=list.get(0).getProjectName();
		
		@SuppressWarnings("unused")
		String projectType= list.get(0).getProjectTypeName();
		Float totalHour =(float) 0.00;
		for(int i=0; i<list.size();i++){			
			totalHour = totalHour+list.get(i).getWorkingHour();			
		}
		       		
		Font titleFont = FontFactory.getFont("Arial", 18, Font.BOLD);
		Font headerFont = FontFactory.getFont("Arial",12,Font.BOLD);
		Paragraph title = new Paragraph("Time Card of Project Report",titleFont); 
		title.setAlignment(Element.ALIGN_CENTER); 
		
		Paragraph projectid = new Paragraph("Project ID: " +projectID);
		Paragraph projectname = new Paragraph("Project Name: " +projectName);
		Paragraph projecttype = new Paragraph("Project Type: " +projectType);
		Paragraph totalhour = new Paragraph("Total Hour: " +totalHour);
	    
		PdfStyleHelper.setHeader(request, document, pdfWriter);
		PdfStyleHelper.setFooter(document, pdfWriter);
		document.open();
		document.add(title);
		document.add(projectid);
		document.add(projectname);
		document.add(projecttype);
		document.add(totalhour);
		document.add(Chunk.NEWLINE);
	  
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		
		 
		for(Map.Entry<String, List<ReportOfProject>> entry : submap.entrySet()){
			Paragraph employee = new Paragraph("Employee: "+entry.getKey(),headerFont);
			document.add(employee);
			document.add(new Paragraph(" "));
			PdfPTable table1 = new PdfPTable(3);
			table1.setWidths(new int[]{50, 50, 50});
			table1.setWidthPercentage(100);
			table1.addCell(new PdfPCell( new Phrase("TimeCard ID",headerFont)));		
			table1.addCell(new PdfPCell( new Phrase("Date",headerFont)));
			table1.addCell(new PdfPCell(new Phrase("Working (Hour)",headerFont)));
			List<ReportOfProject> listEmployee = entry.getValue();
			float sumHours = 0;
			for(int i = 0; i<listEmployee.size();i++){
				table1.addCell(new PdfPCell( new Phrase(listEmployee.get(i).getTimeCardID())));
				table1.addCell(new PdfPCell( new Phrase(df.format(listEmployee.get(i).gettDate()))));
				table1.addCell(new PdfPCell( new Phrase(Float.toString(listEmployee.get(i).getWorkingHour()))));
				sumHours = sumHours+listEmployee.get(i).getWorkingHour();				
			}
			PdfPCell cell = new PdfPCell( new Phrase("SUM: "));
			cell.setColspan(2);
			cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
			cell.setPaddingRight(10);
			table1.addCell(cell);
			table1.addCell(new PdfPCell( new Phrase(Float.toString(sumHours))));
			document.add(table1);
			document.add(Chunk.NEWLINE);
		}
		document.close();
		
	}



}
