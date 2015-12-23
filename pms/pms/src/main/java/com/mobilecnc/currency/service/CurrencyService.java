package com.mobilecnc.currency.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CurrencyService {
	@Autowired
	CurrencyDAO currencyDAO;
	
	public List<CurrencyVO> selectCurrencyList(CurrencyVO currencyVO) throws Exception {
		return currencyDAO.selectCurrencyList(currencyVO);
	}

}
