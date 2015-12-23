package com.mobilecnc.timeCards;

import java.sql.Date;

public class TimeCardDetail {
	String projectCode;
	String projectName;
	String teamName;
	String employeeName;
	Date tDate;
	float workingHour;
	
	public Date gettDate() {
		return tDate;
	}

	public void settDate(Date tDate) {
		this.tDate = tDate;
	}

	public String getProjectCode() {
		return projectCode;
	}

	public void setProjectCode(String projectCode) {
		this.projectCode = projectCode;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getTeamName() {
		return teamName;
	}

	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}

	public String getEmployeeName() {
		return employeeName;
	}

	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}


	public float getWorkingHour() {
		return workingHour;
	}

	public void setWorkingHour(float workingHour) {
		this.workingHour = workingHour;
	}

}
