package com.mobilecnc.helper.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestParam;

import com.mobilecnc.helper.Paging;
import com.mobilecnc.helper.PagingCondition;

/**
 * 
 * @author sereysopheak.eap
 * 
 */
public abstract class AbstractPagingService {
	public abstract <T> List<T> getPagingRecord(PagingCondition pagingCondition) throws Exception;
	public abstract int getRecordCount(PagingCondition pagingCondition) throws Exception;
	
	public <T> Paging<T> getTotalRecords(HttpServletRequest request) throws Exception{
		
		Paging<T> paging = new Paging<T>();
		int page=Integer.parseInt(request.getParameter("page"));
		int rows=Integer.parseInt(request.getParameter("rows"));
		String sidx=request.getParameter("sidx");
		String sord=request.getParameter("sord");
		String searchField = request.getParameter("searchField");
		String searchString = request.getParameter("searchString");
		
		String searchField1 = request.getParameter("searchField1") == null ? "" : request.getParameter("searchField1").trim();
		String searchString1 = request.getParameter("searchString1") == null ? "" : request.getParameter("searchString1").trim();
		
		String searchField2 = request.getParameter("searchField2") == null ? "" : request.getParameter("searchField2").trim();
		String searchString2 = request.getParameter("searchString2") == null ? "" : request.getParameter("searchString2").trim();
		
		String searchYearFiled = request.getParameter("searchYearFiled") == null ? "" : request.getParameter("searchYearFiled").trim();
		String searchYearString = request.getParameter("searchYearString") == null ? "" : request.getParameter("searchYearString").trim();
		
		String searchOper = request.getParameter("searchOper");
		PagingCondition pagingCondition = new PagingCondition(page, rows, sidx, sord);
		int totalRecord;

		if (request.getParameter("_search").equalsIgnoreCase("true")) {
			String oper = searchOper.trim();
			String val = searchString.trim();
			String col = "UPPER(" + searchField.trim() + ")";

			if (oper.equals("bw") || oper.equals("bn")) {
				val = "N'" + val + "%'";
			}
			if (oper.equals("ew") || oper.equals("en")) {
				val += "N'%" + val + "'";
			}
			if (oper.equals("cn") || oper.equals("nc") || oper.equals("in")
					|| oper.equals("ni")) {
				val = "N'%" + val.toUpperCase() + "%'";

			}
			
			String where = "";
			
			pagingCondition.setCol(col);
			pagingCondition.setOper(pagingCondition.getOpsByKey(oper));
			pagingCondition.setVal(val);
			where = " AND ( " + col + " " + pagingCondition.getOper() + " " + val + " ) ";
			
			
			if(!searchString1.equals(""))
			{
				String col1 = "UPPER(" + searchField1.trim() + ")";
				String val1 = "N'" + searchString1.trim().toUpperCase() + "'";
				where += " AND ( " + col1 + " LIKE " + val1 + " ) ";
			}
			
			if(!searchString2.equals(""))
			{
				String col2 = "UPPER(" + searchField2.trim() + ")";
				String val2 = "N'" + searchString2.trim().toUpperCase() + "'";
				where += " AND ( " + col2 + " LIKE " + val2 + " ) ";
			}
			
			if(!searchYearString.equals(""))
			{
				String colYear = "YEAR(" + searchYearFiled.trim() + ")";
				String valYear = "'" + searchYearString.trim() + "'";
				where += " AND ( " + colYear + " = " + valYear + " ) ";
			}
			
			pagingCondition.setWhere(where);
			
			totalRecord = this.getRecordCount(pagingCondition);
		} else {
			pagingCondition.setCol(null);
			totalRecord = this.getRecordCount(pagingCondition);
		}
		List<T> list = this.getPagingRecord(pagingCondition);
		int total = (int) Math.ceil((float) totalRecord / rows);

		paging.setPage(page);
		paging.setRows(list);
		paging.setTotal(total);
		paging.setRecords(totalRecord);

		return paging;
	}
}
