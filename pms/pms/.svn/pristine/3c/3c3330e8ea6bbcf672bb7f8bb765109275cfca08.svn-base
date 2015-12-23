package com.mobilecnc.helper.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mobilecnc.employees.Employee;

@Service
public class SchedulerService {

	@Autowired
	SchedulerDAO schedulerDAO;

	
	public List<Employee> getEmployeeUnsubmitted() throws Exception{
		return schedulerDAO.getEmployeeUnsubmitted();
	}
}
