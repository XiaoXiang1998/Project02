package com.sean.model;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class Goods2Service {
	@Autowired
	private Goods2Repository gRops;

	public List<Goods2> findAllProduct() {
		return gRops.findAll();
	}

	public Optional<Goods2> findById(Integer productId) {
		return gRops.findById(productId); 
	}
}
