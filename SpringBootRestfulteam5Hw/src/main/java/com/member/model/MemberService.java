package com.member.model;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class MemberService {
	
	@Autowired
	private MemberRepository memRepos;
	
/*------------------------------------------------基本資料操作-----------------------------------------------------*/
	
	/*新增會員*/
	public MemberBean insert(MemberBean mem) {
		return memRepos.save(mem);
	}
	
	/*更新會員*/
	public MemberBean update(MemberBean mem) {
		return memRepos.save(mem);
	} 
	
	/*刪除會員*/
	public void deleteById(Integer id) {
		memRepos.deleteById(id);
	}
	
	/*查詢會員*/
	public List<MemberBean> getAll() {
		return memRepos.findAll();
	}
	
/*------------------------------------------------查詢-----------------------------------------------------*/	
	/*查詢姓名*/
	public List<MemberBean> selectByName(String name){
		return memRepos.selectByName(name);
	}

	/*模糊搜尋姓名*/
	public List<MemberBean> selectLikeName(String name){
		return memRepos.selectLikeName(name);
	}

	/*查詢帳號*/
	public List<MemberBean> selectByAccount(String account){
		return memRepos.selectByAccount(account);
	}
	
	/*查詢電話*/
	public List<MemberBean> selectByPhone(String phone){
		return memRepos.selectByPhone(phone);
	}
	
	/*提供登入用資訊*/
	public MemberBean selectByAccountBean(String account) {
		return memRepos.selectByAccountBean(account);
	}
/*------------------------------------------------登入機制-----------------------------------------------------*/		
	
	/*檢查登入*/
	public boolean checkLogin(String account ,String password) {
		return memRepos.checkPwd(account).equals(password);
	}
	
	/*檢查管理權限*/
	public boolean adminCheck(String account) {
		return memRepos.adminCheck(account);
	}
	
	
}
