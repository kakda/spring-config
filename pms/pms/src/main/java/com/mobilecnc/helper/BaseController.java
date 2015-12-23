package com.mobilecnc.helper;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.log4j.Logger;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;

import com.mobilecnc.helper.service.PropertiesService;

@Controller
public class BaseController {

	protected  Logger logger = Logger.getLogger(this.getClass());
	
	protected static Logger log = Logger.getLogger("service");
	
	protected SimpleDateFormat dateFormat = new SimpleDateFormat(PropertiesService.getProperty("date.format"));
	
	@InitBinder
   public void initBinder(WebDataBinder binder) {
         binder.initDirectFieldAccess();
         /* register appropriate date editor */ 
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat,true));
        binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
    }
}
