package com.comment.model;

import java.sql.Timestamp;

import org.springframework.stereotype.Component;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "comments")
@Component
public class Comment {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "commentid")
	private Integer commentId;
	@Column(name = "userid")
	private Integer userId;
	@Column(name = "username")
	private String userName;
	@Column(name = "usertype")
	private String userType;
	@Column(name = "commentcontent")
	private String commentContent;
	@Column(name = "productphoto")
	private String productphoto;
	@Column(name = "commenttime")
	private java.sql.Timestamp commentTime;
	@Column(name = "lastmodifiedtime")
	private java.sql.Timestamp lastModifiedTime;
	@Column(name = "rate")
	private Integer rate;
	@Column(name = "orderid")
	private Integer orderId;

	public Comment() {
	}

	public Comment(Integer commentId, String userName, String userType, String commentContent, String productPhoto,
			Timestamp commentTime, Timestamp lastModifiedTime, Integer rate) {
		this.userId = commentId;
		this.userName = userName;
		this.userType = userType;
		this.commentContent = commentContent;
		this.productphoto = productPhoto;
		this.commentTime = commentTime;
		this.lastModifiedTime = lastModifiedTime;
		this.rate = rate;
	}

	public Comment(Integer commentId, String commentContent, Timestamp lastModifiedTime) {
		this.commentId = commentId;
		this.commentContent = commentContent;
		this.lastModifiedTime = lastModifiedTime;
	}
	
	

	public Integer getCommentId() {
		return commentId;
	}

	public void setCommentId(Integer commentId) {
		this.commentId = commentId;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	public String getCommentContent() {
		return commentContent;
	}

	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}

	public java.sql.Timestamp getCommentTime() {
		return commentTime;
	}

	public void setCommentTime(java.sql.Timestamp commentTime) {
		this.commentTime = commentTime;
	}

	public java.sql.Timestamp getLastModifiedTime() {
		return lastModifiedTime;
	}

	public void setLastModifiedTime(java.sql.Timestamp lastModifiedTime) {
		this.lastModifiedTime = lastModifiedTime;
	}

	

	public Integer getRate() {
		return rate;
	}

	public void setRate(Integer rate) {
		this.rate = rate;
	}

	public Integer getOrderId() {
		return orderId;
	}

	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}

	public String getProductPhoto() {
		return productphoto;
	}

	public void setProductPhoto(String productPhoto) {
		this.productphoto = productPhoto;
	}

}
