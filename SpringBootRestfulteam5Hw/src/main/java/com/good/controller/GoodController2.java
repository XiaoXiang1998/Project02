package com.good.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;

import org.apache.commons.io.output.ByteArrayOutputStream;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.good.dto.GoodFormatImageDto;
import com.good.dto.GoodLaunchDto;
import com.good.dto.GoodPageDto;
import com.good.dto.GoodPriceDetailDTO;
import com.good.dto.GoodTypeDto;
import com.good.model.GoodFormat;
import com.good.model.GoodImageBean;
import com.good.model.GoodsBean2;
import com.member.model.MemberBean;
import com.member.model.MemberService;
import com.sean.model.OrdersService;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

/*
 基本商品資訊的增刪改查
 商品圖片的增刪改查(對應指定的商品編號)
 商品規格的增刪改查(對應指定的商品編號)
 */
//主頁:/good/goodqueryallpage.controller
@Controller
public class GoodController2 {

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
	@Autowired
	private OrdersService oService;
	@PersistenceContext
	private EntityManager entityManager;

	// 管理者製作的圓餅圖、柱狀圖、曲線圖
	@GetMapping("/mangerGoodChart")
	public String mangerGoodChart() {
		return "good/jsp/mangerGoodChart";
	}

	// 製作圓餅圖 "mangerGoodTypePie"
	@GetMapping("mangerGoodTypePie")
	@ResponseBody
	public List<GoodTypeDto> mangerGoodTypePie() {
		List<GoodTypeDto> goodTypeNumber = new ArrayList();
		Query<Object[]> resultList = (Query<Object[]>) entityManager.createQuery(
				"select distinct g.goodsType AS goodsType,count(g.goodsType) AS goodsTypeNumber from GoodsBean2 g where g.status = 1 GROUP BY g.goodsType");// 在搜尋商品名稱後
																																							// 取得對應種類的數量
		List<Object[]> item = resultList.getResultList();
		for (Object[] item1 : item) {
			GoodTypeDto data = new GoodTypeDto();
			data.setGoodsType((String) item1[0]);
			data.setGoodsTypeNumber((Long) item1[1]);
			goodTypeNumber.add(data);
		}
		return goodTypeNumber;
	}

	// 製作柱狀圖
	// select COUNT(*) from Goods g where DATEDIFF(DAY, GETDATE(), g.LaunchDate) = 0
	@GetMapping("numberOfGoodInsert")
	@ResponseBody
	public List<GoodLaunchDto> numberOfGoodInsert() {
		// (日期,數量)
		List<GoodLaunchDto> itemdtolist = new ArrayList<GoodLaunchDto>();
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("YYYY-MM-dd");
		for (int i = 6; i >= 0; i--) {
			Integer number = gService.findNumberInsertGood(i*(-1));
			String date = simpleDateFormat.format(new Date());
			System.err.println(date);
			String[] split = date.split("-");
			int dayoffset = Integer.parseInt(split[2]) - i;
			String dateResult = split[0] + "-" + split[1] + "-" + dayoffset;
			GoodLaunchDto itemdto = new GoodLaunchDto();
			itemdto.setDate(dateResult);
			itemdto.setGoodsNumber(number);
			itemdtolist.add(itemdto);
		}
		return itemdtolist;
	}

	// 製作曲線圖(每天的訂單金額)
	@GetMapping("numberOfGoodSold")
	@ResponseBody
	public List<GoodLaunchDto> numberOfGoodSold() {
		// SELECT * from ORDERS o where DATEDIFF(day, GETDATE(), o.CREATED_AT)=0 and
		// o.ORDER_STATUS=3
		List<GoodLaunchDto> itemdtolist = new ArrayList<GoodLaunchDto>();
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("YYYY-MM-dd");
		for (int i = 6; i >= 0; i--) {
//			Integer number = gService.findNumberInsertGood(i);
			int benefit = (Integer) oService.GetSoldPerDay(i); // 每天賺到的錢
			String date = simpleDateFormat.format(new Date());
			System.err.println(date);
			String[] split = date.split("-");
			int dayoffset = Integer.parseInt(split[2]) - i;
			String dateResult = split[0] + "-" + split[1] + "-" + dayoffset;
			GoodLaunchDto itemdto = new GoodLaunchDto();
			itemdto.setDate(dateResult);
			itemdto.setGoodsNumber(benefit);
			itemdtolist.add(itemdto);
		}
		return itemdtolist;
	}

	// 管理者查詢全部
	@GetMapping("/goodqueryallpage.controller")
	public String goodqueryallpage(HttpServletRequest request) {// 需要做分頁查詢
		HttpSession session2 = request.getSession();
		List<GoodsBean2> allGood = gService.getAll();
		session2.setAttribute("goodBasicInfo", allGood);
		return "good/jsp/mangerGoodQueryAll";
	}

	// 管理者查詢全部(分頁查詢)
	@GetMapping("/mangerqueryByPageStatus/{hidden}")
	@ResponseBody
	public GoodPageDto processQueryAllByPage(@PathVariable("hidden") String hidden) {
//		hidden: 1_上架商品_鯊 or 1_下架商品_鯊 or 1_全部商品_鯊
		String[] split = hidden.split("_");
		System.err.println("hidden = " + hidden);
		int pageNo = Integer.parseInt(split[0]);
		System.err.println("pageNo = " + pageNo);
		String status = split[1];
		System.err.println("status = " + status);
		String goodNameString = split[2];
		System.err.println("goodNameString = " + goodNameString);
		int pageSize = 10;
		Pageable p1 = PageRequest.of(pageNo - 1, pageSize);
		Page<GoodsBean2> page = null;
		switch (status) {
		case "上架商品":
			if (goodNameString.equals("XXX")) {// 沒有輸入商品名稱
				page = gService.findGoodByPageOnMarket(p1);
			} else {
				page = gService.findGoodByPageAndNameOnMarket(p1, goodNameString);
			}
			break;
		case "下架商品":
			if (goodNameString.equals("XXX")) {// 沒有輸入商品名稱
				page = gService.findGoodByPageDiscontinue(p1);
			} else {
				page = gService.findGoodByPageAndNameDiscontinue(p1, goodNameString);
			}
			break;
		case "違規商品":
			if (goodNameString.equals("XXX")) {// 沒有輸入商品名稱
				page = gService.findGoodByPageBAN(p1);
			} else {
				page = gService.findGoodByPageAndNameBAN(p1, goodNameString);
			}
			break;
		case "全部商品":
			if (goodNameString.equals("XXX")) {// 沒有輸入商品名稱
				page = gService.findAllByPage(p1);
			} else {
				page = gService.findGoodByPageAndNameAll(p1, goodNameString);

			}
			break;
		default:
			System.out.println("something wrong!!!!!!!!print hidden = " + hidden);
			break;
		}
		List<GoodsBean2> test = page.getContent();
		for (GoodsBean2 item : test) {
			System.err.println(item.getBrand() + "," + item.getGoodsDirection() + "," + item.getGoodsName() + ","
					+ item.getGoodsType() + "," + item.getShipmentPlace() + "," + item.getTitleImage() + ","
					+ item.getGoodsID() + "," + item.getGoodsold() + "," + item.getNumberRatings() + ","
					+ item.getRating() + "," + item.getLaunchDate() + "," + item.getGoodsSellerID());
		}
		int totalPages;
		long totalElement;
		if (page == null) {
			System.err.println("page變數內沒有資料");
			totalPages = 0;
			GoodPageDto goodPagedto = new GoodPageDto();
			List<GoodsBean2> good = null;
			goodPagedto.setGood(good);
			goodPagedto.setPage(totalPages);
			return goodPagedto;
		} else {
			System.err.println("page變數內有資料");
			totalPages = page.getTotalPages();
			totalElement = page.getTotalElements();
			List<GoodsBean2> good = page.getContent();
			GoodPageDto goodPagedto = new GoodPageDto();
			goodPagedto.setGood(good);
			goodPagedto.setPage(totalPages);
			return goodPagedto;
		}

//		HttpSession session = request.getSession();
		// 沒法及時更改頁數
//		session.setAttribute("totalPages", totalPages);
//		session.setAttribute("totalElements", totalElement);
		//
	}

	// 管理者查詢全部->檢視商品詳細資訊
	@GetMapping("/goodDetailReviewByManger.controller")
	public String goodDetailReviewByManger(@RequestParam("GoodID") Integer goodID, Model m) {
//		HttpSession session = request.getSession();
//		session.setAttribute("GoodID", goodID);\
		// 商品詳細資料需要(商品名稱、商品種類、商品價格範圍、商品平均評分)
		GoodsBean2 good = gService.getById(goodID); // 取得對應商品編號
		// 取得對應商品的種類(related good) 只取商品編號

		//
		Query<Object[]> resultList = (Query<Object[]>) entityManager.createQuery(
//				select min(gf.goodPrice) AS minprice,max(gf.goodPrice) AS maxprice, g.goodsID AS goodsID 
//				from Goods g join GoodFormat gf on g.GoodsID = gf.GoodsID 
//				where g.GoodsID = 1 
//				group by g.GoodsID
				"select min(gf.goodPrice) AS minprice,max(gf.goodPrice) AS maxprice, g.goodsID AS goodsID from GoodsBean2 g join GoodFormat gf on g.goodsID = gf.good.goodsID where g.goodsID = "
						+ good.getGoodsID() + " group by g.goodsID");// 在特定賣家下查詢商品，並取得不同編號下的最大和最小價格
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
			if (good.getGoodsold() == null || good.getGoodsold() == 0) {
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
		for (String item : distinctFormatImage) {
			GoodFormatImageDto goodformatimage = new GoodFormatImageDto();
			goodformatimage.setGoodImagePath(item);
			goodformatimagelist.add(goodformatimage);
		}

		m.addAttribute("Good", good);
		m.addAttribute("GoodFormat", byIDOrderByFormatImage);
		m.addAttribute("GoodFormatNumber", byIDOrderByFormatImage.size());
		m.addAttribute("GoodFormatImagePath", goodformatimagelist);
		m.addAttribute("GoodFormatImagePathNumber", distinctFormatImage.size());
		m.addAttribute("GoodImage", findImagesByID);
		m.addAttribute("GoodImageNumber", findImagesByID.size());
		m.addAttribute("GoodBasicInfo", result);

		m.addAttribute("GoodImageNumber", findImagesByID.size()); //
		m.addAttribute("GoodBasicInfo", result); // 商品詳細資訊
		return "good/jsp/goodDetailReviewByManger";
	}

	@GetMapping("produceCSVAndCopiedImage") // 打開來是亂碼
	@ResponseBody
	public String outputCSV() throws IOException {
		List<GoodsBean2> goodlist = gService.getAll();
		List<GoodImageBean> goodimagelist = giService.getAll();
		List<GoodFormat> goodformatlist = gfService.getAll();
		ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
		String content = "商品編號,商品名稱,商品說明,商品種類,上架日期,品牌,出貨地,評分次數,總評分,賣家編號,封面照,售出次數,商品狀態\r\n";
		String content1 = "圖片編號,圖片路徑,商品編號\r\n";
		String content2 = "規格編號,規格大小,單價,規格圖片路徑,庫存量,商品編號\r\n";
		for (GoodsBean2 item : goodlist) {
			String rowdata = item.csvoutput();
			content = content + rowdata; // content 是字串
		}
		for (GoodImageBean item : goodimagelist) {
			String rowdata = item.csvoutput();
			content1 = content1 + rowdata; // content 是字串
		}
		for (GoodFormat item : goodformatlist) {
			String rowdata = item.csvoutput();
			content2 = content2 + rowdata; // content 是字串
		}

		File fileGoodBasic = new File("./Goodcsv/GoodBasic.csv");
		File fileGoodImage = new File("./Goodcsv/GoodImage.csv");
		File fileGoodFormat = new File("./Goodcsv/GoodFormat.csv");
		if (fileGoodBasic.exists()) {

		} else {
			fileGoodBasic.createNewFile();
			try (FileOutputStream fos = new FileOutputStream(fileGoodBasic);
					BufferedOutputStream bos = new BufferedOutputStream(fos);
					OutputStreamWriter osw = new OutputStreamWriter(bos, "UTF-8");) {
				osw.write(content);
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		if (fileGoodImage.exists()) {

		} else {
			fileGoodImage.createNewFile();
			try (FileOutputStream fos = new FileOutputStream(fileGoodImage);
					BufferedOutputStream bos = new BufferedOutputStream(fos);
					OutputStreamWriter osw = new OutputStreamWriter(bos, "UTF-8");) {
				osw.write(content1);
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		if (fileGoodFormat.exists()) {

		} else {
			fileGoodFormat.createNewFile();
			try (FileOutputStream fos = new FileOutputStream(fileGoodFormat);
					BufferedOutputStream bos = new BufferedOutputStream(fos);
					OutputStreamWriter osw = new OutputStreamWriter(bos, "UTF-8");) {
				osw.write(content2);
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		// 取goodImages內的圖片
		File currentFile = new File("");
		System.err.println("當前絕對路徑:" + currentFile.getAbsolutePath());
		String destinationPos = "";
		File imageFileFolder = new File("src/main/webapp/WEB-INF/goodImages");
		String[] imageFileList = imageFileFolder.list();
		File imageFile;
		for (String item : imageFileList) {
			imageFile = new File("src/main/webapp/WEB-INF/goodImages/" + item);
			File outputfile = new File("./GoodImage/" + item);
			
			try (FileInputStream fileInputStream = new FileInputStream(imageFile);
				BufferedInputStream bufferedInputStream = new BufferedInputStream(fileInputStream);
				InputStreamReader inputStreamReader = new InputStreamReader(bufferedInputStream);
				FileOutputStream fileOutputStream = new FileOutputStream(outputfile);
				BufferedReader bufferedReader = new BufferedReader(inputStreamReader)){
				int len1;
					byte[] resbyte1 = new byte[1024];
					while ((len1 = fileInputStream.read(resbyte1)) != -1) {
						fileOutputStream.write(resbyte1, 0, len1);
					}
				}
			}
		
		return "";
	}

}