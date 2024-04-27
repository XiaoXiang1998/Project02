package com.good.model;

import java.util.Date;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonFormat;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;


@Entity
@Table(name = "Goods")
@Component
public class GoodsBean implements java.io.Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "GOODSId")
	private Integer goodsID;
	@Column(name = "GOODSNAME")
	private String goodsName;
	@Column(name = "GOODSIMG")
	private String goodsImg;
	@Column(name = "GOODSPRICE")
	private Integer goodsPrice;
	@Column(name = "GOODSSTOCK")
	private Integer goodsStock;
	@Column(name = "GOODSDIRECTION")
	private String goodsDirection;
	@Column(name = "GOODSTYPE")
	private String goodsType;
	@JsonFormat(pattern = "yyyy-MM-dd",timezone = "GMT+8")
	@Column(name = "LAUNCHDATE")
	private Date launchDate;
	@Column(name = "BRAND")
	private String brand;
	@Column(name = "SHIPMENTPLACE")
	private String shipmentPlace;	
	@Column(name = "GOODSSELLERID")
	private int goodsSellerID;
	//
	public GoodsBean() {
		
	}
	
	public GoodsBean(Integer goodsID, String goodsName, String goodsImg, Integer goodsPrice, Integer goodsStock,
			String goodsDirection, String goodsType, Date launchDate, String brand, String shipmentPlace,
			int goodsSellerID) {
		this.goodsID = goodsID;
		this.goodsName = goodsName;
		this.goodsImg = goodsImg;
		this.goodsPrice = goodsPrice;
		this.goodsStock = goodsStock;
		this.goodsDirection = goodsDirection;
		this.goodsType = goodsType;
		this.launchDate = launchDate;
		this.brand = brand;
		this.shipmentPlace = shipmentPlace;
		this.goodsSellerID = goodsSellerID;
	}

	public GoodsBean(String goodsName, String goodsImg, Integer goodsPrice, Integer goodsStock, String goodsDirection,
			String goodsType, Date launchDate, String brand, String shipmentPlace, int goodsSellerID) {
		this.goodsName = goodsName;
		this.goodsImg = goodsImg;
		this.goodsPrice = goodsPrice;
		this.goodsStock = goodsStock;
		this.goodsDirection = goodsDirection;
		this.goodsType = goodsType;
		this.launchDate = launchDate;
		this.brand = brand;
		this.shipmentPlace = shipmentPlace;
		this.goodsSellerID = goodsSellerID;
	}

	//
	public int getGoodsSellerID() {
		return goodsSellerID;
	}

	public void setGoodsSellerID(int goodsSellerID) {
		this.goodsSellerID = goodsSellerID;
	}

	public Integer getGoodsID() {
		return goodsID;
	}
	public void setGoodsID(Integer goodsID) {
		this.goodsID = goodsID;
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
	
}