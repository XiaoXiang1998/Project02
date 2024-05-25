package com.good.model;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;



public interface GoodImageRepository extends JpaRepository<GoodImageBean, Integer> {
	
	@Query(value = "from GoodImageBean where name = ?",nativeQuery = true)
	public GoodImageBean findImages(String imagepath);
	@Query(value = "select * from GoodImage gi where gi.GoodsID = ?",nativeQuery = true)
	public List<GoodImageBean> findImagesByID(Integer goodID);
	public List<GoodImageBean> findAll();

// 老師的範例	
//	@Query(value = "from Users where name like concat('%',?1,'%1')")
//	public List<Users> findUsers(String name);
}