package com.good.model;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;


public interface GoodRepository extends JpaRepository<GoodsBean, Integer> {

	@Query(value = "from GoodsBean where goodsName like concat('%',?1,'%1')")
	public List<GoodsBean> findGoods(String goodsName);

//	public List<GoodsBean> findByNameLike(String goodsName);
	
	@Query(value = "select * from Goods", nativeQuery = true)//用標準SQL語法
	public List<GoodsBean> findAll();
	

}
