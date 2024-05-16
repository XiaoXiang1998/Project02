package com.sean.model;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.member.model.MemberBean;

public interface CarItemRepository extends JpaRepository<CarItem, Integer> {
	@Query(value = "from CarItem where member.sid=?1")
	public List<CarItem> findByMemberId(int MemberId);
	
	@Query(value = "from CarItem where carItemId = ?1")
	public List<CarItem> findByCarItemId(Integer carItemId);
	
	@Query(value="select count(*) from CarItem where member = ?1")
	public Integer carItemCount(MemberBean member); 
	
	@Modifying
	@Query(value = "update CarItem set quantity = ?1 where carItemId = ?2")
	public void updateQuantityById(int quantity, int carItemId);

	@Modifying
	@Query(value = "delete CarItem where carItemId = ?1")
	public void clearShopCarByMemberId(Integer carItemId);
}
