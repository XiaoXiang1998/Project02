package com.good.dto;


import jakarta.persistence.ColumnResult;
import jakarta.persistence.NamedNativeQuery;
import jakarta.persistence.SqlResultSetMapping;

@SqlResultSetMapping(name = "GoodTypeDto",
					columns={@ColumnResult(name="goodsType")})
public class GoodTypeIndexDto {
	
	
	private String goodsType;
	//

	public String getGoodsType() {
		return goodsType;
	}

	public void setGoodsType(String goodsType) {
		this.goodsType = goodsType;
	}
	
}
