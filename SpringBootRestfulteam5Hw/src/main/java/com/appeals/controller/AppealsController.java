package com.appeals.controller;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import org.springframework.ui.Model;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfiguration;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.appeals.model.Appeals;
import com.appeals.model.AppealsService;
import com.comment.model.Post;
import com.comment.model.PostService;
import com.good.controller.GoodFormatService;
import com.good.controller.GoodImageService;
import com.good.controller.GoodService;
import com.member.model.MemberBean;
import com.member.model.MemberService;
import com.sean.model.CarItemService;
import com.sean.model.PaymentDetails;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.servlet.http.HttpSession;


@Controller

public class AppealsController {

	@Autowired
	private AppealsService appealsService;
	/*猶能又的程式*/
	@Autowired
	private GoodService gService;
	@Autowired
	private GoodImageService giService;
	@Autowired
	private HttpSession session;
	@Autowired
	private MemberService mService;
	@Autowired
	private GoodFormatService gfService;
	@PersistenceContext
	private EntityManager entityManager;
	@Autowired
	private Post post;

	@Autowired
	private PostService pService;
	
	@Autowired
	private CarItemService cService;
	/*猶能又的程式*/
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
	public String insertAppealsPage(Model m) {
		/*猶能佑的程式*/
//		MemberBean memberBean= (MemberBean) session.getAttribute("member");
//		Set<PaymentDetails> payments = memberBean.getPayments();
		/*猶能佑的程式*/
		return "Appeals/InsertAppeals";
	}

	// 新增
//	@PostMapping("/insert")
//	public String insertAppeals(@RequestParam("Appeals_name") String appealsName,
//			@RequestParam("Appeals_content") String appealsContent,
//			@RequestParam("Appeals_reason") String appealsReason,
//			@RequestParam("Appeals_order") String appealsOrder,
//			@RequestParam("Appeals_date") String appealsDate,
//			@RequestParam("Appeals_other") String appealsOther/*,
//			@RequestParam("Appeals_state") String appealsState*/
//			) {	
//		Appeals newAppeals = new Appeals(appealsName, appealsContent,  appealsReason,appealsOrder ,appealsDate,appealsOther,"待處理");
//		appealsService.insertAppeals(newAppeals);
//		return "redirect:/appeals/success";
//	}
	
	@PostMapping("/insertcontroller")
	public String insertAppeals(@RequestParam("Appeals_name") String appealsName,//會員編號
	                            @RequestParam("Appeals_content") String appealsContent,
	                            @RequestParam("Appeals_reason") String appealsReason,
	                            @RequestParam("Appeals_order") String appealsOrder,//訂單編號
	                            @RequestParam("Appeals_date") String appealsDate,
	                            @RequestParam("Appeals_other") String appealsOther,
	                            Model model) {
	    Appeals newAppeals = new Appeals(appealsName, appealsContent, appealsReason, appealsOrder, appealsDate, appealsOther, "待處理");
	    Appeals savedAppeals = appealsService.insertAppeals(newAppeals);
	    Integer appealsId = savedAppeals.getAppeals_id(); // 获取生成的 Appeals_id
	    model.addAttribute("appealsId", appealsId); // 添加到模型中
	    return "redirect:/success/" + appealsId; // 重定向到显示页面
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
		return isSuccess ? "redirect:/selectOne/" + appeals.getAppeals_id() : "/appeals/getAll";
	}


	// 删除appeals
	
//	@GetMapping("/delete/{id}")
//	public String deleteAppeals(@PathVariable Integer id) {
//	    appealsService.deleteById(id);
//	    return "redirect:/appeals/getAll";
//	}
	
	@GetMapping("/delete")
	public String deleteAppeals2() {
		return "Appeals/delete2";
	}
	
	 @GetMapping("/delete/{id}")
	    public String deleteAppeals(@PathVariable Integer id) {
	        appealsService.deleteById(id);
	        return "Appeals/delete-success"; 
	 }
	//-------------------------------
	
	@GetMapping("/update2/{id}")
	public String showUpdateForm2(@PathVariable("id") int appealsId, Model model) {
		Appeals appeals = appealsService.selectOne(appealsId);
		model.addAttribute("appeals", appeals);
		return "Appeals/UpdateAppeals2";
	}

	@GetMapping("/update2")
	public String updateAppeals2() {
		return "Appeals/UpdateAppeals2";
	}

	@PostMapping("/updatecontroller2")
	public String updateAppeals2(@ModelAttribute("appeals") Appeals appeals) {
		boolean isSuccess = appealsService.updateAppeals(appeals) != null;
		return isSuccess ? "redirect:/selectOne2/" + appeals.getAppeals_id() : "/appeals/getAll";
	
	    }
	
	
	
	@GetMapping("/selectOne2")
	public String getOneAppeals2() {
		return "Appeals/GetAppeals2";
	}

	// get one
	@GetMapping("/selectOne2/{id}")
	public String getOneAppeals2(@PathVariable Integer id, Model model) {
		Appeals appeal = appealsService.selectOne(id);
		model.addAttribute("appeal", appeal);
		System.out.println(id);
		System.out.println(appeal);
		return "Appeals/GetAppeals2";
	}

	
//	@GetMapping("/delete/{id}")
//    public String deleteAppeals(@PathVariable Integer id, RedirectAttributes redirectAttributes) {
//        appealsService.deleteById(id);
//        redirectAttributes.addFlashAttribute("message", "申訴編號 " + id + " 已成功刪除。");
//        return "redirect:/appeals/getAll";
//    }
	
//		    return "redirect:/appeals/success/" + appealsId; // 重定向到显示页面
	@GetMapping("/success/{id}")
	public String showSuccessPage(@PathVariable Integer id, Model model) {
	    model.addAttribute("appealsId", id);
	    return "Appeals/success";
	}
	
		
    
	}


