package com.mobilecnc.timeCards;

import java.util.Date;

public class TimeCardVO extends TimeCard{
	private String projectName;
	private String employeeName;
	private Date plannedAssignDate;
	private Date plannedReleaseDate;
	private Date startDate;
	private Date endDate;
	private String month;
	private String day;
	private int isDefault; 
	
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public String getEmployeeName() {
		return employeeName;
	}
	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}
	public Date getPlannedAssignDate() {
		return plannedAssignDate;
	}
	public void setPlannedAssignDate(Date plannedAssignDate) {
		this.plannedAssignDate = plannedAssignDate;
	}
	public Date getPlannedReleaseDate() {
		return plannedReleaseDate;
	}
	public void setPlannedReleaseDate(Date plannedReleaseDate) {
		this.plannedReleaseDate = plannedReleaseDate;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public int getIsDefault() {
		return isDefault;
	}
	public void setIsDefault(int isDefault) {
		this.isDefault = isDefault;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	
	
}
