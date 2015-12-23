package com.mobilecnc.invalids.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mobilecnc.helper.BaseController;

/**
 * 
 * @author sambath kakda
 *
 */
@Controller
@RequestMapping(value = "invalids/")
public class InvalidController extends BaseController{

	
	@RequestMapping("/browser-detect")
	public String browserDetect(ModelMap model) {		
		return "invalids/browserDetect";
	}

	@RequestMapping("/no-script")
	public String noScript(ModelMap model) {		
		model.addAttribute("page", "invalids/browserNotSupport");
		model.addAttribute("title", "Javascript is disabled !!");
		model.addAttribute("message", "<b>JavaScript</b> must be enabled for proper operation of the Administrator backend . ");
		return "layout/invalid";
	}
	
	@RequestMapping("/ie-not-support")
	public String ieNotSupport(ModelMap model){
		model.addAttribute("page", "invalids/browserNotSupport");
		model.addAttribute("title", "Upgrade Your Internet Explorer !!");
		model.addAttribute("message", "Please update your Internet Explorer . ");
		return "layout/invalid";		
	}
	@RequestMapping("/firefox-not-support")
	public String firefoxNotSupport(ModelMap model){
		model.addAttribute("page", "invalids/browserNotSupport");
		model.addAttribute("title", "Upgrade Your Firefox version !!");
		model.addAttribute("message", "Please update your firefox version . ");
		return "layout/invalid";
	}
	@RequestMapping("/chrome-not-support")
	public String chromeNotSupport(ModelMap model){
		model.addAttribute("page", "invalids/browserNotSupport");
		model.addAttribute("title", "Upgrade Your Chrome version !!");
		model.addAttribute("message", "Please update your chrome version . ");
		return "layout/invalid";
	}
	@RequestMapping("/browser-not-support")
	public String browserNotSupport(ModelMap model){
		model.addAttribute("page", "invalids/browserNotSupport");
		model.addAttribute("title", "Please Change your browser !!");
		model.addAttribute("message", "Please change your browser . Browser support: <b>Internet Explorer 8+</b>, <b> Firefox 8+</b>, <b> Safari 5+</b>, <b> Google Chrome 15+</b> . ");
		return "layout/invalid";
	}
	@RequestMapping("/safari-not-support")
	public String safariNotSupport(ModelMap model){
		model.addAttribute("page", "invalids/browserNotSupport");
		model.addAttribute("title", "Please Change your browser !!");
		model.addAttribute("message", "Please update your safari version . ");
		return "layout/invalid";
	}
	@RequestMapping("/firebug-enable")
	public String firebugEnable(ModelMap model){
		model.addAttribute("page", "invalids/browserNotSupport");
		model.addAttribute("title", "Firebug enabled !!");
		model.addAttribute("message", "Please disable firebug to continue. ");
		return "layout/invalid";
	}
}
