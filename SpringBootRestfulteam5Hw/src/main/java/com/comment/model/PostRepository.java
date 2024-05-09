package com.comment.model;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.member.model.MemberBean;

public interface PostRepository extends JpaRepository<Post, Integer> {
	Page<Post> findByMemberOrderByCommenttimeDesc(MemberBean member, Pageable pageable);	
	
	
	
	
	 // 根據商品的賣家ID查詢相關的評論
    @Query("SELECT p FROM Post p " +
          "INNER JOIN p.orders o " +
           "INNER JOIN o.formatgoodId f " +
          "INNER JOIN f.good g " +
           "WHERE g.goodsSellerID.sid = :sellerId")
    Page<Post> findPostsBySellerId(@Param("sellerId") Integer sellerId, Pageable pageable);
    

}
