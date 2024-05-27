package com.good.dto;

import java.io.Serializable;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.good.model.GoodsBean2;

public class GoodPageDto implements Serializable{


	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Integer page;
	@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
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
