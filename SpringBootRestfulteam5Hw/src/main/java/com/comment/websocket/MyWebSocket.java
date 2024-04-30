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
import jakarta.websocket.OnError;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.PathParam;
import jakarta.websocket.server.ServerEndpoint;


@Component
@ServerEndpoint("/websocket/{username}")
public class MyWebSocket {
		
	 /**
     * 连接建立时触发
     */
    @OnOpen
    public void onOpen(@PathParam("username") String username, Session session) {
        String message= "用户[" + username + "]已进入聊天室！";
 
        //将该用户登录的消息发送给其他人
        ChatUtils.sendMessageAll(message);
 
        //将自己的信息添加到map集合中
        ChatUtils.CLIENTS.put(username,session);
 
        //获取当前的在线人数，发给自己查看
        String onlineInfo=ChatUtils.getOnlineInfo();
        ChatUtils.sendMessage(session,onlineInfo);
    }
 
    /**
     * 客户端接收服务端发来的数据时触发
     */
    @OnMessage
    public void onMessage(@PathParam("username") String username,String message) {
        //广播，把消息同步给其他客户端
        ChatUtils.sendMessageAll("[" + username + "]: " + message);
    }
 
    /**
     * 连接关闭时触发
     */
    @OnClose
    public void onClose(@PathParam("username") String username,Session session) {
        //从当前的map集合中移除该用户
        ChatUtils.CLIENTS.remove(username);
 
        //将该用户离线的消息通知给其他人
        ChatUtils.sendMessageAll("[" + username + "]已离线！");
 
        try {
            //关闭WebSocket下的该Seesion会话
            session.close();
        } catch (IOException e) {
            e.printStackTrace();
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
