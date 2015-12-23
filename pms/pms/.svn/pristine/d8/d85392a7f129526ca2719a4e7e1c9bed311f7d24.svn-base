package com.mobilecnc.currency.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mobilecnc.currency.service.CurrencyService;
import com.mobilecnc.currency.service.CurrencyVO;

@Controller
@RequestMapping(value = "/currency")
public class CurrencyController {
	
	@Autowired 
	CurrencyService currencyService;
	
	@RequestMapping("/selectCurrencyList")
	public String selectCurrencyList(ModelMap model, @ModelAttribute("currencyVO") CurrencyVO currencyVO) throws Exception {
		currencyVO.setCurrencyList(currencyService.selectCurrencyList(currencyVO));
		model.addAttribute("currencyList", currencyVO.getCurrencyList());
		return "currency/selectCurrencyList";
	}
	
}
