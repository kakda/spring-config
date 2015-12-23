package com.mobilecnc.employees.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ldap.core.LdapTemplate;
import org.springframework.stereotype.Repository;

import com.mobilecnc.employees.ADUser;
import com.mobilecnc.employees.UserAttributesMapper;
import com.mobilecnc.helper.service.PropertiesService;

@Repository(value="ldapService")
public class ADService {
	@Autowired
	private LdapTemplate ldapTemplate;
	
	@SuppressWarnings("unchecked")
	public List<ADUser> getAllUsers(){
				
		UserAttributesMapper mapper = new UserAttributesMapper();
		return ldapTemplate.search(PropertiesService.getProperty("LDAP.userRoot"), "(objectClass=person)", mapper);
	}
}
