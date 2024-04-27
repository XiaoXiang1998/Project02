package com.comment.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.comment.model.Comment;
import com.comment.model.CommentService;

@Controller
public class CommentCrudController {

	@Autowired
	private CommentService cService;

	@PostMapping("/comment")
	public String commentInsertAction(@RequestParam("userName") String userName,
			@RequestParam("userType") String userType, @RequestParam("commentContent") String commentContent,
			@RequestParam("rate") Integer rate, @RequestParam("productimage") MultipartFile mf, Model m)
			throws IllegalStateException, IOException {
		Comment saveBean = new Comment();

		if (mf != null && !mf.isEmpty()) { // 檢查圖片是否不為空
			 String fileName = UUID.randomUUID().toString(); // 生成唯一的文件名

			String fileDir = "C:/Action/workspace/SpringBootRestfulteam5Hw/src/main\\webapp\\WEB-INF\\commentPicture";

			File fileDirPath = new File(fileDir);
			if (!fileDirPath.exists()) {
				fileDirPath.mkdirs();
			}
			
			  String fileExtension = FilenameUtils.getExtension(mf.getOriginalFilename()); // 獲取文件擴展名
		        String uploadedFileName = fileName + "." + fileExtension; // 構造完整的文件名

			File uploadedFile = new File(fileDirPath, uploadedFileName);
			mf.transferTo(uploadedFile);

			saveBean.setProductPhoto("commentPicture/" + uploadedFileName);
		}
		System.out.println(saveBean.getProductPhoto());
		// 設定其他欄位
		long currentTimeMillis = System.currentTimeMillis();
		java.sql.Timestamp currTimestamp = new java.sql.Timestamp(currentTimeMillis);
		saveBean.setUserName(userName);
		saveBean.setUserType(userType);
		saveBean.setCommentContent(commentContent);
		saveBean.setCommentTime(currTimestamp);
		saveBean.setLastModifiedTime(currTimestamp);
		saveBean.setRate(rate);

		// 新增資料
		Comment resultBean = cService.insert(saveBean);
		m.addAttribute("com", resultBean);
		return "comment/InsertComment";
	}

	@GetMapping("/comment")
	public String commentGetAllAction(Model m) {
		List<Comment> findAll = cService.getAll();
		m.addAttribute("coms", findAll);
		return "comment/GetAllComments";
	}

	@GetMapping("/comment/{cid}") // Using {cid} as a path variable
	public String commentGetOneAction(@PathVariable("cid") Integer cid, Model m) {

	    Comment resultBean = cService.getById(cid);
	    if (resultBean != null) {
	        m.addAttribute("com", resultBean);
	        return "comment/GetComment";
	    } else {
	        Map<String, String> errors = new HashMap<>();
	        errors.put("errors", "找不到該筆使用者ID,請重新輸入");
	        m.addAttribute("errors", errors);
	        return "comment/get";
	    }
	}

	@GetMapping("/GetCommentsByUserInput")
	public String searchCommentsByKeyword(@RequestParam("keyword") String keyword, Model model) {

		List<Comment> comments = cService.findByNameLike("%"+keyword+"%");
		if (comments != null && !comments.isEmpty()) {
			model.addAttribute("coms", comments);
			return "comment/GetAllComments";
		} else {
			Map<String, String> errors = new HashMap<String, String>();
			errors.put("errors", "找不到對應的關鍵字,請重新輸入");
			model.addAttribute("errors", errors);
			return "comment/userInput";
		}
	}

	@DeleteMapping("/comment/{cid}")
	public String deleteCommentAction(@PathVariable("cid") Integer cid, RedirectAttributes redirectAttributes) {
		cService.deleteById(cid);
		System.out.println("刪除成功" + cid);
		redirectAttributes.addFlashAttribute("message", "Comment deleted successfully");
		return "redirect:/comment";
	}

	@PutMapping("/comment/{cid}")
	public String updateCommentAction(@PathVariable("cid") Integer cid,
			@RequestParam("commentContent") String comment, RedirectAttributes redirectAttributes) {

		long currentTimeMillis = System.currentTimeMillis();
		java.sql.Timestamp currTimestamp = new java.sql.Timestamp(currentTimeMillis);
		Comment com = new Comment(cid,comment,currTimestamp);
		cService.Update(com);
		redirectAttributes.addFlashAttribute("message", "Comment updated successfully");
		return "redirect:/comment";
	}

}
