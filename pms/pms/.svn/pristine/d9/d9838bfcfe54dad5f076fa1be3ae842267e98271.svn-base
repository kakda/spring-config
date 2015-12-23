package com.mobilecnc.excelView;

import java.awt.Color;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import com.mobilecnc.timeCards.TimeCardDetail;

public class ReportTimeCardDetailPDF extends AbstractPdfView  {

	@Override
	protected void buildPdfDocument(Map<String, Object> map, Document document,
			PdfWriter pdfWriter, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// TODO Auto-generated method stub
		@SuppressWarnings({ "unchecked", "unused" })
		List<TimeCardDetail> list = (List<TimeCardDetail>) map.get("timeCardsDetailList");
		
		@SuppressWarnings("unused")
		EntryParameter entryParameter = (EntryParameter) map.get("entryParameter");
		       		
		Font titleFont = FontFactory.getFont("Arial", 18, Font.BOLD);
		Font headerFont = FontFactory.getFont("Arial",12,Font.BOLD);
		Paragraph title = new Paragraph("Time Card Report",titleFont); 
		title.setAlignment(Element.ALIGN_CENTER); 
		
		Paragraph year = new Paragraph("Year: " + Float.toString(entryParameter.getYear()).substring(0,Float.toString(entryParameter.getYear()).indexOf('.')) );
		
		year.setAlignment(Element.ALIGN_LEFT);
		
		Paragraph month = new Paragraph("Month: " +  Float.toString(entryParameter.getMinMonth()).substring(0, Float.toString(entryParameter.getMinMonth()).indexOf('.'))  +" To: " + Float.toString( entryParameter.getMaxMonth()).substring(0,Float.toString(entryParameter.getMaxMonth()).indexOf('.')));
	    month.setAlignment(Element.ALIGN_LEFT);
	    
	    
	    PdfPTable table = new PdfPTable(6);
		table.setWidths(new int[]{55, 85, 50, 70,50,50});
		table.setWidthPercentage(100);
		table.addCell(new PdfPCell( new Phrase("ProjectCode",headerFont)));
		table.addCell(new PdfPCell( new Phrase("ProjectName",headerFont)));
		table.addCell(new PdfPCell( new Phrase("TeamName",headerFont)));
		table.addCell(new PdfPCell(new Phrase("EmployeeName",headerFont)));
		table.addCell(new PdfPCell( new Phrase("Date",headerFont)));
		table.addCell(new PdfPCell(new Phrase("Work-Hour",headerFont)));
		DateFormat df = new SimpleDateFormat("yyyy/MM/dd");
		for(int i=1;i<=list.size();i++){
			TimeCardDetail timecard = list.get(i-1);
			PdfPCell cellProjectCode = new PdfPCell(new Phrase(timecard.getProjectCode()));
			PdfPCell cellProjectName = new PdfPCell(new Phrase(timecard.getProjectName()));
			PdfPCell cellTeamName = new PdfPCell(new Phrase(timecard.getTeamName()==null?" ": timecard.getTeamName()));
			PdfPCell cellDate = new PdfPCell(new Phrase(df.format(timecard.gettDate())));
			PdfPCell cellEmployeeName = new PdfPCell(new Phrase(timecard.getEmployeeName()));
			PdfPCell cellWorkHour = new PdfPCell(new Phrase(Float.toString(timecard.getWorkingHour()) ));
			if(i % 2 ==0){
					cellDate.setBackgroundColor(new Color(230,218,195));
					cellEmployeeName.setBackgroundColor(new Color(230,218,195));
					cellProjectCode.setBackgroundColor(new Color(230,218,195));
					cellWorkHour.setBackgroundColor(new Color(230,218,195));
					cellTeamName.setBackgroundColor(new Color(230,218,195));
					cellProjectName.setBackgroundColor(new Color(230,218,195));
			}
			cellWorkHour.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(cellProjectCode);
			table.addCell(cellProjectName);
			table.addCell(cellTeamName);
			table.addCell(cellEmployeeName);
			table.addCell(cellDate);
			table.addCell(cellWorkHour);
		}
		PdfStyleHelper.setHeader(request, document, pdfWriter);
		PdfStyleHelper.setFooter(document, pdfWriter);
		document.open();
		document.add(title);
		document.add(year);
		document.add(month);
		document.add(Chunk.NEWLINE);
		document.add(table);
		document.close();
		
	}



}
