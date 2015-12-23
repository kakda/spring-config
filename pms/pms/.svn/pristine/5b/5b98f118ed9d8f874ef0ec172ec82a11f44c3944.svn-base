package com.mobilecnc.projects;

import java.io.Serializable;
import java.util.Date;

import org.codehaus.jackson.map.annotate.JsonSerialize;
import org.springframework.format.annotation.NumberFormat;
import org.springframework.format.annotation.NumberFormat.Style;

import com.mobilecnc.helper.CustomDateSerializer;

public class Project implements Serializable{

	private static final long serialVersionUID = 1L;
	private String projectID;
	private String projectName;
	private String projectTypeID;
	private boolean billable;
	private String description;
	private float revenue;
	private float revenueLicense;
	private float revenueSI;
	private float revenueThirdParty;
	private float plannedMM;
	private Date plannedStartDate;
	private Date plannedEndDate;
	private boolean started;
	private boolean finished;
	private int actualMM;
	private Date actualStartDate;
	private Date actualEndDate;
	private int additionalInternalMM;
	private boolean maClosed;
	private Date maStartDate;
	private Date maClosedDate;
	private String customerID;
	private String svn;
	private String svnUrl;
	private String redmine;
	private String redmineUrl;
	private String closedReason;
	private int currencyID;
	private String checkProName;
	
	public String getProName() {
		return checkProName;
	}
	public void setProName(String proName) {
		this.checkProName = proName;
	}
	public int getCurrencyID() {
		return currencyID;
	}
	public void setCurrencyID(int currencyID) {
		this.currencyID = currencyID;
	}
	public String getProjectID() {
		return projectID;
	}
	public void setProjectID(String projectID) {
		this.projectID = projectID;
	}
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public String getProjectTypeID() {
		return projectTypeID;
	}
	public void setProjectTypeID(String projectTypeID) {
		this.projectTypeID = projectTypeID;
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
	public float getRevenue() {
		return revenue;
	}
	public void setRevenue(float revenue) {
		this.revenue = revenue;
	}
	public float getRevenueLicense() {
		return revenueLicense;
	}
	public void setRevenueLicense(float revenueLicense) {
		this.revenueLicense = revenueLicense;
	}
	public float getRevenueSI() {
		return revenueSI;
	}
	public void setRevenueSI(float revenueSI) {
		this.revenueSI = revenueSI;
	}
	public float getRevenueThirdParty() {
		return revenueThirdParty;
	}
	public void setRevenueThirdParty(float revenueThirdParty) {
		this.revenueThirdParty = revenueThirdParty;
	}
	public float getPlannedMM() {
		return plannedMM;
	}
	public void setPlannedMM(float plannedMM) {
		this.plannedMM = plannedMM;
	}
	@JsonSerialize(using = CustomDateSerializer.class)
	public Date getPlannedStartDate() {
		return plannedStartDate;
	}
	public void setPlannedStartDate(Date plannedStartDate) {
		this.plannedStartDate = plannedStartDate;
	}
	public Date getPlannedEndDate() {
		return plannedEndDate;
	}
	public void setPlannedEndDate(Date plannedEndDate) {
		this.plannedEndDate = plannedEndDate;
	}
	public boolean isStarted() {
		return started;
	}
	public void setStarted(boolean started) {
		this.started = started;
	}
	public boolean isFinished() {
		return finished;
	}
	public void setFinished(boolean finished) {
		this.finished = finished;
	}
	public int getActualMM() {
		return actualMM;
	}
	public void setActualMM(int actualMM) {
		this.actualMM = actualMM;
	}
	public void setActualStartDate(Date actualStartDate) {
		this.actualStartDate = actualStartDate;
	}
	@JsonSerialize(using=CustomDateSerializer.class)
	public Date getActualStartDate() {
		return actualStartDate;
	}
	public void setActualEndDate(Date actualEndDate) {
		this.actualEndDate = actualEndDate;
	}
	@JsonSerialize(using=CustomDateSerializer.class)
	public Date getActualEndDate() {
		return actualEndDate;
	}
	public int getAdditionalInternalMM() {
		return additionalInternalMM;
	}
	public void setAdditionalInternalMM(int additionalInternalMM) {
		this.additionalInternalMM = additionalInternalMM;
	}
	public boolean isMaClosed() {
		return maClosed;
	}
	public void setMaClosed(boolean maClosed) {
		this.maClosed = maClosed;
	}
	public Date getMaStartDate() {
		return maStartDate;
	}
	public void setMaStartDate(Date maStartDate) {
		this.maStartDate = maStartDate;
	}
	public Date getMaClosedDate() {
		return maClosedDate;
	}
	public void setMaClosedDate(Date maClosedDate) {
		this.maClosedDate = maClosedDate;
	}
	public String getCustomerID() {
		return customerID;
	}
	public void setCustomerID(String customerID) {
		this.customerID = customerID;
	}
	public String getSvn() {
		return svn;
	}
	public void setSvn(String svn) {
		this.svn = svn;
	}
	public String getSvnUrl() {
		return svnUrl;
	}
	public void setSvnUrl(String svnUrl) {
		this.svnUrl = svnUrl;
	}
	public String getRedmine() {
		return redmine;
	}
	public void setRedmine(String redmine) {
		this.redmine = redmine;
	}
	public String getRedmineUrl() {
		return redmineUrl;
	}
	public void setRedmineUrl(String redmineUrl) {
		this.redmineUrl = redmineUrl;
	}
	public String getClosedReason() {
		return closedReason;
	}
	public void setClosedReason(String closedReason) {
		this.closedReason = closedReason;
	}
	@Override
	public String toString() {
		return "Project [projectID=" + projectID + ", projectName="
				+ projectName + ", projectTypeID=" + projectTypeID
				+ ", billable=" + billable + ", description=" + description
				+ ", revenue=" + revenue + ", revenueLicense=" + revenueLicense
				+ ", revenueSI=" + revenueSI + ", revenueThirdParty="
				+ revenueThirdParty + ", plannedMM=" + plannedMM
				+ ", plannedStartDate=" + plannedStartDate
				+ ", plannedEndDate=" + plannedEndDate + ", started=" + started
				+ ", finished=" + finished + ", actualMM=" + actualMM
				+ ", actualStartDate=" + actualStartDate + ", actualEndDate="
				+ actualEndDate + ", additionalInternalMM="
				+ additionalInternalMM + ", maClosed=" + maClosed
				+ ", maStartDate=" + maStartDate + ", maClosedDate="
				+ maClosedDate + ", customerID=" + customerID + ", svn=" + svn
				+ ", svnUrl=" + svnUrl + ", redmine=" + redmine
				+ ", redmineUrl=" + redmineUrl + ", closedReason="
				+ closedReason + ", currencyID=" + currencyID
				+ ", checkProName=" + checkProName + ", getProName()="
				+ getProName() + ", getCurrencyID()=" + getCurrencyID()
				+ ", getProjectID()=" + getProjectID() + ", getProjectName()="
				+ getProjectName() + ", getProjectTypeID()="
				+ getProjectTypeID() + ", isBillable()=" + isBillable()
				+ ", getDescription()=" + getDescription() + ", getRevenue()="
				+ getRevenue() + ", getRevenueLicense()=" + getRevenueLicense()
				+ ", getRevenueSI()=" + getRevenueSI()
				+ ", getRevenueThirdParty()=" + getRevenueThirdParty()
				+ ", getPlannedMM()=" + getPlannedMM()
				+ ", getPlannedStartDate()=" + getPlannedStartDate()
				+ ", getPlannedEndDate()=" + getPlannedEndDate()
				+ ", isStarted()=" + isStarted() + ", isFinished()="
				+ isFinished() + ", getActualMM()=" + getActualMM()
				+ ", getActualStartDate()=" + getActualStartDate()
				+ ", getActualEndDate()=" + getActualEndDate()
				+ ", getAdditionalInternalMM()=" + getAdditionalInternalMM()
				+ ", isMaClosed()=" + isMaClosed() + ", getMaStartDate()="
				+ getMaStartDate() + ", getMaClosedDate()=" + getMaClosedDate()
				+ ", getCustomerID()=" + getCustomerID() + ", getSvn()="
				+ getSvn() + ", getSvnUrl()=" + getSvnUrl() + ", getRedmine()="
				+ getRedmine() + ", getRedmineUrl()=" + getRedmineUrl()
				+ ", getClosedReason()=" + getClosedReason() + ", getClass()="
				+ getClass() + ", hashCode()=" + hashCode() + ", toString()="
				+ super.toString() + "]";
	}
	
}
