package com.comment.model;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.member.model.MemberBean;

public interface PostMemberRepository extends JpaRepository<MemberBean, Integer> {
	 // 根據帳號和密碼查找成員
    Optional<MemberBean> findByAccountAndPassword(String account, String password);
 // 查询所有所有用戶以及每個用戶的評論數據
    @Query("SELECT m FROM MemberBean m INNER JOIN FETCH m.posts p ORDER BY p.commenttime DESC")
    List<MemberBean> findAllWithPosts();
}
