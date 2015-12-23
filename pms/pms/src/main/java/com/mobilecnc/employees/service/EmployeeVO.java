package com.mobilecnc.employees.service;

import java.util.List;

import com.mobilecnc.employees.Employee;

public class EmployeeVO extends Employee{
	
	List<EmployeeVO> employeeList;
	
	public List<EmployeeVO> getEmployeeList()
	{
		return employeeList;
	}
	
	public void setEmployeeList(List<EmployeeVO> employeeList)
	{
		this.employeeList = employeeList;
	}
	
}
