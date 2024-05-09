package com.member.model;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface LevelRepository extends JpaRepository<LevelBean, Integer> {

	
}
