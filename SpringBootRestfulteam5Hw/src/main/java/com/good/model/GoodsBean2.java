package com.good.model;

import java.util.Date;
import java.util.LinkedHashSet;
import java.util.Set;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonManagedReference;
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
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

//串聯後的資料表
@Entity
@Table(name = "Goods")
@Component
public class GoodsBean2 implements java.io.Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "GOODSID")
	private Integer goodsID;
	@Column(name = "GOODSNAME")
	private String goodsName;
	@Column(name = "GOODSDIRECTION")
	private String goodsDirection;
	@Column(name = "GOODSTYPE")
	private String goodsType;
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	@Column(name = "LAUNCHDATE")
	private Date launchDate = new Date();
	@Column(name = "BRAND")
	private String brand;
	@Column(name = "SHIPMENTPLACE")
	private String shipmentPlace;
	@Column(name = "NUMBERRATINGS")
	private Integer numberRatings;
	@Column(name = "RATING")
	private Integer rating;
	
	@ManyToOne
	@JoinColumn(name = "GOODSSELLERID")
//	@JsonBackReference
	private MemberBean goodsSellerID;
	//
	@Column(name="TITLEIMAGE")
	private String titleImage;
	@Column(name="GOODSSOLD")
	private Integer goodsold;
	@Column(name="STATUS")
	private Integer status;
	//
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "good", cascade = CascadeType.ALL)
	@JsonManagedReference
	private Set<GoodImageBean> images = new LinkedHashSet<GoodImageBean>();

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "good", cascade = CascadeType.ALL)
	@JsonManagedReference
	private Set<GoodFormat> format = new LinkedHashSet<GoodFormat>();

//
	public GoodsBean2() {

	}

	public GoodsBean2(Integer goodsID, String goodsName, String goodsDirection, String goodsType,
			 String brand, String shipmentPlace, MemberBean goodsSellerID,String titleImage,Integer status) {
		this.goodsID = goodsID;
		this.goodsName = goodsName;
		this.goodsDirection = goodsDirection;
		this.goodsType = goodsType;
		this.brand = brand;
		this.shipmentPlace = shipmentPlace;
		this.goodsSellerID = goodsSellerID;
		this.titleImage = titleImage;
		this.status = status;
	}

	public GoodsBean2(String goodsName, String goodsDirection, String goodsType,
			String brand, String shipmentPlace, MemberBean goodsSellerID,String titleImage,Integer status) {
		this.goodsName = goodsName;
		this.goodsDirection = goodsDirection;
		this.goodsType = goodsType;
		this.brand = brand;
		this.shipmentPlace = shipmentPlace;
		this.goodsSellerID = goodsSellerID;
		this.titleImage = titleImage;
		this.status = status;
	}

//
	public MemberBean getGoodsSellerID() {
		return goodsSellerID;
	}

	public void setGoodsSellerID(MemberBean goodsSellerID) {
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

	public Set<GoodImageBean> getImages() {
		return images;
	}

	public void setImages(Set<GoodImageBean> images) {
		this.images = images;
	}

	public Set<GoodFormat> getFormat() {
		return format;
	}

	public void setFormat(Set<GoodFormat> format) {
		this.format = format;
	}

	public String getTitleImage() {
		return titleImage;
	}

	public void setTitleImage(String titleImage) {
		this.titleImage = titleImage;
	}
	public Integer getNumberRatings() {
		return numberRatings;
	}

	public void setNumberRatings(Integer numberRatings) {
		this.numberRatings = numberRatings;
	}

	public Integer getRating() {
		return rating;
	}

	public void setRating(Integer rating) {
		this.rating = rating;
	}

	public Integer getGoodsold() {
		return goodsold;
	}

	public void setGoodsold(Integer goodsold) {
		this.goodsold = goodsold;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "GoodsBean2 [goodsID=" + goodsID + ", goodsName=" + goodsName + ", goodsDirection=" + goodsDirection
				+ ", goodsType=" + goodsType + ", launchDate=" + launchDate + ", brand=" + brand + ", shipmentPlace="
				+ shipmentPlace + ", numberRatings=" + numberRatings + ", rating=" + rating + ", goodsSellerID="
				+ goodsSellerID.getSid() + ", titleImage=" + titleImage + ", goodsold=" + goodsold +", status=" + status+ "]";
	}

	

}