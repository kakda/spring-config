package com.mobilecnc.security.service;

import org.apache.log4j.Logger;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;

import com.mobilecnc.security.User;

public class DBAuthenticator implements IAuthenticationMethod {
	private User user;
	private String password;
	public DBAuthenticator(User user,String password){
		this.user=user;
		this.password=password;
	}
	public void authenticate() throws BadCredentialsException{
		ShaPasswordEncoder pwdEnc = new ShaPasswordEncoder();
		if(!pwdEnc.isPasswordValid(user.getPassword(), password,user.getEmployeeID()))
			throw new BadCredentialsException("Bad credentials, User Name/Password incorrect. Please contact administrator.");
	}
}
