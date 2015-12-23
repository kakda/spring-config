package com.mobilecnc.helper.service;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.mail.AuthenticationFailedException;
import javax.mail.MessagingException;
import javax.mail.Transport;
import javax.mail.internet.MimeMessage;

import org.apache.log4j.Logger;
import org.springframework.mail.MailAuthenticationException;
import org.springframework.mail.MailException;
import org.springframework.mail.MailSendException;
import org.springframework.mail.javamail.JavaMailSenderImpl;

public class CustomJavaMailSender extends JavaMailSenderImpl {
	static Logger logger = Logger.getLogger(CustomJavaMailSender.class);
	
	@Override
	@SuppressWarnings("unchecked")
	protected void doSend(MimeMessage[] mimeMessages, Object[] originalMessages) throws MailException {
		
         Map failedMessages = new HashMap();
         try {
             Transport transport = getTransport(getSession());
             if(getSession().getProperty("mail.smtp.auth").equalsIgnoreCase("false"))
            	 transport.connect();
             else
            	 transport.connect(getHost(), getPort(), getUsername(), getPassword());
             try {
                 for (int i = 0; i < mimeMessages.length; i++) {
                     MimeMessage mimeMessage = mimeMessages[i];
                     try {
                         if (mimeMessage.getSentDate() == null) {
                             mimeMessage.setSentDate(new Date());
                         }
                         mimeMessage.saveChanges();
                         transport.sendMessage(mimeMessage, mimeMessage.getAllRecipients());
                     }
                     catch (MessagingException ex) {
                         Object original = (originalMessages != null ? originalMessages[i] : mimeMessage);
                         failedMessages.put(original, ex);
                     }
                 }
             }
             finally {
                 transport.close();
             }
         }
         catch (AuthenticationFailedException ex) {
             throw new MailAuthenticationException(ex);
         }
         catch (MessagingException ex) {
             throw new MailSendException("Mail server connection failed", ex);
         }
         if (!failedMessages.isEmpty()) {
             throw new MailSendException(failedMessages);
         }
     }

}
