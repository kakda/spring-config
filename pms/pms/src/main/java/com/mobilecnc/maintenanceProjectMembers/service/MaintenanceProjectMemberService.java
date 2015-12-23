package com.mobilecnc.maintenanceProjectMembers.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mobilecnc.maintenanceProjectMembers.MaintenanceProjectMember;

@Service
public class MaintenanceProjectMemberService {
	
	@Autowired
	MaintenanceProjectMemberDAO maintenanceProjectMemberDAO;
	
	public List<MaintenanceProjectMemberVO> selectMaintenanceProjectMemberList(MaintenanceProjectMemberVO maintenanceProjectMemberVO) throws Exception {
		return maintenanceProjectMemberDAO.selectMaintenanceProjectMemberList(maintenanceProjectMemberVO);
	}
	
	public void insertMaintenanceProjectMember(MaintenanceProjectMember maintenanceProjectMember) throws Exception
	{
		maintenanceProjectMemberDAO.insertMaintenanceProjectMember(maintenanceProjectMember);
	}
	
	public String selectMaintenanceProjectManager(String projectID) throws Exception
	{
		return maintenanceProjectMemberDAO.selectMaintenanceProjectManager(projectID);
	}
	
	public List<MaintenanceProjectMemberVO> selectMaintenanceProjectMembers(MaintenanceProjectMemberVO maintenanceProjectMemberVO) throws Exception
	{
		return maintenanceProjectMemberDAO.selectMaintenanceProjectMembers(maintenanceProjectMemberVO);
	}

	public void updateMaintenanceProjectMember(MaintenanceProjectMember maintenanceProjectMember) throws Exception {	
		maintenanceProjectMemberDAO.updateMaintenanceProjectMember(maintenanceProjectMember);
	}
	
	public void deleteMaintenanceProjectMembers(String projectID) throws Exception {	
		maintenanceProjectMemberDAO.deleteMaintenanceProjectMembers(projectID);
	}
	
}
