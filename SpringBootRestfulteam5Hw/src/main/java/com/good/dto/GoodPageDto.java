package com.good.dto;

import java.util.List;

import com.good.model.GoodsBean2;

public class GoodPageDto {
	
	private Integer page;
	
	private List<GoodsBean2> good;

	public Integer getPage() {
		return page;
	}

	public void setPage(Integer page) {
		this.page = page;
	}

	public List<GoodsBean2> getGood() {
		return good;
	}

	public void setGood(List<GoodsBean2> good) {
		this.good = good;
	}

	

	
}