package com.mobilecnc.excelView;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.taglibs.standard.lang.jstl.IntegerLiteral;
import org.springframework.web.servlet.view.document.AbstractPdfView;

import com.lowagie.text.Chunk;
import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.FontFactory;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import com.mobilecnc.projects.service.ProjectVO;

public class ReportProjectPDFView extends AbstractPdfView  {
	@Override
	protected void buildPdfDocument(Map<String, Object> map, Document document,
			PdfWriter pdfWriter, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// TODO Auto-generated method stub
		@SuppressWarnings("unchecked")
		List<ProjectVO> list = (List<ProjectVO>) map.get("projectList");
		Font titleFont = FontFactory.getFont("Arial", 18, Font.BOLD);
		Font headerFont = FontFactory.getFont("Arial",12,Font.BOLD);
		Paragraph title = new Paragraph("Project Report",titleFont); 
		title.setAlignment(Element.ALIGN_CENTER); 
		
		//Paragraph space = new Paragraph("");
		document.setPageSize(PageSize.A4.rotate());
		PdfStyleHelper.setHeader(request, document, pdfWriter);
		PdfStyleHelper.setFooter(document, pdfWriter);
		document.open();
		document.add(title);
		//document.add(space);
		document.add(Chunk.NEWLINE);
	  
		DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
		PdfPTable table = new PdfPTable(10);
		table.setWidths(new int[]{15,50,50,50,50,30,40,40,40,40});
		table.setWidthPercentage(100);
		table.addCell(new PdfPCell( new Phrase("No",headerFont)));
		table.addCell(new PdfPCell( new Phrase("Project",headerFont)));
		table.addCell(new PdfPCell( new Phrase("Type",headerFont)));
		table.addCell(new PdfPCell( new Phrase("PM",headerFont)));
		table.addCell(new PdfPCell( new Phrase("Customer",headerFont)));
		table.addCell(new PdfPCell( new Phrase("Men Month",headerFont)));
		table.addCell(new PdfPCell( new Phrase("Actual Start",headerFont)));
		table.addCell(new PdfPCell( new Phrase("Actual End",headerFont)));
		table.addCell(new PdfPCell( new Phrase("Planned Start",headerFont)));
		table.addCell(new PdfPCell( new Phrase("Planned End",headerFont)));
		int i = 1;
		for(ProjectVO listProject : list){
			table.addCell(new PdfPCell( new Phrase(Integer.toString(i))));
			table.addCell(new PdfPCell( new Phrase(listProject.getProjectName())));
			table.addCell(new PdfPCell( new Phrase(listProject.getProjectTypeName())));
			table.addCell(new PdfPCell( new Phrase(listProject.getEmployeeName())));
			table.addCell(new PdfPCell( new Phrase(listProject.getCustomerName())));
			table.addCell(new PdfPCell( new Phrase(Integer.toString(listProject.getActualMM()))));
			table.addCell(new PdfPCell( new Phrase(listProject.getActualStartDate()==null?"":df.format(listProject.getActualStartDate()))));
			table.addCell(new PdfPCell( new Phrase(listProject.getActualEndDate()==null?"":df.format(listProject.getActualEndDate()))));
			table.addCell(new PdfPCell( new Phrase(listProject.getPlannedStartDate()==null?"":df.format(listProject.getPlannedStartDate()))));
			table.addCell(new PdfPCell( new Phrase(listProject.getPlannedEndDate()==null?"":df.format(listProject.getPlannedEndDate()))));
			i++;
		}
		document.add(table);
		document.close();
	}
}
