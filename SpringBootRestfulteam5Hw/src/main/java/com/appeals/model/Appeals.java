package com.appeals.model;




import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "Appeals")

public class Appeals {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "Appeals_id")
	private int Appeals_id;
	
	@Column(name = "Appeals_name")
	private String Appeals_name;
	
	@Column(name = "Appeals_content")
	private String Appeals_content;
	
	@Column(name = "Appeals_reason")
	private String Appeals_reason;
	
	@Column(name = "Appeals_order")
	private String Appeals_order;
	
	@Column(name = "Appeals_date")
    private String Appeals_date;
	
	@Column(name = "Appeals_other")
	private String Appeals_other;
	
	@Column(name = "Appeals_state")
	private String Appeals_state;

	
 
	

	public Appeals() {
	}

	
	
	public Appeals(int appeals_id, String appeals_name, String appeals_content, String appeals_reason,
			String appeals_order, String appeals_date, String appeals_other, String appeals_state) {
		super();
		Appeals_id = appeals_id;
		Appeals_name = appeals_name;
		Appeals_content = appeals_content;
		Appeals_reason = appeals_reason;
		Appeals_order = appeals_order;
		Appeals_date = appeals_date;
		Appeals_other = appeals_other;
		Appeals_state = appeals_state;
	}



	


	public Appeals(String appeals_name, String appeals_content, String appeals_reason, String appeals_order,
			String appeals_date, String appeals_other, String appeals_state) {
		super();
		Appeals_name = appeals_name;
		Appeals_content = appeals_content;
		Appeals_reason = appeals_reason;
		Appeals_order = appeals_order;
		Appeals_date = appeals_date;
		Appeals_other = appeals_other;
		Appeals_state = appeals_state;
	}



	public int getAppeals_id() {
		return Appeals_id;
	}



	public void setAppeals_id(int appeals_id) {
		Appeals_id = appeals_id;
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



	public String getAppeals_reason() {
		return Appeals_reason;
	}



	public void setAppeals_reason(String appeals_reason) {
		Appeals_reason = appeals_reason;
	}



	public String getAppeals_order() {
		return Appeals_order;
	}



	public void setAppeals_order(String appeals_order) {
		Appeals_order = appeals_order;
	}



	public String getAppeals_date() {
		return Appeals_date;
	}



	public void setAppeals_date(String appeals_date) {
		Appeals_date = appeals_date;
	}



	public String getAppeals_other() {
		return Appeals_other;
	}



	public void setAppeals_other(String appeals_other) {
		Appeals_other = appeals_other;
	}



	public String getAppeals_state() {
		return Appeals_state;
	}



	public void setAppeals_state(String appeals_state) {
		Appeals_state = appeals_state;
	}




//	@Override
//	public String toString() {
//		return "Appeals [Appeals_id=" + Appeals_id + ", Appeals_name=" + Appeals_name + ", Appeals_content="
//				+ Appeals_content + ", Appeals_reason=" + Appeals_reason + ", Appeals_date=" + Appeals_date
//				+ ", Appeals_other=" + Appeals_other + "]";
//	}
//

	




	

	
	
	

}
