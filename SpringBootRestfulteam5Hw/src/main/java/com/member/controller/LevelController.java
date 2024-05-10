package com.member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.member.model.LevelBean;
import com.member.model.LevelService;

@Controller
public class LevelController {

	@Autowired
	private LevelService lService;
	
/*--------------------------------------------------基本操作--------------------------------------------------*/
	/*新增等級制度*/
	@PostMapping("/InsertLevel")
	public ResponseEntity<Map<String, Object>> insertLevel(@RequestParam("level") Integer level,@RequestParam("title") String title ,@RequestParam("threshold") Integer threshold){
		Map<String, Object> response = new HashMap<>();
		LevelBean levelBean = new LevelBean(level,title,threshold);
		if (lService.insert(levelBean)) {
			response.put("success", true);
			response.put("message", "新增成功");
			return ResponseEntity.ok(response);
		} else {
			response.put("success", false);
			response.put("message", "新增失敗");
			return ResponseEntity.badRequest().body(response);
		}
	}
	
	/*刪除會員制度*/
	@DeleteMapping("/DeleteLevel/{level}")
	@ResponseBody
	public void deleteLevel(@PathVariable("level") Integer level) {
		lService.deleteById(level);
		System.out.println("刪除成功");
	}
		
	/*更新會員制度*/
	@PutMapping("/UpdateLevel")
	public ResponseEntity<Map<String, Object>> updateLevel(@RequestParam("level") Integer level,@RequestParam("title") String title ,@RequestParam("threshold") Integer threshold){
		Map<String, Object> response = new HashMap<>();
		LevelBean levelBean = new LevelBean(level,title,threshold);
		if (lService.insert(levelBean)) {
			response.put("success", true);
			response.put("message", "更新成功");
			return ResponseEntity.ok(response);
		} else {
			response.put("success", false);
			response.put("message", "更新失敗");
			return ResponseEntity.badRequest().body(response);
		}
	}
	
	/*查詢全部*/
	@GetMapping("/getAllLevel")
	@ResponseBody
	public List<LevelBean> getAllLevel(){
		return lService.getAll();
	}
}
