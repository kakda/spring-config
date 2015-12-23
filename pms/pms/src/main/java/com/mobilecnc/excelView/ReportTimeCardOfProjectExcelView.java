package com.mobilecnc.excelView;

import java.awt.Color;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedHashMap;
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
import com.mobilecnc.calender.Calenders;
import com.mobilecnc.timeCards.EntryParameter;
import com.mobilecnc.timeCards.ReportOfProject;
import com.mobilecnc.timeCards.TimeCardDetail;

public class ReportTimeCardOfProjectExcelView extends AbstractExcelView{

	@Override
	protected void buildExcelDocument(Map<String, Object> map,
			HSSFWorkbook workbook, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// TODO Auto-generated method stub
		DateFormat df = new SimpleDateFormat("yyyy/MM/dd");
		@SuppressWarnings({ "unused", "unchecked" })
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
 		
		HSSFSheet sheet = workbook.createSheet("TimeCardOfProject");
		setHeader(sheet, workbook, list, projectID,projectName,projectType,totalHour);
		setBody(sheet, workbook, list,submap);
		ExcelStyleHelper.autoColumnWidth(sheet, 4);
		response.setHeader("Content-Disposition","attachment; filename=\"TimeCardOfProject_"+df.format(new Date())+".xls\"");
		
	}
	
	
	@SuppressWarnings({ "unused", "deprecation" })
	private void setHeader(HSSFSheet sheet ,HSSFWorkbook workbook,List<ReportOfProject> list,String projectID,String projectName,String projectType,Float totalHour){
		HSSFRow row = sheet.createRow(0);
		row.createCell(0).setCellValue("Time Card of Project Report");
		sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 4));
//		setStyleHeader(sheet, workbook, row, "reportname");
		ExcelStyleHelper.setStyleHeader(sheet, workbook, row, "reportname");
		
		HSSFRow rowHeader = sheet.createRow(1);
		rowHeader.createCell(0).setCellValue("Project ID: ");
		rowHeader.createCell(1).setCellValue(projectID);
		rowHeader.createCell(2).setCellValue("Project Type: ");
		rowHeader.createCell(3).setCellValue(projectType);
		ExcelStyleHelper.setStyleHeader(sheet, workbook, rowHeader, "header");
		
		HSSFRow rowHeader1 = sheet.createRow(2);
		rowHeader1.createCell(0).setCellValue("Project Name: ");
		rowHeader1.createCell(1).setCellValue(projectName);
		rowHeader1.createCell(2).setCellValue("Total Hour: ");
		rowHeader1.createCell(3).setCellValue(totalHour);
		ExcelStyleHelper.setStyleHeader(sheet, workbook, rowHeader1, "header");
		
	}
	
	@SuppressWarnings("unused")
	private void setBody(HSSFSheet sheet,HSSFWorkbook workbook,List<ReportOfProject> list,LinkedHashMap<String, List<ReportOfProject>> submap){
		int k=3;
		for(Map.Entry<String, List<ReportOfProject>> entry : submap.entrySet()){
			//Employee: Employee Name
			HSSFRow rowHeader3 = sheet.createRow(k);
			rowHeader3.createCell(0).setCellValue("Employee: ");
			rowHeader3.createCell(1).setCellValue(entry.getKey());
			
			k++;
			HSSFRow rowBody = sheet.createRow(k);
			rowBody.createCell(0).setCellValue("TimeCard ID");
			rowBody.createCell(1).setCellValue("Date");
			rowBody.createCell(2).setCellValue("Working (Hour)");			
			ExcelStyleHelper.setStyleBody(sheet, workbook, rowBody);
			ExcelStyleHelper.setStyleHeader(sheet, workbook, rowBody, "header");
			k++;
			List<ReportOfProject> listEmployee = entry.getValue();
			float sumHours = 0;
			for(int i = 0; i<listEmployee.size();i++){
				
				HSSFRow rowContent = sheet.createRow(k);
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
				rowContent.createCell(0).setCellValue(listEmployee.get(i).getTimeCardID());
				rowContent.createCell(1).setCellValue(df.format(listEmployee.get(i).gettDate()));
				rowContent.createCell(2).setCellValue(listEmployee.get(i).getWorkingHour());
				sumHours = sumHours+listEmployee.get(i).getWorkingHour();
				ExcelStyleHelper.setStyleBody(sheet, workbook,rowContent);
				k++;				
			}
			HSSFRow rowSum = sheet.createRow(k);
			rowSum.createCell(0).setCellValue("");
			rowSum.createCell(1).setCellValue("SUM:");
			rowSum.createCell(2).setCellValue(sumHours);
			ExcelStyleHelper.setStyleBody(sheet, workbook,rowSum);
			k++;
			
			
		}
		/*for(int i=0;i<submap.size();i++){
			HSSFRow rowEmployee = sheet.createRow(i+3);
			List<ReportOfProject> employeeObj = submap.get(list.get(i).getEmployeeID());
			rowEmployee.createCell(0).setCellValue("Employee: ");
			rowEmployee.createCell(1).setCellValue(employeeObj.get(i).getEmployeeName());*/
			/*for(int j=0;j<employeeObj.size();j++){				
				rowEmployee.createCell(0).setCellValue("Employee: ");
				rowEmployee.createCell(1).setCellValue(employeeObj.get(j).getEmployeeName());
			}*/
			//ReportOfProject reportOfProject = list.get(i);
			
			//String employeeName = list.get(i).getEmployeeName();
			
			/*sheet.addMergedRegion(new CellRangeAddress(i+3, 4, 0, 4));*/
			
		/*}*/
		//}
		
		
		/*for(int i =0 ; i< list.size();i++){
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
		}*/
	}
	

}
