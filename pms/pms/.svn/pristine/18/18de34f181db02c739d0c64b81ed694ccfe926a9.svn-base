package com.mobilecnc.teams.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
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
import com.mobilecnc.helper.report.DownloadService;
import com.mobilecnc.helper.report.TokenService;
import com.mobilecnc.helper.service.MailService;
import com.mobilecnc.teams.Team;
import com.mobilecnc.teams.TeamVO;
import com.mobilecnc.teams.service.TeamService;

/**
 * 
 * @author sereysopheak.eap
 *
 */
@Controller
@RequestMapping(value = "teams/")
public class TeamController extends BaseController{
	@Autowired
	TeamService teamService;
	
	@Autowired
	TokenService tokenService;
	
	@Autowired
	DownloadService downloadService;
	
	@Autowired
	org.apache.commons.dbcp.BasicDataSource dataSource;
	
	@Resource(name = "mail")
	MailService mailService;;

	Logger logger=Logger.getLogger(TeamController.class);
	@RequestMapping("/add")
	public String add(ModelMap model,HttpSession session) {
		
		model.addAttribute("message", session.getAttribute("message"));
		session.setAttribute("message", null);
		
		model.addAttribute("page", "teams/add");

		return "layout/main";
	}
	
	/*@RequestMapping(value="/reports/download")
	public void download(@RequestParam String type,
			@RequestParam String token,
			HttpServletResponse response) throws SQLException {
		
		HashMap<String, Object> params = new HashMap<String, Object>(); 
		//params.put("p_teamName", "");
		
		downloadService.download(type, token, response,"/mobilecnc/reports/employees.jrxml",params);
	}*/
	
	@RequestMapping("/update/{teamID}")
	public String update(@PathVariable String teamID, ModelMap model) throws Exception{
		TeamVO team=teamService.getTeam(teamID);
		if(team==null)
		{ 	logger.debug("Invalid ID");
			throw new GenericException("Team's not found.");
		}
		model.addAttribute("team", team);

		model.addAttribute("page", "teams/update");
		return "layout/main";
	}


	@RequestMapping("/doUpdate")
	public String doUpdate(@ModelAttribute Team team, @ModelAttribute("Message") Message message, ModelMap model, HttpSession session) throws Exception{
		team.setLastModifyBy((String)session.getAttribute("user"));
		teamService.updateTeam(team);
		message.setUpdateSuccess();
		session.setAttribute("message", message);
		
		return "redirect:/teams/index.html";
	}


	@RequestMapping("/index")
	public String index(ModelMap model,HttpSession session) {
		model.addAttribute("page", "teams/index");
		model.addAttribute("message", session.getAttribute("message"));
		session.setAttribute("message", new Message()); 
		return "layout/main";
	}

	@RequestMapping(value = "/ajaxGrid", method = RequestMethod.GET)
	public @ResponseBody Paging<TeamVO> ajaxGrid(HttpServletRequest request, ModelMap model) throws Exception{
		return teamService.getTotalRecords(request);
	}

	@RequestMapping(value="/doDelete/{teamID}", method=RequestMethod.POST)
	public String doDelete(@PathVariable String teamID, ModelMap model)
			throws Exception {
		teamService.deleteTeam(teamID);
		model.addAttribute("result", "true");
		return "cmm/resultType";
	}

	@RequestMapping("/view/{teamID}")
	public String view(@PathVariable String teamID, ModelMap model)
			throws Exception {
		TeamVO team =  teamService.getTeam(teamID);
		if(team==null)
		{ 	logger.debug("Invalid ID");
			throw new GenericException("Team's not found.");
		}
		model.addAttribute("team", team);
		model.addAttribute("page", "teams/view");
		return "layout/main";
	}

	@RequestMapping("/doAdd")
	public String doAdd(ModelMap model, @ModelAttribute("Team") Team team,@ModelAttribute("Message") Message message,HttpSession session, HttpServletRequest request)
			throws Exception {
		team.setEntryBy((String)session.getAttribute("user"));
		team.setLastModifyBy((String)session.getAttribute("user"));
		teamService.insertTeam(team);
		message.setSaveSuccess();
		session.setAttribute("message", message);
		if(request.getParameter("save").equalsIgnoreCase("save")){
			return "redirect:/teams/add.html";			
		}else{
			return "redirect:/teams/index.html";	
		}
	}

	@RequestMapping("/ajaxCheckTeam")
	public @ResponseBody String ajaxCheckTeam(@ModelAttribute("Team") Team team,
			ModelMap model, HttpServletRequest request) throws Exception {
		team.setTeamName(request.getParameter("fieldValue"));
		String teamID = "";
		if(request.getParameter("teamID") != null)
		{
			teamID = request.getParameter("teamID");
		}
		team.setTeamID(teamID);
		int cnt = teamService.checkExistName(team);
		String test="";
		if (cnt > 0) {
			test = "false";
		} else {
			test = "true";
		}
		return "[\"" + request.getParameter("fieldId") + "\"," + test + "]";
	}
	
	@RequestMapping("/jsonDate")
	public @ResponseBody Map<String,Date> jsonDate(ModelMap model) throws Exception {
		//System.out.println("***************************" + dateFormat.format(new Date()));
		Map<String,Date> map = new HashMap<String,Date>();
		map.put("date",new Date());
		return map;
	}
	
	@RequestMapping("/selectTeamList")
	public String selectTeamList(ModelMap model, @ModelAttribute Team team, HttpServletRequest request, @RequestParam(defaultValue = "247px", value="width") String width) throws Exception {
		
		model.addAttribute("teamsList", teamService.selectTeamList());
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
		return "teams/selectTeamList";
	}
	
}
