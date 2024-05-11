package com.comment.model;





import org.springframework.stereotype.Component;	

import com.member.model.MemberBean;
import com.sean.model.Orders;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;

@Entity @Table(name="post")
@Component
public class Post {
	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "commentid")
	private Integer commentid;
	@Column(name = "commentcontent")
	private String commentcontent;
	@Column(name = "productphoto")
	private  String productphoto;
	@Column(name = "commenttime")
	private java.sql.Timestamp commenttime;
	@Column(name = "lastmodifiedtime")
	private java.sql.Timestamp lastmodifiedtime;
	@Column(name = "buyerrate")
	private Integer buyerrate;
	@Column(name = "replayconetnt")
	private String replayconetnt;
	@Column(name = "replaytime")
	private java.sql.Timestamp replaytime;
	@Column(name = "sellerrate")
	private Integer sellerrate;
	@Column(name = "repliedcommentid")
	private Integer repliedcommentid;
	
	@ManyToOne
	@JoinColumn(name="fk_userid")
	private MemberBean member;
	
	@OneToOne
	@JoinColumn(name="orderid")
	private Orders orders;
	
	public Post() {
		
	}
	
	

	public Post(Integer commentid, String commentcontent, java.sql.Timestamp commenttime) {
		this.commentid = commentid;
		this.commentcontent = commentcontent;
		this.commenttime = commenttime;
	}



	public Integer getCommentid() {
		return commentid;
	}



	public void setCommentid(Integer commentid) {
		this.commentid = commentid;
	}



	public String getCommentcontent() {
		return commentcontent;
	}



	public void setCommentcontent(String commentcontent) {
		this.commentcontent = commentcontent;
	}



	public String getProductphoto() {
		return productphoto;
	}



	public void setProductphoto(String productphoto) {
		this.productphoto = productphoto;
	}



	public java.sql.Timestamp getCommenttime() {
		return commenttime;
	}



	public void setCommenttime(java.sql.Timestamp commenttime) {
		this.commenttime = commenttime;
	}



	public java.sql.Timestamp getLastmodifiedtime() {
		return lastmodifiedtime;
	}



	public void setLastmodifiedtime(java.sql.Timestamp lastmodifiedtime) {
		this.lastmodifiedtime = lastmodifiedtime;
	}



	public Integer getBuyerrate() {
		return buyerrate;
	}



	public void setBuyerrate(Integer buyerrate) {
		this.buyerrate = buyerrate;
	}



	public String getReplayconetnt() {
		return replayconetnt;
	}



	public void setReplayconetnt(String replayconetnt) {
		this.replayconetnt = replayconetnt;
	}



	public java.sql.Timestamp getReplaytime() {
		return replaytime;
	}



	public void setReplaytime(java.sql.Timestamp replaytime) {
		this.replaytime = replaytime;
	}



	public Integer getSellerrate() {
		return sellerrate;
	}



	public void setSellerrate(Integer sellerrate) {
		this.sellerrate = sellerrate;
	}



	



	public MemberBean getMember() {
		return member;
	}



	public void setMember(MemberBean member) {
		this.member = member;
	}



	public Integer getRepliedcommentid() {
		return repliedcommentid;
	}



	public void setRepliedcommentid(Integer repliedcommentid) {
		this.repliedcommentid = repliedcommentid;
	}



	public Orders getOrders() {
		return orders;
	}



	public void setOrders(Orders orders) {
		this.orders = orders;
	}



	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Post [commentid=");
		builder.append(commentid);
		builder.append(", commentcontent=");
		builder.append(commentcontent);
		builder.append(", productphoto=");
		builder.append(productphoto);
		builder.append(", commenttime=");
		builder.append(commenttime);
		builder.append(", lastmodifiedtime=");
		builder.append(lastmodifiedtime);
		builder.append(", buyerrate=");
		builder.append(buyerrate);
		builder.append(", replayconetnt=");
		builder.append(replayconetnt);
		builder.append(", replaytime=");
		builder.append(replaytime);
		builder.append(", sellerrate=");
		builder.append(sellerrate);
		builder.append(", repliedcommentid=");
		builder.append(repliedcommentid);
		builder.append(", member=");
		builder.append(member);
		builder.append(", orders=");
		builder.append(orders);
		builder.append("]");
		return builder.toString();
	}


	
	
	
}
