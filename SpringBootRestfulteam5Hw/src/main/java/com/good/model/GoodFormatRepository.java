package com.good.model;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface GoodFormatRepository extends JpaRepository<GoodFormat, Integer> {
	@Query(value = "select * from GOODFORMAT where goodsID = ? Order By goodImagePath", nativeQuery = true)//用標準SQL語法
	public List<GoodFormat> getByIDOrderByFormatImage(Integer goodID);
	
	@Query(value = "select * from GOODFORMAT where formatID = ?", nativeQuery = true)//用標準SQL語法
	public GoodFormat getById(Integer goodformatID);
}