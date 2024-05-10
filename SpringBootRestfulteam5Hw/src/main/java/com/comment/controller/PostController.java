package com.comment.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
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
import com.member.model.MemberService;
import com.sean.model.Orders;
import com.sean.model.OrdersService;
import com.comment.model.PostMemberService;
import com.comment.model.Post;
import com.comment.model.PostService;
import com.good.controller.GoodService;
import com.good.model.GoodsBean2;

import org.springframework.data.domain.Pageable;

import jakarta.servlet.http.HttpSession;

@Controller
public class PostController {
	@Autowired
	private PostService pService;

	@Autowired
	private PostMemberService mService;
	@Autowired
	private OrdersService oService;

	@Autowired
	private MemberService memberService;

	@Autowired
	private GoodService gService;


	@PostMapping("/post")
	public String postAction(@RequestParam(value = "commentContent", required = false) String commentContent,
			@RequestParam("commentId") Integer orderId, @RequestParam("productimage") MultipartFile mf,
			@RequestParam("rate") int rate, HttpSession session) throws IllegalStateException, IOException {
		MemberBean member = (MemberBean) session.getAttribute("member");
		System.out.println(orderId);

		Orders orders = oService.getById(orderId);

		GoodsBean2 good = orders.getFormatgoodId().getGood();

		Post post = new Post();

		if (mf != null && !mf.isEmpty()) { // 檢查圖片是否不為空
			String fileName = UUID.randomUUID().toString(); // 生成唯一的文件名

			String fileDir = "C:\\team5project\\SpringBootRestfulteam5Hw\\src\\main\\webapp\\WEB-INF\\commentPicture";

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
		post.setOrders(orders);
		pService.insert(post);

		if (good != null) {
			if (good.getNumberRatings() == null) {
				good.setNumberRatings(0);
			}
			if (good.getRating() == null) {
				good.setRating(0);
			}
			good.setNumberRatings(good.getNumberRatings() + 1);
			good.setRating(good.getRating() + rate);
			gService.update(good);

			MemberBean seller = good.getGoodsSellerID();
			if (seller != null) {

				seller.setReviewCount(seller.getReviewCount() + 1);
				seller.setCumulativeScore(seller.getCumulativeScore() + rate);
				memberService.update(member);
			}
		}

		return "redirect:indexcomment";
	}

	@GetMapping("/userComments")
	public String getUserComments(Model model, HttpSession session, @RequestParam(defaultValue = "0") int page) {
		MemberBean member = (MemberBean) session.getAttribute("member");
		Pageable pageable = PageRequest.of(page, 5);

		Page<Post> userComments = pService.findByMemberOrderByCommenttimeDesc(member, pageable);

		List<Post> userReplies = new ArrayList<>();
		for (Post comment : userComments.getContent()) {
			if (comment.getCommentid() != null) {
				List<Post> replies = pService.findRepliesByRepliedCommentId(comment.getCommentid());
				userReplies.addAll(replies);
			}
		}

		model.addAttribute("comments", userComments.getContent());
		model.addAttribute("replies", userReplies);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", userComments.getTotalPages());

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
			String fileDir = "C:/team5project/SpringBootRestfulteam5Hw/src/main/webapp/WEB-INF/commentPicture/"
					+ imagePath;
			File imageFile = new File(fileDir);
			if (imageFile.exists()) {
				imageFile.delete();
			}
		}

		pService.deleteById(id);

		return new ResponseEntity<>("評論已成功刪除", HttpStatus.OK);
	}

	@PutMapping("/post/{pid}")
	public ResponseEntity<String> updateAction(@PathVariable("pid") Integer pid,
			@RequestParam("commentContent") String commentContent) {
		long currentTimeMillis = System.currentTimeMillis();
		java.sql.Timestamp currTimestamp = new java.sql.Timestamp(currentTimeMillis);
		Post post = new Post(pid, commentContent, currTimestamp);
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
			@RequestParam("replyContent") String replyContent, @RequestParam("rate") Integer sellerRate,
			@RequestParam("commentId") Integer commentId, HttpSession session, Model model) {
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

		// 将已回复评论的ID添加到列表中

		// 更新會員信息
		MemberBean memberBean = mService.findById(memberId).orElse(null);
		if (memberBean != null) {
			// 更新被評論分數和累積次數
			memberBean.setReviewCount(memberBean.getReviewCount() + 1);
			memberBean.setCumulativeScore(memberBean.getCumulativeScore() + sellerRate);
			mService.insertMember(memberBean);// 使用 save 方法來更新會員信息
		}

		return "redirect:sellerComments";
	}

	@GetMapping("/commentadmin")
	public String commentadmin(Model model) {
		List<MemberBean> allMembersWithPosts = mService.getAllMembersWithPosts();

		model.addAttribute("allMembers", allMembersWithPosts);

		return "comment/commentadmin";
	}

	@GetMapping("/sellerComments")
	public String getsellerComments(Model model, HttpSession session, @RequestParam(defaultValue = "0") int page,
			@RequestParam(defaultValue = "0") int rating) {
		// 從會話中獲取當前登入的賣家
		MemberBean seller = (MemberBean) session.getAttribute("member");
		System.out.println("ID" + seller.getSid());

		// 設定每頁顯示的資料筆數
		int pageSize = 2;

		// 使用Pageable對象進行分頁查詢
		Pageable pageable = PageRequest.of(page, pageSize);

		Page<Post> sellerComments;

		if (rating > 0) {
			// 根据评分等级筛选评论
			sellerComments = pService.findPostsBySellerIdAndRating(seller.getSid(), rating, pageable);
		} else {
			// 返回全部评论
			sellerComments = pService.findPostsBySellerId(seller.getSid(), pageable);
		}

		// 將查詢結果和分頁相關的資訊添加到模型中
		model.addAttribute("comments", sellerComments.getContent());
		model.addAttribute("currentPage", sellerComments.getNumber()); // 注意: Spring Data JPA的頁碼從0開始
		model.addAttribute("totalPages", sellerComments.getTotalPages());
		model.addAttribute("rating", rating);
		
		// 查询已回复的评论 ID 列表，并将其添加到模型中
	    List<Integer> repliedCommentIds = pService.findRepliedCommentIdsBySellerId(seller.getSid());
	    model.addAttribute("repliedCommentIds", repliedCommentIds);
		// 返回視圖名稱
		
		
		
		return "comment/sellerReplay";
	}

	@GetMapping("/sellerCommentsForUser")
	public String getSellerCommentsForUser(Model model, HttpSession session) {
		// 从 session 中获取当前登录的用户信息
		MemberBean user = (MemberBean) session.getAttribute("member");
		int reviewCount = user.getReviewCount();
		int cumulativeScore = user.getCumulativeScore();

		int avergeScore = cumulativeScore / reviewCount;

		// 获取当前登录用户的所有评论
		List<Post> userComments = user.getPosts();

		List<Post> sellerComments = new ArrayList<>();

		// 遍历用户的评论列表，查找卖家对该评论的回复
		for (Post comment : userComments) {
			Integer userCommentId = comment.getCommentid();
			List<Post> sellerReplies = pService.getSellerCommentsForUser(userCommentId);
			sellerComments.addAll(sellerReplies);
		}
		model.addAttribute("avergeScore", avergeScore);
		model.addAttribute("sellerComments", sellerComments);

		return "comment/sellercommentforuser";
	}

}
