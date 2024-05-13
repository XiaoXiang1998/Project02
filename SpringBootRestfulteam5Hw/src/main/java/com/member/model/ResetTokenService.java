package com.member.model;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ResetTokenService {

	@Autowired
	ResetTokenRepository rtRepos;

	/*------------------------------------------------基本資料操作-----------------------------------------------------*/
	
	/*新增*/
	public boolean inserForgetPassword(ResetTokenBean rtBean) {
		try {
			rtRepos.save(rtBean);
	        return true;
	    } catch (Exception e) {
	    	 e.printStackTrace();
	    	return false;
	    }
	}
	
	/*更新*/
	public boolean updateForgetPassword(ResetTokenBean rtBean) {
		try {
			rtRepos.save(rtBean);
	        return true;
	    } catch (Exception e) {
	    	 e.printStackTrace();
	    	return false;
	    }
	}
	
	/*刪除紀錄*/
	public void deleteForgetPassword(Integer id) {
		rtRepos.deleteById(id);
	}

	/*------------------------------------------------驗證步驟-----------------------------------------------------*/
	
	public Optional<ResetTokenBean> findByToken(String token) {
		return rtRepos.findByToken(token);
	}
}
