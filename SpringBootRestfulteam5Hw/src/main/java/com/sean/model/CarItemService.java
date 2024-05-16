package com.sean.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.member.model.MemberBean;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class CarItemService {
	@Autowired
	private CarItemRepository cRops;

	public List<CarItem> findByMemberId(int MemberId) {
		return cRops.findByMemberId(MemberId);
	}
	
	public List<CarItem> findByIdList(Integer id){
		return cRops.findByCarItemId(id);
	}

	public CarItem insertToShopCar(CarItem carItem) {
		return cRops.save(carItem);
	}

	public void updateQuantityById(int quantity, int carItemId) {
		cRops.updateQuantityById(quantity, carItemId);
	}

	public void deleteCarItemById(Integer id) {
		cRops.deleteById(id);
	}

	public void clearShopCarByMemberId(Integer carItemId) {
		cRops.clearShopCarByMemberId(carItemId);
	}
	public Integer carItemCount(MemberBean member) {
		return cRops.carItemCount(member);
	}
}
