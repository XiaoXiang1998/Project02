package com.member.model;

import java.time.LocalDateTime;

import org.hibernate.annotations.DynamicInsert;
import org.springframework.stereotype.Component;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "resettoken")
@Component
@DynamicInsert
public class ResetTokenBean {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private int id;
	
	@Column(name = "user_id")
	private int user_id;
	
	@Column(name = "token")
	private String token;
	
	@Column(name = "created_at")
	private LocalDateTime created_at;
	
	@Column(name = "used")
	private boolean used;

	public ResetTokenBean() {
	}
	
	public ResetTokenBean(int user_id, String token, LocalDateTime created_at) {
		super();
		this.user_id = user_id;
		this.token = token;
		this.created_at = created_at;
	}

	public ResetTokenBean(int id, int user_id, String token, LocalDateTime created_at, boolean used) {
		super();
		this.id = id;
		this.user_id = user_id;
		this.token = token;
		this.created_at = created_at;
		this.used = used;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public LocalDateTime getCreated_at() {
		return created_at;
	}

	public void setCreated_at(LocalDateTime created_at) {
		this.created_at = created_at;
	}

	public boolean isUsed() {
		return used;
	}

	public void setUsed(boolean used) {
		this.used = used;
	} 
	
	
}
