package com.good.controller;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.antlr.v4.runtime.dfa.DFA;
import org.eclipse.tags.shaded.org.apache.bcel.generic.NEW;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CharsetEditor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonSubTypes.Type;
import com.good.model.GoodsBean;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/good")
public class GoodController {
	@Autowired
	private GoodService gService;
	@GetMapping("/goodindex.controller")
	public String goodindex() {
		return "good/jsp/goodindex";
	}
	@GetMapping("/goodinsert.controller")
	public String processInsertAction() {
		return "good/jsp/goodinsert";
	}
	@PostMapping("/goodinsert2.controller")
	public String processInsertAction2(@RequestParam("GoodsImg") MultipartFile mf,@RequestParam("GoodsName") String goodsName
			,@RequestParam("GoodsPrice") Integer goodsPrice,@RequestParam("GoodsStock") Integer goodsStock
			,@RequestParam("GoodsDirection") String goodsDirection,@RequestParam("GoodsType") String goodsType
			,@RequestParam("LaunchDate") String date,@RequestParam("Brand") String brand
			,@RequestParam("ShipmentPlace") String shipmentPlace,@RequestParam("GoodSellerID") Integer goodSellerID) {
		String patternPath = "C:/Action/workspace/SpringBootRestfulteam5Hw/src/main/webapp/WEB-INF/goodImages/";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		Date launchDate = null;		
		//取得圖片的格式 並且換上新的名字
		String filename = mf.getOriginalFilename();
		int ps = filename.lastIndexOf(".");
		String patternFormat = filename.substring(ps, filename.length());
		String timeStamp = simpleDateFormat.format(new Date());
		String ImgRoot = timeStamp + "" + patternFormat;
		// 將圖片上傳至指定位置後 將goodsImg改成相對路徑
		File file = new File(patternPath, ImgRoot);
		String goodsImg = "../../goodImages/" + ImgRoot;
		//
		try {
			launchDate = sdf.parse(date);
			mf.transferTo(file);
		} catch (ParseException e) {
			e.printStackTrace();
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		GoodsBean good = new GoodsBean(goodsName, goodsImg, goodsPrice, goodsStock, goodsDirection, goodsType, launchDate, brand, shipmentPlace, goodSellerID);
		gService.insert(good);
		return "good/jsp/goodQueryAll";
	}
	
//	@PostMapping("/gooddelete.controller")
	@DeleteMapping("/gooddelete.controller")
	public void processDeleteAction(@RequestParam("GoodsImg") String imageName,@RequestParam("GoodsID") Integer goodsID) {
//		String goodsImg = mf.getOriginalFilename();//ex: ../../goodImages/XXX.jpg
		//imageName 是相對路徑
		String patternPath = "C:/Action/workspace/SpringBootRestfulteam5Hw/src/main/webapp/WEB-INF/goodImages/";
		int ps = imageName.lastIndexOf("/");
		String goodsImg = imageName.substring(ps, imageName.length());//取得圖片名稱
		File file = new File(patternPath, goodsImg);
		file.delete();
		gService.deleteById(goodsID);
//		return "redirect:/good/jsp/goodQueryAll";
	}
	//
	//
	@GetMapping("/goodquerybyid.controller")
	public GoodsBean processQueryAction() {
		GoodsBean resultBean = gService.getById(100);
		return resultBean;
	}
//	@PostMapping("/goodupdate.controller")
	@PutMapping("/goodupdate.controller")
	public String processUpdateAction(@RequestParam("GoodsImg") MultipartFile mf,@RequestParam("GoodsID") Integer goodsID,@RequestParam("GoodsName") String goodsName
			,@RequestParam("GoodsPrice") Integer goodsPrice,@RequestParam("GoodsStock") Integer goodsStock
			,@RequestParam("GoodsDirection") String goodsDirection,@RequestParam("GoodsType") String goodsType
			,@RequestParam("LaunchDate") String date,@RequestParam("Brand") String brand
			,@RequestParam("ShipmentPlace") String shipmentPlace,@RequestParam("GoodSellerID") Integer goodSellerID) {
//		return gService.update(updateBean);
		String patternPath = "C:/Action/workspace/SpringBootRestfulteam5Hw/src/main/webapp/WEB-INF/goodImages/";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		Date launchDate = null;		
		//取得圖片的格式 並且換上新的名字
		String filename = mf.getOriginalFilename();
		int ps = filename.lastIndexOf(".");
		String patternFormat = filename.substring(ps, filename.length());
		String timeStamp = simpleDateFormat.format(new Date());
		String ImgRoot = timeStamp + "" + patternFormat;
		// 將圖片上傳至指定位置後 將goodsImg改成相對路徑
		File file = new File(patternPath, ImgRoot);
		String goodsImg = "../../goodImages/" + ImgRoot;
		//
		try {
			launchDate = sdf.parse(date);
			mf.transferTo(file);
		} catch (ParseException e) {
			e.printStackTrace();
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		GoodsBean good = new GoodsBean(goodsID, goodsName, goodsImg, goodsPrice, goodsStock, goodsDirection, goodsType, launchDate, brand, shipmentPlace, goodSellerID);
		gService.update(good);
	    return "redirect:/good/goodqueryallpage.controller";
	}
	//
	@GetMapping("/findgood1.controller")
	public List<GoodsBean> processAction1(){
		return gService.findGoods("ma");
	}

	@GetMapping("/findallgoods.controller")
	public List<GoodsBean> processAction3(){
		return gService.getAll();
	}
	
//	/good/goodqueryallpage.controller
	@GetMapping("/goodqueryallpage.controller")
	public String processQueryAllPageAction() {
		return "good/jsp/goodQueryAll";
	}
	@GetMapping("/queryByPage/{pageNo}")
	@ResponseBody
	public List<GoodsBean> processQueryAllByPage(@PathVariable("pageNo") int pageNo,Model m,HttpServletRequest request){
		int pageSize = 3;
		Pageable p1 = PageRequest.of(pageNo-1,pageSize);
		Page<GoodsBean> page = gService.findAllByPage(p1);
		
		int totalPages = page.getTotalPages();
		long totalElement = page.getTotalElements();
		
		HttpSession session = request.getSession();
		session.setAttribute("totalPages", totalPages);
		session.setAttribute("totalElements", totalElement);
		
		
		return page.getContent();
	}
	@GetMapping("/returncontrolUI")
	public String returnControlUI() {
		return "ControlUI";
	}
}
