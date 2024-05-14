package com.comment.model;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.member.model.MemberBean;


@Service
@Transactional
public class PostService {

	@Autowired
	private PostRepository pRepository;

	public Post insert(Post post) {
		return pRepository.save(post);
	}

	public Post Update(Post post) {
		Optional<Post> existingComment = pRepository.findById(post.getCommentid());
		if (existingComment.isPresent()) {
			Post oldComment = existingComment.get();
			if (post.getCommentcontent() != null) {
				oldComment.setCommentcontent(post.getCommentcontent());
			}
			if (post.getLastmodifiedtime() != null) {
				oldComment.setLastmodifiedtime(post.getLastmodifiedtime());
			}

			return pRepository.save(oldComment);
		} else {
			// 如果找不到該評論，則可能需要處理此情況
			// 例如拋出異常或返回null
			return null;
		}
	}


	
	

	public Post getById(Integer id) {
		Optional<Post> op1 = pRepository.findById(id);
		if (op1.isPresent()) {
			return op1.get();
		}

		return null;
	}

	 public void deleteByCommentId(Integer commentId) {
	        pRepository.deleteByCommentId(commentId);
	    }
	
	

	public List<Post> getAll() {
		return pRepository.findAll();
	}
	
	

	public Page<Post> findByMemberOrderByCommenttimeDesc(MemberBean member, Pageable pageable) {
		return pRepository.findByMemberOrderByCommenttimeDesc(member, pageable);
	}

	public Page<Post> findPostsBySellerId(int sellerId, Pageable pageable) {
		return pRepository.findPostsBySellerId(sellerId, pageable);
	}

	public List<Post> findRepliesByRepliedCommentId(Integer repliedCommentId) {
		return pRepository.findByRepliedcommentid(repliedCommentId);
	}
	public List<Post> getSellerCommentsForUser(Integer userCommentId) {
		return pRepository.findSellerCommentsForUser(userCommentId);
	}

	public Page<Post> findPostsBySellerIdAndRating(Integer sellerId, Integer rating, Pageable pageable) {
		return pRepository.findPostsBySellerIdAndRating(sellerId, rating, pageable);
	}
	
	public List<Integer> findRepliedCommentIdsBySellerId(Integer sellerId) {
        // 根据卖家ID查询已回复的评论ID列表
        return pRepository.findRepliedCommentIdsBySellerId(sellerId);
    }
	
	public long countCommentsBySellerIdAndBuyerrate(int sellerId, int buyerrate) {
        return pRepository.countCommentsBySellerIdAndBuyerrate(sellerId, buyerrate);
    }

    // 根据商品的卖家ID获取相关评论的数量
    public long countCommentsBySellerId(int sellerId) {
        return pRepository.countPostsBySellerId(sellerId);
    }
	 
    public Page<Post> findRepliedCommentsBySellerId(int sellerId, Pageable pageable) {
        return pRepository.findRepliedCommentsBySellerId(sellerId, pageable);
    }
    
    public List<Post> findBuyerCommentsRepliedBySeller() {
        return pRepository.findBuyerCommentsRepliedBySeller();
    }
    

    public Page<Post> searchCommentsByConditions(int sellerId, String productName, String productSpec, String userName, Pageable pageable) {
        // 调用自定义的查询方法，包含卖家ID作为查询条件
        return pRepository.searchByConditions(sellerId, productName, productSpec, userName, pageable);
    }
}
