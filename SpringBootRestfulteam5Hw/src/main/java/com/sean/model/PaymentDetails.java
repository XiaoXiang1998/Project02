package com.sean.model;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Component;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "payment_details")
@Component
public class PaymentDetails {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "PAYMENT_DETAILSID")
	private int paymentDetailsId;

	@ManyToOne
	@JoinColumn(name = "FK_PAYUSERID")
	private Member2 payUserId;

	@Column(name = "PAYMENT_METHOD")
	private short paymentMethod;

	@Column(name = "CREDITCARDNUMBER")
	private String creditCardNumber;

	@Column(name = "CREATED_AT")
	private Date createdAt;

	@Column(name = "MODIFIED_AT")
	private Date modifiedAt;

	@Column(name = "TOTALPRICE")
	private Integer totalPrice;

	@OneToMany(mappedBy = "paymentId", cascade = { CascadeType.PERSIST, CascadeType.MERGE })
	private List<Orders> orders;

	public PaymentDetails() {

	}

	public int getPaymentDetailsId() {
		return paymentDetailsId;
	}

	public void setPaymentDetailsId(int paymentDetailsId) {
		this.paymentDetailsId = paymentDetailsId;
	}

	public short getPaymentMethod() {
		return paymentMethod;
	}

	public void setPaymentMethod(short paymentMethod) {
		this.paymentMethod = paymentMethod;
	}

	public Member2 getPayUserId() {
		return payUserId;
	}

	public void setPayUserId(Member2 payUserId) {
		this.payUserId = payUserId;
	}

	public List<Orders> getOrders() {
		return orders;
	}

	public void setOrders(List<Orders> orders) {
		this.orders = orders;
	}

	public String getCreditCardNumber() {
		return creditCardNumber;
	}

	public void setCreditCardNumber(String creditCardNumber) {
		this.creditCardNumber = creditCardNumber;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public Date getModifiedAt() {
		return modifiedAt;
	}

	public void setModifiedAt(Date modifiedAt) {
		this.modifiedAt = modifiedAt;
	}

	public Integer getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(Integer totalPrice) {
		this.totalPrice = totalPrice;
	}

	public PaymentDetails(int paymentDetailsId, Member2 payUserId, short paymentMethod, String creditCardNumber,
			Date createdAt, Date modifiedAt, List<Orders> orders) {
		super();
		this.paymentDetailsId = paymentDetailsId;
		this.payUserId = payUserId;
		this.paymentMethod = paymentMethod;
		this.creditCardNumber = creditCardNumber;
		this.createdAt = createdAt;
		this.modifiedAt = modifiedAt;
		this.orders = orders;
	}

	public PaymentDetails(Member2 payUserId, short paymentMethod, String creditCardNumber, Date createdAt,
			Date modifiedAt, Integer totalPrice) {
		super();
		this.payUserId = payUserId;
		this.paymentMethod = paymentMethod;
		this.creditCardNumber = creditCardNumber;
		this.createdAt = createdAt;
		this.modifiedAt = modifiedAt;
		this.totalPrice = totalPrice;
	}

}
