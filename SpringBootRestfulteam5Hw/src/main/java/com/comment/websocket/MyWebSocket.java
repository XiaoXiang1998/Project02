package com.comment.websocket;

import java.io.IOException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
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
	 /**
     * 连接建立时触发
     */
    /**
     * 连接建立时触发
     * @throws JSONException 
     */
    @OnOpen
    public void onOpen(@PathParam("username") String username, Session session, EndpointConfig config) throws JSONException {
        Map<String, Object> userProperties = config.getUserProperties();
        HttpSession httpSession = (HttpSession) userProperties.get(HttpSession.class.getName());
        
        MemberBean member = (MemberBean) httpSession.getAttribute("member");
        if (member != null) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("welcome", "歡迎來到ezbuy聊聊");
            String message = jsonObject.toString();
            
            ChatUtils.sendMessage(session, message);
            ChatUtils.CLIENTS.put(username, session);
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
            // 处理消息...
            
            // 将消息发送给接收者，并包含发送者信息
            ChatUtils.sendMessageToUser(receiver, sender, content);
        } catch (JSONException e) {
            // 处理解析错误...
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
