package com.mobilecnc.employees;

import javax.naming.NamingException;
import javax.naming.directory.Attribute;
import javax.naming.directory.Attributes;

import org.springframework.ldap.core.AttributesMapper;

public class UserAttributesMapper implements AttributesMapper {

	@Override
	public ADUser mapFromAttributes(Attributes attributes) throws NamingException {
		
		ADUser user = new ADUser();
		Attribute cn=attributes.get("cn");
		Attribute phone=attributes.get("telephoneNumber");
		Attribute mail=attributes.get("mail");
		Attribute login=attributes.get("sAMAccountName");
		
		user.setCommonName((String)cn.get());
		user.setTelephone(phone!=null?(String)phone.get():null);
		user.setMail(mail!=null?(String)mail.get():null);
		user.setLogin(login!=null?(String)login.get():null);
		return user;
	}

}
