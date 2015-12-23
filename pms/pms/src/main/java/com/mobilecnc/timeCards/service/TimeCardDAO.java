package com.mobilecnc.timeCards.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.mobilecnc.timeCardProjects.TimeCardProjectVO;
import com.mobilecnc.timeCardUnsubmits.TimeCardUnsubmit;
import com.mobilecnc.timeCards.EmployeeReport;
import com.mobilecnc.timeCards.EntryParameter;
import com.mobilecnc.timeCards.ReportOfProject;
import com.mobilecnc.timeCards.TimeCard;
import com.mobilecnc.timeCards.TimeCardDaily;
import com.mobilecnc.timeCards.TimeCardDetail;
import com.mobilecnc.timeCards.TimeCardVO;


public interface TimeCardDAO {
	
	public List<TimeCardProjectVO> getTimeCardEntry(EntryParameter entryParameter) throws Exception;
	public List<EmployeeReport> getEmployeeReport(EntryParameter entryParameter) throws Exception;
	public List<TimeCardDaily> getEmployeePeriodReport(EntryParameter entryParameter) throws Exception;
	
	public List<TimeCardProjectVO> getProjectFilterByDay(EntryParameter entryParameter) throws Exception;
	
	public TimeCard checkTimeCardSubmitted(TimeCard timeCard) throws Exception;
	
	public List<ReportOfProject> getTimeCardOfProject(String ProjectID) throws Exception;
	
	public List<ReportOfProject> getTimeCardOfProjectByEmployeeID( @Param("projectID") String ProjectID,@Param("staffID") String StaffID ) throws Exception;
	
	public List<ReportOfProject> getTimeCardOfTeam(EntryParameter entryParameter) throws Exception;

	public List<ReportOfProject> getTimeCardByBillable(EntryParameter entryParameter) throws Exception;
	
	public List<TimeCardDetail> getTimeCardDetail(EntryParameter entryParameter) throws Exception;

	public int checkExistingTimeCard(TimeCardVO timeCardVO) throws Exception;
	public String getTimeCardIDByDate(TimeCardVO timeCardVO) throws Exception;
	public void insertTimeCard(TimeCardVO timeCardVO) throws Exception;
	public void updateTimeCard(TimeCardVO timeCardVO) throws Exception;
	public void deleteProject(int timeCardID) throws Exception;
	public void submitTimeCard(TimeCardVO timeCardVO) throws Exception;
	public String getLastTimeCardID(String prefix) throws Exception;
	public int getTotalTimeCardID(String prefix) throws Exception;	
	public void insertTimeCardProject(TimeCardProjectVO timeCardProjectVO) throws Exception;
	public void updateTimeCardProject(TimeCardProjectVO timeCardProjectVO) throws Exception;
	public void insertTimeCardUnsubmit(TimeCardUnsubmit timeCardUnsubmit) throws Exception;
	
	public List<ReportOfProject> getProjectTypeList(String ProjectTypeID) throws Exception;
}
