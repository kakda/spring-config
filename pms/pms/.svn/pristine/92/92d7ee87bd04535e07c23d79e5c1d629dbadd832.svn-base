package com.mobilecnc.projects.service;

import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mobilecnc.helper.Paging;
import com.mobilecnc.helper.PagingCondition;
import com.mobilecnc.helper.service.AbstractPagingService;
import com.mobilecnc.projects.Project;
import com.mobilecnc.timeCards.EntryParameter;
import com.mobilecnc.helper.Paging;
import com.mobilecnc.helper.PagingCondition;

@Service
public class ProjectService extends AbstractPagingService {
	@Autowired
	ProjectDAO projectDAO;
	
	public List<ProjectVO> selectProjectList(ProjectVO projectVO)
			throws Exception {
		return projectDAO.selectProjectList(projectVO);
	}
	
	public List<ProjectVO> selectEmployeeList(ProjectVO projectVO)
			throws Exception {
		return projectDAO.selectEmployeeList(projectVO);
	}

	public int checkExisName(Project project) throws Exception {
		return projectDAO.checkExisName(project);
	}

	public void insertProject(Project project) throws Exception {
		projectDAO.insertProject(project);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ProjectVO> getPagingRecord(PagingCondition pagingCondition)
			throws Exception {
		return projectDAO.getPagingRecord(pagingCondition);
	}
	/*
	@Override
	public List<ProjectVO> getTotalRecord()
			throws Exception {
		return projectDAO.getProjectReport();
	}*/

	@Override
	public int getRecordCount(PagingCondition pagingCondition) throws Exception {
		return projectDAO.getRecordCount(pagingCondition);
	}
	
	public void deleteProject(String projectID) throws Exception {
		projectDAO.deleteProject(projectID);
	}

	public Project getProject(String projectID) throws Exception {
		return projectDAO.getProject(projectID);
	}
	
	public List<ProjectVO> projectYear() throws Exception {
		return projectDAO.projectYear();
	}
	
	public Project selectProjectByID(String projectID) throws Exception {
		return projectDAO.selectProjectByID(projectID);
	}

	/*
	 * Sambath Kakda
	 */

	public List<ProjectVO> getProjectForTimeCard(EntryParameter entryParameter)
			throws Exception {
		return projectDAO.getProjectForTimeCard(entryParameter);

	}
	
	public void updateProject(Project project) throws Exception {
		projectDAO.updateProject(project);
	}

	public int ajaxCheckSVN(String svn) throws Exception{
		return projectDAO.ajaxCheckSVN(svn);
	}
	
	@SuppressWarnings("unchecked")
	public  List<ProjectVO> getProjectReport(SearchProjectParmeter searchProject) throws Exception{
	
		PagingCondition pagingCondition = new PagingCondition();
		String where ="";
		
		int page=1;
		int rows= 30;
		String sidx="projectID";
		String sord="asc";
		String searchField = "projectTypeName";
		String searchString = searchProject.getProjectTypeID() == null ? "":searchProject.getProjectTypeID().trim();
	
		String searchField1 = "employeeName";
		String searchString1 = searchProject.getEmployeeID() == null ? "" : searchProject.getEmployeeID().trim();
		
		String searchField2 = "customerName";
		String searchString2 = searchProject.getCustomerID() == null ? "" : searchProject.getCustomerID().trim();
		
		String searchYearFiled = "actualStartDate";
		String searchYearString = searchProject.getYear() == null ? "" : searchProject.getYear().trim();
		
		//String searchOper = request.getParameter("searchOper");
		//PagingCondition pagingCondition = new PagingCondition(page, rows, sidx, sord);
		int totalRecord;

	/*	if (true) {*/
			String oper = "cn";
			String val = searchString.trim();
			String col = "UPPER(" + searchField.trim() + ")";

			if (oper.equals("bw") || oper.equals("bn")) {
				val = "N'" + val + "%'";
			}
			if (oper.equals("ew") || oper.equals("en")) {
				val += "N'%" + val + "'";
			}
			if (oper.equals("cn") || oper.equals("nc") || oper.equals("in")
					|| oper.equals("ni")) {
				val = "N'%" + val.toUpperCase() + "%'";

			}
			
			//String where = "";
			
			pagingCondition.setCol(col);
			pagingCondition.setOper(pagingCondition.getOpsByKey(oper));
			pagingCondition.setVal(val);
			where = " AND ( " + col + " " + pagingCondition.getOper() + " " + val + " ) ";
			
			
			if(!searchString1.equals(""))
			{
				String col1 = "UPPER(" + searchField1.trim() + ")";
				String val1 = "N'" + searchString1.trim().toUpperCase() + "'";
				where += " AND ( " + col1 + " LIKE " + val1 + " ) ";
			}
			
			if(!searchString2.equals(""))
			{
				String col2 = "UPPER(" + searchField2.trim() + ")";
				String val2 = "N'" + searchString2.trim().toUpperCase() + "'";
				where += " AND ( " + col2 + " LIKE " + val2 + " ) ";
			}
			
			if(!searchYearString.equals(""))
			{
				String colYear = "YEAR(" + searchYearFiled.trim() + ")";
				String valYear = "'" + searchYearString.trim() + "'";
				where += " AND ( " + colYear + " = " + valYear + " ) ";
			}
			
			pagingCondition.setWhere(where);
			
			//totalRecord = this.getRecordCount(pagingCondition);
			
			// System.out.println("**********total Record***********:"+totalRecord);
	/*	} else {
			pagingCondition.setCol(null);
			totalRecord = this.getRecordCount(pagingCondition);
		}*/
		List<ProjectVO>  list = projectDAO.getProjectReport(pagingCondition);
		//int total = (int) Math.ceil((float) totalRecord / rows);

		/*paging.setPage(page);
		paging.setRows(list);
		paging.setTotal(total);
		paging.setRecords(totalRecord);*/
		return list;
	}
	
}
