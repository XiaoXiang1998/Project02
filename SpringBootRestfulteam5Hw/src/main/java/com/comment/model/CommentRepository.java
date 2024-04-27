package com.comment.model;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;


public interface CommentRepository extends JpaRepository<Comment,Integer> {
	public List<Comment> findBycommentContentLike(String commentContent);

}
