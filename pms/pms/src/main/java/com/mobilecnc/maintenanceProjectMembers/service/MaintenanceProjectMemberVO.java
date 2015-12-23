package com.mobilecnc.maintenanceProjectMembers.service;

import java.util.List;

import com.mobilecnc.maintenanceProjectMembers.MaintenanceProjectMember;

public class MaintenanceProjectMemberVO extends MaintenanceProjectMember{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	
	List<MaintenanceProjectMemberVO> maintenanceProjectMemberList;
	
	public List<MaintenanceProjectMemberVO> getMaintenanceProjectMemberList()
	{
		return maintenanceProjectMemberList;
	}
	
	public void setMaintenanceProjectMemberList(List<MaintenanceProjectMemberVO> maintenanceProjectMemberList)
	{
		this.maintenanceProjectMemberList = maintenanceProjectMemberList;
	}
	
}
