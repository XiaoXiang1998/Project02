package com.good.model;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;


public interface GoodRepository extends JpaRepository<GoodsBean2, Integer> {

	
//	public List<GoodsBean> findByNameLike(String goodsName);
	
//	@Query(value = "select * from Goods", nativeQuery = true)//用標準SQL語法
	public List<GoodsBean2> findAll();
	
	@Query(value = "from GoodsBean2 g where g.goodsName like concat('%',?1,'%') AND g.goodsSellerID.sid = ?2")
	public List<GoodsBean2> findSellerGood(String goodsName,Integer sellerID);
	//[賣家檢視自己的所有商品]
	@Query(value = "from GoodsBean2 g where g.goodsSellerID.sid = ?1")
	public List<GoodsBean2> findSellerGoodItem(Integer sellerID);
	//[1.買家搜尋商品][2.買家檢視商城首頁]
	@Query(value = "from GoodsBean2 g where g.goodsName like concat('%',?1,'%') AND g.status = 1")
	public List<GoodsBean2> findGoods(String goodsName);
	@Query(value = "from GoodsBean2 g where g.status = 1 order by g.launchDate DESC")
	public List<GoodsBean2> findGoodByLaunchDate();
	// 在管理端中，從上架、下架、全部商品中查詢商品名稱
	@Query(value = "from GoodsBean2 g where g.status = -1")
	public Page<GoodsBean2> findGoodByPageBAN(Pageable pageable);
	@Query(value = "from GoodsBean2 g where g.status = 1")
	public Page<GoodsBean2> findGoodByPageOnMarket(Pageable pageable);
	@Query(value = "from GoodsBean2 g where g.status = 0")
	public Page<GoodsBean2> findGoodByPageDiscontinue(Pageable pageable);
	@Query(value = "from GoodsBean2 g where g.status = -1 AND g.goodsName like concat('%',?1,'%')")
	public Page<GoodsBean2> findGoodByPageAndNameBAN(Pageable pageable,String goodName);
	@Query(value = "from GoodsBean2 g where g.status = 1 AND g.goodsName like concat('%',?1,'%')")
	public Page<GoodsBean2> findGoodByPageAndNameOnMarket(Pageable pageable,String goodName);
	@Query(value = "from GoodsBean2 g where g.status = 0 AND g.goodsName like concat('%',?1,'%')")
	public Page<GoodsBean2> findGoodByPageAndNameDiscontinue(Pageable pageable,String goodName);
	@Query(value = "from GoodsBean2 g where g.goodsName like concat('%',?1,'%')")
	public Page<GoodsBean2> findGoodByPageAndNameAll(String goodName,Pageable pageable);
	//從賣家中，從上架、下架、全部商品、違規商品中查詢商品名稱
	@Query(value = "from GoodsBean2 g where g.status = 1 AND g.goodsSellerID.sid=?1")
	public Page<GoodsBean2> findSellerGoodByPageOnMarket(Pageable pageable,Integer sellerID);
	@Query(value = "from GoodsBean2 g where g.status = 1 AND g.goodsSellerID.sid=?1 AND g.goodsName like concat('%',?2,'%')")
	public Page<GoodsBean2> findSellerGoodByPageAndNameOnMarket(Pageable pageable,Integer sellerID,String goodNameString);
	@Query(value = "from GoodsBean2 g where g.status = 0 AND g.goodsSellerID.sid=?1")
	public Page<GoodsBean2> findSellerGoodByPageDiscontinue(Pageable pageable,Integer sellerID);
	@Query(value = "from GoodsBean2 g where g.status = 0 AND g.goodsSellerID.sid=?1 AND g.goodsName like concat('%',?2,'%')")
	public Page<GoodsBean2> findSellerGoodByPageAndNameDiscontinue(Pageable pageable,Integer sellerID,String goodNameString);
	@Query(value = "from GoodsBean2 g where g.goodsSellerID.sid=?1")
	public Page<GoodsBean2> findSellerAllByPage(Pageable pageable,Integer sellerID);
	@Query(value = "from GoodsBean2 g where g.goodsSellerID.sid=?1 AND g.goodsName like concat('%',?2,'%')")
	public Page<GoodsBean2> findSellerGoodByPageAndNameAll(Pageable pageable,Integer sellerID,String goodNameString);
	@Query(value = "from GoodsBean2 g where g.status = -1 AND g.goodsSellerID.sid=?1")
	public Page<GoodsBean2> findSellerGoodByPageBAN(Pageable pageable,Integer sellerID);
	@Query(value = "from GoodsBean2 g where g.status = -1 AND g.goodsSellerID.sid=?1 AND g.goodsName like concat('%',?2,'%')")
	public Page<GoodsBean2> findSellerGoodByPageAndNameBAN(Pageable pageable,Integer sellerID,String goodNameString);
	
	//管理者取七天前每天上架的商品數量
	@Query(value = "select COUNT(*) from Goods g where DATEDIFF(DAY, GETDATE(), g.LaunchDate) = ?1",nativeQuery = true)
	public Integer findNumberInsertGood(int day);
	
	//管理者取七天前商品每天銷售的數量(還沒寫完)
	@Query(value = "select COUNT(*) from Goods g where DATEDIFF(DAY, GETDATE(), g.LaunchDate) = ?1",nativeQuery = true)	
	public Integer findNumberInsertSold(int day);
	//取熱門商品種類
	@Query(value = "select distinct g.goodsType,COUNT(g.goodsType) AS Num from Goods g JOIN GoodFormat gf on g.GoodsID = gf.GoodsID JOIN ORDERS o on gf.FormatID = o.FK_FORMATGOODID where g.status = 1 group by g.goodsType order by Num DESC",nativeQuery = true)
	public List<Object[]> findpopularCategory();
}