package com.mobilecnc.security.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.GrantedAuthorityImpl;

import com.mobilecnc.security.UserVO;

/**
 * 
 * @author sereysopheak.eap
 *
 */
public class CustomAuthenticationManager implements AuthenticationManager {

	protected static Logger logger = Logger.getLogger( CustomAuthenticationManager.class );
	
	@Autowired
	UserService userService;
	public Authentication authenticate(Authentication auth)
			throws AuthenticationException {
		UserVO user;
		try{
			user = userService.getUser(auth.getName());
			AuthenticationContext authCtx = new AuthenticationContext();
			if(user==null) throw new BadCredentialsException("Bad credentials, User Name/Password incorrect. Please contact administrator.");
			if(!user.isActive()) throw new BadCredentialsException("Account has been expired. Please contact administrator.");
			if(user.getPassword()==null)
				authCtx.setAuthenticationMethod(new LDAPAuthenticator(auth.getName(),(String)auth.getCredentials()));
			else		
				authCtx.setAuthenticationMethod(new DBAuthenticator(user,(String)auth.getCredentials()));

			authCtx.authenticate();
		} catch (SQLException e) {
			logger.error( e );
			throw new BadCredentialsException("Connection problem");
		} catch(BadCredentialsException ex) {
			logger.error( ex );
			throw new BadCredentialsException("Bad credentials, User Name/Password incorrect. Please contact administrator.");	
		} catch(Exception ex) {
			logger.error( ex );
			throw new BadCredentialsException("Bad credentials, User Name/Password incorrect. Please contact administrator.");
		}
		return new UsernamePasswordAuthenticationToken(
				auth.getName(), 
				auth.getCredentials(), 
				getAuthorities(user.getRoleName()));
		

	}
	
	public Collection<GrantedAuthority> getAuthorities(String access){
		List<GrantedAuthority> authList = new ArrayList<GrantedAuthority>();
		authList.add(new GrantedAuthorityImpl("ROLE_" + access));	
		authList.add(new GrantedAuthorityImpl("ROLE_ANONYMOUS"));
		return authList;
	}

}
