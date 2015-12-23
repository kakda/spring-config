package com.mobilecnc.timeCards.controller;

import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mobilecnc.calender.Calenders;
import com.mobilecnc.calender.service.CalenderService;
import com.mobilecnc.employees.service.EmployeeService;
import com.mobilecnc.employees.service.EmployeeVO;
import com.mobilecnc.helper.BaseController;
import com.mobilecnc.helper.Paging;
import com.mobilecnc.helper.report.DownloadService;
import com.mobilecnc.projectTypes.service.ProjectTypeService;
import com.mobilecnc.projectTypes.service.ProjectTypeVO;
import com.mobilecnc.projects.service.ProjectService;
import com.mobilecnc.projects.service.ProjectVO;
import com.mobilecnc.timeCardProjects.TimeCardProjectVO;
import com.mobilecnc.timeCardProjects.service.TimeCardProjectPaging;
import com.mobilecnc.timeCardUnsubmits.TimeCardUnsubmit;
import com.mobilecnc.timeCards.EmployeeReport;
import com.mobilecnc.timeCards.EntryParameter;
import com.mobilecnc.timeCards.ReportOfProject;
import com.mobilecnc.timeCards.ReportOfProjectGrid;
import com.mobilecnc.timeCards.TimeCardDaily;
import com.mobilecnc.timeCards.TimeCardDetail;
import com.mobilecnc.timeCards.TimeCardVO;
import com.mobilecnc.timeCards.Userdata;
import com.mobilecnc.timeCards.service.TimeCardService;
import com.mobilecnc.unsubmitReasons.service.UnsubmitReasonService;

@Controller
@RequestMapping(value = "/time-cards")
public class TimeCardController extends BaseController {

	/**
	 * Sambath Kakda
	 * 
	 */

	@Autowired
	ProjectService projectService;
	@Autowired
	TimeCardService timeCardService;
	@Autowired
	EmployeeService employeeService;
	@Autowired
	UnsubmitReasonService unsubmitReasonService;
	@Autowired
	DownloadService downloadService;
	@Autowired
	ProjectTypeService projectTypeService;
	@Autowired
	CalenderService calenderService;
	
	
	
	@RequestMapping("/entry")
	public String entry(ModelMap model) throws Exception {
		ProjectTypeVO projectvo = new ProjectTypeVO();
		projectvo.setProjectTypeList(projectTypeService.selectProjectTypeList(projectvo));
		model.addAttribute("page", "timeCards/entry");
		model.addAttribute("projectTypeList",projectvo.getProjectTypeList());
		return "layout/main";
	}

	@RequestMapping("/selectProjectList")
	public String selectProject(ModelMap model, HttpServletRequest request,
			@ModelAttribute("projectVO") ProjectVO projectVO,
			@ModelAttribute("EntryParameter") EntryParameter entryParameter,
			HttpSession session) throws Exception {
		entryParameter.setEmployeeID((String) session.getAttribute("user"));
		projectVO.setProjectList(projectService
				.getProjectForTimeCard(entryParameter));
		model.addAttribute("projectList", projectVO.getProjectList());
		return "timeCards/selectProjectList";
	}

	@RequestMapping("/entryJqgrid")
	public @ResponseBody
	TimeCardProjectPaging entryJqgrid(ModelMap model,
			HttpServletRequest request, HttpSession session) throws Exception {
		TimeCardProjectPaging t = new TimeCardProjectPaging();
		try {
			t = timeCardService.getTimeCardGrid(request,
					(String) session.getAttribute("user"));
			
		} catch (NullPointerException ex) {
			Userdata userdata = new Userdata();
			userdata.setMonday(0);
			userdata.setTuesday(0);
			userdata.setWednesday(0);
			userdata.setThursday(0);
			userdata.setFriday(0);
			userdata.setSaturday(0);
			userdata.setSunday(0);
			userdata.setSubmitted(false);
			userdata.setProjectName("Total: ");
			t.setUserdata(userdata);
		}
		return t;
	}
	
	@RequestMapping(value = "/entryJqgridCalender" ,method = RequestMethod.POST)
	public @ResponseBody List<Calenders>ajaxGetCalender(@RequestBody Calenders calender){
		return calenderService.getentryJqgridCalender(calender) ;
	}
	
	@RequestMapping("/saveEntry")
	public @ResponseBody
	boolean saveEntry(
			@ModelAttribute("TimeCardProjectVO") TimeCardProjectVO timeCardProjectVO)
			throws Exception {
		if (timeCardProjectVO.getTimeCardProjectID() != 0) {
			timeCardService.updateTimeCardProject(timeCardProjectVO);
		} else {
			timeCardService.insertTimeCardProject(timeCardProjectVO);
		}
		return true;
	}

	@RequestMapping("/doAdd")
	public @ResponseBody
	String doAdd(@ModelAttribute("TimeCardVO") TimeCardVO timeCardVO,
			HttpSession session) throws Exception {
		timeCardVO.setTotalWorkingHour(timeCardVO.getMonday()
				+ timeCardVO.getTuesday() + timeCardVO.getWednesday()
				+ timeCardVO.getThursday() + timeCardVO.getFriday()
				+ timeCardVO.getSaturday() + timeCardVO.getSunday());
		timeCardVO.setEmployeeID((String) session.getAttribute("user"));
		timeCardVO.setLastModifyBy((String) session.getAttribute("user"));
		timeCardVO.setEntryBy((String) session.getAttribute("user"));
		return timeCardService.saveTimeCard(timeCardVO);
	}

	@RequestMapping("/deleteProject")
	public @ResponseBody
	boolean deleteProject(HttpServletRequest request) throws Exception {
		timeCardService.deleteProject(Integer.parseInt(request
				.getParameter("timeCardProjectID")));
		return true;
	}

	@RequestMapping("/submitTimeCard")
	public @ResponseBody
	TimeCardVO submitTimeCard(
			@ModelAttribute("TimeCardVO") TimeCardVO timeCardVO,
			HttpSession session) throws Exception {
		timeCardVO.setSubmitted(true);
		timeCardVO.setLastModifyBy((String) session.getAttribute("user"));
		timeCardService.submitTimeCard(timeCardVO);
		return timeCardVO;
	}

	@RequestMapping("/unsubmit")
	public String unsubmit(ModelMap model) throws Exception {

		model.addAttribute("page", "timeCards/unsubmit");
		return "layout/main";
	}

	@RequestMapping("/selectEmployeeList")
	public String selectEmployeeList(ModelMap model,
			@ModelAttribute("employeeVO") EmployeeVO employeeVO,
			HttpServletRequest request,
			@RequestParam(defaultValue = "247px", value = "width") String width)
			throws Exception {
		model.addAttribute("employeeList",
				employeeService.selectEmployeeList(employeeVO));
		model.addAttribute("id", request.getParameter("id"));
		model.addAttribute("placeholder", request.getParameter("placeholder"));
		model.addAttribute("finished", request.getParameter("finished"));
		model.addAttribute("width", width);
		String multiple = "";
		if (request.getParameter("multiple") != null
				&& request.getParameter("multiple").equalsIgnoreCase("true")) {
			multiple = "multiple";
		}
		model.addAttribute("multiple", multiple);
		model.addAttribute("validate", request.getParameter("validate"));
		return "employees/selectEmployeeList";
	}

	@RequestMapping("/selectReasonList")
	public String selectReasonList(ModelMap model, HttpServletRequest request,
			@RequestParam(defaultValue = "247px", value = "width") String width)
			throws Exception {
		model.addAttribute("unsubmitReasonList",
				unsubmitReasonService.getUnsubmitReasonLists());
		model.addAttribute("id", request.getParameter("id"));
		model.addAttribute("placeholder", request.getParameter("placeholder"));
		model.addAttribute("finished", request.getParameter("finished"));
		model.addAttribute("width", width);
		String multiple = "";
		if (request.getParameter("multiple") != null
				&& request.getParameter("multiple").equalsIgnoreCase("true")) {
			multiple = "multiple";
		}
		model.addAttribute("multiple", multiple);
		model.addAttribute("validate", request.getParameter("validate"));

		return "unsubmitReasons/selectReasonList";
	}

	@RequestMapping("/unsubmitTimeCard")
	public @ResponseBody
	TimeCardUnsubmit unsubmitTimeCard(
			@ModelAttribute("TimeCardVO") TimeCardVO timeCardVO,
			@ModelAttribute("TimeCardUnsubmit") TimeCardUnsubmit timeCardUnsubmit,
			HttpSession session) throws Exception {
		timeCardVO.setSubmitted(false);
		timeCardVO.setLastModifyBy((String) session.getAttribute("user"));
		timeCardVO.setLastModifyDate(new Date());
		timeCardService.submitTimeCard(timeCardVO);

		timeCardUnsubmit.setEntryBy((String) session.getAttribute("user"));
		timeCardService.insertTimeCardUnsubmit(timeCardUnsubmit);
		return timeCardUnsubmit;
	}

	@RequestMapping("/reportEmployee")
	public String reportEmployee(ModelMap model) throws Exception {
		model.addAttribute("page", "timeCards/reportEmployee");
		return "layout/main";
	}

	@RequestMapping("/reportEmployeePeriod")
	public String reportEmployeePeriod(ModelMap model) throws Exception {
		model.addAttribute("page", "timeCards/reportEmployeePeriod");
		return "layout/main";
	}

	@RequestMapping("/reportGetEmployeePeriodAjax")
	public @ResponseBody
	List<TimeCardDaily> reportGetEmployeePeriodAjax(
			EntryParameter entryParameter) throws Exception {
		return timeCardService.getEmployeePeriodReport(entryParameter);
	}

	@RequestMapping("/reportGetEmployeeFilterByDayAjax")
	public @ResponseBody
	List<TimeCardProjectVO> reportGetEmployeeFilterByDayAjax(
			EntryParameter entryParameter) throws Exception {
		return timeCardService.getProjectFilterByDay(entryParameter);
	}

	@RequestMapping("/reportGetEmployeeAjax")
	public @ResponseBody
	List<EmployeeReport> getReportEmployee(EntryParameter entryParameter)
			throws Exception {
		return timeCardService.getEmployeeReport(entryParameter);
	}

	@RequestMapping("/reportTimeCardOfProject")
	public String reportTimeCardOfProject(ModelMap model) throws Exception {
		model.addAttribute("page", "timeCards/reportTimeCardOfProject");
		return "layout/main";
	}

	@RequestMapping("/reportTimeCardOfProjectAjax")
	public @ResponseBody
	ReportOfProjectGrid reportTimeCardOfProjectAjax(ModelMap model,
			HttpServletRequest request) throws Exception {
		return timeCardService.getReportTimeCardOfProjectAjax(request
				.getParameter("projectID"));
	}
	
	@RequestMapping("/reportTimeCardOfProjectAjaxByStaffID")
	public @ResponseBody List<ReportOfProject> getReportTimeCardOfProjectAjaxByStaffID(ModelMap model,HttpServletRequest request) throws Exception {
		return timeCardService.getReportTimeCardOfProjectAjaxByStaffID(
				request.getParameter("projectID"),request.getParameter("staffID"));		
	}
	
	/*public @ResponseBody
	ReportOfProjectGrid getReportTimeCardOfProjectAjaxByStaffID(ModelMap model,
			HttpServletRequest request) throws Exception {
		return timeCardService.getReportTimeCardOfProjectAjaxByStaffID(request
				.getParameter("projectID"),request.getParameter("staffID"));
	}*/


	@RequestMapping("/reportTimeCardByBillable")
	public String reportTimeCardByBillable(ModelMap model) throws Exception {
		model.addAttribute("page", "timeCards/reportTimeCardByBillable");
		return "layout/main";
	}

	@RequestMapping("/reportTimeCardByBillableAjax")
	public @ResponseBody
	ReportOfProjectGrid reportTimeCardByBillableAjax(ModelMap model,
			EntryParameter entryParameter) throws Exception {
		return timeCardService.getReportTimeCardByBillableAjax(entryParameter);
	}

	@RequestMapping("/reports/download-project")
	public void downloadOfProject(
			@RequestParam(defaultValue = "pdf", value = "type") String type,
			@RequestParam(value = "projectID") String projectID,
			@RequestParam(defaultValue = "", value = "token") String token,
			HttpServletResponse response, HttpServletRequest request)
			throws SQLException {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("projectID", projectID);

		downloadService.download(type, token, response,
				"/mobilecnc/reports/timecard_of_project_" + type + ".jrxml",
				params);
	}

	@RequestMapping("/reports/download-billable")
	public void downloadByBillable(
			@RequestParam(defaultValue = "pdf", value = "type") String type,
			EntryParameter entryParameter,
			@RequestParam(defaultValue = "", value = "token") String token,
			HttpServletResponse response, HttpServletRequest request)
			throws SQLException {
		HashMap<String, Object> params = new HashMap<String, Object>();

		params.put("startDate", entryParameter.getStartDate());
		params.put("endDate", entryParameter.getEndDate());
		params.put("billable", entryParameter.isBillable());

		downloadService.download(type, token, response,
				"/mobilecnc/reports/timecard_by_billable_" + type + ".jrxml",
				params);
	}

	/**
	 * Rin Rady
	 * 
	 * @param type
	 * @param token
	 * @param startDate
	 * @param endDate
	 * @param teamID
	 * @param response
	 * @param request
	 * @throws SQLException
	 * @throws ParseException
	 */

	@RequestMapping(value = "/reports/download-team")
	public void download(
			@RequestParam(defaultValue = "pdf", value = "type") String type,
			@RequestParam(defaultValue = "", value = "token") String token,
			@RequestParam(defaultValue = "", value = "startDate") String startDate,
			@RequestParam(defaultValue = "", value = "endDate") String endDate,
			@RequestParam(defaultValue = "", value = "tID") String teamID,
			HttpServletResponse response, HttpServletRequest request)
			throws SQLException, ParseException {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("startDate", startDate);
		params.put("endDate", endDate);
		params.put("teamID", teamID);
		downloadService.download(type, token, response,
				"/mobilecnc/reports/timecardteam" + type + ".jrxml", params);
	}

	@RequestMapping("/reportTimeCardOfTeam")
	public String reportTimeCardOfTeam(ModelMap model) throws Exception {
		model.addAttribute("page", "timeCards/reportTimeCardOfTeam");
		return "layout/main";
	}

	@RequestMapping("/reportTimeCardOfTeamAjax")
	public @ResponseBody
	ReportOfProjectGrid reportTimeCardOfTeamAjax(ModelMap model,
			HttpServletRequest request,
			@ModelAttribute EntryParameter entryParameter) throws Exception {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		entryParameter.setStartDate(df.parse(request.getParameter("sDate")));
		entryParameter.setEndDate(df.parse(request.getParameter("eDate")));
		return timeCardService.getReportTimeCardOfTeamAjax(entryParameter);
	}

	@RequestMapping("/reportTimeCardDetail")
	public String reportTimeCardDetail(ModelMap model) throws Exception {

		model.addAttribute("page", "timeCards/reportTimeCardDetail");
		return "layout/main";
	}
	

	@RequestMapping("/reportTimeCardDetailAjax")
	public @ResponseBody Paging<TimeCardDetail> reportTimeCardDetailAjax(ModelMap model,
			HttpServletRequest request,
			@ModelAttribute EntryParameter entryParameter) throws Exception {
		
		
		entryParameter.setYear(Float.parseFloat(request.getParameter("year")));
		entryParameter.setMinMonth(Float.parseFloat(request.getParameter("minMonth")));
		entryParameter.setMaxMonth(Float.parseFloat(request.getParameter("maxMonth")));
		
		
		Paging<TimeCardDetail> paging = new Paging<TimeCardDetail>();		

		paging.setPage(1);
		paging.setRows(timeCardService.getTimeCardDetail(entryParameter));
		paging.setTotal(9999999);
		paging.setRecords(99999999);
		
		return paging;
	}
	

	/**
	 * Sambath Kakda
	 * 
	 * @param type
	 * @param token
	 * @param minMonth
	 * @param maxMonth
	 * @param year
	 * @param response
	 * @param request
	 * @throws SQLException
	 * @throws ParseException
	 */

	@RequestMapping(value = "/reports/download-timecard-detail")
	public void downloadTimecardDetail(
			@RequestParam(defaultValue = "pdf", value = "type") String type,
			@RequestParam(defaultValue = "", value = "token") String token,
			@RequestParam(defaultValue = "", value = "year") int year,
			@RequestParam(defaultValue = "", value = "minMonth") int minMonth,
			@RequestParam(defaultValue = "", value = "maxMonth") int maxMonth,
			HttpServletResponse response, HttpServletRequest request)
			throws SQLException, ParseException {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("year", year);
		params.put("start_month", minMonth);
		params.put("end_month", maxMonth);
		downloadService.download(type, token, response,
				"/mobilecnc/reports/timecardemployee_" + type + ".jrxml", params);
	}
	
	@RequestMapping(value ="/reports/reportProjectType")
	public String reportProjectType(ModelMap model) throws Exception{
		ProjectTypeVO projectTypeList = new ProjectTypeVO();
		projectTypeList.setProjectTypeList(projectTypeService.selectProjectTypeList(projectTypeList));
		model.addAttribute("page","timeCards/reportProjectType");
		model.addAttribute("projectTypeList",projectTypeList.getProjectTypeList());
		return "layout/main";
	}
	
	@RequestMapping(value="/reportProjectTypeAjax")
	public @ResponseBody
	ReportOfProjectGrid reprotProjectTypeAjax(ModelMap model,HttpServletRequest request) throws Exception{
		return timeCardService.getProjectTypeList(request.getParameter("projectTypeID"));
	}
	
	@RequestMapping(value="/entryGetpreviouseMonth")
	public @ResponseBody
	TimeCardProjectPaging getPreviouseMonth (HttpServletRequest request,HttpSession session) throws Exception{
		TimeCardProjectPaging t = new TimeCardProjectPaging();
		try {
			t = timeCardService.getTimeCardGrid(request,(String) session.getAttribute("user"));
			
		} catch (NullPointerException ex) {
			
		}
		return t;
	}
	
	
	@RequestMapping(value="/reportTimeCardDetailExcel")
	public ModelAndView reportTimeCardDetailExcel(HttpServletRequest request ,@ModelAttribute EntryParameter entryParameter) throws Exception{
		ModelAndView map = new ModelAndView("reportTimeCardDetailExcelView");
		map.addObject("timeCardsDetailList",timeCardService.getTimeCardDetail(entryParameter));
		map.addObject("entryParameter",entryParameter);
		return map;
	}
	
	@RequestMapping(value="reportTimeCardDetailPDF")
	public ModelAndView reportTimeCardDetailPDF(HttpServletRequest request ,@ModelAttribute EntryParameter entryParameter) throws Exception{
		ModelAndView map=new ModelAndView("reportTimeCardDetailPDF");
		map.addObject("timeCardsDetailList",timeCardService.getTimeCardDetail(entryParameter));
		map.addObject("entryParameter",entryParameter);
		return map;
	}
	
	@RequestMapping(value="/reportTimeCardOfTeamExcel")
	public ModelAndView reportTimeCardOfTeamExcel(HttpServletRequest request, @ModelAttribute EntryParameter entryParameter) throws Exception{
		ModelAndView map = new ModelAndView("reportTimeCardOfTeamExcelView");
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		entryParameter.setStartDate(df.parse(request.getParameter("sDate")));
		entryParameter.setEndDate(df.parse(request.getParameter("eDate")));
		map.addObject("reportTimeCardOfTeamList", timeCardService.getReportTimeCardOfTeamAjax(entryParameter));
		map.addObject("entryParameter", entryParameter);
		return map;
	}
	
	@RequestMapping(value="/reportTimeCardOfTeamPDF")
	public ModelAndView reportTimeCardOfTeamPDF(HttpServletRequest request, @ModelAttribute EntryParameter entryParameter) throws Exception{
		ModelAndView map = new ModelAndView("reportTimeCardOfTeamPDFView");
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		entryParameter.setStartDate(df.parse(request.getParameter("sDate")));
		entryParameter.setEndDate(df.parse(request.getParameter("eDate")));
		map.addObject("reportTimeCardOfTeamList", timeCardService.getReportTimeCardOfTeamAjax(entryParameter));
		map.addObject("entryParameter", entryParameter);
		return map;
	}
	
	
	
	/*Report time card of project*/
	@RequestMapping(value="/reportTimeCardOfProjectExcel")
	public ModelAndView reportTimeCardOfProjectExcel(HttpServletRequest request) throws Exception{
		ModelAndView map = new ModelAndView("reportTimeCardOfProjectExcelView");
		map.addObject("reportTimeCardOfProjectList",
				timeCardService.getReportTimeCardOfProjectAjaxByStaffID(
						request.getParameter("projectID"),
						request.getParameter("staffID")
						)
					);	
		map.addObject("projectID",request.getParameter("projectID"));
		return map;
	}
	
	
	@RequestMapping(value="/reportTimeCardOfProjectPDF")
	public ModelAndView reportTimeCardOfProjectPDF(HttpServletRequest request) throws Exception{
		ModelAndView map = new ModelAndView("reportTimeCardOfProjectPDFView");
		map.addObject("reportTimeCardOfProjectList",
				timeCardService.getReportTimeCardOfProjectAjaxByStaffID(
						request.getParameter("projectID"),
						request.getParameter("staffID")
						)
					);	
		map.addObject("projectID",request.getParameter("projectID"));
		return map;
	}
	
	@RequestMapping(value="reportTimeCardByBillableExcel")
	public ModelAndView reportTimeCardByBillableExcel(HttpServletRequest request,@ModelAttribute EntryParameter entryParameter) throws Exception{
		ModelAndView map= new ModelAndView("reportTimeCardByBillableExcelView");
		map.addObject("timeCardByBillableList",timeCardService.getReportTimeCardByBillableAjax(entryParameter));
		map.addObject("entryParameter",entryParameter);
		return map;
	}
	
	@RequestMapping(value="reportTimeCardByBillablePdf")
	public ModelAndView reportTimeCardByBillablePdf(HttpServletRequest request, @ModelAttribute EntryParameter entryParameter) throws Exception{
		ModelAndView map = new ModelAndView("reportTimeCardByBillablePDF");
		map.addObject("timeCardByBillableList",timeCardService.getReportTimeCardByBillableAjax(entryParameter));
		map.addObject("entryParameter",entryParameter);
		return map;
	}
}
