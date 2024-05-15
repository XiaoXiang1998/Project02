package com.good.dto;

import jakarta.persistence.ColumnResult;
import jakarta.persistence.SqlResultSetMapping;

//@SqlResultSetMapping(name = "GoodPriceDTO",
//columns={@ColumnResult(name="minprice"),@ColumnResult(name="maxprice"),@ColumnResult(name="goodsID")})
public class GoodPriceDTO {

	private Integer goodAVG;

	private String goodName;

	private String goodType;

	private String titleImage;

	private Integer minprice;

	private Integer maxprice;

	private Integer goodsID;
//
	
	

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

	@Override
	public String toString() {
		return "GoodPriceDTO [goodAVG=" + goodAVG + ", goodName=" + goodName + ", goodType=" + goodType
				+ ", titleImage=" + titleImage + ", minprice=" + minprice + ", maxprice=" + maxprice + ", goodsID="
				+ goodsID + "]";
	}

}
