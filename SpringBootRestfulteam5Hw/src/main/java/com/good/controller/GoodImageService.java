package com.good.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.good.model.GoodImageBean;
import com.good.model.GoodImageRepository;
@Service
@Transactional
public class GoodImageService {
	@Autowired
	private GoodImageRepository goodimageRepos;

	public GoodImageBean insert(GoodImageBean goodimage) {
		return goodimageRepos.save(goodimage);
	}
	public void deleteById(Integer id) {
		goodimageRepos.deleteById(id);
	}
	public GoodImageBean findImages(String imagepath){
		return goodimageRepos.findImages(imagepath);//透過uuid上傳的圖片重複性機率近乎為0
	}

	public GoodImageBean update(GoodImageBean goodimage) {
		return goodimageRepos.save(goodimage);
	}
	
	public Page<GoodImageBean> findAllByPage(Pageable pageable){
		return goodimageRepos.findAll(pageable);
	}
	
	public GoodImageBean getByID(int goodImageID){
		return goodimageRepos.getById(goodImageID);
	}
	public List<GoodImageBean> findImagesByID(Integer goodID) {
		return goodimageRepos.findImagesByID(goodID);
	}

}