package com.comment.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ViewController {
	
	@RequestMapping("/index")
	public String processAction() {
		return "comment/index";
	}
	
	@RequestMapping("index.controller")
	public String indexAction() {
		return "redirect:index";
	}
	
	@RequestMapping("/insertcomment")
	public String insertAction() {
		return "comment/insert";
	
	}
	@RequestMapping("/get")
	public String getAction() {
		return "comment/get";
	}
	@RequestMapping("/userInput")
	public String userInputAction() {
		return "comment/userInput";
	}
	@RequestMapping("/GoControlUI")
	public String goCotrolUIAction() {
		return "ControlUI";
	}
}
