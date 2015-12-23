package com.mobilecnc.timeCardUnsubmits;

import java.util.Date;

public class TimeCardUnsubmit {
	
	private String timeCardUnsubmitID;
	private String timeCardID;
	private String unsubmitReasonID;
	private String employeeID;
	private String approvedID;
	private String otherReason;
	private Date entryDate;
	private String entryBy;
	public String getTimeCardUnsubmitID() {
		return timeCardUnsubmitID;
	}
	public void setTimeCardUnsubmitID(String timeCardUnsubmitID) {
		this.timeCardUnsubmitID = timeCardUnsubmitID;
	}
	public String getTimeCardID() {
		return timeCardID;
	}
	public void setTimeCardID(String timeCardID) {
		this.timeCardID = timeCardID;
	}
	public String getUnsubmitReasonID() {
		return unsubmitReasonID;
	}
	public void setUnsubmitReasonID(String unsubmitReasonID) {
		this.unsubmitReasonID = unsubmitReasonID;
	}
	public String getEmployeeID() {
		return employeeID;
	}
	public void setEmployeeID(String employeeID) {
		this.employeeID = employeeID;
	}
	public String getApprovedID() {
		return approvedID;
	}
	public void setApprovedID(String approvedID) {
		this.approvedID = approvedID;
	}
	public String getOtherReason() {
		return otherReason;
	}
	public void setOtherReason(String otherReason) {
		this.otherReason = otherReason;
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
}
