package com.mobilecnc.employees.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mobilecnc.employees.Employee;
import com.mobilecnc.employees.SearchEmployeeExcel;
import com.mobilecnc.helper.Paging;
import com.mobilecnc.helper.PagingCondition;
import com.mobilecnc.helper.service.AbstractPagingService;
import com.mobilecnc.helper.service.PKService;

@Service
public class EmployeeService extends AbstractPagingService{
	
	@Autowired
	EmployeeDAO employeeDAO;
	
	public List<EmployeeVO> selectEmployeeList(EmployeeVO employeeVO) throws Exception
	{
		return employeeDAO.selectEmployeeList(employeeVO);
	}
	public void insertemployee(Employee employee) throws Exception{
		employee.setEmployeeID(PKService.generateKey("Employees"));
		employeeDAO.insertEmployee(employee);
		employeeDAO.insertEmployeeHistory(employee);
		employeeDAO.insertUser(employee);
	}
	
	public List<EmployeeVO> getUser(EmployeeVO employeeVO) throws Exception{
		return employeeDAO.getUser(employeeVO);
	}
	public void insertEmployeeSkill(Employee employee) throws Exception{
		employeeDAO.insertEmployeeSkill(employee);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<EmployeeVO> getPagingRecord(PagingCondition pagingCondition)
			throws Exception {
		return employeeDAO.getPagingRecord(pagingCondition);
	}

	@Override
	public int getRecordCount(PagingCondition pagingCondition) throws Exception {
		return employeeDAO.getRecordCount(pagingCondition);
	}
	
	public void deleteEmployee(String employeeID) throws Exception{
		employeeDAO.deleteEmployee(employeeID);
		employeeDAO.deleteEmployeeHistory(employeeID);
	}
	
	public Employee getEmployee(String employeeID) throws Exception{
		return employeeDAO.getEmployee(employeeID);
	}
	public void updateEmployee(Employee employee) throws Exception{
		employeeDAO.updateEmployee(employee);
		employeeDAO.updateEmployeeHistory(employee);
		employeeDAO.deleteEmployeeSkill(employee);
	}
	public List<EmployeeVO> getSkill(EmployeeVO employeeVO) throws Exception{
		return employeeDAO.getSkill(employeeVO);
	}
	public int checkExisName(Employee employee) throws Exception {
		return employeeDAO.checkExisName(employee);
	}
	
	/**
	 * @author Chamroeun
	 */
	
	public List<EmployeeVO> selectEmployeeYear() throws Exception{
		return employeeDAO.selectEmployeeYear();
	}
	
	public int getReportRecordCount(PagingCondition pagingCondition) throws Exception {
		return employeeDAO.getReportRecordCount(pagingCondition);
	}

	public List<EmployeeVO> getPagingReportRecord(PagingCondition pagingCondition)
			throws Exception {
		return employeeDAO.getPagingReportRecord(pagingCondition);
	}
	
	public <T> Paging<T> getTotalReportRecords(HttpServletRequest request) throws Exception{
		
		Paging<T> paging = new Paging<T>();
		int page=Integer.parseInt(request.getParameter("page"));
		int rows=Integer.parseInt(request.getParameter("rows"));
		String sidx=request.getParameter("sidx");
		String sord=request.getParameter("sord");
		//String searchField = request.getParameter("searchField");
		String searchString = request.getParameter("searchString");
		
		//String searchField1 = request.getParameter("searchField1") == null ? "" : request.getParameter("searchField1").trim();
		String searchString1 = request.getParameter("searchString1") == null ? "" : request.getParameter("searchString1").trim();
		
		//String searchField2 = request.getParameter("searchField2") == null ? "" : request.getParameter("searchField2").trim();
		String searchString2 = request.getParameter("searchString2") == null ? "" : request.getParameter("searchString2").trim();

		String searchOper = request.getParameter("searchOper");
		PagingCondition pagingCondition = new PagingCondition(page, rows, sidx, sord);
		int totalRecord;

		if (request.getParameter("_search").equalsIgnoreCase("true")) {
			/*String oper = searchOper.trim();
			String val = searchString.trim();
			String col = "UPPER(" + searchField.trim() + ")";

			if (oper.equals("bw") || oper.equals("bn")) {
				val = "'" + val + "%'";
			}
			if (oper.equals("ew") || oper.equals("en")) {
				val += "'%" + val + "'";
			}
			if (oper.equals("cn") || oper.equals("nc") || oper.equals("in")
					|| oper.equals("ni")) {
				val = "'%" + val.toUpperCase() + "%'";
			}*/
			
			String where = "";
			
			/*pagingCondition.setCol(col);
			pagingCondition.setOper(pagingCondition.getOpsByKey(oper));
			pagingCondition.setVal(val);*/
			
			//where = " AND ( " + col + " " + pagingCondition.getOper() + " " + val + " ) ";
			
			if(!searchString.equals(""))
			{
				String aval = searchString.trim();
				where += " (projectIDs LIKE '%"+ aval +"%')";
			}
			
			if(!searchString1.equals(""))
			{
				String val1 = "'" + searchString1.trim() + "'";
				where += (where.isEmpty()?" ":" AND") + " ((YEAR(joinDate) <= "+ val1 +") AND (YEAR(quitDate) >= "+ val1 +") OR (YEAR(joinDate) <= "+ val1 +") AND (quitDate IS NULL))";
				
			}
			
			if(!searchString2.equals(""))
			{
				searchString2 = searchString2.replace(',', '%');
				where += (where.isEmpty()?" ":" AND") +  " (skillIDs LIKE '%" + searchString2 + "%')";			
			}
			
			pagingCondition.setWhere(where);
			
			totalRecord = this.getReportRecordCount(pagingCondition);
		} 
		else {
			pagingCondition.setCol(null);
			totalRecord = this.getReportRecordCount(pagingCondition);
		}
		List<T> list = (List<T>) this.getPagingReportRecord(pagingCondition);
		int total = (int) Math.ceil((float) totalRecord / rows);

		paging.setPage(page);
		paging.setRows(list);
		paging.setTotal(total);
		paging.setRecords(totalRecord);

		return paging;
	}
	
	public  List<EmployeeVO> getTotalReport(SearchEmployeeExcel searchEmployeeExcel) throws Exception{
		PagingCondition pagingCondition = new PagingCondition();
		String where ="";
		if(searchEmployeeExcel.getProjectID() != null)
		{
			String aval = searchEmployeeExcel.getProjectID().trim();
			where += " (projectIDs LIKE '%"+ aval +"%')";
		}
		
		if(searchEmployeeExcel.getYear() != null)
		{
			String val1 = "'" + searchEmployeeExcel.getYear().trim() + "'";
			where += (where.isEmpty()?" ":" AND") + " ((YEAR(joinDate) <= "+ val1 +") AND (YEAR(quitDate) >= "+ val1 +") OR (YEAR(joinDate) <= "+ val1 +") AND (quitDate IS NULL))";
			
		}
		
		if(searchEmployeeExcel.getSkillID() != null)
		{
			searchEmployeeExcel.setSkillID( searchEmployeeExcel.getSkillID().replace(',', '%'));
			where += (where.isEmpty()?" ":" AND") +  " (skillIDs LIKE '%" + searchEmployeeExcel.getSkillID() + "%')";			
		}
		pagingCondition.setWhere(where);
		return employeeDAO.getTotalReportRecord(pagingCondition);
	}
}
