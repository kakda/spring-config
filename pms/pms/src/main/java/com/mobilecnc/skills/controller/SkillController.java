/**
 * @author Chamroeun
 */
package com.mobilecnc.skills.controller;

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
import com.mobilecnc.helper.Message;
import com.mobilecnc.helper.Paging;
import com.mobilecnc.skills.Skill;
import com.mobilecnc.skills.service.SkillService;

@Controller
@RequestMapping(value = "/skills")
public class SkillController {

	@Autowired
	SkillService skillService;
	// get log4j handler
	private static final Logger logger = Logger
			.getLogger(SkillController.class);

	@RequestMapping("/index")
	public String index(ModelMap model, @ModelAttribute("Message") Message message, HttpSession session){
		model.addAttribute("page", "skills/index");
		model.addAttribute("message", session.getAttribute("message"));
		session.setAttribute("message", new Message());
		return "layout/main";
	}
	
	@RequestMapping("/add")
	public String add(ModelMap model, @ModelAttribute("Message") Message message, HttpSession session) {
		model.addAttribute("page", "skills/add");
		model.addAttribute("message", session.getAttribute("message"));
		session.setAttribute("message", new Message());
		return "layout/main";
	}
	
	@RequestMapping("/doAdd")
	public String doAdd(ModelMap model, @ModelAttribute("Skill") Skill skill, @ModelAttribute("Message") Message message, HttpSession session, HttpServletRequest request)
			throws Exception {
		skill.setEntryBy((String)session.getAttribute("user"));
		skillService.insertSkill(skill);
		message.setSaveSuccess();
		session.setAttribute("message", message);	
		
		if (request.getParameter("save").equalsIgnoreCase("save")) {
			return "redirect:/skills/add.html";
		} else {
			return "redirect:/skills/index.html";
		}
	}

	@RequestMapping("/update/{skillID}")
	public String update(@PathVariable String skillID, ModelMap model) throws Exception{
		Skill skill = skillService.getSkill(skillID);

		if(skill==null)
		{ 	logger.debug("Invalid Skill ID");
			throw new GenericException("Skill's not found."); 
		}
		model.addAttribute("skill", skill);
		model.addAttribute("page","skills/update");
		return "layout/main" ;
	}
	
	@RequestMapping("/selectSkillList")
	public String selectSkillList(ModelMap model,@ModelAttribute("skill") Skill skill, HttpServletRequest request, @RequestParam(defaultValue = "247px", value="width") String width) throws Exception{
		model.addAttribute("skillList",skillService.getAllSkills());
		model.addAttribute("id",request.getParameter("id"));
		model.addAttribute("placeholder", request.getParameter("placeholder"));
		model.addAttribute("width", width);
		String multiple = "";
		if(request.getParameter("multiple") != null && request.getParameter("multiple").equalsIgnoreCase("true"))
		{
			multiple = "multiple";
		}
		model.addAttribute("multiple", multiple);
		model.addAttribute("validate", request.getParameter("validate"));
		return "skills/selectSkillList";
		
	}
	
	
	
	@RequestMapping("/doUpdate")
	public String doUpdate(@ModelAttribute Skill skill, ModelMap model,  @ModelAttribute("Message") Message message, HttpSession session) throws Exception{

		skill.setLastModifyBy((String)session.getAttribute("user"));
		skillService.updateSkill(skill);
		
		message.setUpdateSuccess();
		session.setAttribute("message", message);
		return "redirect:/skills/index.html";
	}
	
	@RequestMapping(value="/doDelete/{skillID}",method=RequestMethod.POST)
	public String doDelete(@PathVariable String skillID, ModelMap model)
			throws Exception {
		skillService.deleteSkill(skillID);
		model.addAttribute("result", "true");
		return "cmm/resultType";
	}
	
	@RequestMapping("/view/{skillID}")
	public String view(@PathVariable String skillID, ModelMap model) throws Exception{
		Skill skill = skillService.getSkill(skillID);

		if(skill==null)
		{ 	logger.debug("Invalid Skill ID");
			throw new GenericException("Skill's not found."); 
		}
		model.addAttribute("skill", skill);
		model.addAttribute("page", "skills/view");
		return "layout/main";
	}
	
	@RequestMapping(value = "/ajaxGrid", method = RequestMethod.GET)
	public @ResponseBody Paging<Skill> ajaxGrid(HttpServletRequest request, ModelMap model) throws Exception{
		return skillService.getTotalRecords(request);

	}
	
	
	@RequestMapping("/ajaxCheckSkill")
	public @ResponseBody
	String ajaxCheckSkill(@ModelAttribute("Skill") Skill skill, ModelMap model,
			HttpServletRequest request) throws Exception {
		skill.setSkillName(request.getParameter("fieldValue"));
		String skillID = "";
		if (request.getParameter("skillID") != null) {
			skillID = request.getParameter("skillID");
		}
		skill.setSkillID(skillID);
		int cnt = skillService.checkExistName(skill);
		String test = "";
		if (cnt > 0) {
			test = "false";
		} else {
			test = "true";
		}
		return "[\"" + request.getParameter("fieldId") + "\"," + test + "]";
	}
	
	
}


