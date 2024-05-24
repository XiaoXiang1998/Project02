package com.appeals.controller;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.appeals.model.EmailService;

@Controller
public class EmailController {

    @Autowired
    private EmailService emailService;

    @GetMapping("/sendEmailTest")
    public String sendEmail(
        @RequestParam String subject,
        @RequestParam String body,
        @RequestParam(required = false) String order,
        @RequestParam(required = false) String phone,
        @RequestParam(required = false) String other) {
        
        String to = "javamailtest0518@gmail.com"; // 固定的收件者邮箱

        StringBuilder emailBody = new StringBuilder();
        emailBody.append("描述: ").append(body).append("\n\n");
        if (order != null && !order.isEmpty()) {
            emailBody.append("訂單編號: ").append(order).append("\n");
        }
        if (phone != null && !phone.isEmpty()) {
            emailBody.append("電話號碼: ").append(phone).append("\n");
        }
        if (other != null && !other.isEmpty()) {
            emailBody.append("附件: ").append(other).append("\n");
        }
        emailService.sendEmail(to, subject, emailBody.toString());
        
        return "Appeals/mail";
    }
}
