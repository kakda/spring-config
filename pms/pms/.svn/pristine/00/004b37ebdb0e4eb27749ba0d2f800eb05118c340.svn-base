package com.mobilecnc.unsubmitReasons.controller;

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
import com.mobilecnc.unsubmitReasons.UnsubmitReason;
import com.mobilecnc.unsubmitReasons.service.UnsubmitReasonService;

/**
 * @author sambath kakda
 * @param unsubmitReason
 * @param model
 * @return
 */

@Controller
@RequestMapping(value = "/unsubmit-reasons")
public class UnsubmitReasonController {

	@Autowired
	UnsubmitReasonService unsubmitReasonService;
	// get log4j handler
	private static final Logger logger = Logger
			.getLogger(UnsubmitReasonController.class);

	@RequestMapping("/add")
	public String add(ModelMap model, HttpSession session) {

		model.addAttribute("message", session.getAttribute("message"));
		session.setAttribute("message", new Message()); 
		model.addAttribute("page", "unsubmitReasons/add");

		return "layout/main";
	}

	@RequestMapping("/update/{unsubmitReasonID}")
	public String update(@PathVariable String unsubmitReasonID, ModelMap model)
			throws Exception {
		UnsubmitReason unsubmitReason = unsubmitReasonService.getUnsubmitReason(unsubmitReasonID);

		if(unsubmitReason==null)
		{ 	logger.debug("Invalid Unsubmit Reason ID");
			throw new GenericException("Unsubmit reason's not found."); 
		}
		model.addAttribute("unsubmitReason", unsubmitReason);

		model.addAttribute("page", "unsubmitReasons/update");
		return "layout/main";
	}

	@RequestMapping("/doUpdate")
	public String doUpdate(@ModelAttribute UnsubmitReason unsubmitReason, ModelMap model, @ModelAttribute("Message") Message message, HttpSession session)
			throws Exception {
		unsubmitReason.setLastModifyBy((String)session.getAttribute("user"));
		unsubmitReasonService.updateUnsubmitReason(unsubmitReason);
		
		message.setUpdateSuccess();
		session.setAttribute("message", message);
		return "redirect:/unsubmit-reasons/index.html";
	}


	@RequestMapping("/index")
	public String index(ModelMap model, HttpSession session) {
		model.addAttribute("page", "unsubmitReasons/index");
		
		model.addAttribute("message", session.getAttribute("message"));
		session.setAttribute("message", new Message()); 
		return "layout/main";
	}

	@RequestMapping(value = "/ajaxGrid", method = RequestMethod.GET)
	public @ResponseBody
	Paging<UnsubmitReason> ajaxGrid(HttpServletRequest request, ModelMap model)
			throws Exception {
		return unsubmitReasonService.getTotalRecords(request);

	}

	@RequestMapping(value="/doDelete/{unsubmitReasonID}",method=RequestMethod.POST)
	public String doDelete(@PathVariable String unsubmitReasonID, ModelMap model)
			throws Exception {
		unsubmitReasonService.deleteUnsubmitReason(unsubmitReasonID);
		model.addAttribute("result", "true");
		return "cmm/resultType";
	}

	@RequestMapping("/view/{unsubmitReasonID}")
	public String view(@PathVariable String unsubmitReasonID, ModelMap model)
			throws Exception {
		UnsubmitReason unsubmitReason = unsubmitReasonService.getUnsubmitReason(unsubmitReasonID);

		if(unsubmitReason==null)
		{ 	logger.debug("Invalid Unsubmit Reason ID");
			throw new GenericException("Unsubmit reason's not found."); 
		}
		model.addAttribute("unsubmitReason", unsubmitReason);
		model.addAttribute("page", "unsubmitReasons/view");
		return "layout/main";
	}

	@RequestMapping("/doAdd")
	public String doAdd(ModelMap model,
			@ModelAttribute("Message") Message message,
			@ModelAttribute("UnsubmitReason") UnsubmitReason unsubmitReason, HttpServletRequest request, HttpSession session)
			throws Exception {
		unsubmitReason.setEntryBy((String)session.getAttribute("user"));
		unsubmitReason.setLastModifyBy((String)session.getAttribute("user"));
		unsubmitReasonService.insertUnsubmitReason(unsubmitReason);
	
		
		message.setSaveSuccess();
		session.setAttribute("message", message);

		if(request.getParameter("save").equalsIgnoreCase("save")){
			return "redirect:/unsubmit-reasons/add.html";			
		}else{
			return "redirect:/unsubmit-reasons/index.html";	
		}
	}

	@RequestMapping("/ajaxCheckUnsubmitReason")
	public @ResponseBody
	String ajaxCheckUnsubmitReason(@ModelAttribute("UnsubmitReason") UnsubmitReason unsubmitReason, ModelMap model,
			HttpServletRequest request) throws Exception {
		unsubmitReason.setReason(request.getParameter("fieldValue"));
		String unsubmitReasonID = "";
		if (request.getParameter("unsubmitReasonID") != null) {
			unsubmitReasonID = request.getParameter("unsubmitReasonID");
		}
		unsubmitReason.setUnsubmitReasonID(unsubmitReasonID);
		int cnt = unsubmitReasonService.checkExisName(unsubmitReason);
		String test = "";
		if (cnt > 0) {
			test = "false";
		} else {
			test = "true";
		}
		return "[\"" + request.getParameter("fieldId") + "\"," + test + "]";
	}

	
}
