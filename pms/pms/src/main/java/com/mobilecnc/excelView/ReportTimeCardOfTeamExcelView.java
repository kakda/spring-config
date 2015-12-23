package com.mobilecnc.excelView;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.CellRangeAddress;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import com.mobilecnc.timeCards.EntryParameter;
import com.mobilecnc.timeCards.ReportOfProject;
import com.mobilecnc.timeCards.ReportOfProjectGrid;

public class ReportTimeCardOfTeamExcelView extends AbstractExcelView{

	private String teamName;
	
	@Override
	protected void buildExcelDocument(Map<String, Object> model,
			HSSFWorkbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		@SuppressWarnings("unchecked")
		ReportOfProjectGrid reportOfTeamList = (ReportOfProjectGrid) model.get("reportTimeCardOfTeamList");
		
		EntryParameter entryParameter = (EntryParameter) model.get("entryParameter");
		
		HSSFSheet sheet = workbook.createSheet("TimeCardsOfTeam"+ entryParameter.getYear()+"_"+ entryParameter.getMinMonth()+"_"+entryParameter.getMaxMonth());
		setBody(sheet, workbook, reportOfTeamList);
		setHeader(sheet, workbook, entryParameter);
		ExcelStyleHelper.autoColumnWidth(sheet, 4);
		response.setHeader("Content-Disposition","attachment; filename=\"TimeCardsOfTeam_"+ entryParameter.getTeamID()+".xls\"");
		
	}

	@SuppressWarnings("deprecation")
	private void setHeader(HSSFSheet sheet, HSSFWorkbook workbook,
			EntryParameter entryParameter) {
		// TODO Auto-generated method stub
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		HSSFRow row = sheet.createRow(0);
		row.createCell(0).setCellValue("Time Card Report of Team");
		row.createCell(1);
		row.createCell(2);
		row.createCell(3);
		sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 3));
		ExcelStyleHelper.setStyleHeader(sheet, workbook, row, "reportname");
		HSSFRow rowHeader = sheet.createRow(1);
		rowHeader.createCell(0).setCellValue("TEAM: ");
		rowHeader.createCell(1).setCellValue(teamName);
		rowHeader.createCell(2);
		rowHeader.createCell(3);
		sheet.addMergedRegion(new CellRangeAddress(1, 1, 1, 3));
		ExcelStyleHelper.setStyleHeader(sheet, workbook, rowHeader, "header");
		HSSFRow rowHeader2 = sheet.createRow(2);
		rowHeader2.createCell(0).setCellValue("StartDate: ");
		rowHeader2.createCell(1).setCellValue(df.format(entryParameter.getStartDate()));
		rowHeader2.createCell(2).setCellValue("EndDate: ");
		rowHeader2.createCell(3).setCellValue(df.format(entryParameter.getEndDate()));
		ExcelStyleHelper.setStyleHeader(sheet, workbook, rowHeader2, "header");
	}

	
	private void setBody(HSSFSheet sheet, HSSFWorkbook workbook,
			ReportOfProjectGrid reportOfTeamList) {
		// TODO Auto-generated method stub
		List<ReportOfProject> rowList = reportOfTeamList.getRows();
		if(rowList.size() == 0){
			HSSFRow NoDataRow = sheet.createRow(3);
			NoDataRow.createCell(0).setCellValue("NO DATA FOUND");
			NoDataRow.createCell(1);
			NoDataRow.createCell(2);
			NoDataRow.createCell(3);
			sheet.addMergedRegion(new CellRangeAddress(3, 3, 0, 3));
			ExcelStyleHelper.setStyleBody(sheet, workbook, NoDataRow);
		}else{
		LinkedHashMap<String, List<ReportOfProject>> map = new LinkedHashMap<String, List<ReportOfProject>>();
		for (ReportOfProject linkMap : rowList) {
			String key = linkMap.getProjectName();
			if(map.get(key) == null){
				map.put(key, new ArrayList<ReportOfProject>());
			}
			map.get(key).add(linkMap);
		}
		int i=3;
		for(Map.Entry<String, List<ReportOfProject>> entry : map.entrySet()){
			HSSFRow projectNameRow = sheet.createRow(i);
			projectNameRow.createCell(0).setCellValue("Project:");
			projectNameRow.createCell(1).setCellValue(entry.getKey());
			projectNameRow.createCell(2);
			projectNameRow.createCell(3);
			sheet.addMergedRegion(new CellRangeAddress(i, i, 1, 3));
			ExcelStyleHelper.setStyleHeader(sheet, workbook, projectNameRow, "header");
			i++;
			HSSFRow HeaderProject = sheet.createRow(i);
			HeaderProject.createCell(0).setCellValue("TeamID");
			HeaderProject.createCell(1).setCellValue("Employee");
			HeaderProject.createCell(2).setCellValue("Day");
			HeaderProject.createCell(3).setCellValue("Working");
			ExcelStyleHelper.setStyleHeader(sheet, workbook, HeaderProject, "header");
			i++;
			int totalHour = 0;
			for (int j = 0; j < entry.getValue().size(); j++) {
				HSSFRow DataProject = sheet.createRow(i);
				DataProject.createCell(0).setCellValue(entry.getValue().get(j).getTeamID());
				DataProject.createCell(1).setCellValue(entry.getValue().get(j).getEmployeeName());
				DataProject.createCell(2).setCellValue(entry.getValue().get(j).getDw());
				DataProject.createCell(3).setCellValue(entry.getValue().get(j).getWorkingHour());
				totalHour = (int) (totalHour + entry.getValue().get(j).getWorkingHour());
				teamName = entry.getValue().get(j).getTeamName();
				ExcelStyleHelper.setStyleBody(sheet, workbook, DataProject);
				i++;
			}
			HSSFRow Total = sheet.createRow(i);
			Total.createCell(0).setCellValue("Total Hour:");
			Total.createCell(1);
			Total.createCell(2);
			Total.createCell(3).setCellValue(totalHour);
			sheet.addMergedRegion(new CellRangeAddress(i, i, 0, 2));
			ExcelStyleHelper.setStyleHeader(sheet, workbook, Total, "header");
			i++;
		  }
		}
	}
}
