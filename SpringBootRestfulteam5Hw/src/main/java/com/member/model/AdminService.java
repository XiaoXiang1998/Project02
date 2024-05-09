package com.member.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class AdminService {

	@Autowired
	private AdminRepository adRepos;
/*------------------------------------------------登入操作-----------------------------------------------------*/
	/*登入檢查密碼*/
	public boolean checkAdminLogin(String account,String password) {
		return adRepos.checkAdminPwd(account).equals(password);
	}
/*--------------------------------------------------基本操作--------------------------------------------------*/
	
	/*新增管理員*/ 
	public AdminBean insert(AdminBean ad) {
		return adRepos.save(ad);
	}
	
	/*刪除管理員*/
	public void deleteById(Integer id) {
		adRepos.deleteById(id);
	}
	
	/*修改管理員*/
	public AdminBean update(AdminBean ad) {
		return adRepos.save(ad);
	}
	
	/*查詢全部會員*/
	public List<AdminBean> getAll(){
		return adRepos.findAll();
	}
/*--------------------------------------------------管理者頁面圖表--------------------------------------------------*/
	/*查詢月分對應註冊人數*/
	public Integer terminationDate(Integer year,Integer month) { 
		return adRepos.terminationDate(year, month);
	}
}
