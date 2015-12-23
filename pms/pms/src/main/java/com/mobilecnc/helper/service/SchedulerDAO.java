package com.mobilecnc.helper.service;

import java.util.List;

import com.mobilecnc.employees.Employee;

public interface SchedulerDAO {

	public List<Employee> getEmployeeUnsubmitted() throws Exception;
}
