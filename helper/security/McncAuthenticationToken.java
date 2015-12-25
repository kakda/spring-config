package com.mcnc.yuga.helper.security;

import java.io.Serializable;
import java.util.Collection;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;

import com.mcnc.yuga.helper.security.AppUser;

public class McncAuthenticationToken extends UsernamePasswordAuthenticationToken implements Serializable{
	
	private AppUser appUser = null;
	
	private static final long serialVersionUID = 1L;

	public McncAuthenticationToken(Object principal, Object credentials,
			Collection<? extends GrantedAuthority> authorities, AppUser appUser) {
		super(principal, credentials, authorities);
		this.appUser = appUser;
	}

	public AppUser getAppUser() {
		return appUser;
	}

	public void setAppUser(AppUser appUser) {
		this.appUser = appUser;
	}

}
