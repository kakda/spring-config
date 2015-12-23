package com.mobilecnc.teams;

import java.util.Date;

import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.mobilecnc.helper.CustomDateSerializer;
import com.mobilecnc.helper.CustomDateTimeSerializer;

/**
 * 
 * @author sereysopheak.eap
 *
 */
public class Team {
	private String teamID;
	private String teamName;
	private String description;
	private Date createdOn;
	private String createdBy;
	private Date entryDate;
	private String entryBy;
	private Date lastModifyDate;
	private String lastModifyBy;
	public String getTeamID() {
		return teamID;
	}
	public void setTeamID(String teamID) {
		this.teamID = teamID;
	}
	public String getTeamName() {
		return teamName;
	}
	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
	@JsonSerialize(using = CustomDateSerializer.class)
	public Date getCreatedOn() {
		return createdOn;
	}
	
	public void setCreatedOn(Date createdOn) {
		this.createdOn = createdOn;
	}
	public String getCreatedBy() {
		return createdBy;
	}
	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}
	
	@JsonSerialize(using = CustomDateTimeSerializer.class)
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
	@JsonSerialize(using = CustomDateTimeSerializer.class)
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
