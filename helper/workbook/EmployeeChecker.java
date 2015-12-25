package com.mcnc.yuga.helper.workbook;

import com.mcnc.yuga.dto.Employee;

public class EmployeeChecker extends Employee {

	private Boolean isInsert;

	public Boolean getIsInsert() {
		return isInsert;
	}


	public void setIsInsert(Boolean isInsert) {
		this.isInsert = isInsert;
	}
	
	public EmployeeChecker() {
		this.isInsert = true;
	}


	@Override
	public String toString() {
		return "EmployeeChecker [isInsert=" + isInsert + "]";
	}
	
	
}
