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
	private Integer formatID;
//	@Column(name="GOODSID")
//	@Transient
//	private Integer goodsID;
	@Column(name="GOODSIZE")
	private String goodSize;
	
	@Column(name="GOODPRICE")
	private Integer goodPrice;
	
	@Column(name="GOODIMAGEPATH")
	private String goodImagePath;
	
	@Column(name="GOODSSTOCK")
	private Integer goodsStock;

	@JsonBackReference
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "GOODSID")
	private GoodsBean2 good;
	//
	public GoodFormat(Integer formatID, String goodSize, Integer goodPrice, String goodImagePath) {
		this.formatID = formatID;
//		this.goodsID = goodsID;
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


	public void setFormatID(Integer formatID) {
		this.formatID = formatID;
	}

//	public int getGoodsID() {
//		return goodsID;
//	}
//
//	public void setGoodsID(Integer goodsID) {
//		this.goodsID = goodsID;
//	}

	public String getGoodSize() {
		return goodSize;
	}

	public void setGoodSize(String goodSize) {
		this.goodSize = goodSize;
	}

	public int getGoodPrice() {
		return goodPrice;
	}

	public void setGoodPrice(Integer goodPrice) {
		this.goodPrice = goodPrice;
	}

	public String getGoodImagePath() {
		return goodImagePath;
	}

	public void setGoodImagePath(String goodImagePath) {
		this.goodImagePath = goodImagePath;
	}
	public int getGoodsStock() {
		return goodsStock;
	}

	public void setGoodsStock(Integer goodsStock) {
		this.goodsStock = goodsStock;
	}
	@Override
	public String toString() {
		return "GoodFormat [formatID=" + formatID + ", goodSize=" + goodSize + ", goodPrice="
				+ goodPrice + ", goodImagePath=" + goodImagePath + ", goodsStock=" + goodsStock + "]";
	}
	
	
	
}