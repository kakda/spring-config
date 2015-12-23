/**
 * @author Chamroeun
 */
package com.mobilecnc.projectTypes.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mobilecnc.exception.GenericException;
import com.mobilecnc.helper.Message;
import com.mobilecnc.helper.Paging;
import com.mobilecnc.projectTypes.ProjectType;
import com.mobilecnc.projectTypes.service.ProjectTypeService;
import com.mobilecnc.projectTypes.service.ProjectTypeVO;

@Controller
@RequestMapping(value = "/project-types")
public class ProjectTypeController {

	@Autowired
	ProjectTypeService projectTypeService;
	//get log4j handler
	private static final Logger logger = Logger
			.getLogger(ProjectTypeController.class);
	
	@RequestMapping("/index")
	public String index(ModelMap model, @ModelAttribute("Message") Message message, HttpSession session){
		model.addAttribute("page", "projectTypes/index");
		model.addAttribute("message", session.getAttribute("message"));
		session.setAttribute("message", message);
		return "layout/main";
	}
	
	@RequestMapping("/selectProjectTypeList")
	public String selectProjectTypeList(ModelMap model, @ModelAttribute("projectTypeVO") ProjectTypeVO projectTypeVO) throws Exception {
		projectTypeVO.setProjectTypeList(projectTypeService.selectProjectTypeList(projectTypeVO));
		model.addAttribute("projectTypeList", projectTypeVO.getProjectTypeList());
		return "projectTypes/selectProjectTypeList";
	}
	
	@RequestMapping("/add")
	public String add(ModelMap model, @ModelAttribute("Message") Message message, HttpSession session) {
		model.addAttribute("page", "projectTypes/add");
		model.addAttribute("message", session.getAttribute("message"));
		session.setAttribute("message", new Message());
		return "layout/main";
	}

	@RequestMapping("/doAdd")
	public String doAdd(ModelMap model, @ModelAttribute("ProjectType") ProjectType projectType, @ModelAttribute("Message") Message message, HttpSession session,HttpServletRequest request)
			throws Exception {
		
		projectType.setEntryBy((String)session.getAttribute("user"));
		projectTypeService.insertProjectType(projectType);
		message.setSaveSuccess();
		session.setAttribute("message", message);
		if(request.getParameter("save").equalsIgnoreCase("save")){
			   return "redirect:/project-types/add.html";   
			  }else{
			   return "redirect:/project-types/index.html"; 
			  }
	}

	@RequestMapping("/update/{projectTypeID}")
	public String update(@PathVariable String projectTypeID, ModelMap model) throws Exception{
		
		ProjectType projectType = projectTypeService.getProjectType(projectTypeID);
		
		if(projectType==null)
		{ 	logger.debug("Invalid Project type ID");
			throw new GenericException("Project type's not found."); 
		}
		model.addAttribute("projectType", projectType);
		model.addAttribute("page","projectTypes/update");
		return "layout/main" ;
	}
	
	@RequestMapping("/doUpdate")
	public String doUpdate(@ModelAttribute ProjectType projectType, ModelMap model,  @ModelAttribute("Message") Message message, HttpSession session) throws Exception{
		
		projectType.setLastModifyBy((String)session.getAttribute("user"));
		projectTypeService.updateProjectType(projectType);
		
		message.setUpdateSuccess();
		session.setAttribute("message", message);
		return "redirect:/project-types/index.html";
	}
	
	@RequestMapping(value="/doDelete/{projectTypeID}",method=RequestMethod.POST)
	public String doDelete(@PathVariable String projectTypeID, ModelMap model)
			throws Exception {
		projectTypeService.deleteProjectType(projectTypeID);
		model.addAttribute("result", "true");
		return "cmm/resultType";
	}
	
	@RequestMapping("/view/{projectTypeID}")
	public String view(@PathVariable String projectTypeID, ModelMap model) throws Exception{
		ProjectType projectType = projectTypeService.getProjectType(projectTypeID);
		
		if(projectType==null)
		{ 	logger.debug("Invalid Project type ID");
			throw new GenericException("Project type's not found."); 
		}
		model.addAttribute("projectType", projectType);
		model.addAttribute("page", "projectTypes/view");
		return "layout/main";
	}
	
	@RequestMapping(value = "/ajaxGrid", method = RequestMethod.GET)
	public @ResponseBody Paging<ProjectType> ajaxGrid(HttpServletRequest request, ModelMap model) throws Exception{
		return projectTypeService.getTotalRecords(request);

	}
	
	@RequestMapping("/ajaxCheckProjectType")
	public @ResponseBody
	String ajaxCheckProjectType(@ModelAttribute("ProjectType") ProjectType projectType, ModelMap model,
			HttpServletRequest request) throws Exception {
		projectType.setProjectTypeName(request.getParameter("fieldValue"));
		String projectTypeID = "";
		if (request.getParameter("projectTypeID") != null) {
			projectTypeID = request.getParameter("projectTypeID");
		}
		projectType.setProjectTypeID(projectTypeID);
		int cnt = projectTypeService.checkExistName(projectType);
		String test = "";
		if (cnt > 0) {
			test = "false";
		} else {
			test = "true";
		}
		return "[\"" + request.getParameter("fieldId") + "\"," + test + "]";
	}
	
	
	
}
