package com.sean.model;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	public String ecpayCheckout() {

		AllInOne all = new AllInOne("");

		AioCheckOutALL obj = new AioCheckOutALL();
		obj.setMerchantTradeNo("testCompany0004");
		obj.setMerchantTradeDate("2017/01/01 08:05:23");
		obj.setTotalAmount("50");
		obj.setTradeDesc("test Description");
		obj.setItemName("TestItem");
		// 交易結果回傳網址，只接受 https 開頭的網站，可以使用 ngrok
		obj.setReturnURL("<http://211.23.128.214:5000>");
		obj.setNeedExtraPaidInfo("N");
		// 商店轉跳網址 (Optional)
		obj.setClientBackURL("<http://192.168.1.37:8080/>");
		String form = all.aioCheckOut(obj, null);

		return form;
	}
}
