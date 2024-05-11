package com.sean.model;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.member.model.MemberBean;

public interface NotificationsRepository extends JpaRepository<Notifications,Integer> {
	
	public List<Notifications> findByRecipientIdAndReads(MemberBean recipientId,Integer reads);
	
	@Modifying
	@Query(value = "update Notifications set reads = 1 where id = ?1")
	public void readMessage(Integer Id);
}
