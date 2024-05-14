package com.member.controller;

import java.io.File;
import java.io.IOException;
import java.security.GeneralSecurityException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

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
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken.Payload;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.gson.GsonFactory;
import com.member.model.MailService;
import com.member.model.MemberBean;
import com.member.model.MemberService;
import com.member.model.ResetTokenBean;
import com.member.model.ResetTokenService;
import com.util.tokenGenerator.TokenService;

import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpSession;

@Controller
public class MemberController {

	@Autowired
	private MemberService mService;

	@Autowired
	private MailService mailService;

	@Autowired
	private HttpSession httpSession;

	@Autowired
	private ResetTokenService rtService;

	@Autowired
	private TokenService tokenService;

	// http://localhost:8081/ezbuy.com
	@GetMapping("/ezbuy.com")
	public String loginPage() {
		return "Login";
	}

	// http://localhost:8081/ezbuy.admin.com
	@GetMapping("/ezbuy.admin.com")
	public String backStage() {
		return "BackStageLogin";
	}
	/*------------------------------------------------基本資料操作-----------------------------------------------------*/

	/* 新增會員資料 */
	@PostMapping("/InsertMember")
	public ResponseEntity<String> insertAction(@RequestParam("Account") String account,
			@RequestParam("Password") String password, @RequestParam("Name") String name,
			@RequestParam("Email") String email, @RequestParam("Phone") String phone,
			@RequestParam("Gender") String gender, @RequestParam("Address") String address,
			@RequestParam("Seller") boolean seller, @RequestParam("Photo_Sticker") MultipartFile mf)
			throws IllegalStateException, IOException {

		/* 抓取檔案名稱 */
		String fileName = mf.getOriginalFilename();
		System.out.println("filename: " + fileName);

		/* 設定檔案路徑 */
		String fileDir = "C:/team5project/SpringBootRestfulteam5Hw/src/main/resources/static/UsersPic";

		/* 移動檔案 */
		if (fileName != null && fileName.length() > 0) {

			String[] names = fileName.split("\\.");
			String newFileName = account + "." + names[1];
			/* 設定完整路徑 */
			File fileDirPath = new File(fileDir, newFileName);

			String photo_sticker = "UsersPic/" + newFileName;

			MemberBean memBean = new MemberBean(account, password, email, phone, name, gender, address, photo_sticker,
					seller);

			System.out.println("photo_sticker: " + photo_sticker);
			mf.transferTo(fileDirPath);
			mService.insert(memBean);
		} else {
			MemberBean memBean = new MemberBean(account, password, email, phone, name, gender, address, seller);
			mService.insert(memBean);
		}
		System.out.println("新增成功");
		return ResponseEntity.ok("新增成功");
	}

	/* 刪除會員資料 */
	@DeleteMapping("/DeleteMember/{SID}")
	@ResponseBody
	public void deleteAction(@PathVariable("SID") Integer sid) {
		mService.deleteById(sid);
		System.out.println("刪除成功");
//		return "redirect:/showAllMember";
	}

	/* 修改會員資料 */
	@PutMapping("/UpdateMember")
	public ResponseEntity<String> updateAction(@RequestParam("sid") Integer sid,
			@RequestParam("account") String account, @RequestParam("password") String password,
			@RequestParam("email") String email, @RequestParam("phone") String phone, @RequestParam("name") String name,
			@RequestParam("gender") String gender, @RequestParam("address") String address,
			@RequestParam("photoSticker") MultipartFile mf, @RequestParam("seller") boolean seller,
			@RequestParam("reviewCount") Integer reviewCount, @RequestParam("cumulativeScore") Integer cumulativeScore,
			@RequestParam("totalSalesAmount") Integer totalSalesAmount, @RequestParam("level") Integer level,
			@RequestParam("thirdPartyProvider") String thirdPartyProvider,
			@RequestParam("registrationTime") LocalDate registrationTime,
			@RequestParam(name = "oldPath", required = false) String op) throws IllegalStateException, IOException {

		String fileDir = "C:/team5project/SpringBootRestfulteam5Hw/src/main/resources/static/UsersPic";

		/* 抓取檔案名稱 */
		String fileName = mf.getOriginalFilename();
		System.out.println("filename: " + fileName);

		/* 獲取舊路徑 */
		String realOldPath = "C:/team5project/SpringBootRestfulteam5Hw/src/main/resources/static/UsersPic/" + op;

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
			String photo_sticker = "UsersPic/" + newFileName;

			/*------------------------------------------------------------------------------------------------------------------------------*/
			System.out.println("ID: " + sid);
			System.out.println("帳號: " + account);
			System.out.println("密碼: " + password);
			System.out.println("信箱: " + email);
			System.out.println("電話: " + phone);
			System.out.println("賣家: " + seller);
			System.out.println("姓名: " + name);
			System.out.println("性別: " + gender);
			System.out.println("住址: " + address);
			System.out.println("被評論數: " + reviewCount);
			System.out.println("總評分數: " + cumulativeScore);
			System.out.println("總消費金額: " + totalSalesAmount);
			System.out.println("會員級別: " + level);
			System.out.println("登入方式: " + thirdPartyProvider);
			System.out.println("註冊時間: " + registrationTime);
			System.out.println("舊路徑: " + op);
			/*------------------------------------------------------------------------------------------------------------------------------*/
			MemberBean memBean = new MemberBean(sid, account, password, email, phone, name, gender, address,
					photo_sticker, seller, reviewCount, cumulativeScore, totalSalesAmount, level, thirdPartyProvider,
					registrationTime);
			mService.update(memBean);
			mf.transferTo(fileDirPath);
			System.out.println("有更新圖片版本更新完成");
		} else {
			/*------------------------------------------------------------------------------------------------------------------------------*/
			System.out.println("ID: " + sid);
			System.out.println("帳號: " + account);
			System.out.println("密碼: " + password);
			System.out.println("信箱: " + email);
			System.out.println("電話: " + phone);
			System.out.println("姓名: " + name);
			System.out.println("性別: " + gender);
			System.out.println("賣家: " + seller);
			System.out.println("住址: " + address);
			System.out.println("被評論數: " + reviewCount);
			System.out.println("總評分數: " + cumulativeScore);
			System.out.println("總消費金額: " + totalSalesAmount);
			System.out.println("會員級別: " + level);
			System.out.println("登入方式: " + thirdPartyProvider);
			System.out.println("註冊時間: " + registrationTime);
			System.out.println("舊路徑: " + op);
			/*------------------------------------------------------------------------------------------------------------------------------*/
			System.out.println("無更新圖片");
			MemberBean memBean = new MemberBean(sid, account, password, email, phone, name, gender, address, op, seller,
					reviewCount, cumulativeScore, totalSalesAmount, level, thirdPartyProvider, registrationTime);
			mService.update(memBean);
			System.out.println("無更新圖片版本更新完成");
		}
		return ResponseEntity.ok("更新成功");
	}

	/* 顯示所有會員資料 */
	@GetMapping("/showAllMember")
	public String showMembers(Model m) {
		m.addAttribute("members", mService.getAll());
		return "/WEB-INF/member/GetAllMembers";
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
		return "/WEB-INF/member/GetAllMembers";

	}

	/*------------------------------------------------登入操作-----------------------------------------------------*/

	/* 回到adminUI */
	@PostMapping("/backToAdminUI")
	public String backToAdminUI() {
		return "/WEB-INF/member/AdminUI";
	}

	/* 登入機制 */
	@PostMapping("/MemberLogin.controller")
	public String LoginReponse(@RequestParam("username") String account, @RequestParam("password") String userPwd) {
		if (mService.checkLogin(account, userPwd)) {
			System.out.println("登入成功");
			// 儲存登入會員的bean物件
			MemberBean memberInformation = mService.selectByAccountBean(account);
			System.out.println(memberInformation);
			// 設定session
			httpSession.setAttribute("member", memberInformation);
			System.out.println("session設定成功");
			// 檢查會員等級
			return "/good/jsp/EZBuyindex";
		}
		return null;
	}

	@GetMapping("/forgotPassword")
	public String turnToforgotPassword() {
		return "/member/ForgetPassword";
	}

	/*------------------------------------------------第三方登入測試-----------------------------------------------------*/
	/* 指定第三方登入頁面 */
	@GetMapping("/thirdparty.logintest")
	public String testlogin() {
		return "ThirdPartyTest";
	}

	/* 第三方登入獲取參數 */

	@PostMapping("/google.login")
	public String googleLogin(@RequestParam("credential") String credential)
			throws GeneralSecurityException, IOException {
		GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(new NetHttpTransport(), new GsonFactory())
				// Specify the CLIENT_ID of the app that accesses the backend:
				.setAudience(Collections
						.singletonList("892237680262-jsfn5kl8g9a7ks0nj2sh9vgeem2o4tla.apps.googleusercontent.com"))
				// Or, if multiple clients access the backend:
				// .setAudience(Arrays.asList(CLIENT_ID_1, CLIENT_ID_2, CLIENT_ID_3))
				.build();

		// (Receive idTokenString by HTTPS POST)
		// 这里验证登录回调的credential完整性
		GoogleIdToken idToken = verifier.verify(credential);
		Payload payload = idToken.getPayload();
		
		// Get profile information from payload
		String email = payload.getEmail();
		
		// 紀錄金鑰
		String thirdPartyId = payload.getSubject();
		
		// 紀錄何種第三方登入
		String thirdPartyProvider = "Google";
		
		String name = (String) payload.get("name");
		String pictureUrl = (String) payload.get("picture");
//	            String locale = (String) payload.get("locale");
		String familyName = (String) payload.get("family_name");
		String givenName = (String) payload.get("given_name");
		String[] splitAccount = email.split("@");
		String account = splitAccount[0];
		if (idToken != null) {
//	            int level = 1;

			System.out.println("獨家金鑰: " + thirdPartyId);
			System.out.println("第三方登入方式: " + thirdPartyProvider);
			System.out.println("信箱: " + email);
			System.out.println("帳號: " + account);
			System.out.println("全名: " + name);
			System.out.println("照片: " + pictureUrl);
			System.out.println("姓氏: " + givenName);
			System.out.println("名字: " + familyName);

			if (mService.findByAccount(account).isPresent()) {
				if (mService.checkLogin(account, thirdPartyId)) {
					System.out.println("登入成功");
					// 儲存登入會員的bean物件
					MemberBean memberInformation = mService.selectByAccountBean(account);
					System.out.println(memberInformation);
					// 設定session
					httpSession.setAttribute("member", memberInformation);
					System.out.println("session設定成功");
					// 檢查會員等級
					return "/good/jsp/EZBuyindex";
				}
			} else {
				/* 紀錄當前時間 */
				LocalDate now = LocalDate.now();
				System.out.println(now);
				MemberBean memBean = new MemberBean(account, thirdPartyId, email, name, thirdPartyProvider,now);
				mService.insert(memBean);
				System.out.println("有創建帳號");
				return "/good/jsp/EZBuyindex";
			}
		} 
		return "失敗";
	}

	/*------------------------------------------------忘記密碼功能-----------------------------------------------------*/

	/* 創建忘記密碼的紀錄發送mail且紀錄資料庫 */
	@PostMapping("/forgot-password")
	public ResponseEntity<Map<String, Object>> forgetPassword(@RequestParam("email") String email)
			throws MessagingException {
		Map<String, Object> response = new HashMap<>();

		/* 紀錄當前時間 */
		LocalDateTime now = LocalDateTime.now();

		/* 創建一個Optional物件 */
		Optional<MemberBean> optionalMember = mService.findByEmail(email);

		/* 驗證此email是否存在並回傳布林值 */
		boolean exist = optionalMember.isPresent();

		/* 取得token */
		String token = tokenService.generateToken();

		if (exist) {

			/* 如果此電子信箱有人使用，順便建立memberBean物件以利後續作業 */
			MemberBean member = optionalMember.get();

			/* 創建一個忘記密碼的物件 */
			ResetTokenBean rtBean = new ResetTokenBean();

			System.out.println("忘記密碼的會員編號: " + member.getSid());
			
			/* 存入用戶id */
			rtBean.setUser_id(member.getSid());

			/* 將token設定進去 */
			rtBean.setToken(token);

			/* 設定當前的時間 */
			rtBean.setCreated_at(now);

			/* 新增忘記密碼資料到資料庫 */
			rtService.inserForgetPassword(rtBean);

			mailService.sendResetPasswordEmail(email, token);
			System.out.println("信件已傳送");

			response.put("success", true);
			response.put("message", "重置密碼信件已發送到您的信箱");
			return ResponseEntity.ok(response);
		} else {
			response.put("success", false);
			response.put("message", "此電子信箱不存在");
			return ResponseEntity.badRequest().body(response);
		}
	}

	@GetMapping("/reset-password")
	public String resetPassword(@RequestParam("token") String token) {

		/* 紀錄當前時間 */
		LocalDateTime now = LocalDateTime.now();

		/* 創建一個Optional物件 */
		Optional<ResetTokenBean> optionalToken = rtService.findByToken(token);

		/* 驗證此token是否存在並回傳布林值 */
		boolean exist = optionalToken.isPresent();

		if (exist) {
			/* 如果此資料存在，創建他的bean物件 */
			ResetTokenBean rtBean = optionalToken.get();

			/* 設定session提供後續作使用 */
			httpSession.setAttribute("forgetMember", rtBean);

			/* 紀錄此筆ID */
			Integer thisID = rtBean.getId();

			/* 抓取創建時間 */
			LocalDateTime harvestTime = rtBean.getCreated_at();

			/* 抓取此token資料使否使用過 */
			boolean used = rtBean.isUsed();

			/* 取得當前時間與創建時間之間的時間差 */
			long minutesDifference = ChronoUnit.MINUTES.between(harvestTime, now);

			/* 判斷時間差是否大於15 */
			boolean timeOut = minutesDifference < 15;

			if (timeOut == true) {
				rtService.deleteForgetPassword(thisID);
				return "/member/ResetPassword";
			} else {
				rtService.deleteForgetPassword(thisID);
				return "/member/TimeOut";
			}
		} else {
			return "/member/NotExist";
		}

	}
	
	@PostMapping("/memberResetPassword")
	public String memberResetPassword(@RequestParam("password") String password,@SessionAttribute("forgetMember") ResetTokenBean forgetMember) {
		Integer sid = forgetMember.getUser_id();
		System.out.println("會員ID: " + sid);
		Optional<MemberBean> forgetPasswordMember = mService.findById(sid);
		MemberBean member = forgetPasswordMember.get();
		member.setPassword(password);
		mService.update(member);
		return "Login";
	}

}
