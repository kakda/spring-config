package com.mobilecnc.timeCards.service;

import java.lang.reflect.Array;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mobilecnc.helper.PagingCondition;
import com.mobilecnc.helper.service.AbstractPagingService;
import com.mobilecnc.helper.service.PKService;
import com.mobilecnc.timeCardProjects.TimeCardProjectVO;
import com.mobilecnc.timeCardProjects.service.TimeCardProjectPaging;
import com.mobilecnc.timeCardUnsubmits.TimeCardUnsubmit;
import com.mobilecnc.timeCards.EmployeeReport;
import com.mobilecnc.timeCards.EntryParameter;
import com.mobilecnc.timeCards.ReportOfProject;
import com.mobilecnc.timeCards.ReportOfProjectGrid;
import com.mobilecnc.timeCards.TimeCard;
import com.mobilecnc.timeCards.TimeCardDaily;
import com.mobilecnc.timeCards.TimeCardDetail;
import com.mobilecnc.timeCards.TimeCardVO;
import com.mobilecnc.timeCards.Userdata;

@Service
public class TimeCardService extends AbstractPagingService {
	@Autowired
	TimeCardDAO timeCardDAO;

	public List<TimeCardProjectVO> getTimeCardEntry(
			EntryParameter entryParameter) throws Exception {
		return timeCardDAO.getTimeCardEntry(entryParameter);
	}

	public TimeCard checkTimeCardSubmitted(TimeCard timeCard) throws Exception {
		return timeCardDAO.checkTimeCardSubmitted(timeCard);
	}

	public String getTimeCardID(String prefix) throws Exception {
		int countTimeCard = timeCardDAO.getTotalTimeCardID(prefix);
		int prevId = 0;
		String timeCardId = "";
		if (countTimeCard > 0) {
			prevId = Integer.parseInt(timeCardDAO.getLastTimeCardID(prefix));
			timeCardId = getGenerateID(prevId + 1, prefix);
		} else {
			timeCardId = getGenerateID(1, prefix);
		}
		return timeCardId;
	}

	public String getGenerateID(int prevId, String prefix) {
		String id = prefix;
		if (prevId < 10) {
			id += "000" + Integer.toString(prevId);
		} else if (prevId < 100) {
			id += "00" + Integer.toString(prevId);
		} else if (prevId < 1000) {
			id += "0" + Integer.toString(prevId);
		} else if (prevId < 10000) {
			id += Integer.toString(prevId);
		}
		return id;
	}

	public TimeCardProjectPaging getTimeCardGrid(HttpServletRequest request,
			String currentUser) throws Exception, NullPointerException {
		if (request.getParameter("employeeID") != null) {
			currentUser = (String) request.getParameter("employeeID");
		}

		float monday = 0, tuesday = 0, wednesday = 0, thursday = 0, friday = 0, saturday = 0, sunday = 0;

		TimeCardProjectPaging timeCardProjectPaging = new TimeCardProjectPaging();
		EntryParameter entryParameter = new EntryParameter();
		entryParameter.setEmployeeID(currentUser);
		entryParameter.setStartDate(new SimpleDateFormat("yyyy-MM-dd",
				Locale.ENGLISH).parse(request.getParameter("startDate")));
		entryParameter.setEndDate(new SimpleDateFormat("yyyy-MM-dd",
				Locale.ENGLISH).parse(request.getParameter("endDate")));

		// Copy project from previous timecard
		if (!request.getParameter("year").isEmpty()) {
			this.moveProjectToNextWeek(request, currentUser, entryParameter);
		}
		
		List<TimeCardProjectVO> list = new ArrayList<TimeCardProjectVO>();
		Userdata userdata = new Userdata();

		list = timeCardDAO.getTimeCardEntry(entryParameter);
		
		if (list.size() == 0)
			throw new NullPointerException();
			
		for (TimeCardProjectVO t : list) {
			monday += t.getMonday();
			tuesday += t.getTuesday();
			wednesday += t.getWednesday();
			thursday += t.getThursday();
			friday += t.getFriday();
			saturday += t.getSaturday();
			sunday += t.getSunday();

			if (t.getTimeCardID() == null) {
				userdata.setSubmitted(false);
			} else {
				userdata.setSubmitted(true);
				userdata.setTimeCardID(t.getTimeCardID());
			}
		}

		userdata.setMonday(monday);
		userdata.setTuesday(tuesday);
		userdata.setWednesday(wednesday);
		userdata.setThursday(thursday);
		userdata.setFriday(friday);
		userdata.setSaturday(saturday);
		userdata.setSunday(sunday);
		userdata.setProjectName("Total: ");

		if (userdata.getSubmitted() == true) {
			TimeCard timeCard = new TimeCard();
			timeCard.setTimeCardID(userdata.getTimeCardID());
			timeCard = timeCardDAO.checkTimeCardSubmitted(timeCard);
			userdata.setSubmitted(timeCard.getSubmitted());
		}
		timeCardProjectPaging.setUserdata(userdata);
		timeCardProjectPaging.setRows(list);
		return timeCardProjectPaging;
	}

	public String saveTimeCard(TimeCardVO timeCardVO) throws Exception {
		String timeCardID = null;
		if (timeCardDAO.checkExistingTimeCard(timeCardVO) > 0) {
			timeCardID = timeCardDAO.getTimeCardIDByDate(timeCardVO);
			timeCardDAO.updateTimeCard(timeCardVO);
		} else {
			String prefix = timeCardVO.getYear() + timeCardVO.getMonth()
					+ timeCardVO.getDay();
			timeCardID = getTimeCardID(prefix);
			timeCardVO.setTimeCardID(timeCardID);
			timeCardVO.setSubmitted(false);
			System.out.println(timeCardID);
			timeCardDAO.insertTimeCard(timeCardVO);
		}
		return timeCardID;
	}

	public void deleteProject(int timeCardID) throws Exception {
		timeCardDAO.deleteProject(timeCardID);
	}

	public void submitTimeCard(TimeCardVO timeCardVO) throws Exception {
		timeCardDAO.submitTimeCard(timeCardVO);
	}

	public void insertTimeCardProject(TimeCardProjectVO timeCardProjectVO)
			throws Exception {

		timeCardDAO.insertTimeCardProject(timeCardProjectVO);
	}

	public void updateTimeCardProject(TimeCardProjectVO timeCardProjectVO)
			throws Exception {

		timeCardDAO.updateTimeCardProject(timeCardProjectVO);
	}

	public void insertTimeCardUnsubmit(TimeCardUnsubmit timeCardUnsubmit)
			throws Exception {
		timeCardUnsubmit.setTimeCardUnsubmitID(PKService
				.generateKey("TimeCardUnsubmits"));
		timeCardDAO.insertTimeCardUnsubmit(timeCardUnsubmit);
	}

	public List<EmployeeReport> getEmployeeReport(EntryParameter entryParameter)
			throws Exception {
		return timeCardDAO.getEmployeeReport(entryParameter);
	}

	public List<TimeCardDaily> getEmployeePeriodReport(
			EntryParameter entryParameter) throws Exception {
		return timeCardDAO.getEmployeePeriodReport(entryParameter);
	}

	public List<TimeCardProjectVO> getProjectFilterByDay(
			EntryParameter entryParameter) throws Exception {
		return timeCardDAO.getProjectFilterByDay(entryParameter);
	}

	public List<TimeCardDetail> getTimeCardDetail(EntryParameter entryParameter)
			throws Exception {
		return timeCardDAO.getTimeCardDetail(entryParameter);
	}

	public ReportOfProjectGrid getReportTimeCardOfProjectAjax(String projectID)
			throws Exception {
		ReportOfProjectGrid reportOfProjectGrid = new ReportOfProjectGrid();
		reportOfProjectGrid
				.setRows(timeCardDAO.getTimeCardOfProject(projectID));
		return reportOfProjectGrid;
	}
	
	public List<ReportOfProject> getReportTimeCardOfProjectAjaxByStaffID(String projectID,String StaffID)
			throws Exception {			
		return timeCardDAO.getTimeCardOfProjectByEmployeeID(projectID,StaffID);
	}

	public ReportOfProjectGrid getReportTimeCardOfTeamAjax(
			EntryParameter entryParameter) throws Exception {
		ReportOfProjectGrid reportOfProjectGrid = new ReportOfProjectGrid();
		reportOfProjectGrid.setRows(timeCardDAO
				.getTimeCardOfTeam(entryParameter));
		return reportOfProjectGrid;
	}

	public ReportOfProjectGrid getReportTimeCardByBillableAjax(
			EntryParameter entryParameter) throws Exception {
		ReportOfProjectGrid reportOfProjectGrid = new ReportOfProjectGrid();
		reportOfProjectGrid.setRows(timeCardDAO
				.getTimeCardByBillable(entryParameter));
		return reportOfProjectGrid;
	}

	/*
	 * Copy Project from previous week to next week Author: Sambath Kakda
	 */

	public void moveProjectToNextWeek(HttpServletRequest request,
			String currentUser, EntryParameter entryParameter) throws Exception {
		TimeCardVO timeCardVO = new TimeCardVO();
		timeCardVO.setEmployeeID(currentUser);
		timeCardVO.setYear(Integer.parseInt(request.getParameter("year")));
		timeCardVO.setWeek(Integer.parseInt(request.getParameter("week")));

		if (timeCardDAO.checkExistingTimeCard(timeCardVO) == 0) {
			// There is no timecard. Let start moving !!!
			
			long DAY_IN_MS = 1000 * 60 * 60 * 24;
			List<TimeCardProjectVO> list = new ArrayList<TimeCardProjectVO>();
			EntryParameter epPreWeek = new EntryParameter();

			epPreWeek.setEmployeeID(timeCardVO.getEmployeeID());
			epPreWeek.setStartDate(new Date(entryParameter.getStartDate().getTime() - (7 * DAY_IN_MS)));
			epPreWeek.setEndDate(new Date(entryParameter.getEndDate().getTime() - (7 * DAY_IN_MS)));
			

			list = timeCardDAO.getTimeCardEntry(epPreWeek);
			// Get timecard previous week

			if (list.size() > 0) { // Copy timecard to the current week

				timeCardVO.setMonday(0);
				timeCardVO.setTuesday(0);
				timeCardVO.setWednesday(0);
				timeCardVO.setThursday(0);
				timeCardVO.setFriday(0);
				timeCardVO.setSaturday(0);
				timeCardVO.setSunday(0);
				timeCardVO.setTotalWorkingHour(0);
				timeCardVO.setDay(getCurrentDay());
				timeCardVO.setMonth(getCurrentMonth());

				String timeCardID = saveTimeCard(timeCardVO);

				for (TimeCardProjectVO timeCardProjectVO : list) {
					// copy Timecard Projects
					timeCardProjectVO.setTimeCardID(timeCardID);
					timeCardProjectVO.setMonday(0);
					timeCardProjectVO.setTuesday(0);
					timeCardProjectVO.setWenesday(0);
					timeCardProjectVO.setThursday(0);
					timeCardProjectVO.setFriday(0);
					timeCardProjectVO.setSaturday(0);
					timeCardProjectVO.setSunday(0);
					timeCardProjectVO.setTotalWorkingHour(0);
					timeCardDAO.insertTimeCardProject(timeCardProjectVO);
				}
			}
		}
	}

	/*
	 * Get Maximum week of the year Author: Sambath Kakda
	 */
	public int getMaxWeekOfYear(float year) {
		Calendar c = Calendar.getInstance();
		c.set(Calendar.YEAR, (int) year);
		c.set(Calendar.MONTH, 0);
		c.set(Calendar.DAY_OF_MONTH, 1);
		return c.get(Calendar.WEEK_OF_YEAR);
	}

	public String getCurrentDay() {
		Calendar c = Calendar.getInstance();
		if (c.get(Calendar.DAY_OF_MONTH) < 10) {
			return "0" + Integer.toString(c.get(Calendar.DAY_OF_MONTH));
		} else {
			return Integer.toString(c.get(Calendar.DAY_OF_MONTH));
		}
	}

	public String getCurrentMonth() {
		Calendar c = Calendar.getInstance();
		if (c.get(Calendar.MONTH) + 1 < 10) {
			return "0" + Integer.toString(c.get(Calendar.MONTH) + 1);
		} else {
			return Integer.toString(c.get(Calendar.MONTH) + 1);
		}
	}

	@Override
	public <T> List<T> getPagingRecord(PagingCondition pagingCondition)
			throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int getRecordCount(PagingCondition pagingCondition) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}
	
	public ReportOfProjectGrid getProjectTypeList(String projectTypeID) throws Exception{
		ReportOfProjectGrid reportOfProjectGrid = new ReportOfProjectGrid();
		reportOfProjectGrid.setRows(timeCardDAO.getProjectTypeList(projectTypeID));
		return reportOfProjectGrid;
	}
}
