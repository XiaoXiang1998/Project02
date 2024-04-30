package com.comment.websocket;

import java.io.IOException;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;


import com.member.model.MemberBean;

import jakarta.servlet.http.HttpSession;
import jakarta.websocket.OnClose;
import jakarta.websocket.OnError;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.PathParam;
import jakarta.websocket.server.ServerEndpoint;


@Component
@ServerEndpoint("/websocket/{username}")
public class MyWebSocket {

    @Autowired
    private HttpSession httpSession;
	 /**
     * 连接建立时触发
     */
	  @OnOpen
	    public void onOpen(@PathParam("username") String username, Session session) {
		        MemberBean member = (MemberBean) httpSession.getAttribute("member");
	        if (member != null) {
	            // 根據會員角色設置用戶名
	            String roleName = member.isSeller() ? "seller" : "buyer";
	            String message = "歡迎進入聊天室，你可以開始聊天了！";
	            ChatUtils.sendMessage(session, message);
	            ChatUtils.CLIENTS.put(roleName + "-" + username, session);
	        }
	    }
    /**
     * 客户端接收服务端发来的数据时触发
     */
    @OnMessage
    public void onMessage(@PathParam("username") String sender, String message) {
        // 解析消息，找到接收者的用戶名
        String[] parts = message.split(":");
        String receiver = parts[0];
        String content = parts[1];
        
        // 發送消息給指定的接收者
        ChatUtils.sendMessageToUser(sender, receiver, content);
    }
 
    /**
     * 连接关闭时触发
     */
    @OnClose
    public void onClose(@PathParam("username") String username, Session session) {
        MemberBean member = (MemberBean) httpSession.getAttribute("member");
        if (member != null) {
            String roleName = member.isSeller() ? "seller" : "buyer";
            ChatUtils.CLIENTS.remove(roleName + "-" + username);
        }
    }
    /**
     * 聊天通信发生错误时触发
     */
    @OnError
    public void onError(Session session,Throwable throwable) {
        try {
            //关闭WebSocket下的该Seesion会话
            session.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


	
}
