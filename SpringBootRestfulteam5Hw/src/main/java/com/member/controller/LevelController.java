package com.member.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.member.model.LevelBean;
import com.member.model.LevelService;

@Controller
public class LevelController {

	@Autowired
	private LevelService lService;
	
/*--------------------------------------------------基本操作--------------------------------------------------*/

	@GetMapping("/getAllLevel")
	@ResponseBody
	public List<LevelBean> getAllLevel(){
		return lService.getAll();
	}
}
