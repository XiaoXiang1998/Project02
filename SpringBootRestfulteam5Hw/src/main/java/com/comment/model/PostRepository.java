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
	
	
	
	
	List<Post> findByRepliedcommentid(Integer repliedCommentId);
	
	 // 根據商品的賣家ID查詢相關的評論
    @Query("SELECT p FROM Post p " +
          "INNER JOIN p.orders o " +
           "INNER JOIN o.formatgoodId f " +
          "INNER JOIN f.good g " +
           "WHERE g.goodsSellerID.sid = :sellerId")
    Page<Post> findPostsBySellerId(@Param("sellerId") Integer sellerId, Pageable pageable);
    
    
    @Query("SELECT p FROM Post p WHERE p.repliedcommentid = :commentId")
    List<Post> findSellerCommentsForUser(Integer commentId);
    
    
    @Query("SELECT p FROM Post p " +
            "INNER JOIN p.orders o " +
            "INNER JOIN o.formatgoodId f " +
            "INNER JOIN f.good g " +
            "WHERE g.goodsSellerID.sid = :sellerId " +
            "AND p.buyerrate = :rating")
    Page<Post> findPostsBySellerIdAndRating(@Param("sellerId") Integer sellerId,
                                            @Param("rating") Integer rating,
                                            Pageable pageable);
    
    // 根据卖家ID查询已回复的评论ID列表
    @Query("SELECT p.repliedcommentid FROM Post p WHERE p.member.sid = :sellerId")
    List<Integer> findRepliedCommentIdsBySellerId(@Param("sellerId") Integer sellerId);

}
