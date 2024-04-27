package com.member.model;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface MemberRepository extends JpaRepository<MemberBean, Integer> {
	
	/*檢查密碼*/
	@Query(value = "SELECT password FROM member WHERE account = :account",nativeQuery = true)
	public String checkPwd(@Param("account")String account); 
	
	/*檢查賣家權限*/
	@Query(value = "SELECT admin FROM member WHERE account = :account",nativeQuery = true)
	public boolean adminCheck(@Param("account")String account); 
	
	/*查詢姓名*/
	@Query(value = "SELECT * FROM member WHERE name = :name",nativeQuery = true)
	public List<MemberBean> selectByName(String name);

	/*模糊搜尋姓名*/
	@Query(value = "from MemberBean where name like concat('%',?1,'%')")
	public List<MemberBean> selectLikeName(String name);

	/*查詢帳號*/
	@Query(value = "SELECT * FROM member WHERE account = :account",nativeQuery = true)
	public List<MemberBean> selectByAccount(String account);
	
	/*查詢電話*/
	@Query(value = "SELECT * FROM member WHERE phone = :phone",nativeQuery = true)
	public List<MemberBean> selectByPhone(String phone);
	
	/*返回bean物件提供登入用session*/
	@Query(value = "SELECT * FROM member WHERE account = :account",nativeQuery = true)
	public MemberBean selectByAccountBean(String account);
	
}
