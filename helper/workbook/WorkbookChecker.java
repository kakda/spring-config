package com.mcnc.yuga.helper.workbook;

import java.util.ArrayList;
import java.util.List;

public class WorkbookChecker {

	private boolean result;
	private String message;
	private int row;
	private int col;
	private List<EmployeeChecker> list = new ArrayList<EmployeeChecker>();
	
	public WorkbookChecker() {
		super();
		this.result = true;
	}
	public boolean isResult() {
		return result;
	}
	public void setResult(boolean result) {
		this.result = result;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public int getRow() {
		return row;
	}
	public void setRow(int row) {
		this.row = row;
	}
	public int getCol() {
		return col;
	}
	public void setCol(int col) {
		this.col = col;
	}
	public List<EmployeeChecker> getList() {
		return list;
	}
	public void setList(List<EmployeeChecker> list) {
		this.list = list;
	}
	@Override
	public String toString() {
		return "WookbookChecker [result=" + result + ", message=" + message
				+ ", row=" + row + ", col=" + col + "]";
	}
	
	
	
}
