package com.mobilecnc.excelView;

import java.util.Iterator;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;

public class ExcelStyleHelper {

	
	static public void setStyleHeader(HSSFSheet sheet,HSSFWorkbook workbook,HSSFRow row,String notice){
		HSSFCellStyle style = workbook.createCellStyle();
		HSSFFont font = workbook.createFont();
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		font.setColor(workbook.getCustomPalette().findSimilarColor(102, 102,153).getIndex());
		style.setBorderBottom(CellStyle.BORDER_THIN);
		style.setBorderLeft(CellStyle.BORDER_THIN);
		style.setBorderRight(CellStyle.BORDER_THIN);
		style.setBorderTop(CellStyle.BORDER_THIN);
		style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		@SuppressWarnings("unchecked")
		Iterator<Cell> cell = row.iterator();
		
		if(notice.equalsIgnoreCase("reportName")){
			style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			font.setFontHeight((short) 550);
			style.setFont(font);
		}else if(notice.equalsIgnoreCase("header")){
			style.setFont(font);
		}
		
		while(cell.hasNext()){
			HSSFCell eachCell = (HSSFCell)cell.next();
			eachCell.setCellStyle(style);
		}
	}
	
	static public void setStyleBody(HSSFSheet sheet,HSSFWorkbook workbook,HSSFRow row){
		HSSFCellStyle style= workbook.createCellStyle();
		style.setBorderBottom(CellStyle.BORDER_THIN);
		style.setBorderRight(CellStyle.BORDER_THIN);
		style.setBorderTop(CellStyle.BORDER_THIN);
		style.setBorderLeft(CellStyle.BORDER_THIN);
		style.setVerticalAlignment((short)1);
		Iterator<Cell> cell = row.cellIterator();
		
		while(cell.hasNext()){
			HSSFCell each = (HSSFCell) cell.next();
			each.setCellStyle(style);
		}
		
	}
	
    static public void autoColumnWidth(HSSFSheet sheet,int columnSize){
		for(int i=0;i<=columnSize;i++){
			sheet.autoSizeColumn(i);
		}
	}
}
