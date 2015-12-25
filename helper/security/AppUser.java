package com.mcnc.yuga.helper.security;

import java.util.Date;


public class AppUser {

	private String userName;
	private boolean isReset;
	private Role role;
	private Date enrolledDate;


	public AppUser(String userName) {
		super();
		this.userName = userName;
	}

	public AppUser(String userName, boolean isReset) {
		super();
		this.userName = userName;
		this.isReset = isReset;
	}
	
	public AppUser(String userName, boolean isReset, Role role) {
		this.userName = userName;
		this.isReset = isReset;
		this.role = role;
	}

	public AppUser(String userName, boolean isReset, Role role,
			Date enrolledDate) {
		super();
		this.userName = userName;
		this.isReset = isReset;
		this.role = role;
		this.enrolledDate = enrolledDate;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public boolean isReset() {
		return isReset;
	}

	public void setReset(boolean isReset) {
		this.isReset = isReset;
	}
	
	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}
	

	public Date getEnrolledDate() {
		return enrolledDate;
	}

	public void setEnrolledDate(Date enrolledDate) {
		this.enrolledDate = enrolledDate;
	}

	@Override
	public String toString() {
		return "AppUser [userName=" + userName + ", isReset=" + isReset
				+ ", role=" + role + ", enrolledDate=" + enrolledDate + "]";
	}
}
