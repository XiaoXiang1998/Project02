package com.member.model;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface ResetTokenRepository extends JpaRepository<ResetTokenBean, Integer> {
	
	/*檢查TOEKN是否存在，用於忘記密碼驗證用*/
	@Query(value = "SELECT * FROM ResetToken WHERE token = :token",nativeQuery = true)
	public Optional<ResetTokenBean> findByToken(String token);
}
