package com.good.controller;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

import com.good.model.GoodFormat;
import com.good.model.GoodImageBean;
import com.good.model.GoodsBean2;
import com.member.model.MemberBean;
import com.member.model.MemberService;

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

/////////////////////////////////////////////////////新增頁面/////////////////////////////////////////////////
	@PostMapping("InsertGood.controller")
	public String processInsert() {
		return "good/jsp/insertPage";
	}

	@PostMapping("InsertPage.controller")
	public String processInsertAction2(@RequestParam(name = "GoodImages") List<MultipartFile> goodImages,
			@RequestParam("GoodsName") String goodsName, @RequestParam("GoodsType") String goodsType,
			@RequestParam("LaunchDate") String date, @RequestParam("Brand") String brand,
			@RequestParam("ShipmentPlace") String shipmentPlace, @RequestParam("TitleImage") MultipartFile titleImage,
			@RequestParam("GoodDirection") String goodsDirection,
			@RequestParam(name = "hiddenValue") List<String> datakey,
			@RequestParam(name = "GoodFormatImages") List<MultipartFile> formatImages) {
//建立相對路徑
		String dataPath = "../../goodImages/"; // 透過商品編號取得基本商品資訊 然後透過get取得編號對應的圖片集合
		String patternPath = "../../../../../../../../Documents/team5project/SpringBootRestfulteam5Hw/src/main/webapp/WEB-INF/goodImages/"; // 透過商品編號取得基本商品資訊
																																			// 然後透過get取得編號對應的圖片集合
//建立圖片、規格集合
		Set<GoodImageBean> Imageset = new LinkedHashSet<>();
		Set<GoodFormat> formatset = new LinkedHashSet<>();
//建立simpledateformat 一個用來命名 一個用來把字串轉Date
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		Date launchDate = null;
		try {
			launchDate = sdf.parse(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
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
		GoodsBean2 good = new GoodsBean2(goodsName, goodsDirection, goodsType, launchDate, brand, shipmentPlace, seller,
				titleImagePath);
		good.setImages(Imageset);// 商品基本資訊表 連結 商品圖片表
		good.setFormat(formatset);// 商品基本資訊表 連結 商品規格表
		GoodsBean2 insertgood = gService.insert(good);// 新增成功(有商品編號)
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
																							// "../../goodImages/"
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
			goodImageBean.setGood(insertgood);
			goodImageBean.setImagePath(imagePath);
			Imageset.add(goodImageBean);
			giService.insert(goodImageBean);
		}

		insertgood.setImages(Imageset);
		gService.update(insertgood);
		return "";
	}
	/////////////////////////////////////////////////////查詢全部的頁面/////////////////////////////////////////////////
	@GetMapping("/goodQueryAllPageForUser.controller")
	public String processQueryAllPageAction() {
		return "good/jsp/goodQueryAll3";
	}
	//分頁查詢
	@GetMapping("/queryGoodByPage/{goodID}")
	@ResponseBody
	public List<GoodsBean2> processQueryAllByPage(@PathVariable("goodID") int pageNo, Model m,
			HttpServletRequest request) {
		int pageSize = 10;
		Pageable p1 = PageRequest.of(pageNo - 1, pageSize);
		Page<GoodsBean2> page = gService.findAllByPage(p1);

		int totalPages = page.getTotalPages();
		long totalElement = page.getTotalElements();

		HttpSession session = request.getSession();
		session.setAttribute("totalPages", totalPages);
		session.setAttribute("totalElements", totalElement);

		return page.getContent();
	}
	/////////////////////////////////////////////////////修改頁面/////////////////////////////////////////////////
}
