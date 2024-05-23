package com.sean.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

@Service
public class OrderMail {	
	
	@Autowired
	private JavaMailSender mailSender;
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
	            + "<body>"
	            + "<div style=\"width:60%;margin: auto;\">"
	            + "    <form action=\"\" style=\"width: 600px; border-radius:10px;border: 2px solid#0dcaf0; margin: auto;\">"
	            + "        <h2 style=\"color: #0dcaf0; display: flex;align-items: center;justify-content: center; border-bottom:solid;padding-bottom: 15px;\">EZ BUY 電商平台</h2>"
	            + "        <div style=\" font-size: 20px;display: flex;align-items: center; padding-left: 30px; border-bottom: solid;padding-bottom: 15px;border-color:#0dcaf0 ;\">"
	            + "            親愛的" + buyerName + "您好，感謝您本次的購買<br>"
	            + "            您的訂單 : " + orderId + "已成立<br>"
	            + "        </div>"
	            + "        <div style=\" font-size: 20px;align-items: center; padding-left: 30px; border-bottom: solid;padding-bottom: 15px;border-color: #0dcaf0 ;\">"
	            + "            <table style=\"border: solid #0dcaf0; border-collapse: collapse;  margin-top: 20px; margin-left: auto; margin-right: auto;\">"
	            + "                <tr>"
	            + "                    <td style=\"border: solid #0dcaf0;\">購買商品</td>"
	            + "                    <td style=\"border: solid #0dcaf0;text-align: center;width: 200px;\">" + goodsName + "</td>"
	            + "                </tr>"
	            + "                <tr>"
	            + "                    <td style=\"border: solid #0dcaf0;\">單價</td>"
	            + "                    <td style=\"border: solid #0dcaf0;text-align: center;\">" + originalPrice + "</td>"
	            + "                </tr>"
	            + "                <tr>"
	            + "                    <td style=\"border: solid #0dcaf0;\">數量</td>"
	            + "                    <td style=\"border: solid #0dcaf0;text-align: center;\">" + quantity + "</td>"
	            + "                </tr>"
	            + "                <tr>"
	            + "                    <td style=\"border: solid #0dcaf0;\">總共金額</td>"
	            + "                    <td style=\"border: solid #0dcaf0;text-align: center;\">" + totalPrice + "</td>"
	            + "                </tr>"
	            + "            </table>"
	            + "            <br>"
	            + "            <p><strong>若要查詢訂單狀態，可於登入會員後，於會員中心內查詢。</strong></p>"
	            + "            <div>網址:<a href=\"http://localhost:8081/ezbuy.com\" style=\" text-decoration: none; outline: none;   cursor: pointer;\">http://localhost:8081/ezbuy.com</a></div>"
	            + "        </div>"
	            + "        <div style=\" font-size: 20px;align-items: center; padding-left: 30px; padding-bottom: 15px;\">"
	            + "            <p>1.若有其他疑問，請盡速與我們聯繫。</p>"
	            + "            <p>2.本信件為系統自動推送，請勿回覆此信件。</p>"
	            + "        </div>"
	            + "    </form>"
	            + "</div>"
	            + "</body>"
	            + "</html>";
	}

}
