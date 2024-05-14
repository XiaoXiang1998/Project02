package com.good.model;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;


public interface GoodRepository extends JpaRepository<GoodsBean2, Integer> {

	@Query(value = "from GoodsBean2 where goodsName like concat('%',?1,'%')")
	public List<GoodsBean2> findGoods(String goodsName);

//	public List<GoodsBean> findByNameLike(String goodsName);
	
//	@Query(value = "select * from Goods", nativeQuery = true)//用標準SQL語法
	public List<GoodsBean2> findAll();
	
	@Query(value = "from GoodsBean2 g where g.goodsName like concat('%',?1,'%') AND g.goodsSellerID.sid = ?2")
	public List<GoodsBean2> findSellerGood(String goodsName,Integer sellerID);
	
	@Query(value = "from GoodsBean2 g order by g.launchDate DESC")
	public List<GoodsBean2> findGoodByLaunchDate();
	
}