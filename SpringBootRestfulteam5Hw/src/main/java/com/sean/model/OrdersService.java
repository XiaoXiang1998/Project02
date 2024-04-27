package com.sean.model;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class OrdersService {

	@Autowired
	private OrderRepository oRops;

	public Orders insertToOrder(Orders order) {
		return oRops.save(order);
	}
	
	public List<Orders> findByOrderStatusNot(Integer orderStatus){
		return oRops.findByOrderStatusNot(orderStatus);
	}
	
	public Orders findByOrderIdAndOrderStatusNot(Integer orderId,Integer orderStatus) {
		return oRops.findByOrderIdAndOrderStatusNot(orderId, orderStatus);
	}
	
	public List<Orders> findByCreatedAtBetweenAndOrderStatusNot(Date startDate, Date endDate, int orderStatus){
		return oRops.findByCreatedAtBetweenAndOrderStatusNot(startDate, endDate, orderStatus);
	}
	
	public void cancelOrderById(Integer orderId) {
		oRops.cancelOrderById(orderId);
	}
	
	public void updateOrderById(String name , String address , String tel , Integer orderStatus , Integer orderId) {
		oRops.updateOrderById(name, address, tel, orderStatus, orderId);
	}

}
