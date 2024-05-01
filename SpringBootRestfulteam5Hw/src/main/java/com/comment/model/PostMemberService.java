package com.comment.model;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.member.model.MemberBean;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class PostMemberService {
	
	@Autowired
	private PostMemberRepository mRepository;

	public Optional<MemberBean> findById(Integer id) {
		return mRepository.findById(id);
	}
	
	public Optional<MemberBean> findByAccountAndPassword(String account, String password){
		return mRepository.findByAccountAndPassword(account, password);
	}
	
    public List<MemberBean> getAllMembersWithPosts() {
        return mRepository.findAllWithPosts();
    }

	public MemberBean insertMember (MemberBean member) {
		return mRepository.save(member);
	}
	
    
    
}
