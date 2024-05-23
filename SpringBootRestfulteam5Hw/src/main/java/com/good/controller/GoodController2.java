package com.good.controller;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;

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
import com.good.dto.GoodPageDto;
import com.good.dto.GoodPriceDetailDTO;
import com.good.model.GoodFormat;
import com.good.model.GoodImageBean;
import com.good.model.GoodsBean2;
import com.member.model.MemberBean;
import com.member.model.MemberService;

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
	@PersistenceContext
	private EntityManager entityManager;
//在跳脫視窗(商品圖片表)點擊新增圖片
/*
	@PostMapping("/goodImageinsert.controller")
	public String processImageInsertAction(@RequestParam MultiValueMap<String, MultipartFile> files,
			@RequestParam("GoodsID") Integer goodsID) {
		
		// 插入多張圖片 並且為上船的圖片重新命名 需要商品編號
		 
		// 建立命名方式和圖片路徑
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		String dataPath = "../../goodImages/"; // 透過商品編號取得基本商品資訊 然後透過get取得編號對應的圖片集合
//		String patternPath = "../../../../../../../../Documents/team5project/SpringBootRestfulteam5Hw/src/main/webapp/WEB-INF/goodImages/";		//透過商品編號取得基本商品資訊 然後透過get取得編號對應的圖片集合
		String patternPath = "../../../../../../../../../../team5project/SpringBootRestfulteam5Hw/src/main/webapp/WEB-INF/goodImages/"; // 透過商品編號取得基本商品資訊

		GoodsBean2 insertGood = gService.getById(goodsID);
		Set<GoodImageBean> Imageset = insertGood.getImages();
		GoodImageBean goodImage = null;
		System.out.println("files.size() = " + files.size() + "??AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
		// 取得圖片的格式 並且換上新的名字
		for (Map.Entry<String, List<MultipartFile>> entry : files.entrySet()) {
			List<MultipartFile> fileList = entry.getValue();
			for (MultipartFile multipartFile : fileList) {// 裡面迴圈處理圖片
// entry.getKey():input標籤中的name屬性
// multipartFile.getOriginalFilename():上傳檔案的名稱
//1.取得圖片格式
				String filename = multipartFile.getOriginalFilename();
				int ps = filename.lastIndexOf(".");
				String patternFormat = filename.substring(ps, filename.length());
//2.給予新的名字
				String timeStamp = simpleDateFormat.format(new Date());
//				String ImgRoot = timeStamp + "" + patternFormat;
				String ImgRoot = patternPath + timeStamp + "" + patternFormat;
//3.將圖片上傳
//				File file = new File(patternPath, ImgRoot);
				File file = new File(ImgRoot);
				try {
					multipartFile.transferTo(file);
				} catch (IllegalStateException e) {
// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
// TODO Auto-generated catch block
					e.printStackTrace();
				}
//4.把相對路徑丟進GoodImageBean
				String goodsImg = dataPath + timeStamp + "" + patternFormat;
				goodImage = new GoodImageBean();

				goodImage.setImagePath(goodsImg);
				goodImage.setGood(insertGood);// 將圖片表連結商品基本資訊表
				giService.insert(goodImage);// 將圖片塞入圖片資料表
				Imageset.add(goodImage);// 將類別寫入Set集合
// Imageset.add(goodImage);
			}
		}
		//
		return "redirect:/goodqueryallpage.controller";
	}
	*/
	/**/

	/**/
	// 新增基本商品資訊(裡面有新增圖片這個按鈕 點下去可以新增圖片)有上傳圖片
	@PostMapping("/goodinsert2.controller")
	public String processInsertAction2(@RequestParam MultiValueMap<String, MultipartFile> files,
			@RequestParam("GoodsName") String goodsName, @RequestParam("GoodsDirection") String goodsDirection,
			@RequestParam("GoodsType") String goodsType, @RequestParam("LaunchDate") String date,
			@RequestParam("Brand") String brand, @RequestParam("ShipmentPlace") String shipmentPlace) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date launchDate = null;
		try {
			launchDate = sdf.parse(date);
		} catch (ParseException e) {
// TODO Auto-generated catch block
			e.printStackTrace();
		}
//新增商品基本資訊(有封面照屬性)
		GoodsBean2 insertGood = new GoodsBean2();
//新增分兩階段
//1.加入商品基本資訊 和 想放進去的圖片
//2.規格表資訊
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS");
//		String patternPath = "C:/Users/88691/Documents/team5project/SpringBootRestfulteam5Hw/src/main/webapp/WEB-INF/goodImages/";		//透過商品編號取得基本商品資訊 然後透過get取得編號對應的圖片集合
		String dataPath = "../../goodImages/"; // 透過商品編號取得基本商品資訊 然後透過get取得編號對應的圖片集合
//		String patternPath = "../../../../../../../../Documents/team5project/SpringBootRestfulteam5Hw/src/main/webapp/WEB-INF/goodImages/";		//透過商品編號取得基本商品資訊 然後透過get取得編號對應的圖片集合
		String patternPath = "../../../../../../../../../../team5project/SpringBootRestfulteam5Hw/src/main/webapp/WEB-INF/goodImages/"; // 透過商品編號取得基本商品資訊

		GoodImageBean goodImage = null;
		Set<GoodImageBean> Imageset = new LinkedHashSet<>();
// Set Imageset = new HashSet<GoodImageBean>();
// insertGood.setImages(Set<GoodImageBean> images)
		int titlephotocheck = 1;
		// 將值帶入insertGood類別 連線用的
		MemberBean member = (MemberBean) session.getAttribute("member");
		Integer goodSellerId = member.getSid();
		Optional<MemberBean> members = mService.findById(goodSellerId);
		MemberBean seller = members.get();
		//
		insertGood.setBrand(brand);
		insertGood.setGoodsDirection(goodsDirection);
		insertGood.setGoodsName(goodsName);
		insertGood.setGoodsSellerID(seller);
		insertGood.setGoodsType(goodsType);
		insertGood.setLaunchDate(launchDate);
		insertGood.setShipmentPlace(shipmentPlace);
		System.out.println("files.size() = " + files.size() + "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
		if (files.size() == 0) {// 沒有圖片直接將資料寫入資料庫
			gService.insert(insertGood);
		} else {// 有上傳圖片才需要處理圖片
			for (Map.Entry<String, List<MultipartFile>> entry : files.entrySet()) {
				List<MultipartFile> fileList = entry.getValue();
				for (MultipartFile multipartFile : fileList) {// 裡面迴圈處理圖片
// entry.getKey():input標籤中的name屬性
// multipartFile.getOriginalFilename():上傳檔案的名稱
//1.取得圖片格式
					String filename = multipartFile.getOriginalFilename();
					int ps = filename.lastIndexOf(".");
					String patternFormat = filename.substring(ps, filename.length());
//2.給予新的名字
					String timeStamp = simpleDateFormat.format(new Date());
//					String ImgRoot = timeStamp + "" + patternFormat;
					String ImgRoot = patternPath + timeStamp + "" + patternFormat;
//3.將圖片上傳
//					File file = new File(patternPath, ImgRoot);
					File file = new File(ImgRoot);
					try {
						multipartFile.transferTo(file);
					} catch (IllegalStateException e) {
// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (IOException e) {
// TODO Auto-generated catch block
						e.printStackTrace();
					}
//4.把相對路徑丟進GoodImageBean
//					String goodsImg = "../../goodImages/" + ImgRoot;//
					String goodsImg = dataPath + "" + timeStamp + patternFormat;// dataPath = "../../goodImages/"
					if (titlephotocheck == 1) {// 第一張照片當作封面

						insertGood.setTitleImage(goodsImg);
//						GoodsBean2 good = new GoodsBean2(goodsName, goodsDirection, goodsType, launchDate, brand, shipmentPlace, goodSellerID, goodsImg);
						insertGood = gService.insert(insertGood);
						titlephotocheck++;
					}
					goodImage = new GoodImageBean();
					goodImage.setImagePath(goodsImg);// 將圖片塞入圖片資料表
					goodImage.setGood(insertGood);// 將圖片表連結商品基本資訊表
					giService.insert(goodImage);// 將商品圖片表寫進資料庫
					Imageset.add(goodImage);// 將類別寫入Set集合
				}
			}
			insertGood.setImages(Imageset);// 將商品基本資訊表連結圖片表
			gService.insert(insertGood);// 將商品基本資訊寫入資料庫
		}
// 將圖片上傳至指定位置後 將goodsImg改成相對路徑
		return "redirect:/goodqueryallpage.controller";
	}

//有三種刪除。1.刪除商品基本資訊(連帶刪掉其他兩張表的資訊)
//2.單純刪掉圖片
//3.刪掉某一規格
	// 1.刪除商品基本資訊(連帶刪掉其他兩張表的資訊)
	

	// 2.單純刪掉圖片
	@PostMapping("/goodImagedelete.controller")
	public String processDeleteGoodImageAction1(@RequestParam("GoodImageID") List<String> goodImageID,
			@RequestParam("GoodsID") String goodID) {
		// 透過商品編號取得基本商品資訊 然後透過get取得編號對應的圖片集合
//		String patternPath = "C:/Users/88691/Documents/team5project/SpringBootRestfulteam5Hw/src/main/webapp/WEB-INF/goodImages/";		//透過商品編號取得基本商品資訊 然後透過get取得編號對應的圖片集合
		String dataPath = "../../goodImages/";
//		String patternPath = "../../../../../../../../Documents/team5project/SpringBootRestfulteam5Hw/src/main/webapp/WEB-INF/goodImages/";		//透過商品編號取得基本商品資訊 然後透過get取得編號對應的圖片集合
		String patternPath = "../../../../../../../../../../team5project/SpringBootRestfulteam5Hw/src/main/webapp/WEB-INF/goodImages/"; // 透過商品編號取得基本商品資訊

		for (String item : goodImageID) {
			// 將檔案刪掉
			GoodImageBean imageBean = giService.getByID(Integer.parseInt(item));
			String rootname = imageBean.getImagePath();
			int ps = rootname.lastIndexOf("/");// ex:../../sharkitty18.jpg
			String filename = rootname.substring(ps + 1, rootname.length());// sharkitty18.jpg
			File file = new File(patternPath + "" + filename);
			file.delete();
			// 將對應的資料庫內容刪掉
			giService.deleteById(Integer.parseInt(item));
		}
		// 需要有商品編號(抓商品封面照 如果商品封面照被刪掉 由下一張替補 )
		GoodsBean2 good = gService.getById(Integer.parseInt(goodID));
		String imagePath = good.getTitleImage();// ex:../../sharkitty18.jpg
		int ps = imagePath.lastIndexOf("/");
//		File titleimagefile = new File(patternPath,imagePath.substring(ps+1, imagePath.length()));
		File titleimagefile = new File(patternPath + "" + imagePath.substring(ps + 1, imagePath.length()));
		if (titleimagefile.exists()) {
			System.out.println("title Image exist");
		} else {// 封面照片被刪掉
			Set<GoodImageBean> images = good.getImages();
			if (images.size() == 0) {// 被刪到沒圖片
				good.setTitleImage(null);
			} else {// 還有圖片存在
				for (GoodImageBean item : images) {
					good.setTitleImage(item.getImagePath());
					break;
				}
			}
			gService.update(good);// 把資料寫進資料庫
		}
		//
		return "redirect:/goodqueryallpage.controller";
	}

	// 修改基本商品資訊
	@PostMapping("/goodupdate.controller")
	public String processUpdateAction(@RequestParam(value = "GoodsID", required = false) Integer goodsID,
			@RequestParam("GoodsName") String goodsName, @RequestParam("GoodsDirection") String goodsDirection,
			@RequestParam("GoodsType") String goodsType, @RequestParam("LaunchDate") String date,
			@RequestParam("Brand") String brand, @RequestParam("ShipmentPlace") String shipmentPlace,
			@RequestParam(name = "TitleImage", required = false) MultipartFile mf) {
		// 封面照允許空值
		// 透過商品編號取得基本商品資訊 然後透過get取得編號對應的圖片集合
//		String patternPath = "C:/Users/88691/Documents/team5project/SpringBootRestfulteam5Hw/src/main/webapp/WEB-INF/goodImages/";		//透過商品編號取得基本商品資訊 然後透過get取得編號對應的圖片集合
		String dataPath = "../../goodImages/";
//		String patternPath = "../../../../../../../../Documents/team5project/SpringBootRestfulteam5Hw/src/main/webapp/WEB-INF/goodImages/";		//透過商品編號取得基本商品資訊 然後透過get取得編號對應的圖片集合
		String patternPath = "../../../../../../../../../../team5project/SpringBootRestfulteam5Hw/src/main/webapp/WEB-INF/goodImages/"; // 透過商品編號取得基本商品資訊

		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		String uploadfilename = mf.getOriginalFilename();
		GoodsBean2 good = gService.getById(goodsID);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date launchDate = null;
		try {// 將更新過後的變數寫入
			good.setGoodsName(goodsName);
			good.setGoodsDirection(goodsDirection);
			good.setGoodsType(goodsType);
			launchDate = sdf.parse(date);
			good.setLaunchDate(launchDate);
			good.setBrand(brand);
			good.setShipmentPlace(shipmentPlace);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (uploadfilename.equals("")) {// 沒有上傳圖片

		} else {// 圖片有上傳
			int ps = uploadfilename.lastIndexOf(".");
			String patternFormat = uploadfilename.substring(ps, uploadfilename.length());
			String timeStamp = simpleDateFormat.format(new Date());
//			String ImgRoot = timeStamp + "" + patternFormat;
			String ImgRoot = patternPath + timeStamp + "" + patternFormat;
//			File file = new File(patternPath,ImgRoot);
			File file = new File(ImgRoot);
			try {
				mf.transferTo(file);// 上傳檔案
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			String goodsImg = "../../goodImages/" + timeStamp + "" + patternFormat;
			good.setTitleImage(goodsImg);
		}
		gService.update(good);
		return "redirect:/goodqueryallpage.controller";
	}

	// 在跳脫視窗(商品圖片表)修改多張圖片
	/*
	@PostMapping("/goodImagemodify.controller")
	public String processUpdateImageAction(
			@RequestParam(name = "ControllerData") List<String> goodImageIDUploadFileName,
			@RequestParam MultiValueMap<String, MultipartFile> files) {
		// 商品基本資訊資料表多了(封面照片) 移除(庫存量) ControllerData =
		  //(goodID/goodImageID/uploadfilename)
		 
		
		// 透過商品編號取得基本商品資訊 然後透過get取得編號對應的圖片集合
//		String patternPath = "C:/Users/88691/Documents/team5project/SpringBootRestfulteam5Hw/src/main/webapp/WEB-INF/goodImages/";		//透過商品編號取得基本商品資訊 然後透過get取得編號對應的圖片集合
		String dataPath = "../../goodImages/";
//		String patternPath = "../../../../../../../../Documents/team5project/SpringBootRestfulteam5Hw/src/main/webapp/WEB-INF/goodImages/";		//透過商品編號取得基本商品資訊 然後透過get取得編號對應的圖片集合
		String patternPath = "../../../../../../../../../../team5project/SpringBootRestfulteam5Hw/src/main/webapp/WEB-INF/goodImages/"; // 透過商品編號取得基本商品資訊

		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		System.out.println("files.size()=" + files.size());

		for (Map.Entry<String, List<MultipartFile>> entry : files.entrySet()) {
			List<MultipartFile> fileList = entry.getValue();
			for (MultipartFile multipartFile : fileList) {// 裡面迴圈處理圖片
				// entry.getKey():input標籤中的name屬性
				// multipartFile.getOriginalFilename():上傳檔案的名稱
				String filename = multipartFile.getOriginalFilename();
				System.out.println("multipartFile.getOriginalFilename():" + filename);
				if (filename.equals("")) {

				} else {
					for (String item : goodImageIDUploadFileName) {// item的值為 goodID/imageID/sharkitty.jpg
						System.out.println("ControllerData = " + item);
						int ps1 = item.lastIndexOf("/");
						int ps2 = item.indexOf("/");
						String imageID = item.substring(ps2 + 1, ps1);
						String goodID = item.substring(0, ps2);
						String uploadfilename = item.substring(ps1 + 1, item.length());// 取得 sharkitty.jpg
						System.out.println("imageID = " + imageID);
						System.out.println("goodID = " + goodID);
						GoodsBean2 good = gService.getById(Integer.parseInt(goodID));
						String titleRootImagePath = good.getTitleImage();// ex:../../xxx.jpg
						int titleps = titleRootImagePath.lastIndexOf("/");
						String titleImageName = titleRootImagePath.substring(titleps + 1, titleRootImagePath.length());
						System.out.println("uploadfilename=" + uploadfilename);
						System.out.println("titlefilename=" + titleImageName);
						if (filename.equals(uploadfilename)) {// 假若檔名相同
							// 將舊的圖片檔案刪除
							System.out.println("imageID = " + imageID);
							GoodImageBean imageBean = giService.getByID(Integer.parseInt(imageID));
							String oldRootPath = imageBean.getImagePath();// ../../xxx.jpg
							int ps3 = oldRootPath.lastIndexOf("/");
							System.out.println("oldRootPath.substring(ps2+1,oldRootPath.length()):"
									+ oldRootPath.substring(ps3 + 1, oldRootPath.length()));
//							File oldfile = new File(patternPath,oldRootPath.substring(ps3+1,oldRootPath.length()));
							File oldfile = new File(
									patternPath + "" + oldRootPath.substring(ps3 + 1, oldRootPath.length()));

							System.out.println("檔案是否存在:" + oldfile.exists());
							Boolean result = oldfile.delete();
							System.out.println("是否將檔案刪除了?" + result);
							// 將檔案名稱更改
							String timeStamp = simpleDateFormat.format(new Date());
							int ps4 = uploadfilename.lastIndexOf(".");
							String fileformat = uploadfilename.substring(ps4, uploadfilename.length());
							String ImageFilename = timeStamp + fileformat + "";// "abcd" + ".jpg"
							// 將檔案上傳至指定位置
							File newfile = new File(patternPath + "" + ImageFilename);
							try {
								multipartFile.transferTo(newfile);
							} catch (IllegalStateException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							} catch (IOException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
							// 將圖片路徑寫進資料庫
							String goodsImg = dataPath + ImageFilename;
							System.out.println("goodsImg = " + goodsImg);
							imageBean.setImagePath(goodsImg);
							giService.update(imageBean);
							// 檢查封面照片是不是本次目標
							if (titleImageName.equals(uploadfilename)) {
								// 代表封面照被刪掉了
								System.out.println("不要啊!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!封面照被刪掉了");
								Set<GoodImageBean> images = good.getImages();
								String imagePath = null;
								for (GoodImageBean photo : images) {
									imagePath = photo.getImagePath();
									break;
								}
								good.setTitleImage(imagePath);// 更換封面照
								gService.update(good);// 寫入資料庫
							}
							break;
						}
					}
				}
			}
		}
		return "redirect:/goodqueryallpage.controller";
	}
*/

	// 管理者製作的圓餅圖
	@GetMapping("/mangerGoodChart")
	public String mangerGoodChart() {
		return "good/jsp/mangerGoodChart";
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
		System.err.println("hidden = "+hidden);
		int pageNo = Integer.parseInt(split[0]);System.err.println("pageNo = "+pageNo);
		String status = split[1];
		System.err.println("status = " + status);
		String goodNameString = split[2];
		System.err.println("goodNameString = "+goodNameString);
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
		case "全部商品":
			if (goodNameString.equals("XXX")) {// 沒有輸入商品名稱
				page = gService.findAllByPage(p1);
			} else {
				page = gService.findGoodByPageAndNameAll(p1, goodNameString);
				List<GoodsBean2> test = page.getContent();
				for(GoodsBean2 item:test) {
					System.err.println(item.getBrand() +","+item.getGoodsDirection() +","+item.getGoodsName() +","+item.getGoodsType() +","+
				item.getShipmentPlace() +","+
							item.getTitleImage() +","+item.getGoodsID() +","+item.getGoodsold() +","+item.getNumberRatings() +","+item.getRating() +
							","+item.getLaunchDate() +","+
							item.getGoodsSellerID() );
				}
			}
			break;
		default:
			System.out.println("something wrong!!!!!!!!print hidden = " + hidden);
			break;
		}
		int totalPages;
		long totalElement;
		if (page == null) {
			totalPages = 0;
			GoodPageDto goodPagedto = new GoodPageDto();
			List<GoodsBean2> good = null;
			goodPagedto.setGood(good);
			goodPagedto.setPage(totalPages);
			return goodPagedto;
		} else {
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

	// 分頁查詢
//	@GetMapping("/queryByPage/{pageNo}")
//	@ResponseBody
//	public List<GoodsBean2> processQueryAllByPage(@PathVariable("pageNo") int pageNo, Model m,
//			HttpServletRequest request) {
//		int pageSize = 3;
//		Pageable p1 = PageRequest.of(pageNo - 1, pageSize);
//		Page<GoodsBean2> page = gService.findAllByPage(p1);
//
//		int totalPages = page.getTotalPages();
//		long totalElement = page.getTotalElements();
//
//		HttpSession session = request.getSession();
//		session.setAttribute("totalPages", totalPages);
//		session.setAttribute("totalElements", totalElement);
//
//		return page.getContent();
//	}
	/*
	@GetMapping("/getallgood.controller")
	@ResponseBody
	public List<GoodsBean2> processQueryAll() {
		List<GoodsBean2> goods = gService.getAll();
		for (GoodsBean2 item : goods) {
			System.out.println(item.toString());
			//
			Set<GoodFormat> format = item.getFormat();
			Set<GoodImageBean> images = item.getImages();
			for (GoodFormat item2 : format) {
				System.out.println(item2.toString());
			}

			for (GoodImageBean item3 : images) {
				System.out.println(item3.toString());
			}
		}
		return goods;
	}
*/
	/** 處理規格表 */
	/*
	@PostMapping("/goodformatdelete.controller")
	public String processInsertGoodForamtAction(@RequestParam("GoodsID") Integer goodsID,
			@RequestParam("GoodSize") String goodSize, @RequestParam("GoodPrice") Integer goodPrice,
			@RequestParam("GoodImagePath") MultipartFile mf, @RequestParam("GoodsStock") Integer goodStock) {
//		String patternPath = "../../goodImags/";		//透過商品編號取得基本商品資訊 然後透過get取得編號對應的圖片集合
		String patternPath = "../../../../../../../../../../team5project/SpringBootRestfulteam5Hw/src/main/webapp/WEB-INF/goodImages/"; // 透過商品編號取得基本商品資訊

		// 新寫的code 
		GoodsBean2 good = gService.getById(goodsID);// 透過ID找出商品基本資訊
		Set<GoodImageBean> images = good.getImages();// 找到連結的圖片,假如商品編號為1的圖片有三張,就會有3個images類別
//將set裡的路徑資料取出來 並且將圖片刪掉
		for (GoodImageBean item : images) {
			String goodsImg = item.getImagePath();
			int ps = goodsImg.lastIndexOf("/");
			File file = new File(patternPath, goodsImg);
			file.delete();
		}
//最後再將商品基本資訊表刪除
		gService.deleteById(goodsID);// 當父表被刪除時，子表也會被刪除
//		return "redirect:/good/goodqueryallpage.controller";
		return "good/jsp/goodQueryAll2";
	}
*/
}