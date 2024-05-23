package com.sean.model;

import java.util.Date;

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
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "ORDERID")
	private Orders orderId;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "RECIPIENTID")
	private MemberBean recipientId;
	
	@Column(name = "CONTENT")
	private String content;
	
	@Column(name = "SENDTIME")
	private Date sendTime;
	
	@Column(name = "READS")
	private Integer reads;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	public Orders getOrderId() {
		return orderId;
	}

	public void setOrderId(Orders orderId) {
		this.orderId = orderId;
	}

	public MemberBean getRecipientId() {
		return recipientId;
	}

	public void setRecipientId(MemberBean recipientId) {
		this.recipientId = recipientId;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getSendTime() {
		return sendTime;
	}

	public void setSendTime(Date sendTime) {
		this.sendTime = sendTime;
	}

	public Integer getReads() {
		return reads;
	}

	public void setReads(Integer reads) {
		this.reads = reads;
	}

	public Notifications() {
		super();
	}

	public Notifications(Orders orderId, MemberBean recipientId, String content, Date sendTime, Integer reads) {
		super();
		this.orderId = orderId;
		this.recipientId = recipientId;
		this.content = content;
		this.sendTime = sendTime;
		this.reads = reads;
	}

	
}
