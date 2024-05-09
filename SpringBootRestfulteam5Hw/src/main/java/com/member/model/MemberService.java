package com.member.model;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import jakarta.transaction.Transactional;

@Service
@Transactional
public class MemberService {
	
	@Autowired
	private MemberRepository memRepos;
	
/*------------------------------------------------基本資料操作-----------------------------------------------------*/

	/*新增會員*/
	public boolean insert(MemberBean mem) {
		try {
			memRepos.save(mem);
	        return true;
	    } catch (Exception e) {
	    	 e.printStackTrace();
	    	return false;
	    }
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
	
	/*提供登入Session用資訊*/
	public MemberBean selectByAccountBean(String account) {
		return memRepos.selectByAccountBean(account);
	}
/*------------------------------------------------第三方登入機制-----------------------------------------------------*/			
	public Optional<MemberBean> findByAccount(String account){
		return memRepos.findByAccount(account);
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
	
	public Optional<MemberBean> findById(Integer memberId) {
		
		return memRepos.findById(memberId);
	}
/*------------------------------------------------檢視機制-----------------------------------------------------*/		
	
	public String getMemberLevelTitle(Integer memberId) {
		MemberBean member = memRepos.findById(memberId).orElse(null);
		if(member != null && member.getLevelEntity() != null) {
			System.out.println("當前等級資料: " + member.getLevelEntity().getTitle());
			System.out.println("當前等級消費上限: " + member.getLevelEntity().getThreshold());
			System.out.println("當前總消費金額: " + member.getTotalSalesAmount());
			return member.getLevelEntity().getTitle();
		}
		return "未知等級";
	}
	
	public String updateMemberLevel(Integer memberId) {
		MemberBean member = memRepos.findById(memberId).orElse(null);
		if(member != null && member.getLevelEntity() != null) {
			System.out.println("當前等級資料: " + member.getLevelEntity().getTitle());
			System.out.println("當前等級消費上限: " + member.getLevelEntity().getThreshold());
			System.out.println("當前總消費金額: " + member.getTotalSalesAmount());
			/*把制度表裡面的金額轉成整數，後續做比較*/
			int threshold = member.getLevelEntity().getThreshold();
			if(member.getTotalSalesAmount() > threshold) {
				System.out.println("before: " + member.getLevel());
				member.setLevel(member.getLevel() + 1);
				memRepos.save(member);
				System.out.println("等級更新完成");
			}
			return member.getLevelEntity().getTitle();
		}
		return "未知等級";
	}
	
/*------------------------------------------------返回圖表-----------------------------------------------------*/		
	/*查詢對應級別會員人數*/
	public Integer headcount(Integer level) {
		return memRepos.headcount(level);
	}
	
	/*查詢對應月份註冊人數*/
	public Integer registrationCount(Integer year,Integer month) { 
		return memRepos.registrationCount(year, month);
	}

}
