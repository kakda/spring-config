package com.mobilecnc.maintenanceProjectMembers;

import java.io.Serializable;
import java.util.Date;

import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.mobilecnc.helper.CustomDateSerializer;

public class MaintenanceProjectMember implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String projectID;
	private String employeeID;
	private String maMemberTypeID;
	private Date plannedAssignDate;
	private Date plannedReleaseDate;
	public String getProjectID() {
		return projectID;
	}
	public void setProjectID(String projectID) {
		this.projectID = projectID;
	}
	public String getEmployeeID() {
		return employeeID;
	}
	public void setEmployeeID(String employeeID) {
		this.employeeID = employeeID;
	}
	public String getmaMemberTypeID() {
		return maMemberTypeID;
	}
	public void setmaMemberTypeID(String maMemberTypeID) {
		this.maMemberTypeID = maMemberTypeID;
	}
	@JsonSerialize(using=CustomDateSerializer.class)
	public Date getPlannedAssignDate() {
		return plannedAssignDate;
	}
	public void setPlannedAssignDate(Date plannedAssignDate) {
		this.plannedAssignDate = plannedAssignDate;
	}
	@JsonSerialize(using=CustomDateSerializer.class)
	public Date getPlannedReleaseDate() {
		return plannedReleaseDate;
	}
	public void setPlannedReleaseDate(Date plannedReleaseDate) {
		this.plannedReleaseDate = plannedReleaseDate;
	}
	
	/**
	 * Employee property bin
	 */
	private String employeeType;
	public void setEmployeeType(String employeeType) {
		this.employeeType = employeeType;
	}

	public String getEmployeeType() {
		return employeeType;
	}

}
