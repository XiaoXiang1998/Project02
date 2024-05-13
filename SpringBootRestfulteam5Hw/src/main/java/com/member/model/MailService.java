package com.member.model;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

@Service
public class MailService {

	@Autowired
	private JavaMailSender mailSender;
	
	 public void sendResetPasswordEmail(String to, String token) throws MessagingException {
	        String resetPasswordLink = "http://localhost:8081/reset-password?token=" + token;
	        String emailContent = buildResetPasswordEmailContent(resetPasswordLink);

	        MimeMessage message = mailSender.createMimeMessage();
	        MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

	        helper.setTo(to);
	        helper.setSubject("重置您的密碼");
	        helper.setText(emailContent, true); // true indicates we're sending HTML

	        mailSender.send(message);
	    }

	    private String buildResetPasswordEmailContent(String link) {
	        return "<html>" +
	                "<body style='font-family: Arial, sans-serif; color: #333;'>" +
	                "<div style='width: 100%; max-width: 600px; margin: 20px auto; padding: 20px; background-color: #f7f7f7; border-radius: 10px; box-shadow: 0 2px 5px rgba(0,0,0,0.1);'>" +
	                "<h1 style='text-align: center; color: #555;'>重置您的密碼</h1>" +
	                "<p style='font-size: 16px; line-height: 1.5; text-align: center;'>您最近請求重置密碼。請點擊下面的按鈕進行重置：</p>" +
	                "<div style='text-align: center; margin: 30px;'>" +
	                "<a href='" + link + "' style='background-color: #4CAF50; color: white; padding: 15px 25px; text-align: center; text-decoration: none; display: inline-block; border-radius: 5px; font-size: 18px;' target='_blank'>重置密碼</a>" +
	                "</div>" +
	                "<p style='font-size: 14px; line-height: 1.5; text-align: center;'>如果您沒有請求重置密碼，請忽略此郵件。</p>" +
	                "<hr style='border: none; border-bottom: 1px solid #ccc; margin: 20px 0;'>" +
	                "<footer style='text-align: center; font-size: 12px; color: #aaa;'>" +
	                "<p>此郵件由系統自動發送，請勿回復。</p>" +
	                "</footer>" +
	                "</div>" +
	                "</body>" +
	                "</html>";
	    }
}
