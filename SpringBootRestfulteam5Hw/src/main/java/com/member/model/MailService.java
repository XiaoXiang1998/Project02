package com.member.model;

import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class MailService {

	@Autowired
	private JavaMailSender mailSender;
	
	public void sendPlainText(Collection<String> receivers, String subject, String content) {
		SimpleMailMessage message = new SimpleMailMessage();
		/*設定收件人*/
        message.setTo(receivers.toArray(new String[0]));
        /*設定主旨*/
        message.setSubject(subject);
        /*設定文章內容*/
        message.setText(content);
        /*設定讓名字顯示再寄件人*/
        message.setFrom("EZBuy Official<ezbuycompany@gmail.com>");
        

        mailSender.send(message);
	}
}
