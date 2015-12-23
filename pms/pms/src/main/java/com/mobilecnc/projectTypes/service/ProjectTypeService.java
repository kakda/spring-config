/**
 * @author Chamroeun
 */
package com.mobilecnc.projectTypes.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mobilecnc.helper.PagingCondition;
import com.mobilecnc.helper.service.AbstractPagingService;
import com.mobilecnc.helper.service.PKService;
import com.mobilecnc.projectTypes.ProjectType;

@Service
public class ProjectTypeService extends AbstractPagingService {

	@Autowired
	ProjectTypeDAO projectTypeDAO;
	
	public List<ProjectType> getAllProjectTypes() throws Exception{
		return projectTypeDAO.getAllProjectTypes();
	}
	
	public List<ProjectTypeVO> selectProjectTypeList(ProjectTypeVO projectTypeVO) throws Exception
	{
		return projectTypeDAO.selectProjectTypeList(projectTypeVO);
	}
	
	public void insertProjectType(ProjectType projectType) throws Exception{
		projectType.setProjectTypeID(PKService.generateKey("ProjectTypes"));
		projectTypeDAO.insertProjectType(projectType);
		
	}

	public void updateProjectType(ProjectType projectType) throws Exception{
		projectTypeDAO.updateProjectType(projectType);
	}

	public void deleteProjectType(String projectTypeID) throws Exception{
		projectTypeDAO.deleteProjectType(projectTypeID);
	}
	
	public ProjectType getProjectType(String projectTypeID) throws Exception{
		return projectTypeDAO.getProjectType(projectTypeID);
	}

	public int checkExistName(ProjectType projectType) throws Exception{
		return projectTypeDAO.checkExistName(projectType);
	}
	
	@Override
	@SuppressWarnings("unchecked")
	public List<ProjectType> getPagingRecord(PagingCondition pagingCondition)
			throws Exception {
		return projectTypeDAO.getPagingRecord(pagingCondition);
	}

	@Override
	public int getRecordCount(PagingCondition pagingCondition) throws Exception {
		return projectTypeDAO.getRecordCount(pagingCondition);
	}

}
