package com.sean.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

@Service
public class OrderMail {	
	
	@Autowired
	private JavaMailSender mailSender;
	@Async
	public void sendBuyerMessage(String BuyerEmail, String buyerName,Integer orderId,String goodsName,Integer originalPrice,Integer quantity,Integer totalPrice) {
		String Buyersubject = "您有一份訂單已成立";
        String BuyertextContent = generateEmailContent(buyerName,orderId,goodsName, originalPrice, quantity, totalPrice);
        MimeMessage Buyermessage = mailSender.createMimeMessage();
        System.out.println(BuyertextContent);
        try {
            MimeMessageHelper helper = new MimeMessageHelper(Buyermessage, true);
            helper.setFrom("ezbuycompany@gmail.com");
            helper.setTo(BuyerEmail);
            helper.setSubject(Buyersubject);
            helper.setText(BuyertextContent, true);
            mailSender.send(Buyermessage);
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
	}
	private String generateEmailContent(String buyerName, Integer orderId, String goodsName, Integer originalPrice, Integer quantity, Integer totalPrice) {
	    return "<html>"
	            + "<body style=\"font-family: Arial, sans-serif; background-color: #f8f9fa; margin: 0; padding: 0;\">"
	            + "    <div style=\"width: 100%; max-width: 600px; margin: auto; background-color: #fff; border-radius: 10px; border: 2px solid #0dcaf0; overflow: hidden;\">"
	            + "        <div style=\"background-color: #0dcaf0; color: #fff; padding: 20px; text-align: center; font-size: 24px;\">"
	            + "            EZ BUY 電商平台"
	            + "        </div>"
	            + "        <div style=\"padding: 20px; font-size: 18px; color: #333;\">"
	            + "            <p>親愛的 " + buyerName + " 您好，感謝您本次的購買</p>"
	            + "            <p>您的訂單編號 " + orderId + " 已成立</p>"
	            + "            <table style=\"width: 100%; border-collapse: collapse; margin: 20px 0;\">"
	            + "                <tr>"
	            + "                    <th style=\"border: 1px solid #0dcaf0; background-color: #e9f7fc; padding: 10px; text-align: center;\">購買商品</th>"
	            + "                    <td style=\"border: 1px solid #0dcaf0; padding: 10px; text-align: center;\">" + goodsName + "</td>"
	            + "                </tr>"
	            + "                <tr>"
	            + "                    <th style=\"border: 1px solid #0dcaf0; background-color: #e9f7fc; padding: 10px; text-align: center;\">單價</th>"
	            + "                    <td style=\"border: 1px solid #0dcaf0; padding: 10px; text-align: center;\">" + originalPrice + "</td>"
	            + "                </tr>"
	            + "                <tr>"
	            + "                    <th style=\"border: 1px solid #0dcaf0; background-color: #e9f7fc; padding: 10px; text-align: center;\">數量</th>"
	            + "                    <td style=\"border: 1px solid #0dcaf0; padding: 10px; text-align: center;\">" + quantity + "</td>"
	            + "                </tr>"
	            + "                <tr>"
	            + "                    <th style=\"border: 1px solid #0dcaf0; background-color: #e9f7fc; padding: 10px; text-align: center;\">總共金額</th>"
	            + "                    <td style=\"border: 1px solid #0dcaf0; padding: 10px; text-align: center;\">" + totalPrice + "</td>"
	            + "                </tr>"
	            + "            </table>"
	            + "            <p><strong>若要查詢訂單狀態，可於登入會員後，於會員中心內查詢。</strong></p>"
	            + "            <p>網址:<a href=\"http://localhost:8081/EZBuyIndex\" style=\"color: #0dcaf0; text-decoration: none;\">http://localhost:8081/EZBuyIndex</a></p>"
	            + "        </div>"
	            + "        <div style=\"padding: 20px; font-size: 16px; color: #666;\">"
	            + "            <p>1.若有其他疑問，請盡速與我們聯繫。</p>"
	            + "            <p>2.本信件為系統自動推送，請勿回覆此信件。</p>"
	            + "        </div>"
	            + "    </div>"
	            + "</body>"
	            + "</html>";
	}


}
