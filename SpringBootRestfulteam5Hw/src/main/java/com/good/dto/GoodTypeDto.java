package com.good.dto;


import jakarta.persistence.ColumnResult;
import jakarta.persistence.NamedNativeQuery;
import jakarta.persistence.SqlResultSetMapping;

//@SqlResultSetMapping(name = "GoodTypeDto",
//					columns={@ColumnResult(name="goodsType"),@ColumnResult(name="goodsTypeNumber")})
public class GoodTypeDto {
	
	private Long goodsTypeNumber;
	
	private String goodsType;
	//
	public Long getGoodsTypeNumber() {
		return goodsTypeNumber;
	}

	public void setGoodsTypeNumber(Long goodsTypeNumber) {
		this.goodsTypeNumber = goodsTypeNumber;
	}

	public String getGoodsType() {
		return goodsType;
	}

	public void setGoodsType(String goodsType) {
		this.goodsType = goodsType;
	}

	
}
