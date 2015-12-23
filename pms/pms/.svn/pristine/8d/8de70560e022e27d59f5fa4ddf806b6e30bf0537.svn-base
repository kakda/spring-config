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
import org.apache.poi.hssf.util.CellRangeAddress;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import com.mobilecnc.projects.service.ProjectVO;

public class ReportProjectExcelView extends AbstractExcelView{

	
	@Override
	protected void buildExcelDocument(Map<String, Object> map,
			HSSFWorkbook workbook, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// TODO Auto-generated method stub
		DateFormat df = new SimpleDateFormat("yyyy/MM/dd");
		@SuppressWarnings("unchecked")
		List<ProjectVO> list = (List<ProjectVO>) map.get("projectList");
		
		HSSFSheet sheet = workbook.createSheet("Project");
		setHeader(sheet,workbook);
		setBody(sheet, workbook,list);
		ExcelStyleHelper.autoColumnWidth(sheet, 9);
		response.setHeader("Content-Disposition","attachment; filename=\"Project_Report_"+df.format(new Date())+".xls\"");
		
	}
	
	
	@SuppressWarnings({ "unused", "deprecation" })
	private void setHeader(HSSFSheet sheet ,HSSFWorkbook workbook){
		HSSFRow row = sheet.createRow(0);
		row.createCell(0).setCellValue("Project Report");
		sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 9));
		ExcelStyleHelper.setStyleHeader(sheet, workbook, row, "reportname");
		
	}
	
	@SuppressWarnings("unused")
	private void setBody(HSSFSheet sheet,HSSFWorkbook workbook, List<ProjectVO> list){
		HSSFRow row = sheet.createRow(1);
		row.createCell(0).setCellValue("No");
		row.createCell(1).setCellValue("Project");
		row.createCell(2).setCellValue("Type");
		row.createCell(3).setCellValue("PM");
		row.createCell(4).setCellValue("Customer");
		row.createCell(5).setCellValue("Men Month");
		row.createCell(6).setCellValue("Actual Start");
		row.createCell(7).setCellValue("Actual End");
		row.createCell(8).setCellValue("Planned Date");
		row.createCell(9).setCellValue("Planned End");
		
		ExcelStyleHelper.setStyleBody(sheet, workbook, row);
		ExcelStyleHelper.setStyleHeader(sheet, workbook, row, "header");
		int k = 2;
		int i = 0;
		int j=1;
		for(ProjectVO listProject : list){
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			HSSFRow rowBody = sheet.createRow(k);
			rowBody.createCell(0).setCellValue(j);
			rowBody.createCell(1).setCellValue(listProject.getProjectName());
			rowBody.createCell(2).setCellValue(listProject.getProjectTypeName());
			rowBody.createCell(3).setCellValue(listProject.getEmployeeName());
			rowBody.createCell(4).setCellValue(listProject.getCustomerName());
			rowBody.createCell(5).setCellValue(Integer.toString(listProject.getActualMM()));		
			rowBody.createCell(6).setCellValue(listProject.getActualStartDate()==null?"":df.format(listProject.getActualStartDate()));
			rowBody.createCell(7).setCellValue(listProject.getActualEndDate()==null?"":df.format(listProject.getActualEndDate()));
			rowBody.createCell(8).setCellValue(listProject.getPlannedStartDate()==null?"":df.format(listProject.getPlannedStartDate()));
			rowBody.createCell(9).setCellValue(listProject.getPlannedEndDate()==null?"":df.format(listProject.getPlannedEndDate()));
			ExcelStyleHelper.setStyleBody(sheet, workbook,rowBody);
			i++;
			k++;
			j++;
		}
	}
	
 
}
