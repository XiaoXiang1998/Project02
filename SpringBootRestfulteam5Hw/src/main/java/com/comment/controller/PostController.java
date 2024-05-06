package com.comment.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.apache.commons.io.FilenameUtils;
import org.hibernate.sql.Insert;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
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
import com.comment.model.PostMemberService;
import com.comment.model.Post;
import com.comment.model.PostService;
import org.springframework.data.domain.Pageable;

import jakarta.servlet.http.HttpSession;

@Controller
public class PostController {
	@Autowired
	private PostService pService;
	
	@Autowired
	private PostMemberService mService;
	
	@PostMapping("/post")
	public String postAction(@RequestParam(value = "commentContent", required = false) String commentContent,@RequestParam("productimage")  MultipartFile mf,@RequestParam("rate") int rate,
            HttpSession session) throws IllegalStateException, IOException {
		MemberBean member = (MemberBean) session.getAttribute("member");
		
		Post post =new Post();
		
		if (mf != null && !mf.isEmpty()) { // 檢查圖片是否不為空
			 String fileName = UUID.randomUUID().toString(); // 生成唯一的文件名

			String fileDir = "D:/Action/workspace/team5project/SpringBootRestfulteam5Hw/src/main\\webapp\\WEB-INF\\commentPicture";

			File fileDirPath = new File(fileDir);
			if (!fileDirPath.exists()) {
				fileDirPath.mkdirs();
			}
	        String fileExtension = FilenameUtils.getExtension(mf.getOriginalFilename()); // 獲取文件擴展名
	        String uploadedFileName = fileName + "." + fileExtension; // 構造完整的文件名


			File uploadedFile = new File(fileDirPath, uploadedFileName);
			mf.transferTo(uploadedFile);

			post.setProductphoto("commentPicture/" + uploadedFileName);
		}
		Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String formattedDateTime = sdf.format(currentTimestamp);
		post.setCommentcontent(commentContent);
		post.setBuyerrate(rate);
		post.setCommenttime(currentTimestamp);
		post.setLastmodifiedtime(currentTimestamp);
		post.setMember(member);
		pService.insert(post);
		
		return "redirect:indexcomment";
	}
	
	@GetMapping("/userComments")
    public String getUserComments(Model model, HttpSession session,@RequestParam(defaultValue = "0") int page) {
		MemberBean member = (MemberBean) session.getAttribute("member");
	    Pageable pageable = PageRequest.of(page, 5); 

        Page<Post> userComments = pService.findByMemberOrderByCommenttimeDesc(member, pageable);
        
        model.addAttribute("comments", userComments.getContent()); // 当前页的评论列表
        model.addAttribute("currentPage", page); // 当前页码
        model.addAttribute("totalPages", userComments.getTotalPages()); // 总页数
        
        return "comment/userComment"; 
    }
	 
	 @DeleteMapping("/post/{pid}")
	 public ResponseEntity<String> deleteAction(@PathVariable("pid") Integer id) {
		    Post post = pService.getById(id);
		    
		    if (post == null) {
		        return new ResponseEntity<>("評論不存在", HttpStatus.NOT_FOUND);
		    }

		    String imagePath = post.getProductphoto();

		    if (imagePath != null && !imagePath.isEmpty()) {
		        String fileDir = "D:/Action/workspace/team5project/SpringBootRestfulteam5Hw/src/main/webapp/WEB-INF/" + imagePath;
		        File imageFile = new File(fileDir);
		        if (imageFile.exists()) {
		            imageFile.delete(); 
		        }
		    }

		    pService.deleteById(id);
		    
		    return new ResponseEntity<>("評論已成功刪除", HttpStatus.OK);
	 }
	 
	 @PutMapping("/post/{pid}")
	 public ResponseEntity<String> updateAction(@PathVariable("pid") Integer pid,@RequestParam("commentContent") String commentContent) {
		 long currentTimeMillis = System.currentTimeMillis();
			java.sql.Timestamp currTimestamp = new java.sql.Timestamp(currentTimeMillis);
			Post post = new Post(pid,commentContent,currTimestamp);
			pService.Update(post);
		     return new ResponseEntity<>("評論已成功修改", HttpStatus.OK);

	 }
	 
	 @GetMapping("/allUsersComments")
	 public String viewAllUsersComments(Model model) {
	     List<MemberBean> allMembersWithPosts = mService.getAllMembersWithPosts();
	     
	     int fiveStarsCount = 0;
	     int fourStarsCount = 0;
	     int threeStarsCount = 0;
	     int twoStarsCount = 0;
	     int oneStarCount = 0;
	     int totalPosts = 0; 
	     int commentedPostsCount = 0;
	     int postsWithImagesCount = 0; 

	     for (MemberBean member : allMembersWithPosts) {
	         for (Post post : member.getPosts()) {
	             Integer buyerrate = post.getBuyerrate();
	             if (buyerrate != null) {
	                 String commentContent = post.getCommentcontent();
	                 if (!commentContent.isEmpty()) {
	                     commentedPostsCount++;
	                 }
	                     switch (buyerrate) {
	                         case 5:
	                             fiveStarsCount++;
	                             break;
	                         case 4:
	                             fourStarsCount++;
	                             break;
	                         case 3:
	                             threeStarsCount++;
	                             break;
	                         case 2:
	                             twoStarsCount++;
	                             break;
	                         case 1:
	                             oneStarCount++;
	                             break;
	                         default:
	                             break;
	                     }
	                     
	                     if (post.getProductphoto() != null && !post.getProductphoto().isEmpty()) {
	                         postsWithImagesCount++;
	                     }
	                 
	                 totalPosts++;
	             }
	         }
	     }

	     model.addAttribute("allMembers", allMembersWithPosts);
	     model.addAttribute("fiveStarsCount", fiveStarsCount);
	     model.addAttribute("fourStarsCount", fourStarsCount);
	     model.addAttribute("threeStarsCount", threeStarsCount);
	     model.addAttribute("twoStarsCount", twoStarsCount);
	     model.addAttribute("oneStarCount", oneStarCount);
	     model.addAttribute("totalPosts", totalPosts); 
	     model.addAttribute("commentedPostsCount", commentedPostsCount);
	     model.addAttribute("postsWithImagesCount", postsWithImagesCount);
	     return "comment/allUsersComments";
	 }
	     
	 
	 @PostMapping("/submitReply")
	    public String submitReply(@RequestParam("memberId") Integer memberId, 
	                              @RequestParam("replyContent") String replyContent,
	                              @RequestParam("rate") Integer sellerRate,
	                              @RequestParam("commentId") Integer commentId, 
	                              HttpSession session) {
			MemberBean member = (MemberBean) session.getAttribute("member");

	        // 保存回复内容
	        Post reply = new Post();
	        reply.setReplayconetnt(replyContent);
	        Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());

			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			String formattedDateTime = sdf.format(currentTimestamp);
	        reply.setReplaytime(currentTimestamp);
	        reply.setSellerrate(sellerRate);
	        reply.setMember(member);
	        
	        
	        reply.setRepliedcommentid(commentId);
	        
	       pService.insert(reply);
	       
	        

	        // 更新會員信息
	        MemberBean memberBean = mService.findById(memberId).orElse(null);
	        if (memberBean != null) {
	            // 更新被評論分數和累積次數
	            member.setReviewCount(member.getReviewCount() + 1);
	            member.setCumulativeScore(member.getTotalSalesAmount() + sellerRate);
	            mService.insertMember(member);
	        }

	        return "redirect:allUsersComments";
	    }
	 
	 @GetMapping("/commentadmin")
		public String commentadmin(Model model) {
	     List<MemberBean> allMembersWithPosts = mService.getAllMembersWithPosts();

		 	
	     model.addAttribute("allMembers", allMembersWithPosts);

	     
			return "comment/commentadmin";
		}
	 
//		@GetMapping("/sellerComments")
//	    public String getsellerComments(Model model, HttpSession session) {
//			MemberBean member = (MemberBean) session.getAttribute("member");
//	        
//	       List<Post> userComments = pService.f(member);
//	        
//	        model.addAttribute("post", userComments);
//	        
//	        return "comment/sellerReplay"; 
//	    }
	
}
