package com.appeals.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import org.springframework.ui.Model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.appeals.model.Appeals;
import com.appeals.model.AppealsService;



@Controller
//@RequestMapping("/appeals")
public class AppealsController {

	@Autowired
	private AppealsService appealsService;

	// 首頁
	@RequestMapping(path = "/Crudindex", method = { RequestMethod.GET, RequestMethod.POST })
	public String appealsMainprocess() {
		return "Appeals/AppealsIndex";
	}

	// 查詢全部
	@GetMapping("/getAll")
	public String getAllAppeals(Model model) {
		List<Appeals> appeals = appealsService.getAll();
		model.addAttribute("appeals", appeals);
		return "Appeals/GetAllAppeals";
	}

	@GetMapping("/selectOne")
	public String getOneAppeals() {
		return "Appeals/GetAppeals";
	}

	// get one
	@GetMapping("/selectOne/{id}")
	public String getOneAppeals(@PathVariable Integer id, Model model) {
		Appeals appeal = appealsService.selectOne(id);
		model.addAttribute("appeal", appeal);
		System.out.println(id);
		System.out.println(appeal);
		return "Appeals/GetAppeals";
	}

	// 新增頁面
	@GetMapping("/insert")
	public String insertAppealsPage() {
		return "Appeals/InsertAppeals";
	}

	// 新增
	@PostMapping("/insert")
	public String insertAppeals(@RequestParam("Appeals_name") String appealsName,
			@RequestParam("Appeals_content") String appealsContent, @RequestParam("Appeals_other") String appealsOther,
			@RequestParam("Appeals_reason") String appealsReason) {
		Appeals newAppeals = new Appeals(appealsName, appealsContent, appealsOther, appealsReason);
		appealsService.insertAppeals(newAppeals);
		return "redirect:/getAll";
	}

	// 更新單筆
	@GetMapping("/update/{id}")
	public String showUpdateForm(@PathVariable("id") int appealsId, Model model) {
		Appeals appeals = appealsService.selectOne(appealsId);
		model.addAttribute("appeals", appeals);
		return "Appeals/UpdateAppeals";
	}

	@PostMapping("/update")
	public String updateAppeals() {
		return "Appeals/UpdateAppeals";
	}

	@PostMapping("/updatecontroller")
	public String updateAppeals(@ModelAttribute("appeals") Appeals appeals) {
		boolean isSuccess = appealsService.updateAppeals(appeals) != null;
		return isSuccess ? "redirect:/selectOne/" + appeals.getAppeals_id() : "/getAll";
	}

	// 删除appeals
	
	@GetMapping("/delete/{id}")
	public String deleteAppeals(@PathVariable Integer id) {
	    appealsService.deleteById(id);
	    return "redirect:/getAll";
	}
	@GetMapping("/appealcontrolUI")
	public String appealcontrolUI() {
		
		return "ControlUI";
	}


}
