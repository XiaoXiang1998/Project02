package com.good.dto;


import jakarta.persistence.ColumnResult;
import jakarta.persistence.NamedNativeQuery;
import jakarta.persistence.SqlResultSetMapping;

@SqlResultSetMapping(name = "GoodBasicDto",
					columns={@ColumnResult(name="goodsID"),@ColumnResult(name="goodsType"),@ColumnResult(name="goodsName"),@ColumnResult(name="titleImage")})
public class GoodBasicDto {
	
	private int goodsID;
	
	private String goodsType;
	
	private String goodsName;
	
	private String titleImage;
	//

	public int getGoodsID() {
		return goodsID;
	}

	public void setGoodsID(int goodsID) {
		this.goodsID = goodsID;
	}

	public String getGoodsType() {
		return goodsType;
	}

	public void setGoodsType(String goodsType) {
		this.goodsType = goodsType;
	}

	public String getGoodsName() {
		return goodsName;
	}

	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}

	public String getTitleImage() {
		return titleImage;
	}

	public void setTitleImage(String titleImage) {
		this.titleImage = titleImage;
	}
	
}
