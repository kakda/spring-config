/**
 * @author Chamroeun
 */
package com.mobilecnc.projectTypes.service;

import java.util.List;

import com.mobilecnc.helper.PagingCondition;
import com.mobilecnc.projectTypes.ProjectType;

public interface ProjectTypeDAO {
	public List<ProjectType> getAllProjectTypes() throws Exception;

	public void insertProjectType(ProjectType projectType) throws Exception;

	public void updateProjectType(ProjectType projectType) throws Exception;

	public void deleteProjectType(String projectTypeID) throws Exception;

	public List<ProjectType> getPagingRecord(PagingCondition pagingCondition);

	public int getRecordCount(PagingCondition pagingCondition);

	public ProjectType getProjectType(String projectTypeID) throws Exception;

	public int checkExistName(ProjectType projectType) throws Exception;
	
	public List<ProjectTypeVO> selectProjectTypeList(ProjectTypeVO projectTypeVO) throws Exception;
}
