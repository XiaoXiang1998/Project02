package com.comment.websocket;

import java.io.IOException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.config.MyEndpointConfigurator;
import com.member.model.MemberBean;

import jakarta.servlet.http.HttpSession;
import jakarta.websocket.EndpointConfig;
import jakarta.websocket.OnClose;
import jakarta.websocket.OnError;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.PathParam;
import jakarta.websocket.server.ServerEndpoint;


@Component
@ServerEndpoint(value = "/websocket/{username}", configurator = MyEndpointConfigurator.class)
public class MyWebSocket {

    @Autowired
    private HttpSession httpSession;
	 /**
     * 连接建立时触发
     */
    @OnOpen
    public void onOpen(@PathParam("username") String username, Session session, EndpointConfig config) {
        Map<String, Object> userProperties = config.getUserProperties();
        HttpSession httpSession = (HttpSession) userProperties.get(HttpSession.class.getName());
        
        // 在这里使用 HttpSession
        MemberBean member = (MemberBean) httpSession.getAttribute("member");
        if (member != null) {
            String roleName = member.isSeller() ? "seller" : "buyer";
            String message = "Welcome to the chat room! You can start chatting now.";
            ChatUtils.sendMessage(session, message);
            ChatUtils.CLIENTS.put(roleName + "-" + username, session);
        }
    }

    @OnMessage
    public void onMessage(@PathParam("username") String sender, String message) {
        String[] parts = message.split(":");
        String receiver = parts[0];
        String content = parts[1];
        ChatUtils.sendMessageToUser(sender, receiver, content);
    }

    @OnClose
    public void onClose(@PathParam("username") String username, Session session) {
        // 在这里使用 HttpSession
        HttpSession httpSession = (HttpSession) session.getUserProperties().get(HttpSession.class.getName());
        MemberBean member = (MemberBean) httpSession.getAttribute("member");
        
        if (member != null) {
            String roleName = member.isSeller() ? "seller" : "buyer";
            ChatUtils.CLIENTS.remove(roleName + "-" + username);
        }
    }

    @OnError
    public void onError(Session session, Throwable throwable) {
        try {
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

	
}
