package com.mobilecnc.timeCardProjects;

public class TimeCardProjectVO extends TimeCardProject{
	private int isDefault;
	private String projectName;
	private String projectTypeName;
	
	public String getProjectTypeName() {
		return projectTypeName;
	}
	public void setProjectTypeName(String projectTypeName) {
		this.projectTypeName = projectTypeName;
	}
	public int getIsDefault() {
		return isDefault;
	}
	public void setIsDefault(int isDefault) {
		this.isDefault = isDefault;
	}
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	} 
	
	
}
