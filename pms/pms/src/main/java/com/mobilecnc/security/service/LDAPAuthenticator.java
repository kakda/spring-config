package com.mobilecnc.security.service;

import java.util.HashMap;
import java.util.Hashtable;
import java.util.Map;

import javax.naming.Context;
import javax.naming.NamingEnumeration;
import javax.naming.directory.Attribute;
import javax.naming.directory.Attributes;
import javax.naming.directory.SearchControls;
import javax.naming.directory.SearchResult;
import javax.naming.ldap.InitialLdapContext;
import javax.naming.ldap.LdapContext;

import org.apache.log4j.Logger;
import org.springframework.security.authentication.BadCredentialsException;

import com.mobilecnc.helper.service.PropertiesService;


/**
 * 
 * @author sereysopheak.eap
 * 
 */
public class LDAPAuthenticator implements IAuthenticationMethod {
	private static final String SIMPLE = "simple";
	private static final String COM_SUN_JNDI_LDAP_LDAP_CTX_FACTORY = "com.sun.jndi.ldap.LdapCtxFactory";
	/*
	 * private static final String domain = "@mobilecnc.com"; private static
	 * final String searchBase = "DC=mobilecnc,DC=com";
	 */

//	private static final String domain = "@mcnc.co.kr";
//	private static final String searchBase = "DC=mcnc,DC=co,DC=kr";

	private static final String domain = PropertiesService.getProperty("LDAP.domain"); 
	private static final String searchBase = PropertiesService.getProperty("LDAP.base"); // + "DC=mobilecnc,DC=com";

	private static Logger	logger	= Logger.getLogger( LDAPAuthenticator.class );
	
	private String user;
	private String password;
	
	

	public LDAPAuthenticator(String user, String password) {
		this.user = user;
		this.password = password;
	}

	public void authenticate() throws BadCredentialsException {
		try {
			getAuthenticate();
		} catch (Exception e) {
			logger.error( e );
			throw new BadCredentialsException(
					"Bad credentials, User Name/Password incorrect. Please contact administrator.");
		}
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map getAuthenticate() throws Exception {
//		String ldapURL = "mobilecnc.com";
//		String ldapURL = "mcnc.co.kr";
//		String ldapURL = "218.55.79.2";
//		String ldapURL = "120.136.29.194";//120.136.29.194
		String ldapHost = PropertiesService.getProperty("LDAP.url"); //"ldap://" + ldapURL + ":389";

		String returnedAtts[] = { "userPrincipalName", "sn", "sAMAccountName",
				"givenName", "mail", "mailNickName" };
		String searchFilter = "(&(objectClass=user)(sAMAccountName=" + user
				+ "))";

		// Create the search controls
		SearchControls searchCtls = new SearchControls();
		searchCtls.setReturningAttributes(returnedAtts);
		// Specify the search scope
		searchCtls.setSearchScope(SearchControls.SUBTREE_SCOPE);
		Hashtable env = new Hashtable();
		env.put(Context.INITIAL_CONTEXT_FACTORY,
				COM_SUN_JNDI_LDAP_LDAP_CTX_FACTORY);
		env.put(Context.PROVIDER_URL, ldapHost);
		env.put(Context.SECURITY_AUTHENTICATION, SIMPLE);
		env.put(Context.SECURITY_PRINCIPAL, user + domain);
		env.put(Context.SECURITY_CREDENTIALS, password);
		LdapContext ctxGC = null;

		ctxGC = new InitialLdapContext(env, null);
		// Search objects in GC using filters
		NamingEnumeration answer = ctxGC.search(searchBase, searchFilter, searchCtls);

		while (answer.hasMoreElements()) {
			SearchResult sr = (SearchResult) answer.next();
			Attributes attrs = sr.getAttributes();
			Map amap = null;
			if (attrs != null) {
				amap = new HashMap();
				NamingEnumeration ne = attrs.getAll();
				while (ne.hasMore()) {
					Attribute attr = (Attribute) ne.next();
					amap.put(attr.getID(), attr.get());
				}
				ne.close();
			}
			return amap;
		}
		return null;
	}
}
