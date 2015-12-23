package com.mobilecnc.security.service;

import org.springframework.security.authentication.BadCredentialsException;

public class AuthenticationContext {
	private IAuthenticationMethod authenticationMethod;

	public IAuthenticationMethod getAuthenticationMethod() {
		return authenticationMethod;
	}

	public void setAuthenticationMethod(IAuthenticationMethod authenticationMethod) {
		this.authenticationMethod = authenticationMethod;
	}
	
	public void authenticate() throws BadCredentialsException{
		authenticationMethod.authenticate();
	}
}
