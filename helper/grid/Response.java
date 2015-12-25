package com.mcnc.yuga.helper.grid;

public class Response {

	private int page;
	private int total;
	private int records;
	private Object rows;
	private Object rowshide;
	private Object userdata;

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public int getRecords() {
		return records;
	}

	public void setRecords(int records) {
		this.records = records;
	}

	public Object getRows() {
		return rows;
	}

	public void setRows(Object rows) {
		this.rows = rows;
	}
	
	public Object getRowshide() {
		return rowshide;
	}

	public void setRowshide(Object rowshide) {
		this.rowshide = rowshide;
	}

	public Object getUserdata() {
		return userdata;
	}

	public void setUserdata(Object userdata) {
		this.userdata = userdata;
	}
}
