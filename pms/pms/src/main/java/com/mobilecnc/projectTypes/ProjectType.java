/**
 * @author Chamroeun
 */
package com.mobilecnc.projectTypes;

import java.sql.Date;

public class ProjectType {

	public String projectTypeID;
	public String projectTypeName;
	public boolean billable;
	public String description;
	public Date entryDate;
	public String entryBy;
	public Date lastModifyDate;
	public String lastModifyBy;
	
	public String getProjectTypeID() {
		return projectTypeID;
	}
	public void setProjectTypeID(String projectTypeID) {
		this.projectTypeID = projectTypeID;
	}
	public String getProjectTypeName() {
		return projectTypeName;
	}
	public void setProjectTypeName(String projectTypeName) {
		this.projectTypeName = projectTypeName;
	}
	public boolean isBillable() {
		return billable;
	}
	public void setBillable(boolean billable) {
		this.billable = billable;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Date getEntryDate() {
		return entryDate;
	}
	public void setEntryDate(Date entryDate) {
		this.entryDate = entryDate;
	}
	public String getEntryBy() {
		return entryBy;
	}
	public void setEntryBy(String entryBy) {
		this.entryBy = entryBy;
	}
	public Date getLastModifyDate() {
		return lastModifyDate;
	}
	public void setLastModifyDate(Date lastModifyDate) {
		this.lastModifyDate = lastModifyDate;
	}
	public String getLastModifyBy() {
		return lastModifyBy;
	}
	public void setLastModifyBy(String lastModifyBy) {
		this.lastModifyBy = lastModifyBy;
	}
	
}
