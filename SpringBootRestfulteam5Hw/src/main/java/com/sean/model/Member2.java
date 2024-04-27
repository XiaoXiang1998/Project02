package com.sean.model;

import java.util.LinkedHashSet;
import java.util.Set;

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

@Entity
@Table(name = "member")
@Component
public class Member2 {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "SID")
	private Integer sid;

	@Column(name = "ACCOUNT")
	private String account;

	@Column(name = "PASSWORD")
	private String password;

	@Column(name = "EMAIL")
	private String email;

	@Column(name = "PHONE")
	private String phone;

	@Column(name = "NAME")
	private String name;

	@Column(name = "GENDER")
	private String gender;

	@Column(name = "ADDRESS")
	private String address;

	@Column(name = "PHOTOSTICKER")
	private String photoSticker;

	@Column(name = "SELLER")
	private boolean seller;

	@Column(name = "ADMIN")
	private boolean admin;

	@Column(name = "REVIEWCOUNT")
	private Integer reviewCount;

	@Column(name = "CUMULATIVESCORE")
	private Integer cumulativeScore;

	@Column(name = "TOTALSALESAMOUNT")
	private Integer totalSalesAmount;

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "goodsSellerID", cascade = { CascadeType.PERSIST, CascadeType.MERGE })
	private Set<Goods2> goods2 = new LinkedHashSet<>();

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "payUserId", cascade = { CascadeType.PERSIST, CascadeType.MERGE })
	private Set<PaymentDetails> payments = new LinkedHashSet<>();

	@OneToMany(mappedBy = "buyerId", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	private Set<Orders> buyers = new LinkedHashSet<>();

	@OneToMany(mappedBy = "sellerId", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	private Set<Orders> sellers = new LinkedHashSet<>();

	public Member2() {

	}

	public int getSid() {
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

	public Set<Goods2> getGoods2() {
		return goods2;
	}

	public void setGoods2(Set<Goods2> goods2) {
		this.goods2 = goods2;
	}

	public Set<PaymentDetails> getPayments() {
		return payments;
	}

	public void setPayments(Set<PaymentDetails> payments) {
		this.payments = payments;
	}

	public Set<Orders> getBuyers() {
		return buyers;
	}

	public void setBuyers(Set<Orders> buyers) {
		this.buyers = buyers;
	}

	public Set<Orders> getSellers() {
		return sellers;
	}

	public void setSellers(Set<Orders> sellers) {
		this.sellers = sellers;
	}

	public boolean isSeller() {
		return seller;
	}

	public void setSeller(boolean seller) {
		this.seller = seller;
	}

	public boolean isAdmin() {
		return admin;
	}

	public void setAdmin(boolean admin) {
		this.admin = admin;
	}

	public int getReviewCount() {
		return reviewCount;
	}

	public void setReviewCount(Integer reviewCount) {
		this.reviewCount = reviewCount;
	}

	public int getCumulativeScore() {
		return cumulativeScore;
	}

	public void setCumulativeScore(Integer cumulativeScore) {
		this.cumulativeScore = cumulativeScore;
	}

	public int getTotalSalesAmount() {
		return totalSalesAmount;
	}

	public void setTotalSalesAmount(Integer totalSalesAmount) {
		this.totalSalesAmount = totalSalesAmount;
	}

}
