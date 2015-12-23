package com.mobilecnc.customers.controller;

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

import com.mobilecnc.customers.Customer;
import com.mobilecnc.customers.service.CustomerService;
import com.mobilecnc.customers.service.CustomerVO;
import com.mobilecnc.exception.GenericException;
import com.mobilecnc.helper.Message;
import com.mobilecnc.helper.Paging;
import com.mobilecnc.projectTypes.ProjectType;

@Controller
@RequestMapping("/customers")
public class CustomerController {

	@Autowired
	CustomerService customerService;
	//get log4j handler
	private static final Logger logger = Logger
			.getLogger(CustomerController.class);
	
	@RequestMapping("/index")
	public String index(ModelMap model, @ModelAttribute("Message") Message message, HttpSession session){
		model.addAttribute("page", "customers/index");
		model.addAttribute("message", session.getAttribute("message"));
		session.setAttribute("message", new Message());
		return "layout/main";
	}
	@RequestMapping("/selectCustomerList")
	public String selectCustomerList(ModelMap model, @ModelAttribute("customerVO") CustomerVO customerVO) throws Exception {
		customerVO.setCustomerList(customerService.selectCustomerList(customerVO));
		model.addAttribute("customerList", customerVO.getCustomerList());
		return "customers/selectCustomerList";
	}
	@RequestMapping("/add")
	public String add(ModelMap model, HttpSession session) {
		model.addAttribute("page", "customers/add");
		model.addAttribute("message", session.getAttribute("message"));
		session.setAttribute("message", null);
		return "layout/main";
	}

	@RequestMapping("/doAdd")
	public String doAdd(ModelMap model, @ModelAttribute("Customer") Customer customer, @ModelAttribute("Message") Message message, HttpSession session, HttpServletRequest request)
			throws Exception {
		customer.setEntryBy((String)session.getAttribute("user"));
		customerService.insertCustomer(customer);
		message.setSaveSuccess();
		session.setAttribute("message", message);
		if(request.getParameter("save").equalsIgnoreCase("save")){
			   return "redirect:/customers/add.html";   
			  }else{
			   return "redirect:/customers/index.html"; 
			  }
	}

	@RequestMapping("/update/{customerID}")
	public String update(@PathVariable String customerID, ModelMap model) throws Exception{
		Customer customer=customerService.getCustomer(customerID);
		if(customer==null)
		{ 	logger.debug("Invalid Customer ID");
			throw new GenericException("Customer's not found.");
		}
		model.addAttribute("customer", customerService.getCustomer(customerID));
		model.addAttribute("page","customers/update");
		return "layout/main" ;
	}
	
	@RequestMapping("/doUpdate")
	public String doUpdate(@ModelAttribute Customer customer, ModelMap model,  @ModelAttribute("Message") Message message, HttpSession session) throws Exception{
		customer.setLastModifyBy((String)session.getAttribute("user"));
		customerService.updateCustomer(customer);
		
		message.setUpdateSuccess();
		session.setAttribute("message", message);
		return "redirect:/customers/index.html";
	}
	
	@RequestMapping(value="/doDelete/{customerID}", method=RequestMethod.POST)
	public String doDelete(@PathVariable String customerID, ModelMap model)
			throws Exception {
		customerService.deleteCustomer(customerID);
		model.addAttribute("result", "true");
		return "cmm/resultType";
	}
	
	@RequestMapping("/view/{customerID}")
	public String view(@PathVariable String customerID, ModelMap model) throws Exception{
		Customer customer=customerService.getCustomer(customerID);
		if(customer==null)
		{ 	logger.debug("Invalid Customer ID");
			throw new GenericException("Customer's not found.");
		}
		model.addAttribute("customer", customer);
		model.addAttribute("page", "customers/view");
		return "layout/main";
	}
	
	@RequestMapping(value = "/ajaxGrid", method = RequestMethod.GET)
	public @ResponseBody Paging<ProjectType> ajaxGrid(HttpServletRequest request, ModelMap model) throws Exception{
		return customerService.getTotalRecords(request);

	}
	
}
