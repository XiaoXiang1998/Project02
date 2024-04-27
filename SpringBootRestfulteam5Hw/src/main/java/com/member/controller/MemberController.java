package com.member.controller;

import java.io.File;
import java.io.IOException;

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

import com.member.model.MemberBean;
import com.member.model.MemberService;

import jakarta.servlet.http.HttpSession;

@Controller
public class MemberController {

	@Autowired
	private MemberService mService;

	@Autowired
	private HttpSession httpSession;

	// http://localhost:8080/ezbuy.com
	@GetMapping("/ezbuy.com")
	public String loginPage() {
		return "../Login";
	}

	/*------------------------------------------------基本資料操作-----------------------------------------------------*/
	
	/* 新增會員資料 */
	@PostMapping("/InsertMember")
	public ResponseEntity<String> insertAction(@RequestParam("Account") String account, @RequestParam("Password") String password,
			@RequestParam("Name") String name, @RequestParam("Email") String email, @RequestParam("Phone") String phone,
			@RequestParam("Gender") String gender, @RequestParam("Address") String address,
			@RequestParam("Seller") boolean seller, @RequestParam("Administrator") boolean administrator,
			@RequestParam("Photo_Sticker") MultipartFile mf) throws IllegalStateException, IOException {
		
		/*抓取檔案名稱*/
		String fileName = mf.getOriginalFilename();
		System.out.println("filename: " + fileName);
		
		/*設定檔案路徑*/
		String fileDir = "C:/Action/workspace/SpringBootRestfulteam5Hw/src/main/resources/static/UsersPic";
		
		/*移動檔案*/ 
		if(fileName != null && fileName.length() > 0) {
			
			String[] names = fileName.split("\\.");
			String newFileName = account + "." + names[1];
			/*設定完整路徑*/
			File fileDirPath = new File(fileDir,newFileName);
			
			String photo_sticker = "UsersPic/" + newFileName;
			
			MemberBean memBean = new MemberBean(account,password,email,phone,name,gender,address,photo_sticker,seller,administrator);
			
			System.out.println("photo_sticker: " + photo_sticker);
			mf.transferTo(fileDirPath);
			mService.insert(memBean);
		} else {
			MemberBean memBean = new MemberBean(account,password,email,phone,name,gender,address,seller,administrator);
			mService.insert(memBean);
		}
		System.out.println("新增成功");
		return ResponseEntity.ok("新增成功");
	}
	
	/*刪除會員資料*/
	@DeleteMapping("/DeleteMember/{SID}")
	@ResponseBody
	public void deleteAction(@PathVariable("SID") Integer sid) {
		mService.deleteById(sid);
		System.out.println("刪除成功");
//		return "redirect:/showAllMember";
	} 

	/*修改會員資料*/
	@PutMapping("/UpdateMember")
	public ResponseEntity<String> updateAction(@RequestParam("SID") Integer sid,@RequestParam("Account") String account, @RequestParam("Password") String password,
			@RequestParam("Name") String name, @RequestParam("Email") String email, @RequestParam("Phone") String phone,
			@RequestParam("Gender") String gender, @RequestParam("Address") String address,
			@RequestParam("Seller") boolean seller, @RequestParam("Administrator") boolean administrator,
			@RequestParam("Photo_Sticker") MultipartFile mf,@RequestParam("oldPath") String op,@RequestParam("reviewCount") Integer reviewCount,
			@RequestParam("cumulativeScore") Integer cumulativeScore,@RequestParam("totalSalesAmount") Integer totalSalesAmount) throws IllegalStateException, IOException {
		
		
		
		String fileDir = "C:/Action/workspace/SpringBootRestfulteam5Hw/src/main/resources/static/UsersPic";
		
		/*抓取檔案名稱*/
		String fileName = mf.getOriginalFilename();
		System.out.println("filename: " + fileName);
		
		/*獲取舊路徑*/
		String realOldPath = "C:/Action/workspace/SpringBootRestfulteam5Hw/src/main/resources/static/" + op;
		
		/*檢查是否有上傳檔案*/
		if(fileName != null && fileName.length() > 0) {
			System.out.println("有更新圖片");
			File file = new File(realOldPath);
			/*刪除舊有檔案*/
			file.delete();
			String[] names = fileName.split("\\.");
			String newFileName = account + "." + names[1];
			/*設定完整路徑*/
			File fileDirPath = new File(fileDir,newFileName);
			String photo_sticker = "UsersPic/" + newFileName;

			MemberBean memBean = new MemberBean(sid,account,password,email,phone,name,gender,address,photo_sticker,seller,administrator,reviewCount,cumulativeScore,totalSalesAmount);
			mService.update(memBean);
			mf.transferTo(fileDirPath);
			System.out.println("有更新圖片版本更新完成");
		} else {
			System.out.println("無更新圖片");
			MemberBean memBean = new MemberBean(sid,account,password,email,phone,name,gender,address,op,seller,administrator,reviewCount,cumulativeScore,totalSalesAmount);
			mService.update(memBean);
			System.out.println("無更新圖片版本更新完成");
		}
		return ResponseEntity.ok("更新成功");
	}

	
	
	/*顯示所有會員資料*/
	@GetMapping("/showAllMember")
	public String showMembers(Model m) {
		m.addAttribute("members", mService.getAll());
		return "/member/GetAllMembers";
	}
	
	/* 選定搜尋方法 */
	@GetMapping("/SelectFunction")
	public String selectedFunction(@RequestParam("selected") String function, @RequestParam("content") String content,
			Model m) {

		switch (function) {
		case "SelectByName":
			m.addAttribute("members", mService.selectByName(content));
			break;
		case "SelectLikeName":
			m.addAttribute("members", mService.selectLikeName(content));
			break;
		case "SelectByAccount":
			m.addAttribute("members", mService.selectByAccount(content));
			break;
		case "SelectByPhone":
			m.addAttribute("members", mService.selectByPhone(content));
			break;
		}
		return "/member/GetAllMembers";
		
	}
	
	/*------------------------------------------------登入操作-----------------------------------------------------*/
	
	/* 回到adminUI */
	@PostMapping("/backToAdminUI")
	public String backToAdminUI() {
		return "/member/AdminUI";
	}
	
	/*進入adminUI*/
	@GetMapping("/goToAdminUI")
	public String goToAdminUI() {
		return "/member/AdminUI";
	}
	
	/*登入機制*/
	@PostMapping("/MemberLogin.controller")
	public String LoginReponse(@RequestParam("username") String account, @RequestParam("password") String userPwd) {
		if (mService.checkLogin(account, userPwd)) {
			System.out.println("登入成功");
			System.out.println(mService.selectByAccountBean(account));
			httpSession.setAttribute("member",mService.selectByAccountBean(account));
			System.out.println("session設定成功");
			if (mService.adminCheck(account)) {
				System.out.println("具有賣家身分");
				return "ControlUI";
			}
			System.out.println("不具有賣家身分");
		}
		return null;
	}

	@GetMapping("/returnToControlUI")
	public String returnToControlUI() {
		return "ControlUI";
	}
	
	@GetMapping("/logOut")
	public String Logout() {
		httpSession.removeAttribute("member");
		return "redirect:ezbuy.com";
	}
}
