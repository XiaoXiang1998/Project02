package com.sean.model;

import org.springframework.stereotype.Component;

import com.good.model.GoodFormat;
import com.member.model.MemberBean;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "caritem")
@Component
public class CarItem {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "CARITEMID")
	private Integer carItemId;

	@ManyToOne
	@JoinColumn(name = "FK_FORMATGOODID")
	private GoodFormat good;

	@OneToOne(fetch = FetchType.LAZY, cascade = { CascadeType.PERSIST, CascadeType.MERGE })
	@JoinColumn(name = "FK_MEMBERID")
	private MemberBean member;

	@Column(name = "QUANTITY")
	private Integer quantity;

	@Column(name = "PRICE")
	private Integer price;

	public CarItem() {

	}


	public Integer getCarItemId() {
		return carItemId;
	}


	public void setCarItemId(Integer carItemId) {
		this.carItemId = carItemId;
	}


	


	public GoodFormat getGood() {
		return good;
	}


	public void setGood(GoodFormat good) {
		this.good = good;
	}


	public MemberBean getMember() {
		return member;
	}


	public void setMember(MemberBean member) {
		this.member = member;
	}


	public Integer getQuantity() {
		return quantity;
	}


	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}


	public Integer getPrice() {
		return price;
	}


	public void setPrice(Integer price) {
		this.price = price;
	}


}
