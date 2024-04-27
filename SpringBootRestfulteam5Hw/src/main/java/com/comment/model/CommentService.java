package com.comment.model;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class CommentService {
	
	@Autowired
	private CommentRepository cRpos;	
	
	public Comment insert(Comment com) {
		return cRpos.save(com);
	}
	
	public Comment Update(Comment com) {
	    Optional<Comment> existingComment = cRpos.findById(com.getCommentId());
	    if (existingComment.isPresent()) {
	        Comment oldComment = existingComment.get();
	        if (com.getCommentContent() != null) {
	            oldComment.setCommentContent(com.getCommentContent());
	        }
	        if(com.getLastModifiedTime()!=null) {
	        	oldComment.setLastModifiedTime(com.getLastModifiedTime());
	        }

	        return cRpos.save(oldComment);
	    } else {
	        // 如果找不到該評論，則可能需要處理此情況
	        // 例如拋出異常或返回null
	        return null;
	    }
	}
	
	public void deleteById(Integer id) {
		 cRpos.deleteById(id);
	}
	
	
	public Comment getById(Integer id) {
		 Optional<Comment> op1 = cRpos.findById(id);
		 if(op1.isPresent()) {
			 return op1.get();
		 }
		 
		 return null;
	}
	public List<Comment> getAll(){
		return cRpos.findAll();
	}

	public List<Comment> findByNameLike(String commentContent) {
		return cRpos.findBycommentContentLike(commentContent);
	}
	
	
	
}
