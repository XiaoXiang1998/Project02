package com.config;

import jakarta.servlet.http.HttpSession;
import jakarta.websocket.HandshakeResponse;
import jakarta.websocket.server.HandshakeRequest;
import jakarta.websocket.server.ServerEndpointConfig;

public class Configurator extends ServerEndpointConfig.Configurator {
	@Override
    public void modifyHandshake(ServerEndpointConfig sec, HandshakeRequest request, HandshakeResponse response) {
        HttpSession httpSession = (HttpSession) request.getHttpSession();
        
        // 输出 HttpSession 的相关信息
        System.out.println("Session ID: " + httpSession.getId());
        
        sec.getUserProperties().put(HttpSession.class.getName(), httpSession);
    }
}
