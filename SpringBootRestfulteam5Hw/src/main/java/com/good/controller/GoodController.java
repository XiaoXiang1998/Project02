package com.good.controller;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;

import org.hibernate.internal.build.AllowSysOut;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

import com.comment.model.Post;
import com.comment.model.PostService;
import com.good.dto.GoodBasicDto;
import com.good.dto.GoodFormatImageDto;
import com.good.dto.GoodIDDto;
import com.good.dto.GoodPriceDTO;
import com.good.dto.GoodPriceDetailDTO;
import com.good.dto.GoodPricePageDto;
import com.good.dto.GoodTypeDto;
import com.good.dto.GoodTypeIndexDto;
import com.good.model.GoodFormat;
import com.good.model.GoodImageBean;
import com.good.model.GoodsBean2;
import com.member.model.MemberBean;
import com.member.model.MemberService;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class GoodController {
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
	
/////////////////////////////////////////////////////首頁/////////////////////////////////////////////////
	@RequestMapping(value = "/EZBuyIndex", method = {RequestMethod.GET, RequestMethod.POST})// 商品封面照、商品名稱、商品種類、商品評分(全給0星)、價格範圍
	public String EZBuyIndex(HttpServletRequest request, Model m) { // HttpServletRequest request
		// 透過上架日期取得商品
		List<GoodsBean2> findGoodByLaunchDate = gService.findGoodByLaunchDate();
		List<GoodPriceDTO> pricerange = new ArrayList();
		// 透過商品編號 取得價格最大最小值
		for (GoodsBean2 item : findGoodByLaunchDate) {
			int goodID = item.getGoodsID();
			Query<Object[]> resultList = (Query<Object[]>) entityManager.createQuery(
					"select min(gf.goodPrice) AS minprice,max(gf.goodPrice) AS maxprice, g.goodsID AS goodsID from GoodsBean2 g join GoodFormat gf on g.goodsID = gf.good.goodsID where g.goodsID = ?1 group by g.goodsID")
					.setParameter(1, goodID);// 在特定賣家下查詢商品，並取得不同編號下的最大和最小價格
			List<Object[]> item2 = resultList.getResultList();
			for (Object[] item3 : item2) {
				GoodPriceDTO result = new GoodPriceDTO();
				System.out.println(item.getNumberRatings());
				if (item.getNumberRatings() == null) {// 沒人評分
					result.setGoodAVG(0);
				} else {
					int AVG = item.getRating() / item.getNumberRatings();
					result.setGoodAVG(AVG);
				}
				result.setGoodType(item.getGoodsType());
				result.setGoodName(item.getGoodsName());
				result.setTitleImage(item.getTitleImage());
				result.setGoodsID((Integer) item3[2]);
				result.setMaxprice((Integer) item3[1]);
				result.setMinprice((Integer) item3[0]);
				pricerange.add(result);
			}
		}
//		HttpSession session = request.getSession();
//		session.setAttribute("findGoodPriceRange", pricerange);
//		session.setAttribute("GoodNumber", findGoodByLaunchDate.size());
		m.addAttribute("findGoodPriceRange", pricerange);
		m.addAttribute("GoodNumber", findGoodByLaunchDate.size());
		Object count = session.getAttribute("count");
		Object attribute = session.getAttribute("notifications");
		Object attribute2 = session.getAttribute("carItemCount");
		Object attribute3 = session.getAttribute("member");
		System.out.println(count);
		System.out.println(attribute);
		System.out.println(attribute2);
		System.out.println(attribute3);
		for(GoodPriceDTO item:pricerange) {
			System.out.println(item.toString());
		}

		return "good/jsp/EZBuyindex";
	}

	@GetMapping("EZBuyIndexWithoutLogin") // 商品封面照、商品名稱、商品種類、商品評分(全給0星)、價格範圍
	public String EZBuyIndexWithoutLogin(HttpServletRequest request, Model m) { // HttpServletRequest request
		// 透過上架日期取得商品
		List<GoodsBean2> findGoodByLaunchDate = gService.findGoodByLaunchDate();
		List<GoodPriceDTO> pricerange = new ArrayList();
		// 透過商品編號 取得價格最大最小值
		for (GoodsBean2 item : findGoodByLaunchDate) {
			int goodID = item.getGoodsID();
			Query<Object[]> resultList = (Query<Object[]>) entityManager.createQuery(
					"select min(gf.goodPrice) AS minprice,max(gf.goodPrice) AS maxprice, g.goodsID AS goodsID from GoodsBean2 g join GoodFormat gf on g.goodsID = gf.good.goodsID where g.goodsID = ?1 group by g.goodsID")
					.setParameter(1, goodID);// 在特定賣家下查詢商品，並取得不同編號下的最大和最小價格
			List<Object[]> item2 = resultList.getResultList();
			for (Object[] item3 : item2) {
				GoodPriceDTO result = new GoodPriceDTO();
				System.out.println(item.getNumberRatings());
				if (item.getNumberRatings() == null) {// 沒人評分
					result.setGoodAVG(0);
				} else {
					int AVG = item.getRating() / item.getNumberRatings();
					result.setGoodAVG(AVG);
				}
				result.setGoodType(item.getGoodsType());
				result.setGoodName(item.getGoodsName());
				result.setTitleImage(item.getTitleImage());
				result.setGoodsID((Integer) item3[2]);
				result.setMaxprice((Integer) item3[1]);
				result.setMinprice((Integer) item3[0]);
				pricerange.add(result);
			}
		}
//		HttpSession session = request.getSession();
//		session.setAttribute("findGoodPriceRange", pricerange);
//		session.setAttribute("GoodNumber", findGoodByLaunchDate.size());
		m.addAttribute("findGoodPriceRange", pricerange);
		m.addAttribute("GoodNumber", findGoodByLaunchDate.size());
		Object count = session.getAttribute("count");
		Object attribute = session.getAttribute("notifications");
		Object attribute2 = session.getAttribute("carItemCount");
		Object attribute3 = session.getAttribute("member");
		System.out.println(count);
		System.out.println(attribute);
		System.out.println(attribute2);
		System.out.println(attribute3);
		for(GoodPriceDTO item:pricerange) {
			System.out.println(item.toString());
		}

		return "good/jsp/EZBuyindex";
	}
/////////////////////////////////////////////////////新增頁面/////////////////////////////////////////////////
//	InsertGood.controller
	@GetMapping("InsertGood.controller")
	public String processInsert() {
		return "good/jsp/insertPageTemplete";
	}

	// another insert page(將時間拿掉)
	@PostMapping("InsertPage.controller")
	public String processInsertAction2(@RequestParam(name = "GoodImages") List<MultipartFile> goodImages,
			@RequestParam("GoodsName") String goodsName, @RequestParam("GoodsType") String goodsType,
			@RequestParam("Brand") String brand, @RequestParam("ShipmentPlace") String shipmentPlace,
			@RequestParam("TitleImage") MultipartFile titleImage, @RequestParam("GoodDirection") String goodsDirection,
			@RequestParam(name = "hiddenValue") List<String> datakey,
			@RequestParam(name = "GoodFormatImages") List<MultipartFile> formatImages) {
//建立相對路徑
		String dataPath = "../../goodImages/"; // 透過商品編號取得基本商品資訊 然後透過get取得編號對應的圖片集合
//		String patternPath = "../../../../../../../../Documents/team5project/SpringBootRestfulteam5Hw/src/main/webapp/WEB-INF/goodImages/"; // 透過商品編號取得基本商品資訊
		String patternPath = "../../../../../../../../../../team5project/SpringBootRestfulteam5Hw/src/main/webapp/WEB-INF/goodImages/"; // 透過商品編號取得基本商品資訊
																																		// 然後透過get取得編號對應的圖片集合
//建立圖片、規格集合
		Set<GoodImageBean> Imageset = new LinkedHashSet<>();
		Set<GoodFormat> formatset = new LinkedHashSet<>();
//建立simpledateformat 一個用來命名 一個用來把字串轉Date
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS");
//將值帶入insertGood類別 連線用的
		MemberBean member = (MemberBean) session.getAttribute("member");
		Integer goodSellerId = member.getSid();
		Optional<MemberBean> members = mService.findById(goodSellerId);
		MemberBean seller = members.get();
//取得格式
		String filename = titleImage.getOriginalFilename();
		int ps = filename.lastIndexOf(".");
		String patternFormat = filename.substring(ps, filename.length());
		String timeStamp = simpleDateFormat.format(new Date());
//String ImgRoot = timeStamp + "" + patternFormat;
		String ImgRoot = patternPath + timeStamp + "" + patternFormat;
//將檔案上傳到指定位置
		File file = new File(ImgRoot);
		try {
			titleImage.transferTo(file);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
// 處理商品基本資訊
		String titleImagePath = dataPath + timeStamp + "" + patternFormat;
		GoodsBean2 good = new GoodsBean2(goodsName, goodsDirection, goodsType, brand, shipmentPlace, seller,
				titleImagePath);
		good.setImages(Imageset);// 商品基本資訊表 連結 商品圖片表
		good.setFormat(formatset);// 商品基本資訊表 連結 商品規格表
		System.err.println(good.getLaunchDate() == null);
		GoodsBean2 insertgood = gService.insert(good);// 新增成功(有商品編號)
		Integer iD = insertgood.getGoodsID();
// 處理多個商品規格圖

		for (MultipartFile multipartFile : formatImages) {// 裡面迴圈處理圖片
//entry.getKey():input標籤中的name屬性
//multipartFile.getOriginalFilename():上傳檔案的名稱
//1.取得圖片格式
			String Formatfilename = multipartFile.getOriginalFilename();
			int pos = filename.lastIndexOf(".");
			String patternFormatImage = Formatfilename.substring(pos, Formatfilename.length());
//2.給予新的名字
			String timeStampFormat = simpleDateFormat.format(new Date());
//String ImgRoot = timeStamp + "" + patternFormat;
			String ImgRootFormat = patternPath + timeStampFormat + "" + patternFormatImage;
//3.將圖片上傳
//File file = new File(patternPath, ImgRoot);
			File fileFormat = new File(ImgRootFormat);
			try {
				multipartFile.transferTo(fileFormat);// 將圖片上傳至指定位置
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
//3.5 處理規格表的資料
			for (String item : datakey) {// 裡面包含上傳的資料
				String[] splitdata = item.split("/");
//取得裡面的內容
				String size = splitdata[0];
				String price = splitdata[1];
				String stock = splitdata[2];
				String uplaodfilename = splitdata[3];
//
				System.out.println("uplaodfilename = " + uplaodfilename);
				System.out.println("Formatfilename = " + Formatfilename);
				System.out.println("uplaodfilename.equals(Formatfilename)" + uplaodfilename.equals(Formatfilename));
				if (uplaodfilename.equals(Formatfilename)) {// 假如圖片名稱一樣
					GoodFormat goodformat = new GoodFormat();
					goodformat.setGood(insertgood);// 商品規格表連結商品基本資訊表
					String goodsImg = dataPath + timeStampFormat + "" + patternFormatImage;// dataPath =
//					goodformat.setGoodsID(iD); // "../../goodImages/"
					goodformat.setGoodImagePath(goodsImg);
					goodformat.setGoodPrice(Integer.parseInt(price));
					goodformat.setGoodSize(size);
					goodformat.setGoodsStock(Integer.parseInt(stock));
					GoodFormat insertformat = gfService.insert(goodformat);
					formatset.add(insertformat);
				}
			}
		}

		insertgood.setFormat(formatset);
//處理商品圖片表

		for (MultipartFile multipartFile : goodImages) {// 裡面迴圈處理圖片
//entry.getKey():input標籤中的name屬性
//multipartFile.getOriginalFilename():上傳檔案的名稱
//1.取得圖片格式
			String ImageFormatfilename = multipartFile.getOriginalFilename();
			int pos = filename.lastIndexOf(".");
			String patternImage = ImageFormatfilename.substring(pos, ImageFormatfilename.length());
//2.給予新的名字
			String timeStampImage = simpleDateFormat.format(new Date());
			String ImgRootImage = patternPath + timeStampImage + "" + patternImage;
//3.將圖片上傳
			File fileImage = new File(ImgRootImage);
			try {
				multipartFile.transferTo(fileImage);// 將圖片上傳至指定位置
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
//3.5 處理圖片表的資料
			String imagePath = dataPath + timeStampImage + "" + patternImage;
			GoodImageBean goodImageBean = new GoodImageBean();
//			goodImageBean.setGoodID(iD);
			goodImageBean.setGood(insertgood);
			goodImageBean.setImagePath(imagePath);
			Imageset.add(goodImageBean);
			giService.insert(goodImageBean);
		}

		insertgood.setImages(Imageset);
		gService.update(insertgood);
		return "";
	}
	// another insert page(將時間拿掉)

	///////////////////////////////////////////////////// 查詢全部的頁面/////////////////////////////////////////////////
	
	//模糊化查詢
	@GetMapping("/keywordsearch")
	@ResponseBody
	public List<GoodsBean2> keywordsearch(@RequestParam("inputresult") String keyinput){
		List<GoodsBean2> findGoods = gService.findGoods(keyinput);
		return findGoods;
	}
	// 檢視商品的詳細資訊
	@GetMapping("/goodDetail.controller")
	public String processGoodDetailAction(@RequestParam("GoodID") Integer goodID,@RequestParam(defaultValue = "0") Integer page,
		    @RequestParam(defaultValue = "2") Integer size,
		    @RequestParam(required = false) Integer rate,
		    @RequestParam(required = false) Boolean content,
		    @RequestParam(required = false) Boolean photos,Model m) {
//		HttpSession session = request.getSession();
//		session.setAttribute("GoodID", goodID);\
		//商品詳細資料需要(商品名稱、商品種類、商品價格範圍、商品平均評分)
		GoodsBean2 good = gService.getById(goodID); //取得對應商品編號
		// 取得對應商品的種類(related good) 只取商品編號
		
		//
		Query<Object[]> resultList = (Query<Object[]>) entityManager.createQuery(
//				select min(gf.goodPrice) AS minprice,max(gf.goodPrice) AS maxprice, g.goodsID AS goodsID 
//				from Goods g join GoodFormat gf on g.GoodsID = gf.GoodsID 
//				where g.GoodsID = 1 
//				group by g.GoodsID
				"select min(gf.goodPrice) AS minprice,max(gf.goodPrice) AS maxprice, g.goodsID AS goodsID from GoodsBean2 g join GoodFormat gf on g.goodsID = gf.good.goodsID where g.goodsID = "+ good.getGoodsID() +" group by g.goodsID");// 在特定賣家下查詢商品，並取得不同編號下的最大和最小價格
		List<Object[]> item2 = resultList.getResultList();
//		List<GoodPriceDTO> pricerange = new ArrayList();
		GoodPriceDetailDTO result = new GoodPriceDetailDTO();
		for (Object[] item3 : item2) {
			System.out.println(good.getNumberRatings());
			if (good.getNumberRatings() == null) {// 沒人評分
				result.setGoodAVG(0);
			} else {
				int AVG = good.getRating() / good.getNumberRatings();
				result.setGoodAVG(AVG);
			}
			if(good.getGoodsold()==null || good.getGoodsold()==0) {
				result.setGoodsold(0);
			}
			result.setGoodType(good.getGoodsType());
			result.setGoodName(good.getGoodsName());
			result.setTitleImage(good.getTitleImage());
			result.setGoodsID((Integer) item3[2]);
			result.setMaxprice((Integer) item3[1]);
			result.setMinprice((Integer) item3[0]);
			result.setGoodDirection(good.getGoodsDirection());
		}
		//
		List<GoodFormat> byIDOrderByFormatImage = gfService.getByIDOrderByFormatImage(goodID);
		List<GoodImageBean> findImagesByID = giService.findImagesByID(goodID);
		List<String> distinctFormatImage = gfService.getDistinctFormatImage(goodID);
		List<GoodFormatImageDto> goodformatimagelist = new ArrayList();
		for(String item:distinctFormatImage) {
			GoodFormatImageDto goodformatimage = new GoodFormatImageDto();
			goodformatimage.setGoodImagePath(item);
			goodformatimagelist.add(goodformatimage);
		}
		
		
		Pageable pageable = PageRequest.of(page, size);
	    Page<Post> resultPage;

	    // 查询所有评分对应的数量
	    List<Long> rateCounts = new ArrayList<>();
	    if (rate == null) {
	        for (int i = 5; i >= 1; i--) {
	            long count = pService.getPostsByGoodIdAndRate(goodID, i, Pageable.unpaged()).getTotalElements();
	            rateCounts.add(count);
	        }
	    }

	    // 查询有留言内容的数量
	    long contentCount = pService.findPostsByGoodIdWithContent(goodID, Pageable.unpaged()).getTotalElements();

	    // 查询附上照片的数量
	    long photosCount = pService.findPostsByGoodIdWithPhotos(goodID, Pageable.unpaged()).getTotalElements();

	    // 查询全部评价的数量
	    long totalPostsCount = pService.getPostsByGoodId(goodID, Pageable.unpaged()).getTotalElements();

	    if (rate != null) {
	        resultPage = pService.getPostsByGoodIdAndRate(goodID, rate, pageable);
	    } else if (content != null && content) {
	        resultPage = pService.findPostsByGoodIdWithContent(goodID, pageable);
	    } else if (photos != null && photos) {
	        resultPage = pService.findPostsByGoodIdWithPhotos(goodID, pageable);
	    } else {
	        resultPage = pService.getPostsByGoodId(goodID, pageable);
	    }
	    
	    // 檢查 resultPage 是否為空，如果是，則設置為一個空的 Page 對象
	    if (resultPage.isEmpty()) {
	        resultPage = new PageImpl<>(Collections.emptyList());
	    }
		
		
		m.addAttribute("Good", good);
		m.addAttribute("GoodFormat", byIDOrderByFormatImage);
		m.addAttribute("GoodFormatNumber", byIDOrderByFormatImage.size());
		m.addAttribute("GoodFormatImagePath", goodformatimagelist);
		m.addAttribute("GoodFormatImagePathNumber", distinctFormatImage.size());
		m.addAttribute("GoodImage", findImagesByID);
		m.addAttribute("GoodImageNumber", findImagesByID.size());
		m.addAttribute("GoodBasicInfo", result);
		 m.addAttribute("posts", resultPage.getContent());
		    m.addAttribute("currentPage", resultPage.getNumber());
		    m.addAttribute("totalPages", resultPage.getTotalPages());
		    m.addAttribute("rateCounts", rateCounts);
		    m.addAttribute("contentCount", contentCount);
		    m.addAttribute("photosCount", photosCount);
		    m.addAttribute("txotalPostsCount", totalPostsCount);
		m.addAttribute("GoodImageNumber", findImagesByID.size()); //
		m.addAttribute("GoodBasicInfo", result); //商品詳細資訊
		return "good/jsp/goodDetail";
	}

	// 顯示特並賣家的所有商品
	@GetMapping("/goodQueryAllPageForUser.controller")
	public String processQueryAllPageAction() {
		return "good/jsp/goodBasicQueryAll3";
	}

	// 分頁查詢
	@GetMapping("/frontqueryByPage/{pageNo}")
	@ResponseBody
	public List<GoodsBean2> processQueryAllByPage(@PathVariable("pageNo") int pageNo, Model m,
			HttpServletRequest request) {
		//
		int pageSize = 3;
		Pageable p1 = PageRequest.of(pageNo - 1, pageSize);
		System.err.println("pageNo = "+pageNo+",pageSize = "+pageSize);
		Page<GoodsBean2> page = gService.findAllByPage(p1);
		System.err.println("page.getTotalPages()  ="+page.getTotalPages());
		int totalPages = page.getTotalPages();
		long totalElement = page.getTotalElements();

		HttpSession session = request.getSession();
		session.setAttribute("totalPages", totalPages);
		session.setAttribute("totalElements", totalElement);
		System.out.println("totalPages = " + totalPages);
		return page.getContent();
	}

	// 從首頁搜尋商品名稱
	@GetMapping("/searchGood")
	public String searchGood(@RequestParam("GoodName") String goodsName, HttpServletRequest request) {
		//熱門商品(對應名稱下的熱銷商品)
		Query<Integer> popularListID = (Query<Integer>) entityManager.createQuery(
				"select g.goodsID from GoodsBean2 g where g.goodsName LIKE ?1 ORDER BY g.rating/g.numberRatings")
				.setParameter(1, "%"+ goodsName +"%");// 在搜尋商品名稱後 取得對應種類的數量
//		Query<Integer> resultList0 = (Query<Integer>) entityManager.createQuery(hql);
		List<Integer> ListObject = popularListID.getResultList();
		List<GoodPriceDTO> pricerange = new ArrayList();

		for (Integer item : ListObject) { // 取得滿足要求的商品編號
			 // 先取得編號
			GoodsBean2 good = gService.getById(item);
			Query<Object[]> resultList = (Query<Object[]>) entityManager.createQuery(
					"select min(gf.goodPrice) AS minprice,max(gf.goodPrice) AS maxprice, g.goodsID AS goodsID from GoodsBean2 g join GoodFormat gf on g.goodsID = gf.good.goodsID where g.goodsID = ?1 group by g.goodsID")
					.setParameter(1, item);// 在特定賣家下查詢商品，並取得不同編號下的最大和最小價格
			List<Object[]> item2 = resultList.getResultList();
			for (Object[] item3 : item2) {
				GoodPriceDTO result = new GoodPriceDTO();
				System.out.println(good.getNumberRatings());
				if (good.getNumberRatings() == null) {// 沒人評分
					result.setGoodAVG(0);
				} else {
					int AVG = good.getRating() / good.getNumberRatings();
					result.setGoodAVG(AVG);
				}
				result.setGoodType(good.getGoodsType());
				result.setGoodName(good.getGoodsName());
				result.setTitleImage(good.getTitleImage());
				result.setGoodsID((Integer) item3[2]);
				result.setMaxprice((Integer) item3[1]);
				result.setMinprice((Integer) item3[0]);
				System.out.println(result.toString());
				pricerange.add(result);
			}
		}
		//取得商品種類對應的數量
		HttpSession session = request.getSession();
		session.setAttribute("goodsName", goodsName);
		// 查詢商品名稱取得對應的種類集合
		List<GoodTypeDto> goodTypeNumber = new ArrayList();
		Query<Object[]> resultList = (Query<Object[]>) entityManager.createQuery(
				"select distinct g.goodsType AS goodsType,count(g.goodsType) AS goodsTypeNumber from GoodsBean2 g where g.goodsName LIKE ?1 GROUP BY g.goodsType")
				.setParameter(1, "%"+ goodsName +"%");// 在搜尋商品名稱後 取得對應種類的數量
		List<Object[]> item = resultList.getResultList();
		for (Object[] item1 : item) {
			GoodTypeDto data = new GoodTypeDto();
			data.setGoodsType((String) item1[0]);
			data.setGoodsTypeNumber((Long) item1[1]);
			goodTypeNumber.add(data);
		}
		System.out.println("goodTypeNumber.size() = " + goodTypeNumber.size());
		session.setAttribute("CategoryNumberList", goodTypeNumber);
		session.setAttribute("CategoryNumber", goodTypeNumber.size());
		session.setAttribute("PopularGoodBasicInfo", pricerange);

		return "good/jsp/SearchGood";
	}

	// 跳轉頁面後 呈現搜尋結果
	@GetMapping("/searchGoodResult/{pageNO}/{hiddenContent}")
	@ResponseBody
	public GoodPricePageDto searchGoodResult(@PathVariable("pageNO") Integer pageNo,
			@PathVariable("hiddenContent") String hiddencontent, HttpServletRequest request) {
		// 外界給定
//        let hiddenContent = goodName + "_" + Category + "_" + price + "_" + orderItem;
		// /searchGoodResult/1/鯊鯊貓_娃娃_XXX_XXX
		String[] split = hiddencontent.split("_");
		System.out.println("hiddencontent = "+hiddencontent);
		String goodName = split[0];
		String category = split[1];
		String price = split[2];
		String orderItem = split[3];
		// 自己給予(測試用)
		//
		String hql0 = "select g.goodsID from GoodsBean2 g join GoodFormat gf on g.goodsID = gf.good.goodsID where g.goodsName LIKE '%"
				+ goodName + "%' ";
		String hql1 = "";
		String hql2 = "";
		String hql3 = "";
//		select g.GoodsID
//		from Goods g join GoodFormat gf on g.goodsID = gf.goodsID 
//		where g.GoodsName LIKE '%鯊鯊貓%' AND gf.GoodPrice between 0 and 1500 AND g.GoodsType = '貼圖'
//		order by gf.GoodPrice
		System.out.println("goodName="+goodName+",category="+category+",price="+price+",orderItem="+orderItem);
		if (category.equals("XXX")) {// 沒有選定種類
			if (price.equals("XXX")) {
				System.out.println("price = XXX");
				if (orderItem.equals("XXX")) {
					System.out.println("orderItem = XXX");
				} else {
					switch (orderItem) {
					case "price":
						hql3 = "order by gf.goodPrice";
						break;
					case "score":
//						hql3 = "";
						break;
					case "ID":
						hql3 = "order by g.goodsID";
						break;
					case "NO":
//						hql3 = "";
						break;
					default:
//						hql3 = "";
						System.out.println("something weird");
					}
				}
			} else {
				hql2 = "AND gf.goodPrice between 0 AND " + price + " ";
				if (orderItem.equals("XXX")) {
					System.out.println("orderItem = XXX");
				} else {
					switch (orderItem) {
					case "price":
						hql3 = "order by gf.goodPrice";
						break;
					case "score":
//						hql3 = "";
						break;
					case "ID":
						hql3 = "order by g.goodsID";
						break;
					case "NO":
//						hql3 = "";
						break;
					default:
//						hql3 = "";
						System.out.println("something weird");
					}
				}
			}
		} else {
			hql1 = "AND g.goodsType='" + category + "' ";
			if (price.equals("XXX")) {
				System.out.println("price = XXX");
			} else {
				hql2 = "AND gf.goodPrice between 0 AND " + price + " ";
				if (orderItem.equals("XXX")) {
					System.out.println("orderItem = XXX");
				} else {
					switch (orderItem) {
					case "price":
						hql3 = "order by gf.goodPrice";
						break;
					case "score":
//						hql3 = "";
						break;
					case "ID":
						hql3 = "order by g.goodsID";
						break;
					case "NO":
//						hql3 = "";
						break;
					default:
//						hql3 = "";
						System.out.println("something weird");
					}
				}
			}
		}
		String hql = hql0 + hql1 + hql2 + hql3;
		System.out.println("要顯示價格喔!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		System.out.println("hql = " + hql);
		Query<Integer> resultList0 = (Query<Integer>) entityManager.createQuery(hql);
		List<Integer> ListObject = resultList0.getResultList();
		List<Integer> listID = new ArrayList<>();
		for (Integer item : ListObject) { // 取得滿足要求的商品編號
			if (listID.contains(item)) {
				// 有重複元素 不要加進去
			} else {
				listID.add(item);
				System.out.println("itemID=" + item);
			}
		}
		// @RequestParam("GoodName") String goodsName,@PathVariable("pageNO") Integer
		// pageNo, HttpServletRequest request
		int pageSize = 3;

		List<GoodPriceDTO> pricerange = new ArrayList();
		GoodPricePageDto pricerangePage= new GoodPricePageDto();
		
		for (Integer item : listID) { // 先取得編號
			GoodsBean2 good = gService.getById(item);
			Query<Object[]> resultList = (Query<Object[]>) entityManager.createQuery(
//					select min(gf.GoodPrice) AS minprice,max(gf.GoodPrice) AS maxprice,gf.GoodsID AS 'GoodID'
//					from Goods g join GoodFormat gf on g.GoodsID = gf.GoodsID
//					where gf.GoodsID = 4 
//					group by gf.GoodsID;
					"select min(gf.goodPrice) AS minprice,max(gf.goodPrice) AS maxprice, g.goodsID AS goodsID from GoodsBean2 g join GoodFormat gf on g.goodsID = gf.good.goodsID where g.goodsID = ?1 group by g.goodsID")
					.setParameter(1, item);// 在特定賣家下查詢商品，並取得不同編號下的最大和最小價格
			List<Object[]> item2 = resultList.getResultList();
			for (Object[] item3 : item2) {
				GoodPriceDTO result = new GoodPriceDTO();
				System.out.println(good.getNumberRatings());
				if (good.getNumberRatings() == null) {// 沒人評分
					result.setGoodAVG(0);
				} else {
					int AVG = good.getRating() / good.getNumberRatings();
					result.setGoodAVG(AVG);
				}
				result.setGoodType(good.getGoodsType());
				result.setGoodName(good.getGoodsName());
				result.setTitleImage(good.getTitleImage());
				result.setGoodsID((Integer) item3[2]);
				result.setMaxprice((Integer) item3[1]);
				result.setMinprice((Integer) item3[0]);
				System.out.println(result.toString());
				pricerange.add(result);
			}
		}
		/**/
		Pageable p1 = PageRequest.of(pageNo - 1, pageSize);
		int start = (int) p1.getOffset();
		int end = Math.min((start + p1.getPageSize()), pricerange.size());
		System.err.println("start = " + start + ",end=" + end);
		List<GoodPriceDTO> pageContent = pricerange.subList(start, end);
		int pagesnumber;
		int totalPages;

		if ((pricerange.size() / pageSize) % 1 == 0) {
			pagesnumber = (pricerange.size() / pageSize);
			totalPages = pagesnumber;
		} else {
			pagesnumber = (pricerange.size() / pageSize);
			totalPages = pagesnumber + 1;
		}
		//
		pricerangePage.setGoodPriceDtoList(pageContent);
		pricerangePage.setPage(totalPages);
		//
		HttpSession session = request.getSession();
		System.err.println(session.getAttribute("totalPages"));
		session.setAttribute("totalElements", pricerange.size());
		System.err.println("totalPages = "+totalPages);
		System.err.println("totalElements = "+pricerange.size());
//		m.addAttribute("totalPages", totalPages);
//		m.addAttribute("totalElements", pricerange.size());
		/**/
//		return pageContent;
		return pricerangePage;
	}

	// 透過訂單紀錄中找出最近熱賣的商品種類
	@GetMapping("/indexpopulargoodtype")
	@ResponseBody // 程式測試
	public List<GoodTypeIndexDto> indexpopulargoodtype() {// @RequestParam("sellerIDforSearch") Integer
															// sellerID,@RequestParam("searchGoodName") String goodName
//		List<GoodTypeIndexDto> resultList = entityManager.createQuery("select g.goodsType AS goodsType from Orders o join GoodFormat gf on o.formatgoodId = gf.formatID join GoodsBean2 g on gf.good.goodsID = g.goodsID group by g.goodsType order by sum(o.quantity)").getResultList();
		List<GoodTypeIndexDto> resultList = entityManager
				.createQuery("select distinct g.goodsType AS goodsType from GoodsBean2 g group by g.goodsType")
				.getResultList();// 因為訂單沒資料
		Pageable p1 = PageRequest.of(0, 5);
		int start = (int) p1.getOffset();
		int end = Math.min((start + p1.getPageSize()), resultList.size());
		List<GoodTypeIndexDto> pageContent = resultList.subList(start, end);

		return pageContent;
	}

	// 首頁(再從五種熱賣的商品中各取10個商品)
	@GetMapping("/indexpopulargood/{goodType}")
	@ResponseBody // 程式測試
	public List<GoodBasicDto> indexpopulargood(@PathVariable("goodType") String goodType) {
		// @RequestParam("sellerIDforSearch")
		// Integer
		// sellerID,@RequestParam("searchGoodName")
		// String goodName
//		List<GoodBasicDto> resultList = entityManager.createQuery(
//				"select distinct g.goodsID AS GoodsID,g.goodsType AS GoodsType,g.goodsName AS GoodsName,g.titleImage AS TitleImage from Orders o join GoodFormat gf on o.formatgoodId = gf.formatID join GoodsBean2 g on gf.good.goodsID = g.goodsID where g.goodsType=?1 order by sum(o.quantity)")
//				.setParameter(1, goodType).getResultList();
		List<GoodBasicDto> resultList = entityManager.createQuery(
				"select distinct g.goodsID AS GoodsID,g.goodsType AS GoodsType,g.goodsName AS GoodsName,g.titleImage AS TitleImage from GoodsBean2 g where g.goodsType=?1")
				.setParameter(1, goodType).getResultList();// 訂單內沒資料
		// [GoodsID,GoodsType,GoodsName,TitleImage]
		return resultList;
	}

	// 首頁(每個商品都有最大價格和最小價格,透過商品編號取出來)
	@GetMapping("/indexpopulargoodPrice/{goodID}")
	@ResponseBody // 程式測試
	public List<GoodPriceDTO> indexpopulargoodPrice(@PathVariable("goodID") Integer goodID) {
		List<GoodPriceDTO> resultList1 = entityManager.createQuery(
				"select min(gf.goodPrice) AS minprice,max(gf.goodPrice) AS maxprice, g.goodsID from GoodsBean2 g join GoodFormat gf on g.goodsID = gf.good.goodsID where g.goodsID = ?1 group by g.goodsID")
				.setParameter(1, goodID).getResultList();// 在特定賣家下查詢商品，並取得不同編號下的最大和最小價格
//		[minprice,maxprice,goodsID]
		return resultList1;
	}

	// 首頁(根據上架日期由大到小列出商品)
	@GetMapping("/indexgoodByLaunchDate")
	@ResponseBody // 程式測試
	public List<GoodsBean2> indexgoodByLaunchDate() {
		List<GoodsBean2> findGoodByLaunchDate = gService.findGoodByLaunchDate();
		return findGoodByLaunchDate;
	}

	// 在賣家商品下搜尋商品
	@GetMapping("/searchSellerGood")
	public String searchSellerGood(HttpServletRequest request) {// @RequestParam("sellerIDforSearch") Integer
																// sellerID,@RequestParam("searchGoodName") String
																// goodName,
		List<GoodsBean2> findSellerGood = gService.findSellerGood("貼圖", 3);
		HttpSession session = request.getSession();
		session.setAttribute("good", findSellerGood);
		int resultNumber = findSellerGood.size();
		session.setAttribute("goodNumber", resultNumber);
		return "good/jsp/SellerGood";
	}

	@GetMapping("/frontsellergoodquery")
	@ResponseBody
	public List<GoodsBean2> searchSellerGood2() {// @RequestParam("sellerIDforSearch") Integer
													// sellerID,@RequestParam("searchGoodName") String goodName
//		List<GoodsBean2> findSellerGood = gService.findSellerGood(goodName, sellerID);
		List<GoodsBean2> findSellerGood = gService.findSellerGood("貼圖", 3);
		return findSellerGood;
	}

	// 透過商品編號 查詢商品基本資訊
	// 在查詢全部的頁面中點擊其中一項商品的編輯按鈕
	@GetMapping("goodQuery.controller")
	public String goodMidifyPage() {
//		public String goodMidifyPage(@RequestParam("GoodsID") Integer goodID) {
		int goodID = 3;
		session.setAttribute("goodID", goodID);
		return "good/jsp/modifyPageTemplete";
	}

	// -> 進入該商品的編輯頁面
//				"/good/" + GoodID
	@GetMapping("/good/{goodID}")
	@ResponseBody
	public GoodsBean2 queryGoodById(@PathVariable("goodID") int goodID) {
		GoodsBean2 good = gService.getById(goodID);
//		good.setGoodsID(goodID);
		System.out.println("good=" + good.toString());

		Set<GoodImageBean> images = good.getImages();
		for (GoodImageBean item : images) {
//			item.setGoodID(goodID);
			System.out.println(item.toString());
		}
		Set<GoodFormat> format = good.getFormat();
		for (GoodFormat item : format) {
//			item.setGoodsID(goodID);
			System.out.println(item.toString());
		}
		return good;
	}

	// 透過商品編號查詢商品圖片表資料
	@GetMapping("/goodImage/{goodID}")
	@ResponseBody
	public Set<GoodImageBean> processGetImageByID(@PathVariable("goodID") int goodID) {// 取得對應商品ID的所有圖片路徑
		GoodsBean2 good = gService.getById(goodID);
		Set<GoodImageBean> images = good.getImages();
//		GoodImageBean images = giService.findImagesByID(goodID);
		return images;
	}

	// 透過商品編號查詢商品規格表資料
	@GetMapping("/goodformatHI/{goodID}")
	@ResponseBody
	public List<GoodFormat> queryByIdOrderByFormatImage(@PathVariable("goodID") Integer goodID) {
		List<GoodFormat> goodFormat = gfService.getByIDOrderByFormatImage(goodID);
		for (GoodFormat item : goodFormat) {
//			item.setGoodsID(goodID);
			System.out.println(item.toString());
		}
		return goodFormat;
	}

	///////////////////////////////////////////////////// 修改頁面/////////////////////////////////////////////////
	@PostMapping("goodModify.controller")
	public String goodModifyprocess(@RequestParam(name = "GoodImages", required = false) List<MultipartFile> goodImages,
			@RequestParam(name = "GoodDelete", required = false) List<Integer> goodDelete,
			@RequestParam(name = "GoodImageshidden", required = false) List<String> goodImageshidden,
			// 上面是商品圖片表的部分
			@RequestParam(name = "GoodsName", required = false) String goodsName,
			@RequestParam(name = "GoodsType", required = false) String goodsType,
			@RequestParam(name = "LaunchDate", required = false) String launchDate,
			@RequestParam(name = "Brand", required = false) String brand,
			@RequestParam(name = "ShipmentPlace", required = false) String shipmentPlace,
			@RequestParam(name = "TitleImage", required = false) MultipartFile titleImage,
			@RequestParam(name = "GoodDirection", required = false) String goodDirection,
			@RequestParam(name = "GoodsID", required = false) Integer goodsID,
			// 上面是商品基本資訊
			@RequestParam(name = "GoodFormatImages", required = false) List<MultipartFile> goodFormatImages,
			@RequestParam(name = "hiddenValue", required = false) List<String> hiddenValue,
			@RequestParam(name = "DeleteFormatDataById", required = false) List<Integer> deleteFormatDataById) {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		// 建立相對路徑
		String dataPath = "../../goodImages/"; // 透過商品編號取得基本商品資訊 然後透過get取得編號對應的圖片集合
//		String patternPath = "../../../../../../../../Documents/team5project/SpringBootRestfulteam5Hw/src/main/webapp/WEB-INF/goodImages/"; // 透過商品編號取得基本商品資訊
		String patternPath = "../../../../../../../../../../team5project/SpringBootRestfulteam5Hw/src/main/webapp/WEB-INF/goodImages/"; // 透過商品編號取得基本商品資訊

		//
		GoodsBean2 good = gService.getById(goodsID);
		// 取得基本商品資訊連結的另外兩張表
		Set<GoodFormat> formatset = good.getFormat();
		Set<GoodImageBean> imageset = good.getImages();
		//
		String uploadTitleImage = titleImage.getOriginalFilename();
		System.out.println(brand);
		System.out.println(goodsName);
		System.out.println(goodsType);
		System.out.println(launchDate);

		if (goodsName.equals("")) {
		} else {
			good.setGoodsName(goodsName);
		}
		if (goodsType.equals("")) {

		} else {
			good.setGoodsType(goodsType);
		}
		if (brand.equals("")) {
		} else {
			good.setBrand(brand);
		}
		if (shipmentPlace.equals("")) {

		} else {
			good.setShipmentPlace(shipmentPlace);
		}
		if (goodDirection.equals("")) {
		} else {
			good.setGoodsDirection(goodDirection);
		}

		good.setGoodsID(goodsID);
		// 處理上架日期的格式問題
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		try {
			if (launchDate.equals("")) {

			} else {
				Date launchdate = sdf.parse(launchDate);
				good.setLaunchDate(launchdate);
			}
			good.setShipmentPlace(shipmentPlace);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("uploadTitleImage = " + uploadTitleImage);
		if (uploadTitleImage.equals("")) {// 沒有上傳圖片

		} else {// 圖片有上傳
				// 將圖片刪除
			String oldRootTitleImage = good.getTitleImage();
			System.out.println("oldRootTitleImage = " + oldRootTitleImage);
			System.out.println("oldRootTitleImage.length() = " + oldRootTitleImage.length());
			int ps = oldRootTitleImage.lastIndexOf("/");
			System.out.println();
			String oldTitleImages = oldRootTitleImage.substring(ps + 1);// 取得檔案名稱
			String deleteRootTitlePath = patternPath + "" + oldTitleImages;
			File oldFile = new File(deleteRootTitlePath);
			oldFile.delete();
			// 處理上傳圖片的命名問題
			int pos = uploadTitleImage.lastIndexOf(".");
			String patternFormatImages = uploadTitleImage.substring(pos, uploadTitleImage.length());
//2.給予新的名字
			String timeStampFormat = simpleDateFormat.format(new Date());
//String ImgRoot = timeStamp + "" + patternFormat;
			String ImgRootFormat = patternPath + timeStampFormat + "" + patternFormatImages;
			File file = new File(ImgRootFormat);
			try {
				titleImage.transferTo(file);// 上傳圖片
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// 將封面照資料
			String dataBaseRootFormat = dataPath + timeStampFormat + "" + patternFormatImages;
			good.setTitleImage(dataBaseRootFormat);
		}
		System.out.println(good.toString());
		/////////////////////////// 商品基本資訊//////////////////////////////////////
		for (MultipartFile item : goodImages) {// 裡面包含修改圖片 和 新增圖片
			if (item.getOriginalFilename().equals("")) {// 沒有上傳檔案
				// 啥事不幹
			} else {// 圖片被上傳
				String uploadGoodImageName = item.getOriginalFilename();// xxx.jpg
				int check = 0;
				System.out.println("uploadGoodImageName = " + uploadGoodImageName);
				for (String item2 : goodImageshidden) {// 裡面沒有新增圖片的資料
					// item2 = "1003/sharkitty18.jpg" 修改
					// item2 = "1003" 沒有修改
					// 需要辨別是該圖片是新增還是修改
					String[] dataImageNum = item2.split("/");
					System.out.println(dataImageNum.toString());
					System.out.println("dataImageNum.length = " + dataImageNum.length);
					if (dataImageNum.length == 1) {// 裡面只有圖片編號(代表該欄位甚麼事都沒做)
						// 啥事不幹
					} else {
						if (dataImageNum.length == 2) {// 裡面有包含圖片編號對應的上傳圖片名稱
							System.out.println("dataImageNum[1] = " + dataImageNum[1]);
							if (dataImageNum[1].equals(uploadGoodImageName)) {// 名稱同名代表該次上船的圖片是修改用的
								GoodImageBean image = giService.getByID(Integer.parseInt(dataImageNum[0]));
								// 將上船的圖片給予新的名字後寫進image類別內
								// 將舊的圖片刪除
								String imagePath = image.getImagePath();// ../../xxx.jpg
								int position1 = imagePath.lastIndexOf("/");
								String imageName = imagePath.substring(position1 + 1);// xxx.jpg
								String oldimageRootPath = patternPath + "" + imageName;
								File filetarget = new File(oldimageRootPath);
								filetarget.delete();
								// 取得上傳圖片的格式
								int position = uploadGoodImageName.lastIndexOf(".");
								String imageFormat = uploadGoodImageName.substring(position);// .jpg
								String timeStampFormat = simpleDateFormat.format(new Date());
								String ImgRootFormat = patternPath + timeStampFormat + "" + imageFormat;
								File file = new File(ImgRootFormat);
								try {
									item.transferTo(file);// 將圖片上傳
								} catch (IllegalStateException e) {
									// TODO Auto-generated catch block
									e.printStackTrace();
								} catch (IOException e) {
									// TODO Auto-generated catch block
									e.printStackTrace();
								}
								String dataBaseRootFormat = dataPath + timeStampFormat + "" + imageFormat;
								image.setImagePath(dataBaseRootFormat);
								giService.update(image);// 將圖片更新至資料庫
								check = 1;
							}

						} else {
							System.out.println("something wrong!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
						}
					}
				}
				System.out.println("check = " + check);
				if (check == 0) {// 代表該圖片是用來新增的
					GoodImageBean goodImageBean = new GoodImageBean();
					goodImageBean.setGood(good);// 連結商品基本資訊
					// 處理新增上去的圖片
					int position = uploadGoodImageName.lastIndexOf(".");
					String imageFormat = uploadGoodImageName.substring(position);// .jpg
					String timeStampFormat = simpleDateFormat.format(new Date());
					String ImgRootFormat = patternPath + timeStampFormat + "" + imageFormat;
					System.out.println("ImgRootFormat = " + ImgRootFormat);
					File file = new File(ImgRootFormat);
//						File file1 = new File("./aa.jpg");
					try {
//							item.transferTo(file1);//將圖片上傳
						item.transferTo(file);// 將圖片上傳
					} catch (IllegalStateException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					String dataBaseRootFormat = dataPath + timeStampFormat + "" + imageFormat;
					goodImageBean.setImagePath(dataBaseRootFormat);// 將路徑寫入商品圖片類別中
					imageset.add(goodImageBean);// 將商品基本資訊表連結商品圖片表
					giService.insert(goodImageBean);// 將圖片表寫進資料庫
					//
				}

			}
		}
		for (Integer item : goodDelete) {
			System.out.println("item = " + item);
			if (item == -1) {

			} else {
				GoodImageBean goodimage = giService.getByID(item);
				String imagePath = goodimage.getImagePath();// ../../xxx.jpg
				System.out.println("imagePath = " + imagePath);
				String[] split = imagePath.split("/");
				String deletefilename = split[3];
				System.out.println("deletefilename = " + deletefilename);
				// 將圖片刪掉
				File fileHI = new File(patternPath + "" + deletefilename);
				boolean result = fileHI.delete();
				System.out.println("delete result = " + result);
				imageset.remove(goodimage);
				//
				giService.deleteById(item);// 透過商品圖片編號刪除
			}
		}
		// 商品規格表處理
		Map<String, String> checkImageMap = new HashMap<String, String>();
		String checkpoint = "0";
		System.out.println("開始處理商品規格表搂!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		for (MultipartFile item : goodFormatImages) {// 裡面包含修改圖片 和 新增圖片(只針對圖片有改動的案例)
			String uploadGoodImageName = item.getOriginalFilename();// xxx.jpg
			System.out.println("uploadGoodImageName = " + uploadGoodImageName);
			if (item.getOriginalFilename().equals("") && checkpoint.equals("0")) {// 沒有上傳檔案
				System.out.println("檔案沒有上傳");
				// 處理沒有更新或上傳圖片的修改資料
				for (String item2 : hiddenValue) {
					System.out.println("item2 = " + item2);
					String[] split = item2.split("/");
					if (split.length == 5) {// 在某個規格編號下更改某一細項資料
						String formatID = split[0];
						String size = split[1];
						String price = split[2];
						String stock = split[3];
						String checkType = split[4];
						if (checkType.equals("NO")) {
							// 不用做事
						} else {
							if (checkType.equals("YES")) {
								GoodFormat format = gfService.getById(Integer.parseInt(formatID));
								format.setGoodPrice(Integer.parseInt(price));
								format.setGoodSize(size);
								format.setGoodsStock(Integer.parseInt(stock));
							} else {
								System.out.println("hidden value contain imageName");
							}
						}
					} else {
						if (split.length == 4) {// 處理在同一圖片下新增一個規格
							String size = split[0];
							String price = split[1];
							String stock = split[2];
							String figName = split[3];// 隱藏欄位中 的圖片名稱
							List<GoodFormat> byIDOrderByFormatImage = gfService.getByIDOrderByFormatImage(goodsID);
							for (GoodFormat item3 : byIDOrderByFormatImage) {
								String goodImagePath = item3.getGoodImagePath();
								System.out.println("goodImagePath = " + goodImagePath);
								String[] split2 = goodImagePath.split("/");
								String checkname = split2[3];
								if (checkname.equals(figName)) {
									GoodFormat goodFormat = new GoodFormat();
									goodFormat.setGood(good);
									goodFormat.setGoodImagePath(goodImagePath);
									goodFormat.setGoodPrice(Integer.parseInt(price));
									goodFormat.setGoodSize(size);
									goodFormat.setGoodsStock(Integer.parseInt(stock));
									gfService.insert(goodFormat);
									break;
								}
							}
						}
					}
				}
				checkpoint = "1";
			} else {// 取得到圖片資料(修改圖片或上傳圖片)
//				String uploadGoodImageName = item.getOriginalFilename();// xxx.jpg
				if (uploadGoodImageName.equals("")) {// 沒有圖片的案例處理玩了
					System.out.println("裡面沒東西");
				} else {
//					System.out.println("HI uploadGoodImageName = " + uploadGoodImageName);// uploadGoodImageName
					// 上傳或修改的圖片名稱
					System.out.println("取得到圖片資料(修改圖片或上傳圖片)");
//					String check = "";// 一張規格圖片內有多個規格資料
//					String checkInsertAns = "";
					for (String item2 : hiddenValue) {
						// 需要辨別是該圖片是新增還是修改
						// EX: 大/1500/1000/sharkitty19.jpg
						// EX: 中/1300/800/sharkitty19.jpg
						// EX: 大/1800/600/sharkitty20.jpg
						// EX: 中/1400/500/sharkitty20.jpg
						String[] dataImageNum = item2.split("/");
						System.out.println("item2 = " + item2);
						String check1 = "";
						if (dataImageNum.length == 4) {// 新增資料(1.新增圖片)
							// 攔截隱藏欄位的所有資料
							// 新增圖片(大/1500/1000/sharkitty19.jpg)
							// 新增單一規格(大/1500/1000/202405071005123.jpg)
							// 修改規格單一細項(1100/大/1500/1000/YES)(不包含圖片)
							// 修改規格細項(1100/大/1500/1000/sharkitty19.jpg)(包含圖片)
							String size = dataImageNum[0];
							System.out.println("size = " + size);
							String price = dataImageNum[1];
							System.out.println("price = " + price);
							String stock = dataImageNum[2];
							System.out.println("stock = " + stock);
							String uploadformatImageName = dataImageNum[3];
							//
							if (uploadformatImageName.equals("NO")) {
								System.out.println("資料尚未更動");
							} else {
								// 處理兩大案例
								// 1. 新增圖片(大/1500/1000/sharkitty19.jpg)
								// 1. 新增圖片(中/1300/1200/sharkitty19.jpg)
								// 1. 新增圖片(小/1000/800/sharkitty19.jpg)
								// 2.新增單一規格(大/1500/1000/202405071005123.jpg)
								// 2.新增單一規格(中/1500/1000/202405071005123.jpg)
								// 案例 小/800/100/sharkitty11.jpg(uploadGoodImageName = sharkitty11.jpg)
								// 案例 大/1500/600/sharkitty14.jpg(uploadGoodImageName = sharkitty11.jpg) 跳過不處理

								Set<String> keySet = checkImageMap.keySet();
								System.out.println("keySet start");
								System.out.println(keySet);
								System.out.println("keySet end");
								System.out.println("keySet.contains(uploadformatImageName) = "
										+ keySet.contains(uploadformatImageName));
								if (keySet.contains(uploadformatImageName)
										&& uploadformatImageName.equals(uploadGoodImageName)) {
									//
									String answer = checkImageMap.get(uploadformatImageName);
									GoodFormat goodFormatforInsert = new GoodFormat();
									goodFormatforInsert.setGood(good);
									goodFormatforInsert.setGoodImagePath(answer);
									goodFormatforInsert.setGoodPrice(Integer.parseInt(price));
									goodFormatforInsert.setGoodSize(size);
									goodFormatforInsert.setGoodsStock(Integer.parseInt(stock));
									formatset.add(goodFormatforInsert);
									gfService.insert(goodFormatforInsert);
									break;
								} else {// 假若map內沒有對應的資料
										// 先檢查是不是案例2
									if (!uploadformatImageName.equals(uploadGoodImageName)) {
										System.out.println("跳過不處理(隱藏欄位的圖片名稱和上傳圖片的名稱不符)");
									} else {
										List<GoodFormat> filterhidden = gfService.getByIDOrderByFormatImage(goodsID);// 透過商品編號取得所有對應的規格
										for (GoodFormat item3 : filterhidden) {
											String goodImagePath = item3.getGoodImagePath();// ex:../../goodImages/xxx.jpg
											String[] split = goodImagePath.split("/");
											String checkdatabasefilename = split[3];
											if (checkdatabasefilename.equals(uploadformatImageName)) {
												// 假若隱藏資料中的圖片名稱和上傳圖片名稱吻合(新增單一規格)[不須處理圖片上傳]
												checkImageMap.put(uploadformatImageName, goodImagePath);
												GoodFormat insertgoodformat = new GoodFormat();
												insertgoodformat.setGood(good);
												insertgoodformat.setGoodImagePath(goodImagePath);
												insertgoodformat.setGoodPrice(Integer.parseInt(price));
												insertgoodformat.setGoodSize(size);
												insertgoodformat.setGoodsStock(Integer.parseInt(stock));
												gfService.insert(insertgoodformat);
												formatset.add(insertgoodformat);
												check1 = "1";
												break;
											}
										}
										if (check1.equals("")) {// 代表不是案例2 可能是案例1(新增圖片)[需要處理圖片上傳]
											GoodFormat goodFormat = new GoodFormat();
											goodFormat.setGood(good);// 連結商品基本資訊
											// 處理新增上去的圖片
											System.out.println("uploadGoodImageName = " + uploadGoodImageName);
											int position = uploadGoodImageName.lastIndexOf(".");
											String imageFormat = uploadGoodImageName.substring(position);// .jpg
											String timeStampFormat = simpleDateFormat.format(new Date());
											String ImgRootFormat = patternPath + timeStampFormat + "" + imageFormat;
											File file = new File(ImgRootFormat);
											System.out.println("ImgRootFormat = " + ImgRootFormat);
											System.out.println(
													"item.getOriginalFilename() = " + item.getOriginalFilename());
											try {
												item.transferTo(file);// 將圖片上傳
											} catch (IllegalStateException e) {
												// TODO Auto-generated catch block
												e.printStackTrace();
											} catch (IOException e) {
												// TODO Auto-generated catch block
												e.printStackTrace();
											}
											String dataBaseRootFormat = dataPath + timeStampFormat + "" + imageFormat;
											goodFormat.setGoodImagePath(dataBaseRootFormat);
											goodFormat.setGoodPrice(Integer.parseInt(price));
											goodFormat.setGoodsStock(Integer.parseInt(stock));
											goodFormat.setGoodSize(size);
											goodFormat.setGood(good);
											formatset.add(goodFormat);// 將規格表集合起來
											gfService.insert(goodFormat);// 將規格表寫進資料庫
											checkImageMap.put(uploadGoodImageName, dataBaseRootFormat);
										} else {
											System.out.println("check1 only get 1 or \"\" something wrong happen");
										}
									}

								}
							}
						} else {
							if (dataImageNum.length == 5) {// 修改圖片
								// 有二種狀況
								// 修改規格單一細項(1100/大/1500/1000/YES)(不包含圖片)[已經在其他地方處理過了]
								// 修改規格細項(1100/大/1500/1000/sharkitty19.jpg)(包含圖片)
								// 取得隱藏資料
								String formatID = dataImageNum[0];
								String size = dataImageNum[1];
								String price = dataImageNum[2];
								String stock = dataImageNum[3];
								String formatModifyPath = dataImageNum[4];
								//
								System.out.println("HI uploadGoodImageName = " + uploadGoodImageName);
								System.out.println("HI formatModifyPath = " + formatModifyPath);
								if (!dataImageNum[4].equals("YES") && !dataImageNum[4].equals("NO")) {// 修改規格單一細項(1100/大/1500/1000/sharkitty19.jpg)(不包含圖片)[已經在其他地方處理過了]
									Set<String> keySet = checkImageMap.keySet();
									System.out.println("keySet = " + keySet);
									if (keySet.contains(uploadGoodImageName)
											&& formatModifyPath.equals(uploadGoodImageName)) {
										GoodFormat formatcheck = gfService.getById(Integer.parseInt(formatID));
										formatcheck.setGoodImagePath(checkImageMap.get(uploadGoodImageName));
										formatcheck.setGoodPrice(Integer.parseInt(price));
										formatcheck.setGoodSize(size);
										formatcheck.setGoodsStock(Integer.parseInt(stock));
										gfService.update(formatcheck);
									} else {
										if (!formatModifyPath.equals(uploadGoodImageName)) {
											System.out.println("當前的圖片和隱藏欄位內的圖片名稱不一樣");
										} else {
											// 先將舊的圖片刪除
											GoodFormat formatcheck = gfService.getById(Integer.parseInt(formatID));
											String goodImagePath = formatcheck.getGoodImagePath();// ex:
																									// ../../goodImages/xxx.jpg
											String[] split = goodImagePath.split("/");
											String oldfilename = split[3];
											String oldrootname = patternPath + oldfilename;
											File file = new File(oldrootname);
											file.delete();
											// 處理新增上去的圖片
											int position = uploadGoodImageName.lastIndexOf(".");
											String imageFormat = uploadGoodImageName.substring(position);// .jpg
											String timeStampFormat = simpleDateFormat.format(new Date());
											String ImgRootFormat = patternPath + timeStampFormat + "" + imageFormat;
											File fileupload = new File(ImgRootFormat);
											try {
												item.transferTo(fileupload);// 將圖片上傳
											} catch (IllegalStateException e) {
												// TODO Auto-generated catch block
												e.printStackTrace();
											} catch (IOException e) {
												// TODO Auto-generated catch block
												e.printStackTrace();
											}
											//
											String dataBaseRootFormat = dataPath + timeStampFormat + "" + imageFormat;
											formatcheck.setGoodImagePath(dataBaseRootFormat);
											formatcheck.setGoodPrice(Integer.parseInt(price));
											formatcheck.setGoodsStock(Integer.parseInt(stock));
											formatcheck.setGoodSize(size);
											gfService.update(formatcheck);// 將規格表寫進資料庫
											checkImageMap.put(uploadGoodImageName, dataBaseRootFormat);
										}
									}
								} else {
									if (dataImageNum[4].equals("YES")) {
										System.out.println("沒上傳圖片的案例已經處理過了");
									} else {
										if (dataImageNum[4].equals("NO")) {
											System.out.println("資料沒有更動");
										}
									}
								}
							} else {
								System.out.println("the length not equal to 5 or 4!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
							}
						}

					}
				}

			}
		}

		// 規格表刪除
		if (deleteFormatDataById.size() == 0)

		{

		} else {
			for (

			Integer item : deleteFormatDataById) {
				if (item == -1) {

				} else {
					GoodFormat format = gfService.getById(item);// 找到對應編號的規格資料
					formatset.remove(format);
					gfService.deleteById(item);
				}
			}
		}
		good.setFormat(formatset);
		good.setImages(imageset);
		gService.update(good);
		return "";
	}
}