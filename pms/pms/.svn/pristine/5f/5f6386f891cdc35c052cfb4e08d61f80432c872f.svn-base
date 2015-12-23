package com.mobilecnc.roles.controller;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mobilecnc.exception.GenericException;
import com.mobilecnc.helper.BaseController;
import com.mobilecnc.helper.Message;
import com.mobilecnc.helper.Paging;
import com.mobilecnc.roles.Role;
import com.mobilecnc.roles.service.RoleService;

@Controller
@RequestMapping(value="/roles")
public class RoleController extends BaseController {
	
	Logger logger=Logger.getLogger(RoleController.class);
	@Autowired
	RoleService roleService;
	
	@RequestMapping("/selectRoleList")
	public String selectRoleList(ModelMap model, HttpServletRequest request, @RequestParam(defaultValue = "247px", value="width") String width) throws Exception {
		
		model.addAttribute("rolesList", roleService.selectRoleList());
		model.addAttribute("id", request.getParameter("id"));
		model.addAttribute("placeholder", request.getParameter("placeholder"));
		model.addAttribute("width", width);
		String multiple = "";
		if(request.getParameter("multiple") != null && request.getParameter("multiple").equalsIgnoreCase("true"))
		{
			multiple = "multiple";
		}
		model.addAttribute("multiple", multiple);
		model.addAttribute("validate", request.getParameter("validate"));
		return "roles/selectRoleList";
	}
	
	@RequestMapping("/index")
	public String index(ModelMap model, @ModelAttribute("Message") Message message, HttpSession session){
		model.addAttribute("page", "roles/index");
		model.addAttribute("message", session.getAttribute("message"));
		session.setAttribute("message", new Message());
		return "layout/main";
	}
	
	@RequestMapping("/add")
	public String add(ModelMap model, @ModelAttribute("Message") Message message, HttpSession session) {
		model.addAttribute("page", "roles/add");
		model.addAttribute("message", session.getAttribute("message"));
		session.setAttribute("message", new Message());
		return "layout/main";
	}
	
	@RequestMapping("/doAdd")
	public String doAdd(ModelMap model, @ModelAttribute("Role") Role role, @ModelAttribute("Message") Message message, HttpSession session, HttpServletRequest request)
			throws Exception {
		role.setEntryBy((String)session.getAttribute("user"));
		String addList=request.getParameter("addList")!=null?request.getParameter("addList"):"";
		String removeList=request.getParameter("removeList")!=null?request.getParameter("removeList"):"";
		roleService.insertRole(role,addList,removeList);
		message.setSaveSuccess();
		session.setAttribute("message", message);	
		
		if (request.getParameter("save").equalsIgnoreCase("save")) {
			return "redirect:/roles/add.html";
		} else {
			return "redirect:/roles/index.html";
		}
	}

	@RequestMapping("/update/{roleID}")
	public String update(@PathVariable String roleID, ModelMap model) throws Exception{
		Role role = roleService.getRole(roleID);
		
		if(role==null)
		{ 	logger.debug("Invalid Role ID");
			throw new GenericException("Role's not found."); 
		}
		model.addAttribute("role", role);
		model.addAttribute("page","roles/update");
		return "layout/main" ;
	}
	
	@RequestMapping("/doUpdate")
	public String doUpdate(@ModelAttribute Role role, ModelMap model,  @ModelAttribute("Message") Message message, HttpSession session,HttpServletRequest request) throws Exception{

		role.setLastModifyBy((String)session.getAttribute("user"));
		String addList=request.getParameter("addList")!=null?request.getParameter("addList"):"";
		String removeList=request.getParameter("removeList")!=null?request.getParameter("removeList"):"";
		roleService.updateRole(role,addList,removeList);
		
		message.setUpdateSuccess();
		session.setAttribute("message", message);
		return "redirect:/roles/index.html";
	}
	
	@RequestMapping(value="/doDelete/{roleID}",method=RequestMethod.POST)
	public String doDelete(@PathVariable String roleID, ModelMap model)
			throws Exception {
		roleService.deleteRole(roleID);
		model.addAttribute("result", "true");
		return "cmm/resultType";
	}
	
	@RequestMapping("/view/{roleID}")
	public String view(@PathVariable String roleID, ModelMap model) throws Exception{
		Role role = roleService.getRole(roleID);
		
		if(role==null)
		{ 	logger.debug("Invalid Role ID");
			throw new GenericException("Role's not found."); 
		}
		model.addAttribute("role", role);
		model.addAttribute("page", "roles/view");
		return "layout/main";
	}
	
	@RequestMapping(value = "/ajaxGrid", method = RequestMethod.GET)
	public @ResponseBody Paging<Role> ajaxGrid(HttpServletRequest request, ModelMap model) throws Exception{
		return roleService.getTotalRecords(request);

	}
	
	
	@RequestMapping("/ajaxCheckRole")
	public @ResponseBody
	String ajaxCheckRole(@ModelAttribute("Role") Role role, ModelMap model,
			HttpServletRequest request) throws Exception {
		role.setRoleName(request.getParameter("fieldValue"));
		String roleID = "";
		if (request.getParameter("roleID") != null) {
			roleID = request.getParameter("roleID");
		}
		role.setRoleID(roleID);
		int cnt = roleService.checkExistName(role);
		String test = "";
		if (cnt > 0) {
			test = "false";
		} else {
			test = "true";
		}
		return "[\"" + request.getParameter("fieldId") + "\"," + test + "]";
	}
}
