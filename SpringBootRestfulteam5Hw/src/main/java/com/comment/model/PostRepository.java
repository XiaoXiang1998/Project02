package com.comment.model;

import java.sql.Timestamp;
import java.time.LocalDateTime;
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
	
	@Query("SELECT p FROM Post p " +
		       "INNER JOIN p.orders o " +
		       "INNER JOIN o.formatgoodId f " +
		       "INNER JOIN f.good g " +
		       "WHERE g.goodsSellerID.sid = :sellerId " +
		       "ORDER BY p.commenttime DESC")
    Page<Post> findPostsBySellerId(@Param("sellerId") Integer sellerId, Pageable pageable);
    
    @Query("SELECT p FROM Post p WHERE p.repliedcommentid = :commentId")
    List<Post> findSellerCommentsForUser(Integer commentId);
    
    @Query("SELECT p FROM Post p WHERE p.repliedcommentid IN :commentIds ORDER BY p.replaytime DESC")
    Page<Post> findSellerCommentsForUserWithPagination(@Param("commentIds") List<Integer> commentIds, Pageable pageable);

    @Query("SELECT p FROM Post p WHERE p.repliedcommentid IN :commentIds AND p.sellerrate = :rating ORDER BY p.replaytime DESC")
    Page<Post> getSellerCommentsByRatingWithPagination(@Param("commentIds") List<Integer> commentIds, @Param("rating") Integer rating, Pageable pageable);
    
    @Query("SELECT COUNT(p) FROM Post p WHERE p.repliedcommentid IN :commentIds AND p.sellerrate = :rating")
    Integer countSellerCommentsByRating(@Param("commentIds") List<Integer> commentIds, @Param("rating") int rating);
    
    @Query("SELECT p FROM Post p " +
    	       "INNER JOIN p.orders o " +
    	       "INNER JOIN o.formatgoodId f " +
    	       "INNER JOIN f.good g " +
    	       "WHERE g.goodsSellerID.sid = :sellerId " +
    	       "AND p.buyerrate = :rating " +
    	       "ORDER BY p.commenttime DESC")
    Page<Post> findPostsBySellerIdAndRating(@Param("sellerId") Integer sellerId,
                                            @Param("rating") Integer rating,
                                            Pageable pageable);
    
    @Query("SELECT p.repliedcommentid FROM Post p WHERE p.member.sid = :sellerId")
    List<Integer> findRepliedCommentIdsBySellerId(@Param("sellerId") Integer sellerId);
    
    @Modifying
    @Transactional
    @Query("DELETE FROM Post p WHERE p.commentid = :commentId")
    void deleteByCommentId(@Param("commentId") Integer commentId);
    
    
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
    
    @Query("SELECT p FROM Post p " +
    	       "INNER JOIN p.orders o " +
    	       "INNER JOIN o.formatgoodId f " +
    	       "INNER JOIN f.good g " +
    	       "WHERE g.goodsSellerID.sid = :sellerId " + 
    	       "AND (:productName IS NULL OR p.orders.formatgoodId.good.goodsName LIKE %:productName%) " +
    	       "AND (:productSpec IS NULL OR p.orders.formatgoodId.goodSize LIKE %:productSpec%) " +
    	       "AND (:userName IS NULL OR p.member.name LIKE %:userName%) " +
    	       "AND (:commentTimeStart IS NULL OR p.commenttime >= :commentTimeStart) " +
    	       "AND (:commentTimeEnd IS NULL OR p.commenttime < :commentTimeEnd) " +
    	       "ORDER BY p.commenttime DESC")
    Page<Post> searchByConditions(@Param("sellerId") Integer sellerId,
                                  @Param("productName") String productName,
                                  @Param("productSpec") String productSpec,
                                  @Param("userName") String userName,
                                  @Param("commentTimeStart") Timestamp commentTimeStart,
                                  @Param("commentTimeEnd") Timestamp commentTimeEnd,
                                  Pageable pageable);
    
    @Query(value = "SELECT p FROM Post p INNER JOIN p.orders o INNER JOIN o.formatgoodId f INNER JOIN f.good g WHERE g.goodsID = :goodId ORDER BY p.commenttime DESC")
    Page<Post> productPostsByGoodId(@Param("goodId") Integer goodId, Pageable pageable);

    @Query(value = "SELECT p FROM Post p INNER JOIN p.orders o INNER JOIN o.formatgoodId f INNER JOIN f.good g WHERE g.goodsID= :goodId AND p.buyerrate = :rate ORDER BY p.commenttime DESC")
    Page<Post> productPostsByGoodIdAndRate(@Param("goodId") Integer goodId, @Param("rate") Integer rate, Pageable pageable);

    @Query(value = "SELECT p FROM Post p INNER JOIN p.orders o INNER JOIN o.formatgoodId f INNER JOIN f.good g WHERE g.goodsID = :goodId AND p.commentcontent IS NOT NULL AND p.commentcontent <> '' ORDER BY p.commenttime DESC")
    Page<Post> productPostsByGoodIdWithContent(@Param("goodId") Integer goodId, Pageable pageable);

    @Query(value = "SELECT p FROM Post p INNER JOIN p.orders o INNER JOIN o.formatgoodId f INNER JOIN f.good g WHERE g.goodsID = :goodId AND p.productphoto IS NOT NULL ORDER BY p.commenttime DESC")
    Page<Post> productPostsByGoodIdWithPhotos(@Param("goodId") Integer goodId, Pageable pageable);
}
    
    

