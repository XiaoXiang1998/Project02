package com.comment.websocket;

import java.util.concurrent.atomic.AtomicInteger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.member.model.MemberBean;

import jakarta.servlet.http.HttpSession;

@Controller
public class ChatController {
	
	@Autowired
    private HttpSession httpSession;
	
	 //声明原子变量类，确保服务端和客户端之间操作的原子性和可见性
    private AtomicInteger atomicInteger=new AtomicInteger();
 
    @RequestMapping("/chat")
    public String chat(Model model) {
        MemberBean member = (MemberBean) httpSession.getAttribute("member");

        if (member != null && member.isSeller()) {
            model.addAttribute("username", "seller" + atomicInteger.getAndIncrement());
            return "comment/sellercomment";
        }
        
        model.addAttribute("username", "user" + atomicInteger.getAndIncrement());
        return "comment/indexcomment";
    }
    
}



