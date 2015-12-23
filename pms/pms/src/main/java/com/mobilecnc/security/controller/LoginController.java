package com.mobilecnc.security.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mobilecnc.helper.Message;
import com.mobilecnc.security.User;
import com.mobilecnc.security.UserVO;
import com.mobilecnc.security.service.UserService;

/**
 * 
 * @author sereysopheak.eap
 *
 */
@Controller
@RequestMapping(value="/user")
public class LoginController{
	
	protected static Logger logger = Logger.getLogger("service");
	@Autowired 
	UserService userService;
	
	
	@RequestMapping(value = "login/success")
	public String loginSucess(ModelMap model, HttpSession session,HttpServletRequest request) throws Exception {

		return "redirect:/main.html";
	}

	@RequestMapping(value = "/login")
	public String login(HttpServletRequest request, ModelMap model,  @ModelAttribute("Message") Message message, HttpSession session) {
		model.addAttribute("message", session.getAttribute("message"));
		session.setAttribute("message", new Message());
		model.addAttribute("page", "default/login");
		return "layout/main";
		//return "default/login";
	}
	@RequestMapping(value = "/auth/denied")
	public String accessDenied(HttpServletRequest request, ModelMap model,  @ModelAttribute("Message") Message message, HttpSession session) {
		model.addAttribute("page", "default/accessDenied");
		return "layout/main";
	}
	
	@RequestMapping(value = "/login-failed")
	public String loginerror(ModelMap model, @ModelAttribute("Message") Message message, HttpSession session) {

		model.addAttribute("page","default/login");

		message.setLoginFail();
		session.setAttribute("message", message);
		
		return "redirect:/user/login.html";

	}

	@RequestMapping("/my-profile")
	public String myProfile(ModelMap model, HttpSession session, @ModelAttribute("Message") Message message) throws Exception{
		
		model.addAttribute("message", session.getAttribute("message"));
		session.setAttribute("message", new Message());	
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();		
		model.addAttribute("userVO", userService.getUser(auth.getName()));

		model.addAttribute("page", "default/myProfile");
		return "layout/main";
	}
	
	@RequestMapping("/doUpdate")
	public String updateMyProfile(@ModelAttribute UserVO userVO, ModelMap model, HttpSession session, HttpServletRequest request, @ModelAttribute("Message") Message message) throws Exception{
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		User user = (User)userService.getUser(auth.getName());
		
		userVO.setLastModifyBy(user.getEmployeeID());
		String currentPassword = request.getParameter("currentPassword");
		if (!currentPassword.isEmpty()){
			if(validPassword(user,currentPassword)){
				userService.updateUser(userVO);
				userVO.setPassword(encodePassword(user,request.getParameter("newPassword")));
				userService.changePassword(userVO);
			}
			else{
				message.setLoginFail();
				session.setAttribute("message", message);
				return "redirect:/user/my-profile.html";
			}
		}
		else{
			userService.updateUser(userVO);
		}
		message.setSaveSuccess();
		session.setAttribute("message", message);
		
		return "redirect:/main.html";
	}
	
	private boolean validPassword(User user, String password) throws Exception{
		ShaPasswordEncoder pwdEnc = new ShaPasswordEncoder();
		return pwdEnc.isPasswordValid(user.getPassword(), password, user.getEmployeeID());
	}
	
	private String encodePassword(User user, String password){
		ShaPasswordEncoder pwdEnc = new ShaPasswordEncoder();
		return pwdEnc.encodePassword(password, user.getEmployeeID());
	}
}
