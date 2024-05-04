package com.comment.websocket;

import java.io.IOException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.configurationprocessor.json.JSONArray;
import org.springframework.boot.configurationprocessor.json.JSONException;
import org.springframework.boot.configurationprocessor.json.JSONObject;
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
	
    @OnOpen
    public void onOpen(@PathParam("username") String username, Session session, EndpointConfig config) throws JSONException {
        Map<String, Object> userProperties = config.getUserProperties();
        HttpSession httpSession = (HttpSession) userProperties.get(HttpSession.class.getName());
        
        MemberBean member = (MemberBean) httpSession.getAttribute("member");
        if (member != null) {
            
            // 添加调试语句以确保正确获取用户名
            System.out.println("用户连接：username = " + username);
            
            // 将用户名和会话对象添加到在线用户列表中
            ChatUtils.CLIENTS.put(username, session);
            
            // 向所有用户发送更新后的在线用户列表
            sendOnlineUsersUpdate();
        }
    }

    @OnMessage
    public void onMessage(String message, Session session) {
        try {
            JSONObject jsonObject = new JSONObject(message);
            String sender = jsonObject.getString("sender"); // 获取发送者信息
            String receiver = jsonObject.getString("receiver");
            String content = jsonObject.getString("content");
            System.out.println(sender);
            System.out.println(receiver);
            System.out.println(content);
            
            
            ChatUtils.sendMessageToUser(receiver, sender, content);
        } catch (JSONException e) {
        	e.printStackTrace();
        	
        }
    }
    

    @OnClose
    public void onClose(@PathParam("username") String username, Session session) {
        ChatUtils.CLIENTS.remove(username);

    }

    @OnError
    public void onError(Session session, Throwable throwable) {
        try {
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    
    private void sendOnlineUsersUpdate() throws JSONException {
    	 JSONArray onlineUsersArray = new JSONArray();
    	    for (String username : ChatUtils.CLIENTS.keySet()) {
    	        onlineUsersArray.put(username);
    	    }
    	    JSONObject jsonObject = new JSONObject();
    	    jsonObject.put("onlineUsers", onlineUsersArray);

    	    String onlineUsersUpdate = jsonObject.toString();

    	    for (Session session : ChatUtils.CLIENTS.values()) {
    	        ChatUtils.sendMessage(session, onlineUsersUpdate);
    	    }
	
}
}
