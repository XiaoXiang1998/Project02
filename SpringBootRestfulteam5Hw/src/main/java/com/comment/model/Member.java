package com.comment.model;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity @Table(name="members")
@Component
public class Member {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "sid")
	private Integer sid;

	@Column(name = "account")
	private String account;

	@Column(name = "password")
	private String password;

	@Column(name = "email")
	private String email;

	@Column(name = "phone")
	private String phone;

	@Column(name = "name")
	private String name;

	@Column(name = "gender")
	private String gender;

	@Column(name = "address")
	private String address;

	@Column(name = "photosticker")
	private String photoSticker;

	@Column(name = "seller")
	private Boolean seller;

	@Column(name = "reviewcount")
	private Integer reviewCount;

	@Column(name = "cumulativescore")
	private Integer cumulativeScore;

	@Column(name = "totalsalesamount")
	private Integer totalSalesAmount;
	
	@Column(name="level")
	private Integer level;
	
	
    @OneToMany(fetch = FetchType.LAZY,mappedBy = "member",cascade = CascadeType.ALL)
	private List<Post> posts=new ArrayList<Post>();
    
    
    @OneToMany(fetch = FetchType.LAZY,mappedBy = "memberResult",cascade = CascadeType.ALL)
	private List<Result> Results=new ArrayList<Result>();


	public Integer getSid() {
		return sid;
	}


	public void setSid(Integer sid) {
		this.sid = sid;
	}


	public String getAccount() {
		return account;
	}


	public void setAccount(String account) {
		this.account = account;
	}


	public String getPassword() {
		return password;
	}


	public void setPassword(String password) {
		this.password = password;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getPhone() {
		return phone;
	}


	public void setPhone(String phone) {
		this.phone = phone;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getGender() {
		return gender;
	}


	public void setGender(String gender) {
		this.gender = gender;
	}


	public String getAddress() {
		return address;
	}


	public void setAddress(String address) {
		this.address = address;
	}


	public String getPhotoSticker() {
		return photoSticker;
	}


	public void setPhotoSticker(String photoSticker) {
		this.photoSticker = photoSticker;
	}


	public Boolean getSeller() {
		return seller;
	}


	public void setSeller(Boolean seller) {
		this.seller = seller;
	}


	public Integer getReviewCount() {
		return reviewCount;
	}


	public void setReviewCount(Integer reviewCount) {
		this.reviewCount = reviewCount;
	}


	public Integer getCumulativeScore() {
		return cumulativeScore;
	}


	public void setCumulativeScore(Integer cumulativeScore) {
		this.cumulativeScore = cumulativeScore;
	}


	public Integer getTotalSalesAmount() {
		return totalSalesAmount;
	}


	public void setTotalSalesAmount(Integer totalSalesAmount) {
		this.totalSalesAmount = totalSalesAmount;
	}


	public Integer getLevel() {
		return level;
	}


	public void setLevel(Integer level) {
		this.level = level;
	}


	public List<Post> getPosts() {
		return posts;
	}


	public void setPosts(List<Post> posts) {
		this.posts = posts;
	}


	public List<Result> getResults() {
		return Results;
	}


	public void setResults(List<Result> results) {
		Results = results;
	}

    

    
	
	
	
    
}
