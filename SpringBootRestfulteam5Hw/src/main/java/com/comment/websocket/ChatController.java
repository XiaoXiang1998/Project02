package com.comment.websocket;

import java.util.concurrent.atomic.AtomicInteger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.member.model.MemberBean;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ChatController {
	
	@Autowired
    private HttpSession httpSession;
	
    private AtomicInteger atomicInteger=new AtomicInteger();
 
    @RequestMapping("/chat")
    public String chat(Model model, HttpServletRequest request) {
        HttpSession httpSession = request.getSession();
        MemberBean member = (MemberBean) httpSession.getAttribute("member");

        if (member != null) {
            String username = member.getName(); 
            String photoSticker = member.getPhotoSticker();
            model.addAttribute("username", username);
            model.addAttribute("photoSticker", photoSticker);

            return "comment/talk"; 
        }
        
        return "redirect:/login"; 
    }
    
}



