package com.sean.model;

import java.util.Date;

import org.springframework.stereotype.Component;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "orders")
@Component
public class Orders {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ORDER_ID")
	private Integer orderId;

	@ManyToOne
	@JoinColumn(name = "FK_BUYERID")
	private Member2 buyerId;

	@ManyToOne
	@JoinColumn(name = "FK_SELLER_ID")
	private Member2 sellerId;
	@ManyToOne
	@JoinColumn(name = "FK_FORMATGOODID")
	private Goods2 formatgoodId;

	@Column(name = "QUANTITY")
	private Integer quantity;

	@Column(name = "NAME")
	private String name;

	@Column(name = "ADDRESS")
	private String address;

	@Column(name = "TEL")
	private String tel;

	@Column(name = "SHIPPING_METHOD")
	private short shippingMethod;

	@Column(name = "SHIPPING_FEE")
	private Integer shippingFee;

	@Column(name = "ORIGINAL_PRICE")
	private Integer originalPrice;

	@Column(name = "DISCOUNT_PRICE")
	private Integer discountPrice;

	@Column(name = "TOTAL_PRICE")
	private Integer totalPrice;

	@ManyToOne
	@JoinColumn(name = "FK_PAYMENT_ID")
	private PaymentDetails paymentId;

	@Column(name = "PAY_STATUS")
	private short payStatus;

	@Column(name = "ORDER_STATUS")
	private short orderStatus;

	@Column(name = "CREATED_AT")
	private Date createdAt;

	@Column(name = "MODIFIED_AT")
	private Date modifiedAt;

	public Orders() {

	}

	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public short getShippingMethod() {
		return shippingMethod;
	}

	public void setShippingMethod(short shippingMethod) {
		this.shippingMethod = shippingMethod;
	}

	public int getShippingFee() {
		return shippingFee;
	}

	public void setShippingFee(Integer shippingFee) {
		this.shippingFee = shippingFee;
	}

	public int getOriginalPrice() {
		return originalPrice;
	}

	public void setOriginalPrice(Integer originalPrice) {
		this.originalPrice = originalPrice;
	}

	public int getDiscountPrice() {
		return discountPrice;
	}

	public void setDiscountPrice(Integer discountPrice) {
		this.discountPrice = discountPrice;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(Integer totalPrice) {
		this.totalPrice = totalPrice;
	}

	public int getPayStatus() {
		return payStatus;
	}

	public void setPayStatus(short payStatus) {
		this.payStatus = payStatus;
	}

	public short getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(short orderStatus) {
		this.orderStatus = orderStatus;
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

	public Member2 getBuyerId() {
		return buyerId;
	}

	public void setBuyerId(Member2 buyerId) {
		this.buyerId = buyerId;
	}

	public Member2 getSellerId() {
		return sellerId;
	}

	public void setSellerId(Member2 sellerId) {
		this.sellerId = sellerId;
	}

	public Goods2 getFormatgoodId() {
		return formatgoodId;
	}

	public void setFormatgoodId(Goods2 formatgoodId) {
		this.formatgoodId = formatgoodId;
	}

	public PaymentDetails getPaymentId() {
		return paymentId;
	}

	public void setPaymentId(PaymentDetails paymentId) {
		this.paymentId = paymentId;
	}

	public Orders(Integer orderId, Member2 buyerId, Member2 sellerId, Goods2 formatgoodId, Integer quantity,
			String name, String address, String tel, short shippingMethod, Integer shippingFee, Integer originalPrice,
			Integer discountPrice, Integer totalPrice, PaymentDetails paymentId, short payStatus, short orderStatus,
			Date createdAt, Date modifiedAt) {
		super();
		this.orderId = orderId;
		this.buyerId = buyerId;
		this.sellerId = sellerId;
		this.formatgoodId = formatgoodId;
		this.quantity = quantity;
		this.name = name;
		this.address = address;
		this.tel = tel;
		this.shippingMethod = shippingMethod;
		this.shippingFee = shippingFee;
		this.originalPrice = originalPrice;
		this.discountPrice = discountPrice;
		this.totalPrice = totalPrice;
		this.paymentId = paymentId;
		this.payStatus = payStatus;
		this.orderStatus = orderStatus;
		this.createdAt = createdAt;
		this.modifiedAt = modifiedAt;
	}

	public Orders(Member2 buyerId, Member2 sellerId, Goods2 formatgoodId, Integer quantity, String name, String address,
			String tel, short shippingMethod, Integer shippingFee, Integer originalPrice, Integer discountPrice,
			Integer totalPrice, PaymentDetails paymentId, short payStatus, short orderStatus, Date createdAt,
			Date modifiedAt) {
		super();
		this.buyerId = buyerId;
		this.sellerId = sellerId;
		this.formatgoodId = formatgoodId;
		this.quantity = quantity;
		this.name = name;
		this.address = address;
		this.tel = tel;
		this.shippingMethod = shippingMethod;
		this.shippingFee = shippingFee;
		this.originalPrice = originalPrice;
		this.discountPrice = discountPrice;
		this.totalPrice = totalPrice;
		this.paymentId = paymentId;
		this.payStatus = payStatus;
		this.orderStatus = orderStatus;
		this.createdAt = createdAt;
		this.modifiedAt = modifiedAt;
	}

	public Orders(Integer orderId, Member2 buyerId, Member2 sellerId, Goods2 formatgoodId, Integer quantity,
			String name, String address, String tel, short shippingMethod, Integer shippingFee, Integer originalPrice,
			Integer totalPrice, PaymentDetails paymentId, short payStatus, short orderStatus, Date createdAt,
			Date modifiedAt) {
		super();
		this.orderId = orderId;
		this.buyerId = buyerId;
		this.sellerId = sellerId;
		this.formatgoodId = formatgoodId;
		this.quantity = quantity;
		this.name = name;
		this.address = address;
		this.tel = tel;
		this.shippingMethod = shippingMethod;
		this.shippingFee = shippingFee;
		this.originalPrice = originalPrice;
		this.totalPrice = totalPrice;
		this.paymentId = paymentId;
		this.payStatus = payStatus;
		this.orderStatus = orderStatus;
		this.createdAt = createdAt;
		this.modifiedAt = modifiedAt;
	}

	public Orders(Member2 buyerId, Member2 sellerId, Goods2 formatgoodId, Integer quantity, String name, String address,
			String tel, short shippingMethod, Integer shippingFee, Integer originalPrice, Integer totalPrice,
			PaymentDetails paymentId, short payStatus, short orderStatus, Date createdAt, Date modifiedAt) {
		super();
		this.buyerId = buyerId;
		this.sellerId = sellerId;
		this.formatgoodId = formatgoodId;
		this.quantity = quantity;
		this.name = name;
		this.address = address;
		this.tel = tel;
		this.shippingMethod = shippingMethod;
		this.shippingFee = shippingFee;
		this.originalPrice = originalPrice;
		this.totalPrice = totalPrice;
		this.paymentId = paymentId;
		this.payStatus = payStatus;
		this.orderStatus = orderStatus;
		this.createdAt = createdAt;
		this.modifiedAt = modifiedAt;
	}
	
}
