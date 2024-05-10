package com.good.controller;

import java.util.List;
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
public class GoodService{
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
		 if(op1.isPresent()) {
			 return op1.get();
		 }
		 return null;
	}
	public List<GoodsBean2> getAll() {
		return goodRepos.findAll();
	}
	public List<GoodsBean2> findGoods(String goodsName){
		return goodRepos.findGoods(goodsName);
	}
//	public List<GoodsBean> findByNameLike(String goodsName){
//		return goodRepos.findByNameLike(goodsName);
//	}
	public Page<GoodsBean2> findAllByPage(Pageable pageable){
		return goodRepos.findAll(pageable);
	}
	public List<GoodsBean2> findSellerGood(String goodsName,Integer sellerID){
		return goodRepos.findSellerGood(goodsName, sellerID);
	}
	
}