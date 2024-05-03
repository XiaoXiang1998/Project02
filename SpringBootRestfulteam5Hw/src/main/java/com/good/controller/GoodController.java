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

	///////////////////////////////////////////////////// 查詢全部的頁面/////////////////////////////////////////////////
	@GetMapping("/goodQueryAllPageForUser.controller")
	public String processQueryAllPageAction() {
		return "good/jsp/goodQueryAll3";
	}

	// 分頁查詢
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

	// 透過商品編號 查詢商品基本資訊
	// 在查詢全部的頁面中點擊其中一項商品的編輯按鈕
	@GetMapping("goodQuery.controller")
	public String goodMidifyPage() {
//		public String goodMidifyPage(@RequestParam("GoodsID") Integer goodID) {
		int goodID = 3;
		session.setAttribute("goodID", goodID);
		return "good/jsp/modifyPage";
	}

	// -> 進入該商品的編輯頁面
	@GetMapping("/good/{goodID}")
	@ResponseBody
	public GoodsBean2 queryGoodById(@PathVariable("goodID") Integer goodID) {
		System.out.println("WHYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY");
		GoodsBean2 good = gService.getById(goodID);
//		good.setGoodsID(goodID);
		System.out.println(good.toString());
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
			item.setGoodsID(goodID);
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
		String patternPath = "../../../../../../../../Documents/team5project/SpringBootRestfulteam5Hw/src/main/webapp/WEB-INF/goodImages/"; // 透過商品編號取得基本商品資訊

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
			System.out.println("oldRootTitleImage = "+oldRootTitleImage);
			System.out.println("oldRootTitleImage.length() = "+oldRootTitleImage.length());
			int ps = oldRootTitleImage.lastIndexOf("/");System.out.println();
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
			} else {
				String uploadGoodImageName = item.getOriginalFilename();// xxx.jpg
				int check = 0;
				for (String item2 : goodImageshidden) {
					// item2 = "1003/sharkitty18.jpg" 修改
					// item2 = "1003" 沒有修改
					// 需要辨別是該圖片是新增還是修改
					String[] dataImageNum = item2.split("/");
					if (dataImageNum.length == 1) {// 裡面只有圖片編號
						// 啥事不幹
					} else {
						if (dataImageNum.length == 2) {// 裡面有包含圖片編號對應的上傳圖片名稱
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
		}
		for (Integer item : goodDelete) {
			if (item == -1) {

			} else {
				giService.deleteById(item);// 透過商品圖片編號刪除
			}
		}
		// 商品規格表處理
		for (MultipartFile item : goodFormatImages) {// 裡面包含修改圖片 和 新增圖片
			if (item.getOriginalFilename().equals(null)) {// 沒有上傳檔案
				// 啥事不幹
			} else {
				String uploadGoodImageName = item.getOriginalFilename();// xxx.jpg
//				int check = 0;
				for (String item2 : hiddenValue) {
					// item2 = "1003/sharkitty18.jpg" 修改
					// item2 = "1003" 沒有修改
					// 需要辨別是該圖片是新增還是修改
					String[] dataImageNum = item2.split("/");
					if (dataImageNum.length == 4) {// 新增資料
						String size = dataImageNum[0];
						String price = dataImageNum[1];
						String stock = dataImageNum[2];
						String uploadformatImageName = dataImageNum[3];
						// 處理上傳圖片的問題
						GoodFormat goodFormat = new GoodFormat();
						goodFormat.setGood(good);// 連結商品基本資訊
						// 處理新增上去的圖片
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
						goodFormat.setGoodImagePath(dataBaseRootFormat);
						goodFormat.setGoodPrice(Integer.parseInt(price));
						goodFormat.setGoodsStock(Integer.parseInt(stock));
						goodFormat.setGoodSize(size);
						formatset.add(goodFormat);// 將規格表集合起來
						gfService.insert(goodFormat);// 將規格表寫進資料庫
					} else {
						if (dataImageNum.length == 5) {
							// 有三種狀況
							// 1.沒改資料
							// 2.有改資料(但沒修改圖片)
							// 3.有修改圖片
							// 1
							if (dataImageNum[4].equals("NO")) {
								// 啥事不幹
							} else {
								if (dataImageNum[4].equals("YES")) {// 2
									String formatID = dataImageNum[0];
									String size = dataImageNum[1];
									String price = dataImageNum[2];
									String stock = dataImageNum[3];
									GoodFormat goodFormatModify = gfService.getById(Integer.parseInt(formatID));
									goodFormatModify.setGoodSize(size);
									goodFormatModify.setGoodPrice(Integer.parseInt(price));
									goodFormatModify.setGoodsStock(Integer.parseInt(stock));
									goodFormatModify.setGood(good);
									formatset.add(goodFormatModify);
								} else {// 3
									String formatID = dataImageNum[0];
									String size = dataImageNum[1];
									String price = dataImageNum[2];
									String stock = dataImageNum[3];
									String formatModifyPath = dataImageNum[4];
									if (uploadGoodImageName.equals(formatModifyPath)) {
										// 處理圖片上傳問題(把舊圖片刪除)
										GoodFormat goodFormat = gfService.getById(Integer.parseInt(formatID));
										goodFormat.setGood(good);// 連結商品基本資訊
										String goodFormatImagePath = goodFormat.getGoodImagePath();
										int pos = goodFormatImagePath.lastIndexOf("/");// ../../xxx.jpg
										String FormatImagefilename = goodFormatImagePath.substring(pos + 1);
										String FormatImageRootPath = patternPath + FormatImagefilename;
										File oldfile = new File(FormatImageRootPath);
										oldfile.delete();
										// 處理新增上去的圖片
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
										goodFormat.setGoodImagePath(dataBaseRootFormat);
										goodFormat.setGoodPrice(Integer.parseInt(price));
										goodFormat.setGoodsStock(Integer.parseInt(stock));
										goodFormat.setGoodSize(size);
										formatset.add(goodFormat);// 將規格表集合起來
										gfService.update(goodFormat);// 將規格表寫進資料庫
										/**/
									} else {
										System.out.println("Something happen wrong!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
									}

								}
							}
						} else {
							System.out.println("Something happen wrong!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
						}
						//
						if (dataImageNum.length == 2) {// 裡面有包含圖片編號對應的上傳圖片名稱
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
							}

						} else {
							System.out.println("something wrong!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
						}
					}

				}
			}
		}
		// 規格表刪除
		if (deleteFormatDataById.size() == 0) {

		} else {
			for (Integer item : deleteFormatDataById) {
				if (item == -1) {

				} else {
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
