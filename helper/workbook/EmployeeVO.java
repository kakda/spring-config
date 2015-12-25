package com.mcnc.yuga.helper.workbook;

import org.codehaus.jackson.annotate.JsonIgnore;
import org.codehaus.jackson.annotate.JsonIgnoreProperties;

import com.mcnc.yuga.dto.Employee;

@JsonIgnoreProperties(ignoreUnknown = true)
public class EmployeeVO extends Employee{
	private boolean roleEmployee;
	private boolean rolePM;
	private boolean roleSuperUser;
	private boolean allowDel;
	private String level;
	
//	@JsonIgnore
	public boolean isRoleEmployee() {
		return roleEmployee;
	}
	public void setRoleEmployee(boolean roleEmployee) {
		this.roleEmployee = roleEmployee;
	}
	public boolean isRolePM() {
		return rolePM;
	}
	public void setRolePM(boolean rolePM) {
		this.rolePM = rolePM;
	}
	public boolean isRoleSuperUser() {
		return roleSuperUser;
	}
	public void setRoleSuperUser(boolean roleSuperUser) {
		this.roleSuperUser = roleSuperUser;
	}
	
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public boolean isAllowDel() {
		return allowDel;
	}
	public void setAllowDel(boolean allowDel) {
		this.allowDel = allowDel;
	}
	
	
	@Override
	public String toString() {
		return "EmployeeVO [roleEmployee=" + roleEmployee + ", rolePM="
				+ rolePM + ", roleSuperUser=" + roleSuperUser + ", allowDel="
				+ allowDel + ", level=" + level + "]";
	}
	

	
	
}
