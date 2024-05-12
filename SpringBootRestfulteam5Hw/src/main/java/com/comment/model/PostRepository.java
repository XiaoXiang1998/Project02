package com.comment.model;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

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
    
    @Modifying
    @Transactional
    @Query("DELETE FROM Post p WHERE p.commentid = :commentId")
    void deleteByCommentId(@Param("commentId") Integer commentId);
    
    
 // 根據賣家ID和買家評分星級查詢相關的評論數量
    @Query("SELECT COUNT(p) FROM Post p " +
           "INNER JOIN p.orders o " +
           "INNER JOIN o.formatgoodId f " +
           "INNER JOIN f.good g " +
           "WHERE g.goodsSellerID.sid = :sellerId AND p.buyerrate = :buyerrate")
    long countCommentsBySellerIdAndBuyerrate(@Param("sellerId") Integer sellerId, @Param("buyerrate") Integer buyerrate);
    
    @Query("SELECT COUNT(p) FROM Post p " +
           "INNER JOIN p.orders o " +
           "INNER JOIN o.formatgoodId f " +
           "INNER JOIN f.good g " +
           "WHERE g.goodsSellerID.sid = :sellerId")
    long countPostsBySellerId(@Param("sellerId") Integer sellerId);
    
    @Query("SELECT p FROM Post p WHERE p.member.sid = :sellerId AND p.repliedcommentid IS NOT NULL")
    Page<Post> findRepliedCommentsBySellerId(@Param("sellerId") int sellerId, Pageable pageable);
   
    
    @Query("SELECT p FROM Post p WHERE p.commentid IN (SELECT DISTINCT repliedcommentid FROM Post WHERE repliedcommentid IS NOT NULL)")
    List<Post> findBuyerCommentsRepliedBySeller();
}
