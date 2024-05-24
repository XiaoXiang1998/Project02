package com.good.controller;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.good.model.GoodRepository;
import com.good.model.GoodsBean2;

@Service
@Transactional
public class GoodService {
	@Autowired
	private GoodRepository goodRepos;

	public GoodsBean2 insert(GoodsBean2 good) {
		return goodRepos.save(good);
	}

	public GoodsBean2 update(GoodsBean2 good) {
		return goodRepos.save(good);
	}

	public void deleteById(Integer id) {
		goodRepos.deleteById(id);
	}

	public GoodsBean2 getById(Integer id) {
		Optional<GoodsBean2> op1 = goodRepos.findById(id);
		if (op1.isPresent()) {
			return op1.get();
		}
		return null;
	}

	public List<GoodsBean2> getAll() {
		return goodRepos.findAll();
	}

	public List<GoodsBean2> findGoods(String goodsName) {
		return goodRepos.findGoods(goodsName);
	}

//	public List<GoodsBean> findByNameLike(String goodsName){
//		return goodRepos.findByNameLike(goodsName);
//	}
	public Page<GoodsBean2> findAllByPage(Pageable pageable) {
		return goodRepos.findAll(pageable);
	}

	public List<GoodsBean2> findSellerGoodItem(Integer sellerID) {
		return goodRepos.findSellerGoodItem(sellerID);
	}

	public List<GoodsBean2> findSellerGood(String goodsName, Integer sellerID) {
		return goodRepos.findSellerGood(goodsName, sellerID);
	}

	public List<GoodsBean2> findGoodByLaunchDate() {
		return goodRepos.findGoodByLaunchDate();
	}

	public Page<GoodsBean2> findGoodByPageOnMarket(Pageable pageable) {
		return goodRepos.findGoodByPageOnMarket(pageable);
	}

	public Page<GoodsBean2> findGoodByPageDiscontinue(Pageable pageable) {
		return goodRepos.findGoodByPageDiscontinue(pageable);
	}
	//
	public Page<GoodsBean2> findGoodByPageAndNameOnMarket(Pageable pageable, String goodName) {
		return goodRepos.findGoodByPageAndNameOnMarket(pageable, goodName);
	}

	public Page<GoodsBean2> findGoodByPageAndNameDiscontinue(Pageable pageable, String goodName) {
		return goodRepos.findGoodByPageAndNameDiscontinue(pageable, goodName);
	}

	public Page<GoodsBean2> findGoodByPageAndNameAll(Pageable pageable, String goodName) {
		return goodRepos.findGoodByPageAndNameAll(goodName, pageable);
	}
	public Page<GoodsBean2> findGoodByPageBAN(Pageable pageable){
		return goodRepos.findGoodByPageBAN(pageable);
	}
	public Page<GoodsBean2> findGoodByPageAndNameBAN(Pageable pageable,String goodName){
		return goodRepos.findGoodByPageAndNameBAN(pageable, goodName);
	}
	// 從賣家中，從上架、下架、全部商品、違規商品中查詢商品名稱
	public Page<GoodsBean2> findSellerGoodByPageOnMarket(Pageable pageable, Integer sellerID) {
		return goodRepos.findSellerGoodByPageOnMarket(pageable, sellerID);
	}

	public Page<GoodsBean2> findSellerGoodByPageAndNameOnMarket(Pageable pageable, Integer sellerID,
			String goodNameString) {
		return goodRepos.findSellerGoodByPageAndNameOnMarket(pageable, sellerID, goodNameString);
	}

	public Page<GoodsBean2> findSellerGoodByPageDiscontinue(Pageable pageable, Integer sellerID) {
		return goodRepos.findSellerGoodByPageDiscontinue(pageable, sellerID);
	}

	public Page<GoodsBean2> findSellerGoodByPageAndNameDiscontinue(Pageable pageable, Integer sellerID,
			String goodNameString) {
		return goodRepos.findSellerGoodByPageAndNameDiscontinue(pageable, sellerID, goodNameString);
	}

	public Page<GoodsBean2> findSellerAllByPage(Pageable pageable, Integer sellerID) {
		return goodRepos.findSellerAllByPage(pageable, sellerID);
	}

	public Page<GoodsBean2> findSellerGoodByPageAndNameAll(Pageable pageable, Integer sellerID, String goodNameString) {
		return goodRepos.findSellerGoodByPageAndNameAll(pageable, sellerID, goodNameString);
	}

	public Page<GoodsBean2> findSellerGoodByPageBAN(Pageable pageable, Integer sellerID) {
		return goodRepos.findSellerGoodByPageBAN(pageable, sellerID);
	}

	public Page<GoodsBean2> findSellerGoodByPageAndNameBAN(Pageable pageable, Integer sellerID,
			String goodNameString) {
		return goodRepos.findSellerGoodByPageAndNameBAN(pageable, sellerID, goodNameString);
	}

	// 管理者取七天前商品上架的數量
	public Integer findNumberInsertGood(int day) {
		return goodRepos.findNumberInsertGood(day);
	}

	// 管理者取七天前商品上架的數量[要取訂單資料表][還沒寫完]
	public Integer findNumberInsertSold(int day) {
		return goodRepos.findNumberInsertSold(day);
	}
	//取得任門商品種類
	public List<Object[]> findpopularCategory(){
		return goodRepos.findpopularCategory();
	}
}