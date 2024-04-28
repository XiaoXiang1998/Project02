package com.good.controller;


import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.good.model.GoodFormat;
import com.good.model.GoodFormatRepository;
import com.good.model.GoodsBean2;
@Service
@Transactional
public class GoodFormatService {
	@Autowired
	private GoodFormatRepository goodformatRepos;
	//
	public GoodFormat insert(GoodFormat goodformat) {
		return goodformatRepos.save(goodformat);
	}
	public void deleteById(Integer id) {
		goodformatRepos.deleteById(id);
	}
	public GoodFormat update(GoodFormat goodformat) {
		return goodformatRepos.save(goodformat);
	}
	public Page<GoodFormat> findAllByPage(Pageable pageable){
		return goodformatRepos.findAll(pageable);
	}
	public Optional<GoodFormat> findById(Integer goodFormatId) {
		return goodformatRepos.findById(goodFormatId); 
	}
	public List<GoodFormat> getAll() {
		return goodformatRepos.findAll();
	}
	
}
