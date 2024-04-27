package com.appeals.model;

import org.springframework.stereotype.Component;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "Appeals")
@Component
public class Appeals {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "Appeals_id")
	private int Appeals_id;
	
	@Column(name = "Appeals_reason")
	private String Appeals_reason;
	
	@Column(name = "Appeals_name")
	private String Appeals_name;
	
	@Column(name = "Appeals_content")
	private String Appeals_content;
	
	@Column(name = "Appeals_other")
	private String Appeals_other;

	public Appeals() {
	}

	public Appeals(int appeals_id, String appeals_reason, String appeals_name, String appeals_content,
			String appeals_other) {
		Appeals_id = appeals_id;
		Appeals_reason = appeals_reason;
		Appeals_name = appeals_name;
		Appeals_content = appeals_content;
		Appeals_other = appeals_other;
	}

	public Appeals(String appeals_reason, String appeals_name, String appeals_content, String appeals_other) {
		Appeals_reason = appeals_reason;
		Appeals_name = appeals_name;
		Appeals_content = appeals_content;
		Appeals_other = appeals_other;
	}

	public int getAppeals_id() {
		return Appeals_id;
	}

	public void setAppeals_id(int appeals_id) {
		Appeals_id = appeals_id;
	}

	public String getAppeals_reason() {
		return Appeals_reason;
	}

	public void setAppeals_reason(String appeals_reason) {
		Appeals_reason = appeals_reason;
	}

	public String getAppeals_name() {
		return Appeals_name;
	}

	public void setAppeals_name(String appeals_name) {
		Appeals_name = appeals_name;
	}

	public String getAppeals_content() {
		return Appeals_content;
	}

	public void setAppeals_content(String appeals_content) {
		Appeals_content = appeals_content;
	}

	public String getAppeals_other() {
		return Appeals_other;
	}

	public void setAppeals_other(String appeals_other) {
		Appeals_other = appeals_other;
	}

	@Override
	public String toString() {
		return "Appeals [Appeals_id=" + Appeals_id + ", Appeals_reason=" + Appeals_reason + ", Appeals_name="
				+ Appeals_name + ", Appeals_content=" + Appeals_content + ", Appeals_other=" + Appeals_other + "]";
	}
	
	

}
