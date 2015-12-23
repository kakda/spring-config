package com.mobilecnc.projects.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mobilecnc.helper.PagingCondition;
import com.mobilecnc.helper.service.AbstractPagingService;

@Service
public class ProjectServiceClose extends AbstractPagingService{
	@Autowired
	ProjectDAO projectDAO;
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ProjectVO> getPagingRecord(PagingCondition pagingCondition)
			throws Exception {
		return projectDAO.getPagingRecordClose(pagingCondition);
	}

	@Override
	public int getRecordCount(PagingCondition pagingCondition) throws Exception {
		return projectDAO.getRecordCountClose(pagingCondition);
	}
	
}
