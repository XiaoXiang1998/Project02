package com.sean.model;


import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.member.model.MemberBean;

public interface OrderRepository extends JpaRepository<Orders, Integer> {
	
	public List<Orders> findByOrderStatusNot(Integer orderStatus);
	
	public Orders findByOrderIdAndOrderStatusNot(Integer orderId,Integer orderStatus);

	public List<Orders> findByCreatedAtBetweenAndOrderStatusNot(Date startDate, Date endDate, int orderStatus);
	
	public Page<Orders> findByBuyerIdAndOrderStatusOrderByOrderIdDesc(MemberBean BuyerId,Integer status,Pageable pageable);
	
	public Page<Orders> findByBuyerIdOrderByOrderIdDesc(MemberBean BuyerId,Pageable pageable);
	
	public Page<Orders> findBySellerIdAndOrderStatusOrderByOrderIdDesc(MemberBean SellerId,Integer status,Pageable pageable);

	public Page<Orders> findBySellerIdOrderByOrderIdDesc(MemberBean SellerId,Pageable pageable);
	@Modifying
	@Query(value = "update Orders set orderStatus = 5 where orderId = ?1")
	public void cancelOrderById(Integer orderId);
	
	@Query(value = "select count(*) from Orders where createdAt between ?1 And ?2 And orderStatus != 5")
	public Integer findOrdersCount(Date star,Date end);
	@Query(value = "select sum(totalPrice) from Orders where createdAt between ?1 And ?2 And orderStatus != 5")
	public Integer findOrdersPrice(Date star,Date end);
	
	@Modifying
	@Query(value = "update Orders set name = ?1 , address = ?2 , tel = ?3 , orderStatus = ?4 where orderId = ?5")
	public void updateOrderById(String name , String address , String tel , Integer orderStatus , Integer orderId);

	@Modifying
	@Query(value = "update Orders set name = ?1 , address = ?2 , tel = ?3 where orderId = ?4")
	public void BuyerUpdate(String name , String address , String tel , Integer orderId);

	@Modifying
	@Query(value = "update Orders set orderStatus = ?1 where orderId = ?2")
	public void UpdateStatus(Integer orderStatus, Integer orderId);
	
	/*游能佑新增的程式*/
	@Query(value = "SELECT ISNULL(sum(o.TOTAL_PRICE),0) from ORDERS o where DATEDIFF(day, o.CREATED_AT,GETDATE())= ?1 and o.ORDER_STATUS=3",nativeQuery = true)
	public Integer GetSoldPerDay(int daylimit);
	/*游能佑新增的程式*/
}
