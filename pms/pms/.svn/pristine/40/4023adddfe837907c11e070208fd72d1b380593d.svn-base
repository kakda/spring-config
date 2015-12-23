package com.mobilecnc.main.controller;

import java.security.Principal;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mobilecnc.security.UserVO;
import com.mobilecnc.security.service.UserService;

@Controller
public class MainController {
	@Autowired
	UserService userService;

	@RequestMapping("/main")
	public String home(ModelMap model, HttpSession session, Principal principal)
			throws Exception {
		Authentication auth = SecurityContextHolder.getContext()
				.getAuthentication();
		UserVO user = userService.getUser(auth.getName());

		session.setAttribute("user", user.getEmployeeID());
		session.setAttribute("currentUser", user.getEmployeeName());
		session.setAttribute("userRole", user.getRoleID());
		model.addAttribute("page", "default/home");
		return "layout/main";
	}

	@RequestMapping("/contact")
	public String contact(ModelMap model) throws Exception {

		model.addAttribute("page", "default/contact");
		return "layout/main";
	}
	
	@RequestMapping("/usermanual")
	public String usermanual(ModelMap model) throws Exception{

		model.addAttribute("page", "default/usermanual");
		return "layout/main";
	}
}
