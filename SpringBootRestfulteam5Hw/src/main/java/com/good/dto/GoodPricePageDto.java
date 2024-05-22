package com.good.dto;

import java.util.List;

import com.good.model.GoodsBean2;

public class GoodPricePageDto {
	
	private Integer page;
	
	private List<GoodPriceDTO> goodPriceDtoList;

	public Integer getPage() {
		return page;
	}

	public void setPage(Integer page) {
		this.page = page;
	}

	public List<GoodPriceDTO> getGoodPriceDtoList() {
		return goodPriceDtoList;
	}

	public void setGoodPriceDtoList(List<GoodPriceDTO> goodPriceDtoList) {
		this.goodPriceDtoList = goodPriceDtoList;
	}

	

	

	
}
