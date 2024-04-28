package com.good.model;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonBackReference;

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
@Component
@Table(name="GOODIMAGE")
public class GoodImageBean {
	@Id 
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="GOODIMAGEID")
	private int goodImageID;//自動建立ID
	
//	@Column(name="GOODSID")
//	@Transient
//	private int goodsID;//外來鍵不用給值

	@Column(name="IMAGEPATH")
	private String imagePath;//路徑名稱需要給值
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "GOODSID")
	@JsonBackReference
	private GoodsBean2 good;
	//
	public GoodImageBean(int goodImageID, String imagePath) {
		this.goodImageID = goodImageID;
		this.imagePath = imagePath;
	}
	
	public GoodImageBean() {

	}

	public GoodImageBean(String imagePath) {
		this.imagePath = imagePath;
	}
	//

	public int getGoodImageID() {
		return goodImageID;
	}

	public void setGoodImageID(int goodImageID) {
		this.goodImageID = goodImageID;
	}



	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}

	public GoodsBean2 getGood() {
		return good;
	}

	public void setGood(GoodsBean2 good) {
		this.good = good;
	}
	
}
