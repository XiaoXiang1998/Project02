package com.comment.websocket;

import java.io.IOException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.config.Configurator;
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
@ServerEndpoint(value = "/websocket/{username}", configurator = Configurator.class)
public class MyWebSocket {

    @Autowired
    private HttpSession httpSession;
	 /**
     * 连接建立时触发
     */
    /**
     * 连接建立时触发
     */
    @OnOpen
    public void onOpen(@PathParam("username") String username, Session session, EndpointConfig config) {
        Map<String, Object> userProperties = config.getUserProperties();
        HttpSession httpSession = (HttpSession) userProperties.get(HttpSession.class.getName());
        
        MemberBean member = (MemberBean) httpSession.getAttribute("member");
        if (member != null) {
            String message = "Welcome to the chat room! You can start chatting now.";
            ChatUtils.sendMessage(session, message);
            ChatUtils.CLIENTS.put(username, session);
        }
    }

    @OnMessage
    public void onMessage(String message, Session session) {
        String sender = (String) session.getUserProperties().get("username"); // 获取当前登录用户作为发送者
        String[] parts = message.split(":", 2); // 分割接收者和消息内容
        if (parts.length == 2) { // 检查消息格式是否正确
            String receiver = parts[0];  // 接收者
            String content = parts[1];  // 消息内容
            
            ChatUtils.sendMessageToUser(sender, receiver, content); // 传递发送者、接收者和消息内容
        } else {
            // 处理消息格式错误的情况
            String errorMessage = "Invalid message format: " + message;
            ChatUtils.sendMessageToSender("System", errorMessage);
        }
    }

    @OnClose
    public void onClose(@PathParam("username") String username, Session session) {
        Map<String, Object> userProperties = session.getUserProperties();
        HttpSession httpSession = (HttpSession) userProperties.get(HttpSession.class.getName());
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
