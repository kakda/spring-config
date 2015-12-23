package com.mobilecnc.projects.controller;

import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mobilecnc.exception.GenericException;
import com.mobilecnc.helper.BaseController;
import com.mobilecnc.helper.Message;
import com.mobilecnc.helper.Paging;
import com.mobilecnc.helper.report.DownloadService;
import com.mobilecnc.helper.service.PKService;
import com.mobilecnc.helper.service.PropertiesService;
import com.mobilecnc.helper.service.SVNService;
import com.mobilecnc.maintenanceProjectMembers.MaintenanceProjectMember;
import com.mobilecnc.maintenanceProjectMembers.service.MaintenanceProjectMemberService;
import com.mobilecnc.maintenanceProjectMembers.service.MaintenanceProjectMemberVO;
import com.mobilecnc.projectMembers.ProjectMember;
import com.mobilecnc.projectMembers.service.ProjectMemberService;
import com.mobilecnc.projectMembers.service.ProjectMemberVO;
import com.mobilecnc.projects.Project;
import com.mobilecnc.projects.service.ProjectService;
import com.mobilecnc.projects.service.ProjectServiceClose;
import com.mobilecnc.projects.service.ProjectVO;
import com.mobilecnc.projects.service.SearchProjectParmeter;
import com.mobilecnc.redmine.RedmineService;
import com.mobilecnc.redmine.Repository;
import com.mobilecnc.redmine.RepositoryVO;
import com.mobilecnc.redmine.service.RepositoryService;

@Controller
@RequestMapping(value = "/projects")
public class ProjectController extends BaseController{
	
	Logger logger=Logger.getLogger(ProjectController.class);
	@Autowired
	ProjectService projectService;
	
	@Autowired
	ProjectServiceClose projectServiceClose;
	
	@Autowired
	ProjectMemberService projectMemberService;
	
	@Autowired
	MaintenanceProjectMemberService maintenanceProjectMemberService;
	
	@Autowired
	SVNService svnService;
	
	@Autowired
	RedmineService redmineService;
	
	@Autowired
	RepositoryService repositoryService;
	
	@Autowired
	DownloadService downloadService;
	/**
	 * Rin Rady
	 * 
	 */
	@RequestMapping("/index")
	public String index(ModelMap model, HttpSession session){
		model.addAttribute("page", "projects/index");
		model.addAttribute("message", session.getAttribute("message"));
		session.setAttribute("message", new Message());
		return "layout/main";
	}
	
	@RequestMapping("/project-report")
	public String report(ModelMap model, HttpSession session){
		model.addAttribute("page", "projects/report");
		model.addAttribute("message", session.getAttribute("message"));
		session.setAttribute("message", new Message());
		return "layout/main";
	}
	
	@RequestMapping(value="/reports/download")
	public void download(@RequestParam(defaultValue = "pdf", value = "type") String type,@RequestParam(defaultValue = "", value = "projectName") String projectName, 
			@RequestParam(defaultValue = "", value = "projectTypeID1") String projectTypeID1, 
			@RequestParam(defaultValue = "", value = "customerID1") String customerID1, 
			@RequestParam(defaultValue = "", value = "employeeID1") String employeeID1,
			@RequestParam(defaultValue = "", value = "actualYear1") String actualYear1,
			@RequestParam (defaultValue = "", value = "token") String token,
			HttpServletResponse response, HttpServletRequest request) throws SQLException {
		HashMap<String, Object> params = new HashMap<String, Object>(); 
		if(projectTypeID1==null) projectTypeID1="";
		if(customerID1==null) customerID1="";
		if(employeeID1==null) employeeID1="";
		if(actualYear1==null) actualYear1="";
		params.put("projectTypeName", projectTypeID1);
		params.put("customerName", customerID1);
		params.put("employeeName", employeeID1);
		params.put("actualYear", actualYear1);
		
		//downloadService.download(type, token, response,"/mobilecnc/reports/project"+type+".jrxml",params);
	}
	
	@RequestMapping("/projectClose")
	public String projectClose(ModelMap model){
		model.addAttribute("page", "projects/projectClose");
		return "layout/main";
	}
	
	@RequestMapping("/projectYear")
	public String projectYear(ModelMap model, @ModelAttribute("projectVO") ProjectVO projectVO) throws Exception {
		projectVO.setProjectList(projectService.projectYear());
		model.addAttribute("projectYear", projectVO.getProjectList());
		return "projects/projectYear";
	}
	
	@RequestMapping("/doClose")
	public String doClose(@ModelAttribute Project project, @ModelAttribute("Message") Message message, HttpSession session) throws Exception{
		project.setFinished(true);
		project.setStarted(true);
		projectService.updateProject(project);
		message.setSaveSuccess();
		session.setAttribute("message", message);
		return "redirect:/projects/index.html";
	}
	
	@RequestMapping("/close")
	public String close(ModelMap model, @RequestParam String projectID, @RequestParam String projectName){
		if(! projectID.equals(""))
		{
			model.addAttribute("projectID", projectID);
			model.addAttribute("projectName", projectName);
			model.addAttribute("page", "projects/close");
			return "layout/main";
		}
		return "redirect:/projects/index.html"; 
	}
	
	@RequestMapping("/add")
	public String add(ModelMap model, HttpSession session) {
		model.addAttribute("page", "projects/add");
		model.addAttribute("userRole", session.getAttribute("userRole").toString());
		model.addAttribute("user", session.getAttribute("user").toString());
		return "layout/main";
	}
	
	@RequestMapping(value = "/selectRepository")
	public  @ResponseBody RepositoryVO selectRepository(ModelMap model) {
		RepositoryVO repositoryVO = new RepositoryVO();
		List<Repository> r = repositoryService.getAllRepository();
		repositoryVO.setRows(r);
		model.addAttribute("msg", repositoryVO);
		return repositoryVO;
	}
	
	@RequestMapping("/ajaxCheckSVN")
	public @ResponseBody
	String ajaxCheckSVN(ModelMap model, HttpServletRequest request) throws Exception {
		
		String svn = request.getParameter("fieldValue");
		if(svn != null && !svn.equals(""))
		{
			ArrayList<String> projects = (ArrayList<String>) SVNService.getProjectsName();
			if(! projects.isEmpty())
			{
				Iterator<String> iter = projects.iterator();
				while(iter.hasNext())
				{
					if(svn.toLowerCase().equals(iter.next()))
					{
						return "[\"" + request.getParameter("fieldId") + "\",false]";
					}
				}
					
			}
		}
		return "[\"" + request.getParameter("fieldId") + "\",true]";
	}

	@RequestMapping("/doAdd")
	public String doAdd(@ModelAttribute ProjectMember projectMember, ModelMap model, @ModelAttribute("Message") Message message, @ModelAttribute("Project") Project project, HttpSession session, HttpServletRequest request) throws Exception {
		project.setProjectID(PKService.generateKey("Projects"));
		String projectID = project.getProjectID();
		/**
		 * Create SVN repository
		 */
		if(project.getSvn() != null && !project.getSvn().equals(""))
		{
			SVNService.createSVNRepository(project.getSvn());
			project.setSvnUrl(PropertiesService.getProperty("SVN.url")+project.getSvn());
		}
		/**
		 * Create Redmine repository
		 */
		if(project.getRedmine() != null && !project.getRedmine().equals(""))
		{
			Random r = new Random();
		    String alphabet = "abcdefghijklmnopqrstuvwxyz";
		    String indentifier = "";
		    for (int i = 0; i < 50; i++) {
		    	indentifier += alphabet.charAt(r.nextInt(alphabet.length()));
		    } 
			redmineService.createRedmineRepository(project.getRedmine(), indentifier);
			project.setRedmineUrl(PropertiesService.getProperty("redmine.uri")+"/projects/"+indentifier);
		}
		/**
		 * Insert Project
		 */
		projectService.insertProject(project);
		
		/**
		 * Insert Project Manager
		 */
		DateFormat df1 = new SimpleDateFormat("yyyy-MM-dd"); 
	    Date NOW = new Date();
	    NOW = df1.parse(df1.format(new Date()));

	    projectMember.setProjectID(projectID);
		projectMember.setMemberTypeID("MBT01");
		projectMember.setPlannedAssignDate(NOW);
		projectMember.setEmployeeID(request.getParameter("employeeID"));
		projectMemberService.insertProjectMember(projectMember);
		
		/**
		 * Insert Project Members
		 */
		projectMember.setMemberTypeID("MBT02");
		String[] members = request.getParameterValues("member");
		if(members != null)
		{
			for (int i = 0; i < members.length; i++) 
		    {
				projectMember.setEmployeeID(members[i]);
				projectMemberService.insertProjectMember(projectMember);
		    }
		}
		
		/**
		 * Insert Project Contractors
		 */
		String[] contractors = request.getParameterValues("contractor");
		if(contractors != null)
		{
			for (int i = 0; i < contractors.length; i++) 
		    {
				projectMember.setEmployeeID(contractors[i]);
				projectMemberService.insertProjectMember(projectMember);
		    }
		}
		
		message.setSaveSuccess();
		session.setAttribute("message", message);
		return "redirect:/projects/index.html";
	}
	
	@RequestMapping("/selectProjectList")
	public String selectProjectList(ModelMap model, @ModelAttribute("projectVO") ProjectVO projectVO) throws Exception {
		projectVO.setProjectList(projectService.selectProjectList(projectVO));
		model.addAttribute("projectList", projectVO.getProjectList());
		return "projects/selectProjectList";
	}
	
	@RequestMapping("/selectEmployeeList")
	public String selectEmployeeList(ModelMap model, @ModelAttribute("projectVO") ProjectVO projectVO) throws Exception {
		projectVO.setProjectList(projectService.selectEmployeeList(projectVO));
		model.addAttribute("employeeList", projectVO.getEmployeeList());
		return "projects/selectProjectList";
	}
	
	@RequestMapping("/ajaxCheckProject")
	public @ResponseBody
	String ajaxCheckProject(@ModelAttribute("Project") Project project, ModelMap model, HttpServletRequest request) throws Exception {
		project.setProName(" AND projectName LIKE N'"+request.getParameter("fieldValue")+"' ");
		project.setProjectID(request.getParameter("projectID"));
		int cnt = projectService.checkExisName(project);
		String test = "";
		if (cnt > 0) {
			test = "false";
		} else {
			test = "true";
		}
		return "[\"" + request.getParameter("fieldId") + "\"," + test + "]";
	}
	
	@RequestMapping(value = "/ajaxGrid", method = RequestMethod.GET)
	public @ResponseBody
	Paging<Project> ajaxGrid(HttpServletRequest request, ModelMap model)
			throws Exception {
		return projectService.getTotalRecords(request);

	}
	
	@RequestMapping(value = "/ajaxGridClose", method = RequestMethod.GET)
	public @ResponseBody
	Paging<Project> ajaxGridClose(HttpServletRequest request, ModelMap model)
			throws Exception {
		return projectServiceClose.getTotalRecords(request);

	}
	
	@RequestMapping(value="/doDelete/{projectID}",method=RequestMethod.POST)
	public String doDelete(@PathVariable String projectID, ModelMap model)
			throws Exception {
		projectService.deleteProject(projectID);
		model.addAttribute("result", "true");
		return "cmm/resultType";
	}
	
	@RequestMapping("/view/{projectID}")
	public String view(@PathVariable String projectID, ModelMap model)
			throws Exception {
		Project project = new Project();
		project = projectService.getProject(projectID);
		
		if(project==null)
		{ 	logger.debug("Invalid Project ID");
			throw new GenericException("Project's not found.");
		}
		model.addAttribute("project", project);
		model.addAttribute("page", "projects/view");
		return "layout/main";
	}
	
	@RequestMapping("/update/{projectID}")
	public String update(@PathVariable String projectID, ModelMap model, @ModelAttribute ProjectMemberVO projectMemberVO, @ModelAttribute MaintenanceProjectMemberVO maintenanceProjectMemberVO)
			throws Exception {
		if(! projectID.equals(""))
		{	Project project = projectService.getProject(projectID);
			
			if(project==null)
			{ 	logger.debug("Invalid Project ID");
				throw new GenericException("Project's not found.");
			}
			model.addAttribute("projectID", projectID);
			model.addAttribute("project", projectService.selectProjectByID(projectID));
			projectMemberVO.setProjectID(projectID);
			
			model.addAttribute("projectManager", projectMemberService.selectProjectManager(projectID));
			projectMemberVO.setEmployeeType("employee");
			model.addAttribute("projectMembers", projectMemberService.selectProjectMembers(projectMemberVO));
			projectMemberVO.setEmployeeType("contractor");
			model.addAttribute("projectContractors", projectMemberService.selectProjectMembers(projectMemberVO));
			
			model.addAttribute("maintenanceProjectManager", projectMemberService.selectProjectManagerMa(projectID));
			projectMemberVO.setEmployeeType("employee");
			model.addAttribute("maintenanceProjectMembers", projectMemberService.selectProjectMembersMa(projectMemberVO));
			projectMemberVO.setEmployeeType("contractor");
			model.addAttribute("maintenanceProjectContractors", projectMemberService.selectProjectMembersMa(projectMemberVO));
		}
		model.addAttribute("page", "projects/update");
		return "layout/main";
	}
	
	@RequestMapping("/doUpdate")
	public String doUpdate(@ModelAttribute MaintenanceProjectMember maintenanceProjectMember, @ModelAttribute ProjectMember projectMember, @RequestParam String projectID, ModelMap model, @ModelAttribute("Message") Message message, HttpSession session, Project project, HttpServletRequest request)
			throws Exception {
		
		if(! projectID.equals(""))
		{
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date date = new Date();
			String today = dateFormat.format(date);
			
			DateFormat df1 = new SimpleDateFormat("yyyy-MM-dd"); 
		    Date NOW = new Date();
		    NOW = df1.parse(df1.format(new Date()));
			
			if(request.getParameter("actualStartDate") != null && !request.getParameter("actualStartDate").equals("") && project.getActualStartDate() != null)
			{
				String actualStartDate = dateFormat.format(project.getActualStartDate());
				if( project.getActualStartDate().compareTo(NOW) == -1 || actualStartDate.equals(today))
				{	
					project.setStarted(true);
				}	
			}
			else
			{
				project.setStarted(false);
			}
			
			if(request.getParameter("actualEndDate") != null && !request.getParameter("actualEndDate").equals("") && project.getActualEndDate() != null )
			{
				String actualEndDate = dateFormat.format(project.getActualEndDate());
				if(project.getActualEndDate().compareTo(NOW) == -1 || actualEndDate.equals(today))
				{
					project.setFinished(true);
				}
			}
			else
			{
				project.setFinished(false);
			}
			
			if(request.getParameter("maClosedDate") != null && !request.getParameter("maClosedDate").equals("") && project.getMaClosedDate() != null )
			{
				String maClosedDate = dateFormat.format(project.getMaClosedDate());
				if(project.getMaClosedDate().compareTo(NOW)  == 1 || maClosedDate.equals(today))
				{
					project.setMaClosed(true);
				}
			}
			else
			{
				project.setMaClosed(false);
			}
			
			/**
			 * Update Project
			 */
			projectService.updateProject(project);
			
			/**
			 * If project is not closed
			 */
			

			
			if(request.getParameter("isFinished").equals("0"))
			{
				
				/**
				 * Insert Project Members
				 */
				
				projectMember.setMemberTypeID("MBT02");
				projectMember.setPlannedAssignDate(NOW);
			    projectMember.setProjectID(projectID);
			    projectMemberService.deleteProjectMember(projectMember);
			
			    
				String[] members = request.getParameterValues("member");
				if(members != null)
				{
					for (int i = 0; i < members.length; i++) 
				    {
						projectMember.setEmployeeID(members[i]);
						projectMemberService.insertProjectMember(projectMember);
				    }
				}
				

				/**
				 * Insert Project Contractors
				 */
				String[] contractors = request.getParameterValues("contractor");
				if(contractors != null)
				{
					for (int i = 0; i < contractors.length; i++) 
				    {
						projectMember.setEmployeeID(contractors[i]);
						projectMemberService.insertProjectMember(projectMember);
				    }
				}
				
				
				/**
				 * Update Project Manager
				 */
				
				projectMember.setMemberTypeID("MBT01");
				projectMember.setEmployeeID(request.getParameter("employeeID"));
				projectMemberService.deleteProjectMember(projectMember);
				projectMemberService.insertProjectMember(projectMember);

				
			}
			else
			{
				/**
				 * Update Project Owner
				 */
			    projectMember.setProjectID(projectID);
				projectMember.setMaMemberTypeID("MBT04");
				projectMember.setEmployeeID(request.getParameter("maOwner"));
				projectMember.setEmployeeIDOld(request.getParameter("OwnerOldID"));
				projectMemberService.updateProjectOwner(projectMember);
				

				
				/**
				 * Insert Project Maintenance Members
				 */
				
				projectMember.setMaMemberTypeID("MBT03");
			    projectMember.setProjectID(projectID);
			    projectMemberService.deleteProjectMemberMa(projectMember);
			    
				String[] maMembers = request.getParameterValues("maMember");
				if(maMembers != null)
				{
					for (int i = 0; i < maMembers.length; i++) 
				    {
						projectMember.setEmployeeID(maMembers[i]);
						projectMemberService.insertProjectMemberMa(projectMember);
				    }
				}
				

				/**
				 * Insert Project Maintenance Contractors
				 */
				String[] maContractors = request.getParameterValues("maContractor");
				if(maContractors != null)
				{
					for (int i = 0; i < maContractors.length; i++) 
				    {
						projectMember.setEmployeeID(maContractors[i]);
						projectMemberService.insertProjectMemberMa(projectMember);
				    }
				}
				

			}
				
			message.setUpdateSuccess();
		}
		else
		{
			message.setUpdateFail();
		}
		
		session.setAttribute("message", message);
		return "redirect:/projects/index.html";
	}
		
	/**
	  * @author Chamroeun
	  * @param model
	  * @param projectVO
	  * @param request
	  * @param width
	  * @return
	  * @throws Exception
	  */
	 @RequestMapping("/selectMultiProjectList")
	 public String selectMultiProjectList(ModelMap model, @ModelAttribute("projectVO") ProjectVO projectVO, HttpServletRequest request, @RequestParam(defaultValue = "247px", value="width") String width) throws Exception {
	  
	  model.addAttribute("id",request.getParameter("id"));
	  model.addAttribute("placeholder", request.getParameter("placeholder"));
	  model.addAttribute("width", width);
	  model.addAttribute("validate", request.getParameter("validate"));
	  String multiple = "";
	  if(request.getParameter("multiple") != null && request.getParameter("multiple").equalsIgnoreCase("true"))
	  {
	   multiple = "multiple";
	  }
	  model.addAttribute("multiple", multiple);
	  
	  projectVO.setProjectList(projectService.selectProjectList(projectVO));
	  model.addAttribute("projectList", projectVO.getProjectList());
	  return "projects/selectMultiProjectList";
	 }
	 
	 
	 @RequestMapping(value="/report/reportProjectExcel", method = RequestMethod.GET)
		public ModelAndView reportProjectExcel(HttpServletRequest request, @ModelAttribute("searchPro") SearchProjectParmeter searchProject) throws Exception{
			ModelAndView map= new ModelAndView("reportProjectExcelView");
			map.addObject("projectList", projectService.getProjectReport(searchProject));			
			return map;
		}
	 
	@RequestMapping(value="/report/reportProjectPDF")
	public ModelAndView reportProjectPDF(HttpServletRequest request,@ModelAttribute("searchPro") SearchProjectParmeter searchProject) throws Exception{
		ModelAndView map = new ModelAndView("reportProjectPDFView");
		map.addObject("projectList", projectService.getProjectReport(searchProject));	
		return map;
	}
	
	
}

















