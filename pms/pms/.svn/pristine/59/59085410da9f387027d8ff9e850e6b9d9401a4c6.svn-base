package com.mobilecnc.helper.service;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.i18n.CookieLocaleResolver;

import com.mobilecnc.customers.controller.CustomerController;
/**
 * 
 * @author sereysopheak.eap
 *
 */
public class CustomCookieLocaleResolver extends CookieLocaleResolver {  
	   Logger log=Logger.getLogger(CustomerController.class);
	private LocaleResolver nextLocaleResolver;  
	  
	public void setNextLocaleResolver(LocaleResolver resolver) {  
	this.nextLocaleResolver = resolver;  
	}  
	  
	@Override  
	protected Locale determineDefaultLocale(HttpServletRequest request) {
		return nextLocaleResolver.resolveLocale(request);  
	}  
}  
