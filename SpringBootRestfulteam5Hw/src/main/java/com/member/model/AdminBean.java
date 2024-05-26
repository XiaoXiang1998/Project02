package com.member.model;

import java.time.LocalDate;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonFormat;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "admins")
@Component
public class AdminBean {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "aid")
	private Integer aid; 
	
	@Column(name = "account")
	private String account;
	
	@Column(name = "password")
	private String password;
	
	@Column(name = "email")
	private String email;
	
	@Column(name = "phone")
	private String phone;
	
	@Column(name = "name")
	private String name;
	
	@Column(name = "gender")
	private String gender;
	
	@Column(name = "address")
	private String address;
	
	@Column(name = "photosticker")
	private String photoSticker;
	
	@Column(name = "hiredate")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	private LocalDate hiredate;

	public AdminBean() {
	}
	
	/*新增有圖片*/
	public AdminBean(String account, String password, String email, String phone, String name, String gender,
			String address, String photoSticker, LocalDate hiredate) {
		super();
		this.account = account;
		this.password = password;
		this.email = email;
		this.phone = phone;
		this.name = name;
		this.gender = gender;
		this.address = address;
		this.photoSticker = photoSticker;
		this.hiredate = hiredate;
	}

	/*新增無圖片*/
	public AdminBean(String account, String password, String email, String phone, String name, String gender,
			String address, LocalDate hiredate) {
		super();
		this.account = account;
		this.password = password;
		this.email = email;
		this.phone = phone;
		this.name = name;
		this.gender = gender;
		this.address = address;
		this.hiredate = hiredate;
	}
	
	/*修改*/
	public AdminBean(Integer aid, String account, String password, String email, String phone, String name,
			String gender, String address, String photoSticker, LocalDate hiredate) {
		super();
		this.aid = aid;
		this.account = account;
		this.password = password;
		this.email = email;
		this.phone = phone;
		this.name = name;
		this.gender = gender;
		this.address = address;
		this.photoSticker = photoSticker;
		this.hiredate = hiredate;
	}


	public Integer getAid() {
		return aid;
	}

	public void setAid(Integer aid) {
		this.aid = aid;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhotoSticker() {
		return photoSticker;
	}

	public void setPhotoSticker(String photoSticker) {
		this.photoSticker = photoSticker;
	}

	public LocalDate getHiredate() {
		return hiredate;
	}

	public void setHiredate(LocalDate hiredate) {
		this.hiredate = hiredate;
	}
	
}
