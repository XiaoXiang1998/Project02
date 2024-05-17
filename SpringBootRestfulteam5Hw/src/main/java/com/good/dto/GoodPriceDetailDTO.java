package com.good.dto;

import jakarta.persistence.ColumnResult;
import jakarta.persistence.SqlResultSetMapping;

//@SqlResultSetMapping(name = "GoodPriceDTO",
//columns={@ColumnResult(name="minprice"),@ColumnResult(name="maxprice"),@ColumnResult(name="goodsID")})
public class GoodPriceDetailDTO {

	private Integer goodAVG;

	private String goodName;

	private String goodType;

	private String titleImage;

	private Integer minprice;

	private Integer maxprice;

	private Integer goodsID;
//
	private String goodDirection;
	
	private Integer goodsold;
	
	public Integer getGoodsold() {
		return goodsold;
	}

	public void setGoodsold(Integer goodsold) {
		this.goodsold = goodsold;
	}

	public String getTitleImage() {
		return titleImage;
	}

	public Integer getGoodAVG() {
		return goodAVG;
	}

	public void setGoodAVG(Integer goodAVG) {
		this.goodAVG = goodAVG;
	}

	public String getGoodName() {
		return goodName;
	}

	public void setGoodName(String goodName) {
		this.goodName = goodName;
	}

	public String getGoodType() {
		return goodType;
	}

	public void setGoodType(String goodType) {
		this.goodType = goodType;
	}

	public void setTitleImage(String titleImage) {
		this.titleImage = titleImage;
	}

	public Integer getMaxprice() {
		return maxprice;
	}

	public void setMaxprice(Integer maxprice) {
		this.maxprice = maxprice;
	}

	public Integer getMinprice() {
		return minprice;
	}

	public void setMinprice(Integer minprice) {
		this.minprice = minprice;
	}

	public Integer getGoodsID() {
		return goodsID;
	}

	public void setGoodsID(Integer goodsID) {
		this.goodsID = goodsID;
	}

	public String getGoodDirection() {
		return goodDirection;
	}

	public void setGoodDirection(String goodDirection) {
		this.goodDirection = goodDirection;
	}

	@Override
	public String toString() {
		return "GoodPriceDetailDTO [goodAVG=" + goodAVG + ", goodName=" + goodName + ", goodType=" + goodType
				+ ", titleImage=" + titleImage + ", minprice=" + minprice + ", maxprice=" + maxprice + ", goodsID="
				+ goodsID + ", goodDirection=" + goodDirection + "]";
	}

	
}
