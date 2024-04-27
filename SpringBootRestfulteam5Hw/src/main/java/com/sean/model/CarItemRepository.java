package com.sean.model;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

public interface CarItemRepository extends JpaRepository<CarItem, Integer> {
	@Query(value = "from CarItem where member.sid=?1")
	public List<CarItem> findByMemberId(int MemberId);

	@Modifying
	@Query(value = "update CarItem set quantity = ?1 where carItemId = ?2")
	public void updateQuantityById(int quantity, int carItemId);

	@Modifying
	@Query(value = "delete CarItem where member.sid = ?1")
	public void clearShopCarByMemberId(Integer MemberId);
}
