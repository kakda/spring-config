package com.mobilecnc.projectMembers;

import java.io.Serializable;
import java.util.Date;

import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.mobilecnc.helper.CustomDateSerializer;

public class ProjectMember implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String projectID;
	private String employeeID;
	private String memberTypeID;
	private String maMemberTypeID;
	public String getMaMemberTypeID() {
		return maMemberTypeID;
	}
	public void setMaMemberTypeID(String maMemberTypeID) {
		this.maMemberTypeID = maMemberTypeID;
	}

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
	public String getMemberTypeID() {
		return memberTypeID;
	}
	public void setMemberTypeID(String memberTypeID) {
		this.memberTypeID = memberTypeID;
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
	
	/**
	 * outside property
	 */
	private String employeeIDOld;
	public String getEmployeeIDOld() {
		return employeeIDOld;
	}
	public void setEmployeeIDOld(String employeeIDOld) {
		this.employeeIDOld = employeeIDOld;
	}
}
