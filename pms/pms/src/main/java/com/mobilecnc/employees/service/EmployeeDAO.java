package com.mobilecnc.employees.service;

import java.util.List;

import com.mobilecnc.employees.Employee;
import com.mobilecnc.helper.PagingCondition;

public interface EmployeeDAO {
	
	public List<EmployeeVO> selectEmployeeList(EmployeeVO employeeVO) throws Exception;
	public void insertEmployee(Employee employee) throws Exception;
	public void insertEmployeeHistory(Employee employee) throws Exception;
	public void insertUser(Employee employee) throws Exception;
	public void insertEmployeeSkill(Employee employee) throws Exception;
	public List<EmployeeVO> getPagingRecord(PagingCondition pagingCondition) throws Exception;
	public int getRecordCount(PagingCondition pagingCondition) throws Exception;
	public void deleteEmployee(String employeeID) throws Exception;
	public void deleteEmployeeHistory(String employeeID) throws Exception;
	public Employee getEmployee(String employeeID) throws Exception;
	public void updateEmployee(Employee employee) throws Exception;
	public void updateEmployeeHistory(Employee employee) throws Exception;
	public List<EmployeeVO> getSkill(EmployeeVO employeeVO) throws Exception;
	public void deleteEmployeeSkill(Employee employee) throws Exception;
	public int checkExisName(Employee employee) throws Exception;
	public List<EmployeeVO> getUser(EmployeeVO employeeVO) throws Exception;
	
	public List<EmployeeVO> selectEmployeeYear() throws Exception;
	public int getReportRecordCount(PagingCondition pagingCondition) throws Exception;
	public List<EmployeeVO> getPagingReportRecord(PagingCondition pagingCondition) throws Exception;
	public List<EmployeeVO> getTotalReportRecord(PagingCondition pagingCondition) throws Exception;
}
