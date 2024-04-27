package com.good.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.good.model.GoodRepository;
import com.good.model.GoodsBean;

@Service
@Transactional
public class GoodService{
	@Autowired
	private GoodRepository goodRepos;
	
	public GoodsBean insert(GoodsBean good) {
		return goodRepos.save(good);
	}
	public GoodsBean update(GoodsBean good) {
		return goodRepos.save(good);
	}
	public void deleteById(Integer id) {
		goodRepos.deleteById(id);
	}
	public GoodsBean getById(Integer id) {
		 Optional<GoodsBean> op1 = goodRepos.findById(id);
		 if(op1.isPresent()) {
			 return op1.get();
		 }
		 return null;
	}
	public List<GoodsBean> getAll() {
		return goodRepos.findAll();
	}
	public List<GoodsBean> findGoods(String goodsName){
		return goodRepos.findGoods(goodsName);
	}
//	public List<GoodsBean> findByNameLike(String goodsName){
//		return goodRepos.findByNameLike(goodsName);
//	}
	public Page<GoodsBean> findAllByPage(Pageable pageable){
		return goodRepos.findAll(pageable);
	}
	
}
