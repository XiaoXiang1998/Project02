package com.sean.model;

import org.springframework.stereotype.Component;

import com.member.model.MemberBean;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "notifications")
@Component
public class Notifications {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID")
	private Integer id;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "RECIPIENTID")
	private MemberBean recipientId;
	
	@Column(name = "CONTENT")
	private String content;
	
	@Column(name = "SENDTIME")
	private String sendTime;
	
	@Column(name = "READS")
	private Integer reads;
}
