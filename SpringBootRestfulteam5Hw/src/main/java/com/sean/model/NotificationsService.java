package com.sean.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.member.model.MemberBean;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class NotificationsService {
	
	@Autowired
	private NotificationsRepository nRops;
	
	public Notifications sendMessage(Notifications notification) {
		return nRops.save(notification);
	}
	
	public Integer noReadCounts(MemberBean recipientId) {
		return nRops.noReadCounts(recipientId);
	}
	
	public List<Notifications> findByRecipientIdOrderBySendTimeDesc(MemberBean recipientId){
		return nRops.findByRecipientIdOrderBySendTimeDesc(recipientId);
	}
	
	public void readMessage(Integer Id) {
		nRops.readMessage(Id);
	}
}
