package com.mobilecnc.helper.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mobilecnc.helper.CustomKey;

/**
 * 
 * @author sereysopheak.eap
 * @Description provide a service to generate AutoID for database store
 */
@Service
public class PKService {
	
	static PKDAO pKDAO;
	
	@SuppressWarnings("static-access")
	@Autowired
	public void setpKDAO(PKDAO pKDAO) {
		this.pKDAO = pKDAO;
	}


	public static String generateKey(String tableName){
		CustomKey customKey = new CustomKey();
		customKey.setTableName(tableName);
		customKey.setFieldName(PropertiesService.getProperty(tableName + ".key"));
		customKey.setPattern(PropertiesService.getProperty(tableName + ".pattern"));
		customKey.setDigitLength(Integer.parseInt(PropertiesService.getProperty(tableName + ".digitLength")));
		
		return pKDAO.getPKValue(customKey);
	}
}
