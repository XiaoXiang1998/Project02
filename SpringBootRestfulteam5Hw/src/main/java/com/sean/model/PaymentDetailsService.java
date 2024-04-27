package com.sean.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class PaymentDetailsService {
	@Autowired
	private PaymentDetailsRepository pRops;

	public PaymentDetails paymentDetails(PaymentDetails paymentDetails) {
		return pRops.save(paymentDetails);
	}

}
