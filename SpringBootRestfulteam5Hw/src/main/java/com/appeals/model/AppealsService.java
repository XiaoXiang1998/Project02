package com.appeals.model;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class AppealsService {

    @Autowired
    private AppealsRepository aRepos;

    // 新增
    public Appeals insertAppeals(Appeals appeals) {
        return aRepos.save(appeals);
    }

    // 刪除
   
    
    public void deleteById(Integer id) {
    	aRepos.deleteById(id);
	}

    // 修改
    public Appeals updateAppeals(Appeals appeals) {
        return aRepos.save(appeals);
    }
    
   
    
    

    // 查詢單個
    public Appeals selectOne(int appealsId) {
        Optional<Appeals> optionalAppeals = aRepos.findById(appealsId);
        
        
        if(optionalAppeals.isPresent()) {
			return optionalAppeals.get();
		}
		
		return null;
	}

    // 查詢全部
    public List<Appeals> getAll() {
        return aRepos.findAll();
    }
}