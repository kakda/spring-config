package com.mobilecnc.contractors.controller;

import java.security.Principal;
import java.util.List;

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

import com.mobilecnc.contractors.Contractor;
import com.mobilecnc.contractors.service.ContractorService;
import com.mobilecnc.contractors.service.ContractorVO;
import com.mobilecnc.employees.Employee;
import com.mobilecnc.employees.service.EmployeeService;
import com.mobilecnc.exception.GenericException;
import com.mobilecnc.helper.BaseController;
import com.mobilecnc.helper.Message;
import com.mobilecnc.helper.Paging;
import com.mobilecnc.security.UserVO;
import com.mobilecnc.security.service.UserService;
import com.mobilecnc.skills.Skill;

@Controller
@RequestMapping(value = "/contractors")
public class ContractorController extends BaseController{
	
	@Autowired
	ContractorService contractorService;
	
	@Autowired 
	UserService userService;
	
	@Autowired
	EmployeeService employeeService;
	
	Logger logger = Logger.getLogger(ContractorController.class);
	@RequestMapping("/index")
	public String index(ModelMap model) throws Exception{
		model.addAttribute("page", "contractors/index");
		return "layout/main";
	}
	
	@RequestMapping(value = "/ajaxGrid", method = RequestMethod.GET)
	public @ResponseBody
	Paging<Contractor> ajaxGrid(HttpServletRequest request, ModelMap model)
			throws Exception {
		return contractorService.getTotalRecords(request);

	}
	
	@RequestMapping("/add")
	public String add(ModelMap model,HttpSession session) {
		
		model.addAttribute("message", session.getAttribute("message"));
		session.setAttribute("message", null);
		
		model.addAttribute("page", "contractors/add");

		return "layout/main";
	}
	
	@RequestMapping(value="/doDelete/{employeeID}", method=RequestMethod.POST)
	public String doDelete(@PathVariable String employeeID, ModelMap model)
			throws Exception {
		contractorService.deleteContractor(employeeID);
		model.addAttribute("result", "true");
		return "cmm/resultType";
	}
	
	@RequestMapping("/doAdd")
	public String doAdd(ModelMap model, @ModelAttribute("Contractor") Contractor contractor,@ModelAttribute("Message") Message message,HttpSession session, HttpServletRequest request)
			throws Exception {
		contractor.setEntryBy((String)session.getAttribute("user"));
		contractor.setLastModifyBy((String)session.getAttribute("user"));
		contractor.setType("contractor");
		//contractor.setCompanyID("CPN0001");
		//contractor.setUserName(contractor.getEmployeeName());
		contractor.setActiveUser(contractor.setActive(true)?1:0);
		contractorService.insertContractor(contractor);
		String[] skillID = request.getParameterValues("skillID");
		if(skillID!=null){
			for(int i=0; i<skillID.length; i++)
			{
				contractor.setSkillID(skillID[i]);
				contractorService.insertContractorSkill(contractor);
			}
		}
		message.setSaveSuccess();
		session.setAttribute("message", message);
		if(request.getParameter("save").equalsIgnoreCase("save")){
			return "redirect:/contractors/add.html";			
		}else{
			return "redirect:/contractors/index.html";	
		}
	}
	
	@RequestMapping("/update/{employeeID}")
	public String update(@PathVariable String employeeID, @ModelAttribute ContractorVO contractorVO, 
			ModelMap model,HttpServletRequest request) throws Exception{
		
		Contractor ctr=contractorService.getEmployee(employeeID);
		if(ctr==null)
		{ 	logger.debug("Provided ID is not the contractor");
			throw new GenericException("Contractor type is required.");
		}
		
		if(request.getParameter("re_employ")!=null)
		{	if(ctr.getQuitDate()==null)
			{
				logger.debug("Contractor is currently employed");
				throw new GenericException("Re-employment cannot proceed. Contractor is currently employed.");
			}
			model.addAttribute("re_employ",true);
			ctr.setJoinDate(null);
			ctr.setQuitDate(null);
			ctr.setQuitReason(null);
		}
		else
			model.addAttribute("re_employ",false);
		model.addAttribute("employee", ctr);
		contractorVO.setEmployeeID(employeeID);
		model.addAttribute("skill", contractorService.getSkill(contractorVO));
		model.addAttribute("page", "contractors/update");
		return "layout/main";
	}
	
	@RequestMapping("/doUpdate")
	public String doUpdate(@ModelAttribute Contractor contractor,UserVO userVO,Principal principal,
			@ModelAttribute("Message") Message message, ModelMap model, HttpSession session, 
			HttpServletRequest request,@RequestParam("re_employ") boolean isReEmploy) throws Exception{
		
		contractor.setLastModifyBy((String)session.getAttribute("user"));
		contractor.setType("contractor");
		
		userService.updateUser(userVO);
		contractorService.updateContractor(contractor,isReEmploy);
		String[] skillID = request.getParameterValues("skillID");
		if(skillID!=null){
			for(int i=0; i<skillID.length; i++)
			{
				contractor.setSkillID(skillID[i]);
				contractorService.insertContractorSkill(contractor);
			}
		 }
		
		message.setUpdateSuccess();
		session.setAttribute("message", message);
		
		return "redirect:/contractors/index.html";
	}
	
	@RequestMapping("/ajaxCheckUserUpdate")
	public @ResponseBody
	String ajaxCheckEmployee(@ModelAttribute("Employee") Employee employee, ModelMap model, HttpServletRequest request) throws Exception {
		employee.setUserName(request.getParameter("fieldValue"));
		
		String EmployeeID = "";
		if(request.getParameter("employeeID") != null)
		{
			EmployeeID = request.getParameter("employeeID");
		}
		employee.setEmployeeID(EmployeeID);
		
		int cnt = employeeService.checkExisName(employee);
		String test = "";
		if (cnt > 0) {
			test = "false";
		} else {
			test = "true";
		}
		return "[\"" + request.getParameter("fieldId") + "\"," + test + "]";
	}
	
	/**
	 * @author Chamroeun
	 * @param model
	 * @param employeeID
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping("/view/{employeeID}")
	public String view(ModelMap model, @PathVariable String employeeID) throws Exception{
		Contractor contractor = contractorService.getEmployee(employeeID);
		if(contractor==null)
		{ 	logger.debug("Provided ID is not the contractor");
			throw new GenericException("Contractor's not found.");
		}
		List<Skill> skillList = contractorService.getEmployeeSkills(employeeID);
		model.addAttribute("contractor", contractor);
		model.addAttribute("skillList", skillList);
		model.addAttribute("page", "contractors/view");
		return "layout/main";
	}
}

