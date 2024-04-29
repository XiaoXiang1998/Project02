package com.comment.model;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.member.model.MemberBean;

public interface PostMemberRepository extends JpaRepository<MemberBean, Integer> {
	 // 根據帳號和密碼查找成員
    Optional<MemberBean> findByAccountAndPassword(String account, String password);
 // 查询所有用户以及每个用户的评论数据
    @Query("SELECT m FROM MemberBean m LEFT JOIN FETCH m.posts p ORDER BY p.commenttime DESC")
    List<MemberBean> findAllWithPosts();
}
