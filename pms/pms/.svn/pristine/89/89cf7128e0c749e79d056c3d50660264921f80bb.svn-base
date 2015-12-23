package com.mobilecnc.projectMembers.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mobilecnc.projectMembers.ProjectMember;
import com.mobilecnc.projectMembers.service.ProjectMemberService;

@Controller
@RequestMapping(value="/project-member")
public class ProjectMemberController {

	/**
	 * Rin Rady
	 */
	@Autowired
	ProjectMemberService projectMemberService;
	
	@RequestMapping("/deleteMultiProjectMember")
	public  @ResponseBody boolean deleteMultiProjectMember(HttpServletRequest request, @ModelAttribute ProjectMember projectMember, @RequestParam(value="projectID") String projectID) throws Exception{
		if(! projectID.equals(""))
		{
			projectMember.setProjectID(projectID);
			projectMember.setEmployeeID(request.getParameter("employeeID"));
			projectMemberService.deleteMultiProjectMember(projectMember);
		}
		return true;
	}
	
	@RequestMapping("/deleteMultiProjectMemberMa")
	public @ResponseBody boolean deleteMultiProjectMemberMa(HttpServletRequest request, @ModelAttribute ProjectMember projectMember, @RequestParam(value="projectID") String projectID) throws Exception{
		if(! projectID.equals(""))
		{
			projectMember.setProjectID(projectID);
			projectMember.setEmployeeID(request.getParameter("employeeID"));
			projectMemberService.deleteMultiProjectMemberMa(projectMember);
		}
		return true;
	}
	
	@RequestMapping("/updateMember")
	public @ResponseBody boolean updateMember(HttpServletRequest request, @ModelAttribute ProjectMember projectMember, @RequestParam(value="projectID") String projectID) throws Exception{
		if(! projectID.equals(""))
		{
			projectMember.setProjectID(projectID);
			projectMember.setEmployeeID(request.getParameter("employeeID"));
			projectMemberService.updateMember(projectMember);
		}
		return true;
	}
	
	@RequestMapping("/updateMemberMa")
	public @ResponseBody boolean updateMemberMa(HttpServletRequest request, @ModelAttribute ProjectMember projectMember, @RequestParam(value="projectID") String projectID) throws Exception{
		if(! projectID.equals(""))
		{
			projectMember.setProjectID(projectID);
			projectMember.setEmployeeID(request.getParameter("employeeID"));
			projectMemberService.updateMemberMa(projectMember);
		}
		return true;
	}
	
}
