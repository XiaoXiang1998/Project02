package com.member.model;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import org.hibernate.annotations.DynamicInsert;
import org.springframework.stereotype.Component;

import com.comment.model.Post;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.good.model.GoodsBean2;
import com.sean.model.Orders;
import com.sean.model.PaymentDetails;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "members")
@Component
@DynamicInsert
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
	private Integer reviewCount;

	@Column(name = "cumulativescore")
	private Integer cumulativeScore;

	@Column(name = "totalsalesamount")
	private Integer totalSalesAmount;

	@Column(name = "level")
	private Integer level;
	
	@Column(name = "third_party_provider")
	private String thirdPartyProvider;

	@Column(name = "registrationtime")
	private LocalDate registrationTime;
	
	/*表示可以多個會員對應一個等級*/
	@ManyToOne
	@JoinColumn(name = "level",insertable = false,updatable = false)
	@JsonIgnore
	private LevelBean levelEntity;
	

//	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "goodsSellerID", cascade = { CascadeType.PERSIST, CascadeType.MERGE })
	@JsonIgnore
	private Set<GoodsBean2> goods2 = new LinkedHashSet<>();

	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "payUserId", cascade = { CascadeType.PERSIST, CascadeType.MERGE })
	private Set<PaymentDetails> payments = new LinkedHashSet<>();

	@JsonIgnore
	@OneToMany(mappedBy = "buyerId", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	private Set<Orders> buyers = new LinkedHashSet<>();

	@JsonIgnore
	@OneToMany(mappedBy = "sellerId", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	private Set<Orders> sellers = new LinkedHashSet<>();

	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "member", cascade = CascadeType.ALL)
	private List<Post> posts = new ArrayList<Post>();

	/*建立聯繫*/
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
	
	/*新增時無照片*/
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
			String gender, String address, String photoSticker, boolean seller, Integer reviewCount,
			Integer cumulativeScore, Integer totalSalesAmount, Integer level, String thirdPartyProvider,LocalDate registrationTime) {
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
		this.level = level;
		this.thirdPartyProvider = thirdPartyProvider;
		this.registrationTime = registrationTime;
	}
	
	/*第三方登入用*/
	public MemberBean(String account, String password, String email, String name, String thirdPartyProvider) {
		this.account = account;
		this.password = password;
		this.email = email;
		this.name = name;
		this.thirdPartyProvider = thirdPartyProvider;
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

	public String getThirdPartyProvider() {
		return thirdPartyProvider;
	}

	public void setThirdPartyProvider(String thirdPartyProvider) {
		this.thirdPartyProvider = thirdPartyProvider;
	}

	public LocalDate getRegistrationTime() {
		return registrationTime;
	}

	public void setRegistrationTime(LocalDate registrationTime) {
		this.registrationTime = registrationTime;
	}

	public LevelBean getLevelEntity() {
		return levelEntity;
	}

	public void setLevelEntity(LevelBean levelEntity) {
		this.levelEntity = levelEntity;
	}

	public Set<GoodsBean2> getGoods2() {
		return goods2;
	}

	public void setGoods2(Set<GoodsBean2> goods2) {
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

	public List<Post> getPosts() {
		return posts;
	}

	public void setPosts(List<Post> posts) {
		this.posts = posts;
	}

}
