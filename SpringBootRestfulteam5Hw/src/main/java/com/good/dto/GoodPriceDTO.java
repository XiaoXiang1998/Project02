package com.good.dto;

import jakarta.persistence.ColumnResult;
import jakarta.persistence.SqlResultSetMapping;

@SqlResultSetMapping(name = "GoodPriceDTO",
columns={@ColumnResult(name="minprice"),@ColumnResult(name="maxprice"),@ColumnResult(name="goodsID")})
public class GoodPriceDTO {
	
	private int minprice;
	
	private int maxprice;

	private int goodsID;

	public int getMaxprice() {
		return maxprice;
	}

	public void setMaxprice(int maxprice) {
		this.maxprice = maxprice;
	}

	public int getMinprice() {
		return minprice;
	}

	public void setMinprice(int minprice) {
		this.minprice = minprice;
	}

	public int getGoodsID() {
		return goodsID;
	}

	public void setGoodsID(int goodsID) {
		this.goodsID = goodsID;
	}
	
}
