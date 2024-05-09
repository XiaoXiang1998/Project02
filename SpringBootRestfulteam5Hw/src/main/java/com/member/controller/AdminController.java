package com.member.controller;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.service.annotation.GetExchange;

import com.member.model.AdminBean;
import com.member.model.AdminService;
import com.member.model.MemberBean;
import com.member.model.MemberService;

@Controller
public class AdminController {

	@Autowired
	private MemberService mService;

	@Autowired
	private AdminService adService;

	// http://localhost:8080/backstage
	@GetMapping("/backstage")
	public String goToBackstage() {
		return "BackStageLogin";
	}

	// 登入
	@PostMapping("/adminInterface")
	public String adminInterface(@RequestParam("account") String accoun, @RequestParam("password") String password) {
		if (adService.checkAdminLogin(accoun, password)) {
			System.out.println("管理者登入成功");
			return "/member/AdminIndex";
		}
		return null;
	}

	/*--------------------------------------------------基本操作--------------------------------------------------*/
	/* 新增會員資料 */
	@PostMapping("/InsertAdmin")
	public ResponseEntity<Map<String, Object>> insertAction(@RequestParam("account") String account,
			@RequestParam("password") String password, @RequestParam("email") String email,
			@RequestParam("phone") String phone, @RequestParam("name") String name,
			@RequestParam("gender") String gender, @RequestParam("address") String address,
			@RequestParam("photoSticker") MultipartFile mf) throws IllegalStateException, IOException {

		Map<String, Object> response = new HashMap<>();

		LocalDate hiredate = LocalDate.now();
		System.out.println("入職日: " + hiredate);
		/* 抓取檔案名稱 */
		String fileName = mf.getOriginalFilename();
		System.out.println("filename: " + fileName);

		/* 設定檔案路徑 */
		String fileDir = "C:/team5project/SpringBootRestfulteam5Hw/src/main/resources/static/AdminsPic";

		/* 移動檔案 */
		if (fileName != null && fileName.length() > 0) {

			String[] names = fileName.split("\\.");
			String newFileName = account + "." + names[1];
			/* 設定完整路徑 */
			File fileDirPath = new File(fileDir, newFileName);

			String photoSticker = "AdminsPic/" + newFileName;

			AdminBean adBean = new AdminBean(account, password, email, phone, name, gender, address, photoSticker,
					hiredate);

			System.out.println("photo_sticker: " + photoSticker);
			mf.transferTo(fileDirPath);
			if (adService.insert(adBean)) {
				response.put("success", true);
				response.put("message", "新增成功");
				return ResponseEntity.ok(response);
			} else {
				response.put("success", false);
				response.put("message", "新增失敗");
				return ResponseEntity.badRequest().body(response);
			}
		} else {
			AdminBean adBean = new AdminBean(account, password, email, phone, name, gender, address, hiredate);
			if (adService.insert(adBean)) {
				response.put("success", true);
				response.put("message", "新增成功");
				return ResponseEntity.ok(response);
			} else {
				response.put("success", false);
				response.put("message", "新增失敗");
				return ResponseEntity.badRequest().body(response);
			}
		}
	}

	/* 刪除會員資料 */
	@DeleteMapping("/DeleteAdmin/{AID}")
	@ResponseBody
	public void deleteAction(@PathVariable("AID") Integer aid) {
		adService.deleteById(aid);
		System.out.println("刪除成功");
	}

	@PutMapping("/updateAdmin")
	public ResponseEntity<String> updateAdminAction(@RequestParam("aid") Integer aid,
			@RequestParam("account") String account, @RequestParam("password") String password,
			@RequestParam("email") String email, @RequestParam("phone") String phone, @RequestParam("name") String name,
			@RequestParam("gender") String gender, @RequestParam("address") String address,
			@RequestParam("photoSticker") MultipartFile mf, @RequestParam("hiredate") LocalDate hiredate,
			@RequestParam(name = "oldPath", required = false) String op) throws IllegalStateException, IOException {

		String fileDir = "C:/team5project/SpringBootRestfulteam5Hw/src/main/resources/static/AdminsPic";

		/* 抓取檔案名稱 */
		String fileName = mf.getOriginalFilename();
		System.out.println("filename: " + fileName);

		/* 獲取舊路徑 */
		String realOldPath = "C:/team5project/SpringBootRestfulteam5Hw/src/main/resources/static/AdminsPic/" + op;

		/* 檢查是否有上傳檔案 */
		if (fileName != null && fileName.length() > 0) {
			System.out.println("有更新圖片");
			File file = new File(realOldPath);
			/* 刪除舊有檔案 */
			file.delete();
			String[] names = fileName.split("\\.");
			String newFileName = account + "." + names[1];
			/* 設定完整路徑 */
			File fileDirPath = new File(fileDir, newFileName);
			String photo_sticker = "AdminsPic/" + newFileName;
			/*------------------------------------------------------------------------------------------------------------------------------*/
			System.out.println("ID: " + aid);
			System.out.println("帳號: " + account);
			System.out.println("密碼: " + password);
			System.out.println("信箱: " + email);
			System.out.println("電話: " + phone);
			System.out.println("姓名: " + name);
			System.out.println("性別: " + gender);
			System.out.println("住址: " + address);
			System.out.println("註冊時間: " + hiredate);
			System.out.println("舊路徑: " + op);
			/*------------------------------------------------------------------------------------------------------------------------------*/
			AdminBean adBean = new AdminBean(aid, account, password, email, phone, name, gender, address, photo_sticker,
					hiredate);
			adService.update(adBean);

			mf.transferTo(fileDirPath);
			System.out.println("有更新圖片版本更新完成");
		} else {
			/*------------------------------------------------------------------------------------------------------------------------------*/
			System.out.println("ID: " + aid);
			System.out.println("帳號: " + account);
			System.out.println("密碼: " + password);
			System.out.println("信箱: " + email);
			System.out.println("電話: " + phone);
			System.out.println("姓名: " + name);
			System.out.println("性別: " + gender);
			System.out.println("住址: " + address);
			System.out.println("註冊時間: " + hiredate);
			System.out.println("舊路徑: " + op);
			/*------------------------------------------------------------------------------------------------------------------------------*/
			System.out.println("無更新圖片");
			AdminBean adBean = new AdminBean(aid, account, password, email, phone, name, gender, address, op, hiredate);
			adService.update(adBean);
			System.out.println("無更新圖片版本更新完成");
		}
		return ResponseEntity.ok("更新成功");
	}

	@GetMapping("/getAllAdmin")
	@ResponseBody
	public List<AdminBean> getAllAdmin() {
		return adService.getAll();
	}

	/*--------------------------------------------------傳送管理員頁面--------------------------------------------------*/
	@GetMapping("/terminationDate")
	@ResponseBody
	public List<Integer> terminationDate() {
		LocalDate today = LocalDate.now();
		int year = today.getYear();
		int month = today.getMonthValue();

		System.out.println(year + " " + month);
		List<Integer> list = new ArrayList<>();
		// 當前回顧幾個月
		int review = 0;
		// 當前回顧到的月份
		int reviewMonth = 0;
		// 提供一個新的計算前一年月份
		int beforeReview = 0;

		for (int time = 5; time > 0; time--) {
			reviewMonth = month - review;
			// 如果都還是大於零就是本年度的月份
			if (reviewMonth > 0) {
				System.out.println("當前年份: " + year + "當前月份: " + reviewMonth);
				list.add(adService.terminationDate(year, reviewMonth));

			} else {
				// 如果已經回顧到去年年份需要減一
				int beforeyear = year - 1;
				reviewMonth = 12 - beforeReview;
				System.out.println("當前年份: " + beforeyear + "當前月份: " + reviewMonth);
				list.add(adService.terminationDate(beforeyear, reviewMonth));
				beforeReview++;
			}
			// 往前回顧幾個月
			review += 1;
			System.out.println("當前往前回顧" + review + "個月");
		}
		// 反轉列表
		Collections.reverse(list);
		return list;
	}

	/*--------------------------------------------------傳送會員頁面--------------------------------------------------*/
	// 提供柱狀圖資料
	@GetMapping("/headcount")
	@ResponseBody
	public List<Integer> headcount() {

		List<Integer> list = new ArrayList<>();

		for (int level = 1; level < 6; level++) {
			System.out.println("level = " + level);
			list.add(mService.headcount(level));
		}
		return list;
	}

	// 提供摺線圖
	@GetMapping("/registerCount")
	@ResponseBody
	public List<Integer> registrationCount() {
		LocalDate today = LocalDate.now();
		int year = today.getYear();
		int month = today.getMonthValue();

		System.out.println(year + " " + month);
		List<Integer> list = new ArrayList<>();
		// 當前回顧幾個月
		int review = 0;
		// 當前回顧到的月份
		int reviewMonth = 0;
		// 提供一個新的計算前一年月份
		int beforeReview = 0;

		for (int time = 5; time > 0; time--) {
			reviewMonth = month - review;
			// 如果都還是大於零就是本年度的月份
			if (reviewMonth > 0) {
				System.out.println("當前年份: " + year + "當前月份: " + reviewMonth);
				list.add(mService.registrationCount(year, reviewMonth));

			} else {
				// 如果已經回顧到去年年份需要減一
				int beforeyear = year - 1;
				reviewMonth = 12 - beforeReview;
				System.out.println("當前年份: " + beforeyear + "當前月份: " + reviewMonth);
				list.add(mService.registrationCount(beforeyear, reviewMonth));
				beforeReview++;
			}
			// 往前回顧幾個月
			review += 1;
			System.out.println("當前往前回顧" + review + "個月");
		}
		// 反轉列表
		Collections.reverse(list);
		return list;
	}

	/* 會員DataTable */
	@GetMapping("/adminGetAllMember")
	@ResponseBody
	public List<MemberBean> dataTable() {
		return mService.getAll();
	}

	/*--------------------------------------------------導覽列跳轉頁面--------------------------------------------------*/
	@GetMapping("/AdminIndex")
	public String turnToMemberManagement() {
		return "/member/AdminIndex";
	}

	@GetMapping("/AdminManagement")
	public String turnToAdminManagement() {
		return "/member/AdminManagement";
	}

	@GetMapping("/AdminInsert")
	public String turnToAdminInsert() {
		return "/member/AdminInsert";
	}

	@GetMapping("/MembershipLevelGuidelines")
	public String turnToMembershipLevelGuidelines() {
		return "/member/MembershipLevelGuidelines";
	}
}
