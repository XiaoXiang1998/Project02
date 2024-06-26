package com.comment.model;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
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
import com.fasterxml.jackson.databind.MappingIterator;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.dataformat.csv.CsvMapper;
import com.fasterxml.jackson.dataformat.csv.CsvSchema;
import com.fasterxml.jackson.dataformat.xml.XmlMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
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
	        } else {
	            long currentTimeMillis = System.currentTimeMillis();
	            java.sql.Timestamp currTimestamp = new java.sql.Timestamp(currentTimeMillis);
	            oldComment.setLastmodifiedtime(currTimestamp);
	        }

	        return pRepository.save(oldComment);
	    } else {
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
        return pRepository.findRepliedCommentIdsBySellerId(sellerId);
    }
	
	public long countCommentsBySellerIdAndBuyerrate(int sellerId, int buyerrate) {
        return pRepository.countCommentsBySellerIdAndBuyerrate(sellerId, buyerrate);
    }

    public long countCommentsBySellerId(int sellerId) {
        return pRepository.countPostsBySellerId(sellerId);
    }
	 
    public Page<Post> findRepliedCommentsBySellerId(int sellerId, Pageable pageable) {
        return pRepository.findRepliedCommentsBySellerId(sellerId, pageable);
    }
    
    public List<Post> findBuyerCommentsRepliedBySeller() {
        return pRepository.findBuyerCommentsRepliedBySeller();
    }
    
     
   
    public Page<Post> searchByConditions(Integer sellerId, String productName, String productSpec, String userName, Timestamp commentTimeStart, Timestamp commentTimeEnd, Pageable pageable) {
        return pRepository.searchByConditions(sellerId, productName, productSpec, userName, commentTimeStart, commentTimeEnd, pageable);
    }
    public Page<Post> findSellerCommentsForUserWithPagination(List<Integer> commentIds, Pageable pageable) {
        return pRepository.findSellerCommentsForUserWithPagination(commentIds, pageable);
    }

    public Page<Post> getSellerCommentsByRatingWithPagination(List<Integer> commentIds, Integer rating, Pageable pageable) {
        return pRepository.getSellerCommentsByRatingWithPagination(commentIds, rating, pageable);
    }
    
    public List<Long> countSellerCommentsByRatings(List<Integer> commentIds) {
        List<Long> ratingCounts = new ArrayList<>();
        for (int i = 1; i <= 5; i++) {
            long count = pRepository.countSellerCommentsByRating(commentIds, i);
            ratingCounts.add(count);
        }
        return ratingCounts;
    }
    
    public Page<Post> getPostsByGoodId(Integer goodId, Pageable pageable) {
        return pRepository.productPostsByGoodId(goodId, pageable);
    }

    public Page<Post> getPostsByGoodIdAndRate(Integer goodId, Integer rate, Pageable pageable) {
        return pRepository.productPostsByGoodIdAndRate(goodId, rate, pageable);
    }
    
    public Page<Post> findPostsByGoodIdWithContent(Integer goodId, Pageable pageable) {
        return pRepository.productPostsByGoodIdWithContent(goodId, pageable);
    }

    public Page<Post> findPostsByGoodIdWithPhotos(Integer goodId, Pageable pageable) {
        return pRepository.productPostsByGoodIdWithPhotos(goodId, pageable);
    }
    

    public byte[] exportToCSV(List<Post> posts) {
        try {
            StringWriter writer = new StringWriter();
            List<String> lines = new ArrayList<>();
            List<String> header = Arrays.asList("commentid", "commentcontent", "productphoto", "commenttime", "lastmodifiedtime", "buyerrate", "replayconetnt", "replaytime", "sellerrate", "repliedcommentid");
            lines.add(String.join(",", header));

            for (Post post : posts) {
                List<String> rowData = new ArrayList<>();
                rowData.add(String.valueOf(post.getCommentid()));
                
                String commentContent = post.getCommentcontent() != null ? 
                    (post.getCommentcontent().isEmpty() ? "NULL" : post.getCommentcontent().replace("\r", " ").replace("\n", "").trim()) : "NULL";
                rowData.add(commentContent);
                
                rowData.add(post.getProductphoto() != null ? post.getProductphoto() : "NULL");
                rowData.add(post.getCommenttime() != null ? post.getCommenttime().toString() : "NULL");
                rowData.add(post.getLastmodifiedtime() != null ? post.getLastmodifiedtime().toString() : "NULL");
                rowData.add(post.getBuyerrate() != null ? String.valueOf(post.getBuyerrate()) : "NULL");
                rowData.add(post.getReplayconetnt() != null ? post.getReplayconetnt() : "NULL");
                rowData.add(post.getReplaytime() != null ? post.getReplaytime().toString() : "NULL");
                rowData.add(post.getSellerrate() != null ? String.valueOf(post.getSellerrate()) : "NULL");
                rowData.add(post.getRepliedcommentid() != null ? String.valueOf(post.getRepliedcommentid()) : "NULL");
                lines.add(String.join(",", rowData));
            }

            writer.write(String.join("\n", lines));
            return writer.toString().getBytes();
        } catch (Exception e) {
            throw new RuntimeException("Failed to export data to CSV", e);
        }
    }

    public byte[] exportToJSON(List<Post> posts) {
        try {
            for (Post post : posts) {
                if (post.getCommentcontent() != null) {
                    post.setCommentcontent(post.getCommentcontent().replace("\r", "").replace("\n", "").trim());
                }
            }

            ObjectMapper mapper = new ObjectMapper();
            mapper.registerModule(new JavaTimeModule()); 
            return mapper.writeValueAsBytes(posts);
        } catch (Exception e) {
            throw new RuntimeException("Failed to export data to JSON", e);
        }
    }

    public byte[] exportToXML(List<Post> posts) {
        try {
            for (Post post : posts) {
                if (post.getCommentcontent() != null) {
                    post.setCommentcontent(post.getCommentcontent().replace("\r", "").replace("\n", "").trim());
                }
            }

            XmlMapper mapper = new XmlMapper();
            return mapper.writeValueAsBytes(posts);
        } catch (Exception e) {
            throw new RuntimeException("Failed to export data to XML", e);
        }
    }
}
