package com.comment.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

import org.apache.commons.io.FilenameUtils;
import org.hibernate.sql.Insert;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.web.PageableDefault;
import org.springframework.format.annotation.DateTimeFormat;
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

		if (mf != null && !mf.isEmpty()) {
			String fileName = UUID.randomUUID().toString();

			String fileDir = "C:\\team5project\\SpringBootRestfulteam5Hw\\src\\main\\webapp\\WEB-INF\\commentPicture";

			File fileDirPath = new File(fileDir);
			if (!fileDirPath.exists()) {
				fileDirPath.mkdirs();
			}
			String fileExtension = FilenameUtils.getExtension(mf.getOriginalFilename());
			String uploadedFileName = fileName + "." + fileExtension;

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
		String imagePath = post.getProductphoto();

		if (imagePath != null && !imagePath.isEmpty()) {
			String fileDir = "C:/team5project/SpringBootRestfulteam5Hw/src/main/webapp/WEB-INF/commentPicture"
					+ imagePath;
			File imageFile = new File(fileDir);
			if (imageFile.exists()) {
				imageFile.delete();
			}
		}
		pService.deleteByCommentId(id);

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

		MemberBean memberBean = mService.findById(memberId).orElse(null);
		if (memberBean != null) {
			memberBean.setReviewCount(memberBean.getReviewCount() + 1);
			memberBean.setCumulativeScore(memberBean.getCumulativeScore() + sellerRate);
			mService.insertMember(memberBean);
		}

		return "redirect:sellerComments";
	}

	@GetMapping("/commentadmin")
	public String commentadmin(Model model) {
		List<Post> Posts = pService.getAll();

		model.addAttribute("Post", Posts);

		return "comment/commentadmin";
	}
	/*
	 * @GetMapping("/sellerComments") public String getsellerComments(Model model,
	 * HttpSession session, @RequestParam(defaultValue = "0") int page,
	 * 
	 * @RequestParam(defaultValue = "0") int rating) { MemberBean seller =
	 * (MemberBean) session.getAttribute("member"); System.out.println("ID" +
	 * seller.getSid());
	 * 
	 * Long totalComments = pService.countCommentsBySellerId(seller.getSid());
	 * 
	 * long[] starCounts = new long[5]; for (int i = 1; i <= 5; i++) {
	 * starCounts[i-1] =
	 * pService.countCommentsBySellerIdAndBuyerrate(seller.getSid(), i); }
	 * 
	 * int pageSize = 2;
	 * 
	 * Pageable pageable = PageRequest.of(page, pageSize);
	 * 
	 * Page<Post> sellerComments;
	 * 
	 * if (rating > 0) {
	 * 
	 * sellerComments = pService.findPostsBySellerIdAndRating(seller.getSid(),
	 * rating, pageable); } else {
	 * 
	 * sellerComments = pService.findPostsBySellerId(seller.getSid(), pageable); }
	 * 
	 * model.addAttribute("comments", sellerComments.getContent());
	 * model.addAttribute("currentPage", sellerComments.getNumber()); // 注意: Spring
	 * Data JPA的頁碼從0開始 model.addAttribute("totalPages",
	 * sellerComments.getTotalPages()); model.addAttribute("rating", rating);
	 * model.addAttribute("totalComments", totalComments);
	 * model.addAttribute("starCounts", starCounts);
	 * 
	 * List<Integer> repliedCommentIds =
	 * pService.findRepliedCommentIdsBySellerId(seller.getSid());
	 * model.addAttribute("repliedCommentIds", repliedCommentIds);
	 * 
	 * 
	 * 
	 * return "comment/sellerReplay"; }
	 */

	@GetMapping("/sellerComments")
	public String getSellerComments(Model model, HttpSession session, @RequestParam(defaultValue = "0") int page,
			@RequestParam(defaultValue = "0") int rating, @RequestParam(defaultValue = "") String productName,
			@RequestParam(defaultValue = "") String productSpec, @RequestParam(defaultValue = "") String userName,
			@RequestParam(defaultValue = "") @DateTimeFormat(pattern = "yyyy-MM-dd") Date commentTime) {
		MemberBean seller = (MemberBean) session.getAttribute("member");
		System.out.println("ID" + seller.getSid());
		System.out.println("Page: " + page);
		System.out.println("Rating: " + rating);
		System.out.println("Product Name: " + productName);
		System.out.println("Product Spec: " + productSpec);
		System.out.println("User Name: " + userName);
		System.out.println("Comment Time: " + commentTime);
		Long totalComments = pService.countCommentsBySellerId(seller.getSid());

		long[] starCounts = new long[5];
		for (int i = 1; i <= 5; i++) {
			starCounts[i - 1] = pService.countCommentsBySellerIdAndBuyerrate(seller.getSid(), i);
		}

		int pageSize = 2;
		Pageable pageable = PageRequest.of(page, pageSize);

		Page<Post> sellerComments;

		if (productName.isEmpty() && productSpec.isEmpty() && userName.isEmpty() && commentTime == null) {
			if (rating > 0) {
				sellerComments = pService.findPostsBySellerIdAndRating(seller.getSid(), rating, pageable);
			} else {
				sellerComments = pService.findPostsBySellerId(seller.getSid(), pageable);
			}
		} else {
			Timestamp commentTimeStart = null;
			Timestamp commentTimeEnd = null;
			if (commentTime != null) {
				Calendar cal = Calendar.getInstance();
				cal.setTime(commentTime);
				cal.set(Calendar.HOUR_OF_DAY, 0);
				cal.set(Calendar.MINUTE, 0);
				cal.set(Calendar.SECOND, 0);
				cal.set(Calendar.MILLISECOND, 0);
				commentTimeStart = new Timestamp(cal.getTimeInMillis());

				cal.add(Calendar.DAY_OF_MONTH, 1);
				commentTimeEnd = new Timestamp(cal.getTimeInMillis());
			}
			sellerComments = pService.searchByConditions(seller.getSid(), productName, productSpec, userName,
					commentTimeStart, commentTimeEnd, pageable);
		}

		model.addAttribute("comments", sellerComments.getContent());
		model.addAttribute("currentPage", sellerComments.getNumber()); // 注意: Spring Data JPA的頁碼從0開始
		model.addAttribute("totalPages", sellerComments.getTotalPages());
		model.addAttribute("rating", rating);
		model.addAttribute("totalComments", totalComments);
		model.addAttribute("starCounts", starCounts);

		List<Integer> repliedCommentIds = pService.findRepliedCommentIdsBySellerId(seller.getSid());
		model.addAttribute("repliedCommentIds", repliedCommentIds);

		return "comment/sellerReplay";
	}

	/*
	 * @GetMapping("/sellerCommentsForUser") public String
	 * getSellerCommentsForUser(Model model, HttpSession session) { MemberBean user
	 * = (MemberBean) session.getAttribute("member"); int reviewCount =
	 * user.getReviewCount(); int cumulativeScore = user.getCumulativeScore();
	 * 
	 * int avergeScore = cumulativeScore / reviewCount;
	 * 
	 * List<Post> userComments = user.getPosts();
	 * 
	 * List<Post> sellerComments = new ArrayList<>();
	 * 
	 * for (Post comment : userComments) { Integer userCommentId =
	 * comment.getCommentid(); List<Post> sellerReplies =
	 * pService.getSellerCommentsForUser(userCommentId);
	 * sellerComments.addAll(sellerReplies); }
	 * 
	 * List<Integer> ratingCounts = new ArrayList<>(Collections.nCopies(6, 0)); for
	 * (Post comment : sellerComments) { int rating = comment.getSellerrate();
	 * ratingCounts.set(rating, ratingCounts.get(rating) + 1); }
	 * 
	 * int totalCommentsCount = sellerComments.size();
	 * 
	 * model.addAttribute("avergeScore", avergeScore);
	 * model.addAttribute("sellerComments", sellerComments);
	 * model.addAttribute("ratingCounts", ratingCounts);
	 * model.addAttribute("totalCommentsCount", totalCommentsCount);
	 * 
	 * return "comment/sellercommentforuser"; }
	 */
	@GetMapping("/sellerCommentsForUser")
	public String getSellerCommentsForUser(Model model, HttpSession session, @RequestParam(defaultValue = "0") int page,
			@RequestParam(defaultValue = "0") int rating) {
		MemberBean user = (MemberBean) session.getAttribute("member");

		int pageSize = 2;

		List<Post> userComments = user.getPosts();
		List<Integer> commentIds = userComments.stream().map(Post::getCommentid).collect(Collectors.toList());

		Page<Post> sellerComments;

		List<Long> ratingCounts = pService.countSellerCommentsByRatings(commentIds);
		long totalElements = 0;
		if (rating > 0) {
			sellerComments = pService.getSellerCommentsByRatingWithPagination(commentIds, rating,
					PageRequest.of(page, pageSize));
		} else {
			sellerComments = pService.findSellerCommentsForUserWithPagination(commentIds,
					PageRequest.of(page, pageSize));
			totalElements = sellerComments.getTotalElements();
		}

		model.addAttribute("comments", sellerComments.getContent());
		model.addAttribute("currentPage", sellerComments.getNumber()); // 注意: Spring Data JPA的页码从0开始
		model.addAttribute("totalPages", sellerComments.getTotalPages());
		model.addAttribute("ratingCounts", ratingCounts);
		model.addAttribute("selectedRating", rating);
		model.addAttribute("totalCommentsCount", totalElements);

		return "comment/replyforbuyer";
	}

	@GetMapping("/repliedComments")
	public String getRepliedComments(Model model, HttpSession session, @RequestParam(defaultValue = "0") int page) {
		MemberBean seller = (MemberBean) session.getAttribute("member");
		int sellerId = seller.getSid();

		int pageSize = 3;

		Pageable pageable = PageRequest.of(page, pageSize);

		Page<Post> repliedComments = pService.findRepliedCommentsBySellerId(sellerId, pageable);

		List<Post> sellerCommentsForUser = pService.findBuyerCommentsRepliedBySeller();
		model.addAttribute("repliedComments", repliedComments.getContent());
		model.addAttribute("currentPage", repliedComments.getNumber()); // 注意：Spring Data JPA的页码从0开始
		model.addAttribute("totalPages", repliedComments.getTotalPages());
		model.addAttribute("sellerCommentsForUser", sellerCommentsForUser);

		return "comment/repliedComments";
	}

	@GetMapping("/goodDetailPosts")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> getGoodDetailPosts(@RequestParam("GoodID") Integer goodID,
	                                                              @RequestParam(defaultValue = "0") Integer page,
	                                                              @RequestParam(defaultValue = "2") Integer size,
	                                                              @RequestParam(required = false) Integer rate,
	                                                              @RequestParam(required = false) Boolean content,
	                                                              @RequestParam(required = false) Boolean photos) {
	    Pageable pageable = PageRequest.of(page, size);
	    Page<Post> resultPage;

	    // 查詢所有評分對應的數量
	    List<Long> rateCounts = new ArrayList<>();
	    if (rate == null) {
	        for (int i = 5; i >= 1; i--) {
	            long count = pService.getPostsByGoodIdAndRate(goodID, i, Pageable.unpaged()).getTotalElements();
	            rateCounts.add(count);
	        }
	    }

	    // 查詢有留言內容的數量
	    long contentCount = pService.findPostsByGoodIdWithContent(goodID, Pageable.unpaged()).getTotalElements();

	    // 查詢附上照片的數量
	    long photosCount = pService.findPostsByGoodIdWithPhotos(goodID, Pageable.unpaged()).getTotalElements();

	    // 查詢全部評價的數量
	    long totalPostsCount = pService.getPostsByGoodId(goodID, Pageable.unpaged()).getTotalElements();

	    // 根據條件篩選評論
	    if (rate != null) {
	        resultPage = pService.getPostsByGoodIdAndRate(goodID, rate, pageable);
	    } else if (content != null && content) {
	        resultPage = pService.findPostsByGoodIdWithContent(goodID, pageable);
	    } else if (photos != null && photos) {
	        resultPage = pService.findPostsByGoodIdWithPhotos(goodID, pageable);
	    } else {
	        resultPage = pService.getPostsByGoodId(goodID, pageable);
	    }

	    Map<String, Object> response = new HashMap<>();
	    response.put("posts", resultPage.getContent());
	    response.put("totalPages", resultPage.getTotalPages());
	    response.put("currentPage", resultPage.getNumber());
	    response.put("rateCounts", rateCounts);
	    response.put("contentCount", contentCount);
	    response.put("photosCount", photosCount);
	    response.put("totalPostsCount", totalPostsCount);
	    
	    return ResponseEntity.ok(response);
	}

}
