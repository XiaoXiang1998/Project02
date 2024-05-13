package com.good.dto;


import jakarta.persistence.ColumnResult;
import jakarta.persistence.NamedNativeQuery;
import jakarta.persistence.SqlResultSetMapping;

@SqlResultSetMapping(name = "GoodTypeDto",
					columns={@ColumnResult(name="goodsType"),@ColumnResult(name="goodsTypeNumber")})
public class GoodTypeDto {
	
	private int goodsTypeNumber;
	
	private String goodsType;
	//
	public int getGoodsTypeNumber() {
		return goodsTypeNumber;
	}

	public void setGoodsTypeNumber(int goodsTypeNumber) {
		this.goodsTypeNumber = goodsTypeNumber;
	}

	public String getGoodsType() {
		return goodsType;
	}

	public void setGoodsType(String goodsType) {
		this.goodsType = goodsType;
	}
	
}
