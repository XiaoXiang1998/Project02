package com.member.security;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutHandler;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class MemberLogoutHandler implements LogoutHandler {

	 @Override
	    public void logout(HttpServletRequest request, HttpServletResponse response, Authentication authentication) {
	        HttpSession session = request.getSession(); // false 表示如果 session 不存在不創建新 session
	        if (session != null) {
	            session.invalidate(); // 刪除 session
	        }
	    }
}
