package com.member.model;

import java.util.List;

import org.springframework.stereotype.Component;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "levelcorrespondencetable")
@Component
public class LevelBean {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "level")
	private Integer level;

	@Column(name = "title")
	private String title;

	@Column(name = "threshold")
	private int threshold;
	
	/* Level類與Member類之間的一對多關聯 */
	@OneToMany(mappedBy = "level")
	private List<MemberBean> members;

	public LevelBean() {
	}

	public LevelBean(Integer level, String title, int threshold, List<MemberBean> members) {
		this.level = level;
		this.title = title;
		this.threshold = threshold;
		this.members = members;
	}

	public Integer getLevel() {
		return level;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getThreshold() {
		return threshold;
	}

	public void setThreshold(int threshold) {
		this.threshold = threshold;
	}

	public List<MemberBean> getMembers() {
		return members;
	}

	public void setMembers(List<MemberBean> members) {
		this.members = members;
	}
	
}