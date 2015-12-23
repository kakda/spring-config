package com.mobilecnc.excelView;

import java.awt.Color;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import com.mobilecnc.employees.Employee;
import com.mobilecnc.employees.SearchEmployeeExcel;
import com.mobilecnc.employees.service.EmployeeVO;

public class ReportEmployeePDFView extends AbstractPdfView{

	@Override
	protected void buildPdfDocument(Map<String, Object> map,
			Document document, PdfWriter pdfWriter,
			HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		@SuppressWarnings({ "unused", "unchecked" })
		List<EmployeeVO> employeeList = (List<EmployeeVO>) map.get("EmployeeList");
		
		@SuppressWarnings("unused")
		SearchEmployeeExcel searchParam = (SearchEmployeeExcel) map.get("searchEmployee");
		
		
		Font titleFont = FontFactory.getFont("Arial", 18, Font.BOLD);
		Font headerFont = FontFactory.getFont("Arial",12,Font.BOLD);
		Paragraph title = new Paragraph("Human Resource Report",titleFont); 
		title.setAlignment(Element.ALIGN_CENTER); 
		
		Paragraph project = new Paragraph("Project: "+ (searchParam.getProjectName()==null?"ALL":searchParam.getProjectName()),headerFont);
		Paragraph year = new Paragraph("Year: "+ (searchParam.getYear()==null?"ALL":searchParam.getYear()),headerFont);
		Paragraph skill = new Paragraph("Skill: "+ (searchParam.getSkillName()==null?"ALL":searchParam.getSkillName()),headerFont);
	
		PdfPTable table = new PdfPTable(10);
		table.setWidths(new int[]{15,60,55,40,25,70,50,50,40,40});
		table.setWidthPercentage(100);
		table.setHorizontalAlignment(Element.ALIGN_CENTER);
		
		String header[] = new String[]{"No","Employee Name","Company Name","Title","Grade","Email","Mobile Phone","Skills","Join Date","Quit Date"};
		List<PdfPCell> rowHeader = PdfStyleHelper.setRowHeader(header, headerFont);
		
		for(PdfPCell cell : rowHeader){
			table.addCell(cell);
		}
		
		int i=1;
		for(Employee employee : employeeList){
			setBody(table, employee, i);
			i++;
		}
		
		document.setPageSize(PageSize.A4.rotate());
		PdfStyleHelper.setHeader(request, document, pdfWriter);
		PdfStyleHelper.setFooter(document, pdfWriter);
		document.open();
		document.add(title);
		document.add(project);
		document.add(year);
		document.add(skill);
		document.add(Chunk.NEWLINE);
		document.add(table);
		document.close();
		
	}
	
	
	
	private void setBody(PdfPTable table,Employee employee,int row){
		DateFormat df = new SimpleDateFormat("yyyy/MM/dd");
		table.addCell(new PdfPCell(new Phrase(Integer.toString(row))));
		table.addCell(new PdfPCell(new Phrase(employee.getEmployeeName()==null?"":employee.getEmployeeName())));
		table.addCell(new PdfPCell(new Phrase(employee.getCompanyName()==null?"":employee.getCompanyName())));
		table.addCell(new PdfPCell(new Phrase(employee.getTitleName()==null?"":employee.getTitleName())));
		table.addCell(new PdfPCell(new Phrase(employee.getGrade()==null?"":employee.getGrade())));
		table.addCell(new PdfPCell(new Phrase(employee.getEmail()==null?"":employee.getEmail())));
		table.addCell(new PdfPCell(new Phrase(employee.getMobilePhone()==null?"":employee.getMobilePhone())));
		table.addCell(new PdfPCell(new Phrase(employee.getSkillNames()==null?"":employee.getSkillNames())));
		table.addCell(new PdfPCell(new Phrase(employee.getJoinDate()==null?"":df.format(employee.getJoinDate()))));
		table.addCell(new PdfPCell(new Phrase(employee.getQuitDate()==null?"":df.format(employee.getQuitDate()))));
		
	}
}
