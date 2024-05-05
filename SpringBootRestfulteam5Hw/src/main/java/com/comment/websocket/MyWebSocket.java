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
            
            System.out.println("用户连接：username = " + username);
            
            ChatUtils.CLIENTS.put(username, session);
            
            sendUserOnlineMessage(username); // 在用戶進入聊天室時發送進入聊天室提示

            
            if (ChatUtils.CLIENTS.size() > 1) {
                sendOnlineUsersUpdate();
            }
        }
    }

    @OnMessage
    public void onMessage(String message, Session session) {
        try {
            System.out.println("Received message: " + message);

            JSONObject jsonObject = new JSONObject(message);
            String sender = jsonObject.getString("sender"); 
            String receiver = jsonObject.getString("receiver");
            String content = jsonObject.getString("content");
            String time = jsonObject.getString("time"); // 提取时间信息

            System.out.println(sender);
            System.out.println(receiver);
            System.out.println(content);
            System.out.println(time); // 打印时间信息

            ChatUtils.sendMessageToUser(receiver, sender, content,time);
        } catch (JSONException e) {
        	e.printStackTrace();
        	
        }
    }
    

    @OnClose
    public void onClose(@PathParam("username") String username, Session session) {
        ChatUtils.CLIENTS.remove(username);
        
        if (!ChatUtils.CLIENTS.isEmpty()) {
            sendOnlineUsersUpdate();
            sendUserOfflineMessage(username); // 在用戶離線時發送離線提示

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
    
    
    private void sendOnlineUsersUpdate() {
        try {
            JSONArray onlineUsersArray = new JSONArray();
            for (String username : ChatUtils.CLIENTS.keySet()) {
                onlineUsersArray.put(username);
                System.out.println("username"+username);
            }
            System.out.println("onlineUserArray:"+onlineUsersArray);
            JSONObject jsonObject = new JSONObject();
            
            jsonObject.put("onlineUsers", onlineUsersArray);
            
            String onlineUsersUpdate = jsonObject.toString();
            System.out.println("onlineUsersUpdate"+onlineUsersUpdate);
            for (Session session : ChatUtils.CLIENTS.values()) {
                session.getBasicRemote().sendText(onlineUsersUpdate);
            }
        } catch (IOException | JSONException e) {
            e.printStackTrace();
        }
    }
    
    private void sendUserOfflineMessage(String offlineUsername) {
        try {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("offlineUser", offlineUsername);
            String offlineMessage = jsonObject.toString();
            
            for (Session session : ChatUtils.CLIENTS.values()) {
                session.getBasicRemote().sendText(offlineMessage);
            }
        } catch (IOException | JSONException e) {
            e.printStackTrace();
        }
    }
    
    private void sendUserOnlineMessage(String onlineUsername) {
        try {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("onlineUser", onlineUsername);
            String onlineMessage = jsonObject.toString();
            
            for (Session session : ChatUtils.CLIENTS.values()) {
                session.getBasicRemote().sendText(onlineMessage);
            }
        } catch (IOException | JSONException e) {
            e.printStackTrace();
        }
    }
    
}

