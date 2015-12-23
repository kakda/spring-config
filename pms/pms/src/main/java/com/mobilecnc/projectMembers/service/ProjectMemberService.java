package com.mobilecnc.projectMembers.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mobilecnc.projectMembers.ProjectMember;

@Service
public class ProjectMemberService {
	
	@Autowired
	ProjectMemberDAO projectMemberDAO;
	
	public List<ProjectMemberVO> selectProjectMemberList(ProjectMemberVO projectMemberVO) throws Exception {
		return projectMemberDAO.selectProjectMemberList(projectMemberVO);
	}
	
	public void insertProjectMember(ProjectMember projectMember) throws Exception
	{
		projectMemberDAO.insertProjectMember(projectMember);
	}

	public void insertProjectMemberMa(ProjectMember projectMember) throws Exception{
		projectMemberDAO.insertProjectMemberMa(projectMember);
	}
	
	public String selectProjectManager(String projectID) throws Exception
	{
		return projectMemberDAO.selectProjectManager(projectID);
	}
	
	public String selectProjectManagerMa(String projectID) throws Exception
	{
		return projectMemberDAO.selectProjectManagerMa(projectID);
	}
	
	public List<ProjectMemberVO> selectProjectMembers(ProjectMemberVO projectMemberVO) throws Exception
	{
		return projectMemberDAO.selectProjectMembers(projectMemberVO);
	}
	
	public List<ProjectMemberVO> selectProjectMembersMa(ProjectMemberVO projectMemberVO) throws Exception
	{
		return projectMemberDAO.selectProjectMembersMa(projectMemberVO);
	}

	public void updateProjectMember(ProjectMember projectMember) throws Exception {	
		projectMemberDAO.updateProjectMember(projectMember);
	}
	
	public void deleteProjectMembers(String projectID) throws Exception {	
		projectMemberDAO.deleteProjectMembers(projectID);
	}
	
	public void deleteMultiProjectMember(ProjectMember projectMember) throws Exception {	
		projectMemberDAO.deleteMultiProjectMember(projectMember);
	}
	
	public void updateMember(ProjectMember projectMember) throws Exception {	
		projectMemberDAO.updateMember(projectMember); 
	}

	public void updateProjectManager(ProjectMember projectMember) throws Exception{
		projectMemberDAO.updateProjectManager(projectMember);
	}

	public void updateProjectOwner(ProjectMember projectMember) throws Exception{
		projectMemberDAO.updateProjectOwner(projectMember) ;
	}

	public void updateMemberMa(ProjectMember projectMember) throws Exception{
		projectMemberDAO.updateMemberMa(projectMember); 
	}

	public void deleteMultiProjectMemberMa(ProjectMember projectMember) throws Exception{
		projectMemberDAO.deleteMultiProjectMemberMa(projectMember);
	}
	
	public void deleteProjectMember(ProjectMember projectMember) throws Exception{
		projectMemberDAO.deleteProjectMember(projectMember);
	}
	
	public void deleteProjectMemberMa(ProjectMember projectMember) throws Exception{
		projectMemberDAO.deleteProjectMemberMa(projectMember);
	}
	
}
