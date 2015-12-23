package com.mobilecnc.projects.service;

import java.util.List;
import com.mobilecnc.projects.Project;

public class ProjectVO extends Project{
	
	private static final long serialVersionUID = 1L;
	
	List<ProjectVO> projectList;
	
	public List<ProjectVO> getProjectList()
	{
		return projectList;
	}
	public List<ProjectVO> getEmployeeList()
	{
		return projectList;
	}
	public void setProjectList(List<ProjectVO> projectList)
	{
		this.projectList = projectList;
	}
	
	private String employeeName;
	private String customerName;
	private String projectTypeName;
	private String projectMembers;
	private String maintenanceOwner;
	private String maintenanceMembers;
	private String currencyType;
	
	public String getCurrencyType() {
		return currencyType;
	}

	public void setCurrencyType(String currencyType) {
		this.currencyType = currencyType;
	}

	public String getProjectMembers() {
		return projectMembers;
	}

	public void setProjectMembers(String projectMembers) {
		this.projectMembers = projectMembers;
	}

	public String getMaintenanceOwner() {
		return maintenanceOwner;
	}

	public void setMaintenanceOwner(String maintenanceOwner) {
		this.maintenanceOwner = maintenanceOwner;
	}

	public String getMaintenanceMembers() {
		return maintenanceMembers;
	}

	public void setMaintenanceMembers(String maintenanceMembers) {
		this.maintenanceMembers = maintenanceMembers;
	}

	public String getEmployeeName() {
		return employeeName;
	}

	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getProjectTypeName() {
		return projectTypeName;
	}

	public void setProjectTypeName(String projectTypeName) {
		this.projectTypeName = projectTypeName;
	}
	
	
}
