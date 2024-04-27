package com.sean.model;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class Member2Service {
	
	@Autowired
	private Member2Repository mRops;

	public Optional<Member2> findById(Integer memberId) {
		
		return mRops.findById(memberId);
	}


}
