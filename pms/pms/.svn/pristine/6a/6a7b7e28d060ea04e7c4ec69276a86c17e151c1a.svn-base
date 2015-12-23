package com.mobilecnc.projects.service;

import java.util.List;

import com.mobilecnc.helper.PagingCondition;
import com.mobilecnc.projects.Project;
import com.mobilecnc.timeCards.EntryParameter;


public interface ProjectDAO {

	public List<ProjectVO> selectProjectList(ProjectVO projectVO) throws Exception;
	
	public List<ProjectVO> selectEmployeeList(ProjectVO projectVO) throws Exception;	

	public int checkExisName(Project project) throws Exception;

	public void insertProject(Project project) throws Exception;

	public List<ProjectVO> getPagingRecord(PagingCondition pagingCondition) throws Exception;

	public int getRecordCount(PagingCondition pagingCondition) throws Exception;
	
	public List<ProjectVO> getPagingRecordClose(PagingCondition pagingCondition) throws Exception;

	public int getRecordCountClose(PagingCondition pagingCondition) throws Exception;

	public void deleteProject(String projectID) throws Exception;

	public Project selectProjectByID(String projectID) throws Exception;
	
	public Project getProject(String projectID) throws Exception;
	
	public List<ProjectVO> projectYear() throws Exception;
	
	/*
	 *  Sambath Kakda
	 * 
	 */
	public List<ProjectVO> getProjectForTimeCard(EntryParameter entryParameter) throws Exception;
	
	public void updateProject(Project project) throws Exception;

	public int ajaxCheckSVN(String svn) throws Exception;
	
	public List<ProjectVO> getProjectReport(PagingCondition pagingCondition) throws Exception;
	
	
}
