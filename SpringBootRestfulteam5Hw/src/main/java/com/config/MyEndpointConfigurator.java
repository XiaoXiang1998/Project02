package com.config;

import jakarta.servlet.http.HttpSession;
import jakarta.websocket.HandshakeResponse;
import jakarta.websocket.server.HandshakeRequest;
import jakarta.websocket.server.ServerEndpointConfig;
import jakarta.websocket.server.ServerEndpointConfig.Configurator;

public class MyEndpointConfigurator extends Configurator {
		
	
	 @Override
	    public void modifyHandshake(ServerEndpointConfig sec, HandshakeRequest request, HandshakeResponse response) {
	        HttpSession httpSession = (HttpSession) request.getHttpSession();
	        sec.getUserProperties().put(HttpSession.class.getName(), httpSession);
	    }
}
