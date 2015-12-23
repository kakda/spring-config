package com.mobilecnc.security.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mobilecnc.security.Permission;

@Service
public class SecurityService {
	@Autowired
	SecurityDAO securityDAO;
	
	public List<Permission>getPermissions(String roleID) throws Exception{
		return securityDAO.getPermissions(roleID);
	}
}
