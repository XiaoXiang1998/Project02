package com.sean.model;

import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.comment.model.Post;
import com.member.model.MemberBean;

import ecpay.payment.integration.AllInOne;
import ecpay.payment.integration.domain.AioCheckOutALL;
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
	public List<Orders> findByBuyerIdAndOrderStatus(MemberBean BuyerId,Integer status){
		return oRops.findByBuyerIdAndOrderStatus(BuyerId,status);
	}
	public List<Orders> findBySellerIdAndOrderStatus0(MemberBean SellerId,Integer status){
		return oRops.findBySellerIdAndOrderStatus(SellerId, 0);
	}
	public List<Orders> findBySellerIdAndOrderStatus1(MemberBean SellerId,Integer status){
		return oRops.findBySellerIdAndOrderStatus(SellerId, 1);
	}
	public List<Orders> findBySellerIdAndOrderStatus2(MemberBean SellerId,Integer status){
		return oRops.findBySellerIdAndOrderStatus(SellerId, 2);
	}
	public List<Orders> findBySellerIdAndOrderStatus3(MemberBean SellerId,Integer status){
		return oRops.findBySellerIdAndOrderStatus(SellerId, 3);
	}
	public List<Orders> findBySellerIdAndOrderStatus4(MemberBean SellerId,Integer status){
		return oRops.findBySellerIdAndOrderStatus(SellerId, 4);
	}
	public List<Orders> findBySellerIdAndOrderStatus5(MemberBean SellerId,Integer status){
		return oRops.findBySellerIdAndOrderStatus(SellerId, 5);
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
	public String ecpayCheckout(String totalAmount,String merchantTradeDate, String itemName) {

		String uuId = UUID.randomUUID().toString().replaceAll("-", "").substring(0, 20);

		AllInOne all = new AllInOne("");

		AioCheckOutALL obj = new AioCheckOutALL();
		obj.setMerchantTradeNo(uuId);
		obj.setMerchantTradeDate(merchantTradeDate);
		obj.setTotalAmount(totalAmount);
		obj.setTradeDesc("test Description");
		obj.setItemName(itemName);
		obj.setReturnURL("http://localhost:8081/goindex.controller");
		obj.setClientBackURL("http://localhost:8081/goindex.controller");
		obj.setNeedExtraPaidInfo("N");
		String form = all.aioCheckOut(obj, null);

		return form;
	}

	public Orders getById(Integer id) {
		 Optional<Orders> op1 = oRops.findById(id);
		 if(op1.isPresent()) {
			 return op1.get();
		 }
		 
		 return null;
	}
	
	
}
