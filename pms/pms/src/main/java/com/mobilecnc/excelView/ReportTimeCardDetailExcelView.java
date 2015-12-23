package com.mobilecnc.excelView;

import java.awt.Color;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.CellRangeAddress;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import com.lowagie.text.Font;
import com.mobilecnc.timeCards.EntryParameter;
import com.mobilecnc.timeCards.TimeCardDetail;

public class ReportTimeCardDetailExcelView extends AbstractExcelView{

	@Override
	protected void buildExcelDocument(Map<String, Object> map,
			HSSFWorkbook workbook, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// TODO Auto-generated method stub
		
		@SuppressWarnings({ "unused", "unchecked" })
		List<TimeCardDetail> list =	(List<TimeCardDetail>) map.get("timeCardsDetailList");
		
		@SuppressWarnings("unused")
		EntryParameter entryParameter = (EntryParameter) map.get("entryParameter");
	
		HSSFSheet sheet = workbook.createSheet("TimeCardsDetail"+ entryParameter.getYear()+"_"+ entryParameter.getMinMonth()+"_"+entryParameter.getMaxMonth());
		setHeader(sheet, workbook, entryParameter);
		setBody(sheet, workbook, list);
		ExcelStyleHelper.autoColumnWidth(sheet, 6);
		response.setHeader("Content-Disposition","attachment; filename=\"TimeCardsDetail_"+ Float.toString(entryParameter.getYear()).substring(0,Float.toString(entryParameter.getYear()).indexOf('.')) +""+ Float.toString(entryParameter.getMinMonth()).substring(0, Float.toString(entryParameter.getMinMonth()).indexOf('.')) +""+Float.toString( entryParameter.getMaxMonth()).substring(0,Float.toString(entryParameter.getMaxMonth()).indexOf('.'))+".xls\"");
		
	}
	
	
	@SuppressWarnings({ "unused", "deprecation" })
	private void setHeader(HSSFSheet sheet ,HSSFWorkbook workbook,EntryParameter entryParameter){
		HSSFRow row = sheet.createRow(0);
		row.createCell(0).setCellValue("Time Card Report");
		sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 5));
//		setStyleHeader(sheet, workbook, row, "reportname");
		ExcelStyleHelper.setStyleHeader(sheet, workbook, row, "reportname");
		HSSFRow rowHeader = sheet.createRow(1);
		rowHeader.createCell(0).setCellValue("Year: ");
		rowHeader.createCell(1).setCellValue(entryParameter.getYear());
//		setStyleHeader(sheet, workbook, rowHeader, "header");
		ExcelStyleHelper.setStyleHeader(sheet, workbook, rowHeader, "header");
		HSSFRow rowHeader2 = sheet.createRow(2);
		rowHeader2.createCell(0).setCellValue("Month: ");
		rowHeader2.createCell(1).setCellValue(entryParameter.getMinMonth());
		rowHeader2.createCell(2).setCellValue("To: ");
		rowHeader2.createCell(3).setCellValue(entryParameter.getMaxMonth());
//		setStyleHeader(sheet, workbook, rowHeader2,"header");
		ExcelStyleHelper.setStyleHeader(sheet, workbook, rowHeader2, "");
		HSSFRow headerTitle = sheet.createRow(3);
		headerTitle.createCell(0).setCellValue("ProjectCode");
		headerTitle.createCell(1).setCellValue("ProjectName");
		headerTitle.createCell(2).setCellValue("TeamName");
		headerTitle.createCell(3).setCellValue("EmployeeName");
		headerTitle.createCell(4).setCellValue("Date");
		headerTitle.createCell(5).setCellValue("Work-Hour");
//		setStyleHeader(sheet, workbook, headerTitle, "header");
		ExcelStyleHelper.setStyleHeader(sheet, workbook, headerTitle, "header");
	}
	
	@SuppressWarnings("unused")
	private void setBody(HSSFSheet sheet,HSSFWorkbook workbook,List<TimeCardDetail> list){
		
		for(int i =0 ; i< list.size();i++){
			TimeCardDetail timecard = list.get(i);
			DateFormat df = new SimpleDateFormat("yyyy/MM/dd");
			HSSFRow row = sheet.createRow(i+4);
			row.createCell(0).setCellValue(timecard.getProjectCode());
			row.createCell(1).setCellValue(timecard.getProjectName());
			row.createCell(2).setCellValue(timecard.getTeamName()==null? " ":timecard.getTeamName());
			row.createCell(3).setCellValue(timecard.getEmployeeName());
			row.createCell(4).setCellValue(df.format(timecard.gettDate()));
			row.createCell(5).setCellValue(timecard.getWorkingHour());
//			setStyleBody(sheet, workbook, row);
			ExcelStyleHelper.setStyleBody(sheet, workbook, row);
		}
	}
	

}
