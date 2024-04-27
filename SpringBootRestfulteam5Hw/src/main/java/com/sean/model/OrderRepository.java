package com.sean.model;


import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

public interface OrderRepository extends JpaRepository<Orders, Integer> {
	
	public List<Orders> findByOrderStatusNot(Integer orderStatus);
	
	public Orders findByOrderIdAndOrderStatusNot(Integer orderId,Integer orderStatus);

	public List<Orders> findByCreatedAtBetweenAndOrderStatusNot(Date startDate, Date endDate, int orderStatus);
	
	@Modifying
	@Query(value = "update Orders set orderStatus = 5 where orderId = ?1")
	public void cancelOrderById(Integer orderId);
	
	@Modifying
	@Query(value = "update Orders set name = ?1 , address = ?2 , tel = ?3 , orderStatus = ?4 where orderId = ?5")
	public void updateOrderById(String name , String address , String tel , Integer orderStatus , Integer orderId);
}
