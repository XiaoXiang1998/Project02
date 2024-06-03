package com.comment.model;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.member.model.MemberBean;

public interface PostMemberRepository extends JpaRepository<MemberBean, Integer> {
    Optional<MemberBean> findByAccountAndPassword(String account, String password);
    @Query("SELECT m FROM MemberBean m INNER JOIN FETCH m.posts p ORDER BY p.commenttime DESC")
    List<MemberBean> findAllWithPosts();
}
