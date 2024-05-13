package com.util.tokenGenerator;

import java.util.UUID;

import org.springframework.stereotype.Service;

@Service
public class TokenService {

	public static String generateToken() {
		return UUID.randomUUID().toString();
	}
}
