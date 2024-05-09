package com.member.model;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface AdminRepository extends JpaRepository<AdminBean, Integer> {

	/*檢查管理員登入*/
	@Query(value = "SELECT password FROM admins WHERE account = :account",nativeQuery = true)
	public String checkAdminPwd(String account);
	
	/*搜尋註冊人數*/
	@Query(value = "SELECT COUNT(*) FROM admins WHERE YEAR(hiredate) = :year AND MONTH(hiredate) = :month",nativeQuery = true)
	public Integer terminationDate(Integer year ,Integer month);
}
