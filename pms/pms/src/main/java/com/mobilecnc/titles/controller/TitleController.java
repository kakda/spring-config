package com.mobilecnc.titles.controller;

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
import com.mobilecnc.titles.Title;
import com.mobilecnc.titles.service.TitleService;

@Controller
@RequestMapping(value = "/titles")
public class TitleController extends BaseController{
	Logger logger=Logger.getLogger(TitleController.class);

	@Autowired
	TitleService titleService;

	@RequestMapping("/add")
	public String add(ModelMap model, HttpSession session) {

		model.addAttribute("message", session.getAttribute("message"));
		session.setAttribute("message", null); 
		model.addAttribute("page", "titles/add");

		return "layout/main";
	}
	
	/**
	 * @author sereysopheak.eap
	 * @param titleID
	 * @param model
	 * @return
	 */
	@RequestMapping("/update/{titleID}")
	public String update(@PathVariable String titleID, ModelMap model)
			throws Exception {
		Title title = titleService.getTitle(titleID);

		if(title==null)
		{ 	logger.debug("Invalid Title ID");
			throw new GenericException("Title's not found."); 
		}
		model.addAttribute("title", title);

		model.addAttribute("page", "titles/update");
		return "layout/main";
	}

	/**
	 * @author sereysopheak.eap
	 * @param title
	 * @param model
	 * @return
	 */
	@RequestMapping("/doUpdate")
	public String doUpdate(@ModelAttribute Title title, ModelMap model, @ModelAttribute("Message") Message message, HttpSession session)
			throws Exception {
		title.setLastModifyBy((String)session.getAttribute("user"));
		titleService.updateTitle(title);
		
		message.setUpdateSuccess();
		session.setAttribute("message", message);
		return "redirect:/titles/index.html";
	}
	
	/**
	 * @author sambath kakda
	 * @param title
	 * @param model
	 * @return
	 */

	@RequestMapping("/index")
	public String index(ModelMap model, HttpSession session) {
		model.addAttribute("page", "titles/index");
		
		// @Sambath Kakda
		
		model.addAttribute("message", session.getAttribute("message"));
		session.setAttribute("message", new Message()); 
		return "layout/main";
	}

	@RequestMapping(value = "/ajaxGrid", method = RequestMethod.GET)
	public @ResponseBody
	Paging<Title> ajaxGrid(HttpServletRequest request, ModelMap model)
			throws Exception {
		return titleService.getTotalRecords(request);

	}

	@RequestMapping(value="/doDelete/{titleID}",method=RequestMethod.POST)
	public String doDelete(@PathVariable String titleID, ModelMap model) throws Exception{
			titleService.deleteTitle(titleID);
			model.addAttribute("result", "true");
		return "cmm/resultType";
	}

	@RequestMapping("/view/{titleID}")
	public String view(@PathVariable String titleID, ModelMap model)
			throws Exception {
		Title title = titleService.getTitle(titleID);

		if(title==null)
		{ 	logger.debug("Invalid Title ID");
			throw new GenericException("Title's not found."); 
		}
		model.addAttribute("title", title);
		model.addAttribute("page", "titles/view");
		return "layout/main";
	}

	/**
	 * Rin Rady
	 * 
	 * @param model
	 * @param titleID
	 * @throws Exception
	 * 
	 */
	@RequestMapping("/doAdd")
	public String doAdd(ModelMap model, @ModelAttribute("Message") Message message, @ModelAttribute Title title, HttpSession session, HttpServletRequest request)
			throws Exception {
		title.setEntryBy((String)session.getAttribute("user"));
		title.setLastModifyBy((String)session.getAttribute("user"));
		titleService.insertTitle(title);

		message.setSaveSuccess();
		session.setAttribute("message", message);
		if(request.getParameter("save").equalsIgnoreCase("save")){
			return "redirect:/titles/add.html";			
		}else{
			return "redirect:/titles/index.html";	
		}
	}

	/**
	 * Rin Rady
	 * 
	 * @param title
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/ajaxCheckTitle")
	public @ResponseBody
	String ajaxCheckTitle(@ModelAttribute("Title") Title title, ModelMap model,
			HttpServletRequest request) throws Exception {
		title.setTitleName(request.getParameter("fieldValue"));
		String titleID = "";
		if (request.getParameter("titleID") != null) {
			titleID = request.getParameter("titleID");
		}
		title.setTitleID(titleID);
		int cnt = titleService.checkExisName(title);
		String test = "";
		if (cnt > 0) {
			test = "false";
		} else {
			test = "true";
		}
		return "[\"" + request.getParameter("fieldId") + "\"," + test + "]";
	}
	
	@RequestMapping("/selectTitleList")
	public String selectTitleList(ModelMap model, @ModelAttribute Title title, HttpServletRequest request, @RequestParam(defaultValue = "247px", value="width") String width) throws Exception {
		
		model.addAttribute("titlesList", titleService.selectTitleList());
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
		return "titles/selectTitleList";
	}

}
