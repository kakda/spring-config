package com.mobilecnc.projectMembers.service;

import java.util.List;

import com.mobilecnc.employees.Employee;
import com.mobilecnc.projectMembers.ProjectMember;

public class ProjectMemberVO extends ProjectMember{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	
	List<ProjectMemberVO> projectMemberList;
	
	public List<ProjectMemberVO> getProjectMemberList()
	{
		return projectMemberList;
	}
	
	public void setProjectMemberList(List<ProjectMemberVO> projectMemberList)
	{
		this.projectMemberList = projectMemberList;
	}
	
}
