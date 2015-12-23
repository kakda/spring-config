package com.mobilecnc.companies.controller;

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

import com.mobilecnc.companies.Company;
import com.mobilecnc.companies.service.CompanyService;
import com.mobilecnc.exception.GenericException;
import com.mobilecnc.helper.Message;
import com.mobilecnc.helper.Paging;
import com.mobilecnc.projectTypes.ProjectType;

@Controller
@RequestMapping(value="/companies")
public class CompanyController {
	
	@Autowired
	CompanyService companyService;
	
	private static final Logger logger = Logger.getLogger(CompanyController.class);
	
	@RequestMapping("/selectCompanyList")
	public String selectCompanyList(ModelMap model, HttpServletRequest request, @RequestParam(defaultValue = "247px", value="width") String width) throws Exception {
		
		model.addAttribute("companiesList", companyService.selectCompanyList());
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
		return "companies/selectCompanyList";
	}
	
	@RequestMapping("/index")
	public String index(ModelMap model, @ModelAttribute("Message") Message message, HttpSession session){
		model.addAttribute("page", "companies/index");
		model.addAttribute("message", session.getAttribute("message"));
		session.setAttribute("message", new Message());
		return "layout/main";
	}
	
	@RequestMapping("/add")
	public String add(ModelMap model, HttpSession session) {
		model.addAttribute("page", "companies/add");
		model.addAttribute("message", session.getAttribute("message"));
		session.setAttribute("message", null);
		return "layout/main";
	}
	
	@RequestMapping("/doAdd")
	public String doAdd(ModelMap model,
			@ModelAttribute("Company") Company company,
			@ModelAttribute("Message") Message message, HttpSession session,
			HttpServletRequest request) throws Exception {
		company.setEntryBy((String) session.getAttribute("user"));
		companyService.insertCompany(company);
		message.setSaveSuccess();
		session.setAttribute("message", message);
		if (request.getParameter("save").equalsIgnoreCase("save")) {
			return "redirect:/companies/add.html";
		} else {
			return "redirect:/companies/index.html";
		}
	}
	
	@RequestMapping("/update/{companyID}")
	public String update(@PathVariable String companyID, ModelMap model) throws Exception{
		Company company=companyService.getCompany(companyID);
		if(company==null)
		{ 	logger.debug("Invalid Company ID");
			throw new GenericException("Company's not found.");
		}
		model.addAttribute("company", company);
		model.addAttribute("page","companies/update");
		return "layout/main" ;
	}
	
	@RequestMapping("/doUpdate")
	public String doUpdate(@ModelAttribute Company company, ModelMap model,  @ModelAttribute("Message") Message message, HttpSession session) throws Exception{
		company.setLastModifyBy((String)session.getAttribute("user"));
		companyService.updateCompany(company);
		
		message.setUpdateSuccess();
		session.setAttribute("message", message);
		return "redirect:/companies/index.html";
	}
	
	@RequestMapping(value="/doDelete/{companyID}", method=RequestMethod.POST)
	public String doDelete(@PathVariable String companyID, ModelMap model)
			throws Exception {
		companyService.deleteCompany(companyID);
		model.addAttribute("result", "true");
		return "cmm/resultType";
	}
	
	@RequestMapping("/view/{companyID}")
	public String view(@PathVariable String companyID, ModelMap model) throws Exception{
		Company company = new Company();
		company = companyService.getCompany(companyID);
		if(company==null)
		{ 	logger.debug("Invalid Company ID");
			throw new GenericException("Company's not found.");
		}
		model.addAttribute("company", company);
		model.addAttribute("page", "companies/view");
		return "layout/main";
	}
	
	@RequestMapping(value = "/ajaxGrid", method = RequestMethod.GET)
	public @ResponseBody Paging<ProjectType> ajaxGrid(HttpServletRequest request, ModelMap model) throws Exception{
		return companyService.getTotalRecords(request);
	}
	
	
}
