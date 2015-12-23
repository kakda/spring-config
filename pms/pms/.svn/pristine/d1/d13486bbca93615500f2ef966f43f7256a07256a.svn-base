package com.mobilecnc.excelView;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import com.mobilecnc.employees.Employee;
import com.mobilecnc.employees.SearchEmployeeExcel;
import com.mobilecnc.employees.service.EmployeeVO;

public class ReportEmployeeExcelView extends AbstractExcelView{

	@Override
	protected void buildExcelDocument(Map<String, Object> map,
			HSSFWorkbook workbook, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// TODO Auto-generated method stub
		DateFormat df = new SimpleDateFormat("yyyy/MM/dd");
		@SuppressWarnings("unchecked")
		List<EmployeeVO> employeeList = (List<EmployeeVO>) map.get("EmployeeList");
		@SuppressWarnings("unused")
		SearchEmployeeExcel searchEmployeeExcel = (SearchEmployeeExcel) map.get("searchEmployeeExcel");
		
		
		HSSFSheet sheet = workbook.createSheet();
		setHeader(sheet, workbook, searchEmployeeExcel);
		setBody(sheet,workbook,employeeList);
		ExcelStyleHelper.autoColumnWidth(sheet, 10);
		
		response.setHeader("Content-Disposition","attachment; filename=\"HR_Report_"+ df.format(new Date()) +".xls\"");
		
	}
	
	private void setHeader(HSSFSheet sheet,HSSFWorkbook workbook,SearchEmployeeExcel searchEmployeeExcel){
		HSSFRow row = sheet.createRow(0);
		row.createCell(0).setCellValue("Human Resource Report");
		sheet.addMergedRegion(new CellRangeAddress(0,0,0,9));
		ExcelStyleHelper.setStyleHeader(sheet, workbook, row, "reportName");
		
		HSSFRow searchRowProject = sheet.createRow(1);
		searchRowProject.createCell(0).setCellValue("Project: ");
		searchRowProject.createCell(1).setCellValue(searchEmployeeExcel.getProjectName()==null?"ALL":searchEmployeeExcel.getProjectName());
		ExcelStyleHelper.setStyleHeader(sheet, workbook, searchRowProject, "header");
		
		HSSFRow searchRowYear = sheet.createRow(2);
		searchRowYear.createCell(0).setCellValue("Year: ");
		searchRowYear.createCell(1).setCellValue(searchEmployeeExcel.getYear()==null?"ALL":searchEmployeeExcel.getYear());
		ExcelStyleHelper.setStyleHeader(sheet, workbook, searchRowYear, "header");
		
		HSSFRow searchRowSkill = sheet.createRow(3);
		searchRowSkill.createCell(0).setCellValue("Skills: ");
		searchRowSkill.createCell(1).setCellValue(searchEmployeeExcel.getSkillName()==null?"ALL":searchEmployeeExcel.getSkillName());
		sheet.addMergedRegion(new CellRangeAddress(3,3,1,3));
		ExcelStyleHelper.setStyleHeader(sheet, workbook, searchRowSkill, "header");
		
		HSSFRow header = sheet.createRow(4);
		header.createCell(0).setCellValue("No");
		header.createCell(1).setCellValue("Employee Name");
		header.createCell(2).setCellValue("Company Name");
		header.createCell(3).setCellValue("Title");
		header.createCell(4).setCellValue("Grade");
		header.createCell(5).setCellValue("Email");
		header.createCell(6).setCellValue("Mobile Phone");
		header.createCell(7).setCellValue("Skills");
		header.createCell(8).setCellValue("Join Date");
		header.createCell(9).setCellValue("Quit Date");
		ExcelStyleHelper.setStyleHeader(sheet, workbook, header, "header");
		
		
	}
	
	private void setBody(HSSFSheet sheet , HSSFWorkbook workbook,List<EmployeeVO> employeeList){
		int i =1;
		DateFormat df = new SimpleDateFormat("yyyy/MM/dd");
		for(Employee employee : employeeList){
			HSSFRow row = sheet.createRow(i+4);
			row.createCell(0).setCellValue(i);
			row.createCell(1).setCellValue(employee.getEmployeeName());
			row.createCell(2).setCellValue(employee.getCompanyName()==null?"":employee.getCompanyName());
			row.createCell(3).setCellValue(employee.getTitleName()==null?"":employee.getTitleName());
			row.createCell(4).setCellValue(employee.getGrade()==null?"":employee.getGrade());
			row.createCell(5).setCellValue(employee.getEmail()==null?"":employee.getEmail());
			row.createCell(6).setCellValue(employee.getMobilePhone()==null?"":employee.getMobilePhone());
			row.createCell(7).setCellValue(employee.getSkillNames()==null?"":employee.getSkillNames());
			row.createCell(8).setCellValue(employee.getJoinDate()==null?"":df.format(employee.getJoinDate()));
			row.createCell(9).setCellValue(employee.getQuitDate()==null?"":df.format(employee.getQuitDate()));
			ExcelStyleHelper.setStyleBody(sheet, workbook, row);
			i++;
		}
	}

}
