package com.mobilecnc.helper;

import java.util.HashMap;
import java.util.Map;

public class PagingCondition {
	public int start;
	public int end;
	public int page;
	public String sidx;
	public String sord;
	public String where;
	public int rows;
	public Map<String, String> ops = new HashMap<String, String>();
	public String col;
	public String oper;
	public String val;

	public PagingCondition() {
		this.addOps();
	}

	public PagingCondition(int page, int rows) {
		this.calculateStartEnd(page, rows);
		this.addOps();
	}

	public PagingCondition(int page, int rows, String sidx, String sord) {
		this.setSidx(sidx);
		this.setSord(sord);
		this.calculateStartEnd(page, rows);
		this.addOps();
	}

	public String getCol() {
		return col;
	}

	public void setCol(String col) {
		this.col = col;
	}

	public String getOper() {
		return oper;
	}

	public void setOper(String oper) {
		this.oper = oper;
	}

	public String getVal() {
		return val;
	}

	public void setVal(String val) {
		this.val = val;
	}

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getEnd() {
		return end;
	}

	public void setEnd(int end) {
		this.end = end;
	}

	public String getSidx() {
		return sidx;
	}

	public void setSidx(String sidx) {
		this.sidx = sidx;
	}

	public String getSord() {
		return sord;
	}

	public void setSord(String sord) {
		this.sord = sord;
	}

	public String getWhere() {
		return where;
	}

	public void setWhere(String where) {
		this.where = where;
	}

	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public Map<String, String> getOps() {
		return ops;
	}

	public void setOps(Map<String, String> ops) {
		this.ops = ops;
	}

	private void addOps() {
		this.ops.put("eq", "="); // equal
		this.ops.put("ne", "<>");// not equal
		this.ops.put("lt", "<");// less than
		this.ops.put("le", "<=");// less than or equal
		this.ops.put("gt", ">");// greater than
		this.ops.put("ge", ">=");// greater than or equal
		this.ops.put("bw", "LIKE");// begins with
		this.ops.put("bn", "NOT LIKE");// doesn't begin with
		this.ops.put("in", "LIKE");// is in
		this.ops.put("ni", "NOT LIKE");// is not in
		this.ops.put("ew", "LIKE");// ends with
		this.ops.put("en", "NOT LIKE");// doesn't end with
		this.ops.put("cn", "LIKE");// contains
		this.ops.put("nc", "NOT LIKE");// doesn't contain
	}

	public String getOpsByKey(String key) {
		return this.ops.get(key);
	}

	public void calculateStartEnd(int page, int rows) {
		this.setPage(page);
		this.setRows(rows);
		this.setStart((page - 1) * rows + 1);
		this.setEnd(page * rows);
	}
}
