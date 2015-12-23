package com.mobilecnc.security.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mobilecnc.exception.GenericException;
import com.mobilecnc.helper.Paging;
import com.mobilecnc.roles.Role;
import com.mobilecnc.security.User;
import com.mobilecnc.security.UserVO;
import com.mobilecnc.security.service.UserService;

@Controller
@RequestMapping("/users")
public class UserController {
	@Autowired 
	UserService userService;
	Logger logger=Logger.getLogger(UserController.class);
	@RequestMapping("/index")
	public String show(ModelMap model){
		model.addAttribute("page", "users/index");
		return "layout/main";
	}
	@RequestMapping(value = "/ajaxGrid", method = RequestMethod.GET)
	public @ResponseBody Paging<Role> ajaxGrid(HttpServletRequest request, ModelMap model) throws Exception{
		return userService.getTotalRecords(request);

	}
	@RequestMapping("/doSave")
	public @ResponseBody String doSave(@RequestParam("activeList")String activeList,@RequestParam("inActiveList")String inActiveList
					,HttpSession session) throws Exception{
		//logger.debug("**************************************"+request.getParameter("activeList"));
		
		userService.updateUserStatus(activeList, inActiveList, (String)session.getAttribute("user"));
		return "true";
	}
	@RequestMapping("/reset-password/{userID}")
	public String resetPassword(ModelMap model,@PathVariable("userID") String userID) throws Exception{
		//Contractor ctr=contractorService.getEmployee(employeeID);
		UserVO user = userService.getUserByID(userID);
		if(user==null)
		{ 	logger.debug("Provided ID is not exist");
			throw new GenericException("User not found");
		}
		if(user.getPassword()==null){
			logger.debug("Cannot reset password for employee");
			throw new GenericException("Password must be reset in LDAP");
		}
		model.addAttribute("userID",userID);
		model.addAttribute("page", "users/resetPassword");
		return "layout/main";
	}
	@RequestMapping("/doResetPassword")
	public String doResetPassword(@RequestParam String employeeID,@RequestParam String newPassword,HttpSession session,ModelMap model) throws Exception{
		UserVO user=new UserVO();
		user.setEmployeeID(employeeID);
		user.setLastModifyBy(session.getAttribute("user").toString());
		user.setPassword(encodePassword(user, newPassword));
		userService.changePassword(user);
		model.addAttribute("page", "users/index");
		return "layout/main";
	}
	private String encodePassword(User user, String password){
		ShaPasswordEncoder pwdEnc = new ShaPasswordEncoder();
		return pwdEnc.encodePassword(password, user.getEmployeeID());
	}
}
