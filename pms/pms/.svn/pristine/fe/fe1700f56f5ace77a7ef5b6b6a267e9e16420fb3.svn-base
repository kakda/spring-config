package com.mobilecnc.security.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.access.SecurityConfig;
import org.springframework.security.web.FilterInvocation;
import org.springframework.security.web.access.intercept.FilterInvocationSecurityMetadataSource;

/**
 * 
 * @author sereysopheak.eap
 *
 */
public class CustomFilterSecurityMetadataSource implements FilterInvocationSecurityMetadataSource {
	@Autowired
	URLDAO urlDAO;

	public List<ConfigAttribute> getAttributes(Object object) {
        FilterInvocation fi = (FilterInvocation) object;
        String url = fi.getRequestUrl();
        List<ConfigAttribute> attributes = new ArrayList<ConfigAttribute>();

        attributes = getAttributesByURL(url);
        
        return attributes;
    }

	public Collection<ConfigAttribute> getAllConfigAttributes() {
		return null;
	}

    public boolean supports(Class<?> clazz) {
        return FilterInvocation.class.isAssignableFrom(clazz);
    }

    public List<ConfigAttribute> getAttributesByURL(String url)
    {
        List<ConfigAttribute> attributes = new ArrayList<ConfigAttribute>();
        List<String> roles;
        try{
        	roles = urlDAO.getRoles(url);
	        for(String role:roles)
	        {	ConfigAttribute ca = new SecurityConfig("ROLE_"+role); 
	        	attributes.add(ca);
	        }
        }catch(Exception exception)
        {
        	exception.printStackTrace();
        	return null;
        }
        if(url.contains("/main.html") || url.contains("/user/my-profile.html")) 
        	attributes.add(new SecurityConfig("ROLE_ANONYMOUS"));
        return attributes;
    }
}