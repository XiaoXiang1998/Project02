package com.good.model;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonBackReference;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
@Entity
@Table(name = "GOODFORMAT")
@Component
public class GoodFormat {
	@Id 
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="FORMATID")
	private int formatID;
//	@Column(name="GOODSID")
//	@Transient
//	private int goodsID;
	@Column(name="GOODSIZE")
	private String goodSize;
	
	@Column(name="GOODPRICE")
	private int goodPrice;
	
	@Column(name="GOODIMAGEPATH")
	private String goodImagePath;
	
	@Column(name="GOODSTOCK")
	private int goodStock;

	@JsonBackReference
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "GOODSID")
	private GoodsBean2 good;
	//
	public GoodFormat(int formatID, String goodSize, int goodPrice, String goodImagePath) {
		this.formatID = formatID;
		this.goodSize = goodSize;
		this.goodPrice = goodPrice;
		this.goodImagePath = goodImagePath;
	}
	public GoodFormat() {
	
	}
	//
	public GoodsBean2 getGood() {
		return good;
	}
	public void setGood(GoodsBean2 good) {
		this.good = good;
	}
	
	public int getFormatID() {
		return formatID;
	}


	public void setFormatID(int formatID) {
		this.formatID = formatID;
	}


	public String getGoodSize() {
		return goodSize;
	}

	public void setGoodSize(String goodSize) {
		this.goodSize = goodSize;
	}

	public int getGoodPrice() {
		return goodPrice;
	}

	public void setGoodPrice(int goodPrice) {
		this.goodPrice = goodPrice;
	}

	public String getGoodImagePath() {
		return goodImagePath;
	}

	public void setGoodImagePath(String goodImagePath) {
		this.goodImagePath = goodImagePath;
	}
	
	
	
}
