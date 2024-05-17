package com.good.dto;


import jakarta.persistence.ColumnResult;
import jakarta.persistence.NamedNativeQuery;
import jakarta.persistence.SqlResultSetMapping;

//@SqlResultSetMapping(name = "GoodTypeDto",
//					columns={@ColumnResult(name="goodsType"),@ColumnResult(name="goodsTypeNumber")})
public class GoodFormatImageDto {
	
	
	private String goodImagePath;
	//

	public String getGoodImagePath() {
		return goodImagePath;
	}

	public void setGoodImagePath(String goodImagePath) {
		this.goodImagePath = goodImagePath;
	}

	
}
