package com.good.dto;


import jakarta.persistence.ColumnResult;
import jakarta.persistence.NamedNativeQuery;
import jakarta.persistence.SqlResultSetMapping;

//@SqlResultSetMapping(name = "GoodTypeDto",
//					columns={@ColumnResult(name="goodsType"),@ColumnResult(name="goodsTypeNumber")})
public class GoodLaunchDto {
	
	private int goodsNumber;
	
	private String date;
	//

	public int getGoodsNumber() {
		return goodsNumber;
	}

	public void setGoodsNumber(int goodsNumber) {
		this.goodsNumber = goodsNumber;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}
	

	
}
