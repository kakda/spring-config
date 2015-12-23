package com.mobilecnc.employees;

public class SearchEmployeeExcel {
	
	private String projectID;
	private String year;
	private String skillID;
	private String skillName;
	private String projectName;
	public String getProjectID() {
		return projectID;
	}
	public String getSkillName() {
		return skillName;
	}
	public void setSkillName(String skillName) {
		this.skillName = skillName;
	}
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public void setProjectID(String projectID) {
		this.projectID = projectID;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getSkillID() {
		return skillID;
	}
	public void setSkillID(String skillID) {
		this.skillID = skillID;
	}

	@Override
	public String toString() {
		return "SearchEmployeeExcel [projectID=" + projectID + ", year=" + year
				+ ", skillID=" + skillID + "]";
	}
	
	

}
