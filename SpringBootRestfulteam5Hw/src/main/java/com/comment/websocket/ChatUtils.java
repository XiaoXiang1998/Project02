	package com.comment.websocket;
	
	import org.slf4j.LoggerFactory;
	
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
	            return;
	        }
	
	        try {
	            basic.sendText(message);
	        } catch (IOException e) {
	            logger.error("Error sending message", e);
	        }
	    }
	
	    public static void sendMessageToUser(String sender, String receiver, String message) {
	        Session receiverSession = CLIENTS.get(receiver);
	        if (receiverSession != null) {
	            sendMessage(receiverSession, message);
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
