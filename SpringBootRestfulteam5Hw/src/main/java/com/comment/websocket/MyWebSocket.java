package com.comment.websocket;

import java.io.IOException;
import java.util.Map;
import java.util.Map.Entry;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.comment.model.Result;
import com.comment.model.ResultService;
import com.config.GetHttpSessionConfig;
import com.member.model.MemberBean;

import jakarta.servlet.http.HttpSession;
import jakarta.websocket.EndpointConfig;
import jakarta.websocket.OnClose;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.ServerEndpoint;


@Component
@ServerEndpoint(value = "/chat",configurator = GetHttpSessionConfig.class)
public class MyWebSocket {
		
	@Autowired
	private ResultService rService;
	
	private static final Map<MemberBean,Session> onLineUsers=new ConcurrentHashMap<>();
	
	private HttpSession httpSession;
  
	
	@OnOpen
	public void onOpen(Session session,EndpointConfig config) throws IOException {
		this.httpSession = (HttpSession) config.getUserProperties().get(HttpSession.class.getName());
		MemberBean member = (MemberBean) httpSession.getAttribute("member");
		//1.將session進行保存
		onLineUsers.put(member, session);
		
	}
	
	
	
	
	@OnClose
	public void onClose(Session session) {
		
		// 从在线用户列表中移除该会话
	    onLineUsers.values().removeIf(s -> s.equals(session));
		
		
		
	}
	
	@OnMessage
	public void onMessage(String message, Session session) throws IOException {
	    if (session.isOpen()) {
	    	MemberBean sender = null;
	        // 遍历在线用户列表，找到发送消息的用户
	        for (Entry<MemberBean, Session> entry : onLineUsers.entrySet()) {
	            if (entry.getValue().equals(session)) {
	                sender = entry.getKey();
	                break;
	            }
	        }
	        
	        if (sender != null) {
	            // 处理消息
	            Result result = new Result();
	            result.setMessage(message);
	            result.setMemberResult(sender);

	            // 将 Result 对象保存到数据库中
	            rService.insert(result);
	        }
	    } else {
	        System.err.println("WebSocket connection is not open.");
	    }
	}
	
	
	
	
}
