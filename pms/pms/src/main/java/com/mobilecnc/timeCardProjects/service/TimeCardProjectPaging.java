package com.mobilecnc.timeCardProjects.service;

import java.util.List;

import com.mobilecnc.timeCardProjects.TimeCardProjectVO;
import com.mobilecnc.timeCards.TimeCardVO;
import com.mobilecnc.timeCards.Userdata;

public class TimeCardProjectPaging{

	private int page;
	private int records;
	private int total;
	private List<TimeCardProjectVO> rows;
	private Userdata userdata;
	
	public TimeCardProjectPaging(){
		// Do something
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getRecords() {
		return records;
	}

	public void setRecords(int records) {
		this.records = records;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public List<TimeCardProjectVO> getRows() {
		return rows;
	}

	public void setRows(List<TimeCardProjectVO> rows) {
		this.rows = rows;
	}

	public Userdata getUserdata() {
		return userdata;
	}

	public void setUserdata(Userdata userdata) {
		this.userdata = userdata;
	}	
	
}
