package com.sean.model;

import java.util.Date;

import org.springframework.stereotype.Component;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "goods")
@Component
public class Goods2 {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "GOODSID")
	private Integer goodsId;

	@Column(name = "GOODSNAME")
	private String goodsName;

	@Column(name = "GOODSIMG")
	private String goodsImg;

	@ManyToOne
	@JoinColumn(name = "GOODSSELLERID")
	private Member2 goodsSellerID;

	@Column(name = "GOODSTITLE")
	private String goodsTitle;

	@Column(name = "GOODSPRICE")
	private Integer goodsPrice;

	@Column(name = "GOODSSTOCK")
	private Integer goodsStock;

	@Column(name = "GOODSDIRECTION")
	private String goodsDirection;

	@Column(name = "GOODSTYPE")
	private String goodsType;

	@Column(name = "LAUNCHDATE")
	private Date launchDate;

	@Column(name = "BRAND")
	private String brand;

	@Column(name = "SHIPMENTPLACE")
	private String shipmentPlace;

	public Goods2() {

	}

	

	public Integer getGoodsId() {
		return goodsId;
	}



	public void setGoodsId(Integer goodsId) {
		this.goodsId = goodsId;
	}



	public String getGoodsName() {
		return goodsName;
	}



	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}



	public String getGoodsImg() {
		return goodsImg;
	}



	public void setGoodsImg(String goodsImg) {
		this.goodsImg = goodsImg;
	}



	public Member2 getGoodsSellerID() {
		return goodsSellerID;
	}



	public void setGoodsSellerID(Member2 goodsSellerID) {
		this.goodsSellerID = goodsSellerID;
	}



	public String getGoodsTitle() {
		return goodsTitle;
	}



	public void setGoodsTitle(String goodsTitle) {
		this.goodsTitle = goodsTitle;
	}



	public Integer getGoodsPrice() {
		return goodsPrice;
	}



	public void setGoodsPrice(Integer goodsPrice) {
		this.goodsPrice = goodsPrice;
	}



	public Integer getGoodsStock() {
		return goodsStock;
	}



	public void setGoodsStock(Integer goodsStock) {
		this.goodsStock = goodsStock;
	}



	public String getGoodsDirection() {
		return goodsDirection;
	}



	public void setGoodsDirection(String goodsDirection) {
		this.goodsDirection = goodsDirection;
	}



	public String getGoodsType() {
		return goodsType;
	}



	public void setGoodsType(String goodsType) {
		this.goodsType = goodsType;
	}



	public Date getLaunchDate() {
		return launchDate;
	}



	public void setLaunchDate(Date launchDate) {
		this.launchDate = launchDate;
	}



	public String getBrand() {
		return brand;
	}



	public void setBrand(String brand) {
		this.brand = brand;
	}



	public String getShipmentPlace() {
		return shipmentPlace;
	}



	public void setShipmentPlace(String shipmentPlace) {
		this.shipmentPlace = shipmentPlace;
	}



	public Goods2(Integer goodsId, String goodsName, String goodsImg, Member2 goodsSellerID, String goodsTitle,
			Integer goodsPrice, Integer goodsStock, String goodsDirection, String goodsType, Date launchDate,
			String brand, String shipmentPlace) {
		super();
		this.goodsId = goodsId;
		this.goodsName = goodsName;
		this.goodsImg = goodsImg;
		this.goodsSellerID = goodsSellerID;
		this.goodsTitle = goodsTitle;
		this.goodsPrice = goodsPrice;
		this.goodsStock = goodsStock;
		this.goodsDirection = goodsDirection;
		this.goodsType = goodsType;
		this.launchDate = launchDate;
		this.brand = brand;
		this.shipmentPlace = shipmentPlace;
	}

}
