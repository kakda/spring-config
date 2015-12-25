package com.mcnc.yuga.helper.grid;

import org.codehaus.jackson.annotate.JsonIgnore;
import org.codehaus.jackson.annotate.JsonIgnoreProperties;
import org.codehaus.jackson.map.annotate.JsonSerialize;

@JsonSerialize
@JsonIgnoreProperties(ignoreUnknown = true)
public class Request {

	@JsonIgnore
	private boolean search;
	
	@JsonIgnore
	private int page;
	
	@JsonIgnore
	private int rows;
	
	@JsonIgnore
	private String sortField;
	
	@JsonIgnore
	private String sortType;

	@JsonIgnore
	private int start;

	@JsonIgnore
	private int end;

	
	private String operation;
	
	public Request(){
	
	}
	
	public Request(boolean search, int page, int rows, String sortField,
			String sortType) {
		super();
		this.search = search;
		this.page = page;
		this.rows = rows;
		this.sortField = sortField;
		this.sortType = sortType;
		
	}

	public int getStart() {
		
		this.start = (this.page * this.rows) - this.rows + 1;
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getEnd() {
		
		this.end = this.rows*this.page;
		return end;
	}

	public void setEnd(int end) {
		this.end = end;
	}

	
	public boolean isSearch() {
		return search;
	}
	public void setSearch(boolean search) {
		this.search = search;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}
	public String getSortField() {
		return sortField;
	}
	public void setSortField(String sortField) {
		this.sortField = sortField;
	}
	public String getSortType() {
		return sortType;
	}
	public void setSortType(String sortType) {
		this.sortType = sortType;
	}

	
	public String getOperation() {
		return operation;
	}
	
	
	public void setOperation(String operation) {
		this.operation = operation;
	}

	@Override
	public String toString() {
		return "Request [search=" + search + ", page=" + page + ", rows="
				+ rows + ", sortField=" + sortField + ", sortType=" + sortType
				+ ", start=" + start + ", end=" + end + ", operation="
				+ operation + "]";
	}
	
}
