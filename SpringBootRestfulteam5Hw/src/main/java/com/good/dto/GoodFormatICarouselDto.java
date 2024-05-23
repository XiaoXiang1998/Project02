package com.good.dto;

import jakarta.persistence.ColumnResult;
import jakarta.persistence.NamedNativeQuery;
import jakarta.persistence.SqlResultSetMapping;

//@SqlResultSetMapping(name = "GoodTypeDto",
//					columns={@ColumnResult(name="goodsType"),@ColumnResult(name="goodsTypeNumber")})
public class GoodFormatICarouselDto {

	private String formatImagePath;
	private String formatSize;
	private Integer formatPrice;
	private Integer formatStock;
	private Integer formatID;
	private Integer index;
	public String getFormatImagePath() {
		return formatImagePath;
	}
	public void setFormatImagePath(String formatImagePath) {
		this.formatImagePath = formatImagePath;
	}
	public String getFormatSize() {
		return formatSize;
	}
	public void setFormatSize(String formatSize) {
		this.formatSize = formatSize;
	}
	public Integer getFormatPrice() {
		return formatPrice;
	}
	public void setFormatPrice(Integer formatPrice) {
		this.formatPrice = formatPrice;
	}
	public Integer getFormatStock() {
		return formatStock;
	}
	public void setFormatStock(Integer formatStock) {
		this.formatStock = formatStock;
	}
	public Integer getFormatID() {
		return formatID;
	}
	public void setFormatID(Integer formatID) {
		this.formatID = formatID;
	}
	public Integer getIndex() {
		return index;
	}
	public void setIndex(Integer index) {
		this.index = index;
	}

	//
	

}
