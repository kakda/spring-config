package com.mobilecnc.excelView;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import com.mobilecnc.timeCards.EntryParameter;
import com.mobilecnc.timeCards.ReportOfProject;
import com.mobilecnc.timeCards.ReportOfProjectGrid;

public class ReportTimeCardByBillableExcelView extends AbstractExcelView{

	@Override
	protected void buildExcelDocument(Map<String, Object> map,
			HSSFWorkbook workbook, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// TODO Auto-generated method stub
		
		@SuppressWarnings("unused")
		ReportOfProjectGrid projectGrid = (ReportOfProjectGrid) map.get("timeCardByBillableList");
		
		@SuppressWarnings("unused")
		EntryParameter entryParameter = (EntryParameter) map.get("entryParameter");
		
		List<ReportOfProject> list =projectGrid.getRows();
		HashMap<String,List<ReportOfProject>> mapProject = new HashMap<String,List<ReportOfProject>>();
		
		DateFormat df = new SimpleDateFormat("yyyy/MM/dd");
		float totalhour = 0;
		for (int i=0 ; i<list.size();i++){
			ReportOfProject item = list.get(i);
			totalhour += item.getWorkingHour();
			if(mapProject.get(item.getProjectID())== null){
				mapProject.put(item.getProjectID(), new ArrayList<ReportOfProject>());
			}
			mapProject.get(item.getProjectID()).add(item);
		}
		
		
		
		
		HSSFSheet sheet = workbook.createSheet("TimeCardByBillable");
		setHeader(sheet, workbook,entryParameter,totalhour);
		setBody(sheet, workbook, mapProject);
		ExcelStyleHelper.autoColumnWidth(sheet, 5);
		
		response.setHeader("Content-Disposition","attachment; filename=\"TimeCardsByBillable_"+ df.format(new Date()) +".xls\"");
	}
	
	private void setHeader(HSSFSheet sheet,HSSFWorkbook workbook,EntryParameter entryParameter,float total){
		DateFormat df = new SimpleDateFormat("yyyy/MM/dd");
		HSSFRow row= sheet.createRow(0);
		row.createCell(0).setCellValue("TimeCard By Billable Report");
		sheet.addMergedRegion(new CellRangeAddress(0,0,0,3));
		ExcelStyleHelper.setStyleHeader(sheet, workbook, row, "reportName");
		
		HSSFRow header = sheet.createRow(1);
		header.createCell(0).setCellValue("StartDate: ");
		header.createCell(1).setCellValue(df.format(entryParameter.getStartDate()));
		header.createCell(2).setCellValue("EndDate: ");
		header.createCell(3).setCellValue(df.format(entryParameter.getEndDate()));
		ExcelStyleHelper.setStyleHeader(sheet, workbook, header, "header");
		
		HSSFRow header2 = sheet.createRow(2);
		header2.createCell(0).setCellValue("Status: ");
		header2.createCell(1).setCellValue(entryParameter.isBillable()==true ?"Billable":"Not Billable");
		header2.createCell(2).setCellValue("Total Hour: ");
		header2.createCell(3).setCellValue(total);
		ExcelStyleHelper.setStyleHeader(sheet, workbook, header2, "header");
		
	}
	
	
	private void setBody(HSSFSheet sheet,HSSFWorkbook workbook,HashMap<String,List<ReportOfProject>> mapList){
		int k=3;
		DateFormat df = new SimpleDateFormat("yyyy/MM/dd");
		for(String key : mapList.keySet()){
			List<ReportOfProject> itemList = mapList.get(key);
			HSSFRow row = sheet.createRow(k);
			if(itemList.size()>0){
				ReportOfProject itemTitle = itemList.get(0);
				row.createCell(0).setCellValue("ProjectID: ");
				row.createCell(1).setCellValue(itemTitle.getProjectID());
				row.createCell(2).setCellValue("ProjectName: ");
				row.createCell(3).setCellValue(itemTitle.getProjectName());
				k+=1;
				ExcelStyleHelper.setStyleHeader(sheet, workbook, row, "header");
				
				HSSFRow rowHeaderDetail = sheet.createRow(k);
				rowHeaderDetail.createCell(0).setCellValue("");
				rowHeaderDetail.createCell(1).setCellValue("");
				rowHeaderDetail.createCell(2).setCellValue("Date");
				rowHeaderDetail.createCell(3).setCellValue("Hour");
				k+=1;
				ExcelStyleHelper.setStyleHeader(sheet, workbook, rowHeaderDetail, "header");
				
				float totaleachProject=0;
				for(int i=0;i<itemList.size();i++){
						ReportOfProject itemData = itemList.get(i);
						HSSFRow rowData = sheet.createRow(k);
						rowData.createCell(0).setCellValue("");
						rowData.createCell(1).setCellValue("");
						rowData.createCell(2).setCellValue(df.format(itemData.gettDate()));
						rowData.createCell(3).setCellValue(itemData.getWorkingHour());
						totaleachProject += itemData.getWorkingHour();
						k+=1;
						
						ExcelStyleHelper.setStyleBody(sheet, workbook, rowData);
				}
				
				HSSFRow totalEachRow = sheet.createRow(k);
				totalEachRow.createCell(0).setCellValue("");
				totalEachRow.createCell(1).setCellValue("");
				totalEachRow.createCell(2).setCellValue("Total: ");
				totalEachRow.createCell(3).setCellValue(totaleachProject);
				k+=1;
				
				ExcelStyleHelper.setStyleHeader(sheet, workbook, totalEachRow, "header");
			}
		}
	}

}
