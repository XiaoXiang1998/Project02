	package com.comment.websocket;
	
	import org.slf4j.LoggerFactory;
import org.springframework.boot.configurationprocessor.json.JSONException;
import org.springframework.boot.configurationprocessor.json.JSONObject;

import com.member.model.MemberBean;
	
	import org.slf4j.Logger;
	import org.slf4j.LoggerFactory;
	 
	
	import jakarta.*;
	import jakarta.websocket.RemoteEndpoint;
	import jakarta.websocket.Session;
	
	import java.io.IOException;
	import java.util.Map;
	import java.util.Set;
	import java.util.concurrent.ConcurrentHashMap;
	
	
	                        
	public class ChatUtils {
	    private static final Logger logger = LoggerFactory.getLogger(ChatUtils.class);
	
	    public static final Map<String, Session> CLIENTS = new ConcurrentHashMap<>();
	
	    public static void sendMessage(Session session, String message) {
	        if (session == null) {
	            return;
	        }
	
	        final RemoteEndpoint.Basic basic = session.getBasicRemote();
	        if (basic == null) {
	            logger.error("Basic remote is null");

	            return;
	        }
	
	        try {
	            logger.info("Sending message: " + message);

	            basic.sendText(message);
	        } catch (IOException e) {
	            logger.error("Error sending message", e);
	        }
	    }
	
	    public static void sendMessageToUser(String receiver, String sender, String message,String time) throws JSONException {
	        Session receiverSession = CLIENTS.get(receiver);
	        if (receiverSession != null) {
	            JSONObject jsonObject = new JSONObject();
	            jsonObject.put("sender", sender);
	            jsonObject.put("content", message);
	            jsonObject.put("time", time); 
	            
	            sendMessage(receiverSession, jsonObject.toString());
	        } else {
	            sendMessageToSender("System", "User " + receiver + " is not online.");
	        }
	    }
	
	    public static void sendMessageToSender(String sender, String message) {
	        Session senderSession = CLIENTS.get(sender);
	        if (senderSession != null) {
	            sendMessage(senderSession, message);
	        }
	    }
	
	    public static String getOnlineInfo() {
	        Set<String> userNames = CLIENTS.keySet();
	        if (userNames.size() == 0) {
	            return "No users online.";
	        }
	        return "Online users: " + userNames.toString();
	    }
	}
