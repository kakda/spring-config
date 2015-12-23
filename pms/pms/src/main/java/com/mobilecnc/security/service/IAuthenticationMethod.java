package com.mobilecnc.security.service;

import org.springframework.security.authentication.BadCredentialsException;

public interface IAuthenticationMethod {
	public void authenticate() throws BadCredentialsException;
}
