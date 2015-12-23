/**
 * @author Chamroeun
 */
package com.mobilecnc.customers;

import java.sql.Date;

public class Customer {

	public String customerID;
	public String customerNameEn;
	public String customerNameKr;
	public String industry;
	public String address;
	public String contactName;
	public String contactMobilePhone;
	public String contactCompanyPhone;
	public String contactEmail;
	public String description;
	public Date entryDate;
	public String entryBy;
	public Date lastModifyDate;
	public String lastModifyBy;
	
	public String getCustomerID() {
		return customerID;
	}
	public void setCustomerID(String customerID) {
		this.customerID = customerID;
	}
	public String getCustomerNameEn() {
		return customerNameEn;
	}
	public void setCustomerNameEn(String customerNameEn) {
		this.customerNameEn = customerNameEn;
	}
	public String getCustomerNameKr() {
		return customerNameKr;
	}
	public void setCustomerNameKr(String customerNameKr) {
		this.customerNameKr = customerNameKr;
	}
	public String getIndustry() {
		return industry;
	}
	public void setIndustry(String industry) {
		this.industry = industry;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getContactName() {
		return contactName;
	}
	public void setContactName(String contactName) {
		this.contactName = contactName;
	}
	public String getContactMobilePhone() {
		return contactMobilePhone;
	}
	public void setContactMobilePhone(String contactMobilePhone) {
		this.contactMobilePhone = contactMobilePhone;
	}
	public String getContactCompanyPhone() {
		return contactCompanyPhone;
	}
	public void setContactCompanyPhone(String contactCompanyPhone) {
		this.contactCompanyPhone = contactCompanyPhone;
	}
	public String getContactEmail() {
		return contactEmail;
	}
	public void setContactEmail(String contactEmail) {
		this.contactEmail = contactEmail;
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
