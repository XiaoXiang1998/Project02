package com.member.model;

import org.springframework.stereotype.Component;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "members")
@Component
public class MemberBean {

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
	private boolean seller;

	@Column(name = "reviewcount")
	private int reviewCount;

	@Column(name = "cumulativescore")
	private int cumulativeScore;

	@Column(name = "totalsalesamount")
	private int totalSalesAmount;
	
	@Column(name="level")
	private Integer level;
	
	public MemberBean() {
	}

	/* 新增用不需要id */
	public MemberBean(String account, String password, String email, String phone, String name, String gender,
			String address, String photoSticker, boolean seller) {
		this.account = account;
		this.password = password;
		this.email = email;
		this.phone = phone;
		this.name = name;
		this.gender = gender;
		this.address = address;
		this.photoSticker = photoSticker;
		this.seller = seller;
	}

	/* 新增時沒有頭貼用 */
	public MemberBean(String account, String password, String email, String phone, String name, String gender,
			String address, boolean seller) {
		this.account = account;
		this.password = password;
		this.email = email;
		this.phone = phone;
		this.name = name;
		this.gender = gender;
		this.address = address;
		this.seller = seller;
	}

	/* 修改時用 */
	public MemberBean(Integer sid, String account, String password, String email, String phone, String name,
			String gender, String address, String photoSticker, boolean seller, int reviewCount,
			int cumulativeScore, int totalSalesAmount) {
		this.sid = sid;
		this.account = account;
		this.password = password;
		this.email = email;
		this.phone = phone;
		this.name = name;
		this.gender = gender;
		this.address = address;
		this.photoSticker = photoSticker;
		this.seller = seller;
		this.reviewCount = reviewCount;
		this.cumulativeScore = cumulativeScore;
		this.totalSalesAmount = totalSalesAmount;
	}

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

	public boolean isSeller() {
		return seller;
	}

	public void setSeller(boolean seller) {
		this.seller = seller;
	}

	public int getReviewCount() {
		return reviewCount;
	}

	public void setReviewCount(int reviewCount) {
		this.reviewCount = reviewCount;
	}

	public int getCumulativeScore() {
		return cumulativeScore;
	}

	public void setCumulativeScore(int cumulativeScore) {
		this.cumulativeScore = cumulativeScore;
	}

	public int getTotalSalesAmount() {
		return totalSalesAmount;
	}

	public void setTotalSalesAmount(int totalSalesAmount) {
		this.totalSalesAmount = totalSalesAmount;
	}

	public Integer getLevel() {
		return level;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}
	
	
}
