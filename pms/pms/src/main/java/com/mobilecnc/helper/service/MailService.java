package com.mobilecnc.helper.service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailParseException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
public class MailService {

	@Autowired
	private JavaMailSender javaMailSender;

	private SimpleMailMessage simpleMailMessage;

	Logger logger = Logger.getLogger(MailService.class);

	public SimpleMailMessage getSimpleMailMessage() {
		return simpleMailMessage;
	}

	public void setSimpleMailMessage(SimpleMailMessage simpleMailMessage) {
		this.simpleMailMessage = simpleMailMessage;
	}

	/**
	 * @author : Sereysopheak - call for sending mail
	 * @param : String title
	 * @param : String to_address
	 * @param : String dear
	 */
	public void sendMail(String title, String[] to_address, String dear) {
		MimeMessage message = javaMailSender.createMimeMessage();
		try {
			MimeMessageHelper helper = new MimeMessageHelper(message, true);
			helper.setText(String.format(simpleMailMessage.getText(), dear),
					true);
			helper.setSubject(title);
			helper.setTo(to_address);
			helper.setFrom(PropertiesService.getProperty("mail.from"));
			String cc=PropertiesService.getProperty("mail.cc");
			if(!(cc.isEmpty()||cc==null))
				helper.setCc(PropertiesService.getProperty("mail.cc").split(","));
		} catch (MessagingException ex) {
			throw new MailParseException(ex);
		}

		javaMailSender.send(message);

	}
}
