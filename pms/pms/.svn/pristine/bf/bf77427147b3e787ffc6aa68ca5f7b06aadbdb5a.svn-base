package com.mobilecnc.security.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mobilecnc.helper.Paging;
import com.mobilecnc.security.Permission;
import com.mobilecnc.security.service.SecurityService;

@Controller
@RequestMapping(value="/auth")
public class SecurityController {
	@Autowired
	SecurityService securityService;
	
	@RequestMapping(value="/permission")
	public String permission(ModelMap model){
		
		model.addAttribute("page", "security/accessPermission");
		return "layout/main";
	}
	
	@RequestMapping(value = "/ajaxGrid", method = RequestMethod.GET)
	public @ResponseBody Paging<Permission> ajaxGrid(@RequestParam String roleID) throws Exception{
		Paging<Permission> p =new Paging<Permission>();
		p.setRows(securityService.getPermissions(roleID));
		return p;
	}
}
