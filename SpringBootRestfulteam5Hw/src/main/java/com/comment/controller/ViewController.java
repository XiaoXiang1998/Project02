package com.comment.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ViewController {
	
	@GetMapping("/hello")
	@ResponseBody
	public String action() {
		return "java dog";
	}
	
	
	@GetMapping("/indexcomment")
	public String indexAction() {
		return "comment/indexcomment";
	}
	
	@GetMapping("/insertPost")
	public String insert() {
		return "comment/insert";
	}
	
	@GetMapping("/sellercomment")
	public String sellerComment() {
		return "comment/sellercomment";
	}
	
	
	
}
