package com.mobilecnc.calender.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mobilecnc.calender.Calenders;
import com.mobilecnc.calender.service.CalenderService;
import com.mobilecnc.companies.controller.CompanyController;
import com.mobilecnc.helper.BaseController;


@RequestMapping("/calender")
@Controller
public class CalenderController extends BaseController{
	
	private static final Logger logger = Logger.getLogger(CalenderController.class);
	
	@Autowired
	CalenderService calenderService;
	
	@RequestMapping("/index")
	public String index(ModelMap model){
		model.addAttribute("page", "calender/index");

		return "layout/main";
	}

	@RequestMapping(value = "/ajaxGetCalender" ,method = RequestMethod.POST)
	public @ResponseBody List<Calenders>ajaxGetCalender(@RequestBody Calenders calender){
		return calenderService.getCalender(calender) ;
	}
	
	@RequestMapping("/doadd")
	public @ResponseBody Calenders insertCalender(@RequestBody Calenders calender){
		return calenderService.insertCalender(calender);
	}
	
	@RequestMapping("/doUpdate")
	public @ResponseBody Calenders doUpdate(@RequestBody Calenders calender){
		return calenderService.updateCalender(calender);
	}
	
	@RequestMapping("/doDelete")
	public @ResponseBody boolean doDelete(@RequestBody Calenders calender){
		return calenderService.deleteCalender(calender);
	}
	
	@RequestMapping("/getHistory")
	public @ResponseBody HashMap<String, List<Calenders>> getHistory(){
		List<Calenders> calender = calenderService.getHistory();
		LinkedHashMap<String, List<Calenders>> map = new LinkedHashMap<String, List<Calenders>>();
		for (Calenders LinkMap : calender) {
			String key = LinkMap.getYears();
			if(map.get(key) == null){
				map.put(key, new ArrayList<Calenders>());
			}
			map.get(key).add(LinkMap);
		}
		
		return map;
	}
	@RequestMapping("/copyCalender")
	public @ResponseBody boolean copyCalender(){
		return calenderService.copyCalender();
	}
	
	@RequestMapping("/removeDataYear")
	public @ResponseBody boolean removeDataYear(@ModelAttribute(value="calen") Calenders calen){
		try {
			calenderService.removeDataYear(calen);
			return true;
		} catch (Exception e) {
			System.out.println(e.toString());
			return false;
		}
		
	}
	
}
