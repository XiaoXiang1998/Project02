package com.sean.controller;

import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.net.URLEncoder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.good.controller.GoodFormatService;
import com.good.controller.GoodService;
import com.good.model.GoodFormat;
import com.good.model.GoodsBean2;
import com.member.model.MemberBean;
import com.member.model.MemberService;
import com.sean.model.CarItem;
import com.sean.model.CarItemService;
import com.sean.model.Orders;
import com.sean.model.OrdersService;
import com.sean.model.PaymentDetails;
import com.sean.model.PaymentDetailsService;

import jakarta.servlet.http.HttpSession;

@Controller
public class OrderController {
	@Autowired
	private CarItemService cService;

	@Autowired
	private GoodFormatService gService;
	@Autowired
	private GoodService gdService;
	@Autowired
	private MemberService mService;

	@Autowired
	private PaymentDetailsService pService;

	@Autowired
	private OrdersService oService;
	
	@Autowired
	private HttpSession session;
	
	@GetMapping("goindex.controller")
	public String GoIndex(Model m) {
		m.addAttribute("page","index");
		return "Order/jsp/Index";
	}
	
	
	
	@GetMapping("goquery.controller")
	public String GoQuery(Model m) {
		m.addAttribute("page","query");
		return "/Order/jsp/Query";
	}
	@GetMapping("goui.controller")
	public String GoUI() {
		return "ControlUI";
	}

	@GetMapping("shopcar.controller")
	public String ShopCar(Integer MemberId, Model m) {
		MemberBean member =(MemberBean)session.getAttribute("member");
		Integer memberId = member.getSid();
		List<CarItem> carItems = cService.findByMemberId(memberId);
		m.addAttribute("page","shopcar");
		m.addAttribute("carItems", carItems);
		return "Order/jsp/ShopCar";
	}

	@GetMapping("product.controller")
	public String Product(Model m) {
		List<GoodFormat> products = gService.getAll();
		m.addAttribute("products", products);
		m.addAttribute("page","product");
		return "Order/jsp/Product";
	}

	@PostMapping("inserttoshopcar.controller")
	public String insertToShopCar(@RequestParam("productId") Integer productId,
			@RequestParam("quantity") Integer quantity, @RequestParam("productPrice") Integer productPrice) {
		MemberBean memberb =(MemberBean)session.getAttribute("member");
		Integer memberId = memberb.getSid();
		Optional<MemberBean> members = mService.findById(memberId);
		MemberBean member = members.get();
		Optional<GoodFormat> goods = gService.findById(productId);
		GoodFormat good = goods.get();
		CarItem carItem = new CarItem();
		carItem.setMember(member);
		carItem.setGood(good);
		carItem.setPrice(productPrice);
		carItem.setQuantity(quantity);
		cService.insertToShopCar(carItem);
		return "Order/jsp/Product";
	}

	@PutMapping("updateQuantity.controller")
	public String UpdateQuantityById(@RequestParam("itemId") Integer cartItemId,
			@RequestParam("quantity") Integer quantity, Model m) {
		MemberBean memberb =(MemberBean)session.getAttribute("member");
		Integer memberId = memberb.getSid();
		cService.updateQuantityById(quantity, cartItemId);
		List<CarItem> carItems = cService.findByMemberId(memberId);
		m.addAttribute("carItems", carItems);
		return "Order/jsp/ShopCar";
	}

	@DeleteMapping("/deleteCartItem.controller")
	public String DeleteCartItem(@RequestParam("itemId") Integer cartItemId, Model m) {
		MemberBean memberb =(MemberBean)session.getAttribute("member");
		Integer memberId = memberb.getSid();
		cService.deleteCarItemById(cartItemId);
		List<CarItem> carItems = cService.findByMemberId(memberId);
		m.addAttribute("carItems", carItems);
		return "Order/jsp/ShopCar";
	}

	@GetMapping("/payment.controller")
	public String Payment(Model m) {
		MemberBean memberb =(MemberBean)session.getAttribute("member");
		Integer memberId = memberb.getSid();
		List<CarItem> cartItems = cService.findByMemberId(memberId);
		m.addAttribute("cartItems", cartItems);
		m.addAttribute("memberId", memberId);
		m.addAttribute("page","shopcar");
		return "Order/jsp/Payment";
	}
	@GetMapping("/ecpayCheckout")
	@ResponseBody
	public String ecpayCheckout(@RequestParam("aioCheckOutALLForm") String aioCheckOutALLForm) {

		return aioCheckOutALLForm;
	}
	
	@PostMapping("order.controller")
		public String Order(@RequestParam("memberId") Integer memberId, @RequestParam("sellerId") Integer[] sellerIds,
				@RequestParam("productId") Integer[] productIds, @RequestParam("quantity") Integer[] quantities,
				@RequestParam("name") String[] names, @RequestParam("address") String[] addresses,
				@RequestParam("tel") String[] tels, @RequestParam("shippingMethod") short[] shippingMethods,
				@RequestParam("shippingFee") Integer[] shippingFees, @RequestParam("totalPrices") Integer[] totalPrices,
				@RequestParam("originalPrices") Integer[] oringinalPrices, @RequestParam("totalPrice") Integer AlltotalPrice,
				@RequestParam("paymentMethod") short paymentMethod, @RequestParam("statusValue") short statusValue,
				@RequestParam("itemId") String[] itemIds,Model m) {
			
			
			System.out.println(memberId.getClass());
			Date currentDate = new Date();
			Optional<MemberBean> members = mService.findById(memberId);
			MemberBean member = members.get();
			PaymentDetails p = new PaymentDetails();
			p.setPayUserId(member);
			p.setPaymentMethod(paymentMethod);
			p.setCreatedAt(currentDate);
			p.setModifiedAt(currentDate);
			p.setTotalPrice(AlltotalPrice);
			PaymentDetails pBean = pService.paymentDetails(p);
	
			for (int i = 0; i < itemIds.length; i++) {
	
				
				Optional<MemberBean> sellerId = mService.findById(sellerIds[i]);
				MemberBean seller = sellerId.get();
				Optional<GoodFormat> products = gService.findById(productIds[i]);
				GoodFormat product = products.get();
				Orders order = new Orders();
				order.setBuyerId(member);
				order.setSellerId(seller);
				order.setFormatgoodId(product);
				order.setQuantity(quantities[i]);
				order.setName(names[i]);
				order.setAddress(addresses[i]);
				order.setTel(tels[i]);
				order.setShippingMethod(shippingMethods[i]);
				order.setShippingFee(shippingFees[i]);
				order.setOriginalPrice(oringinalPrices[i]);
				order.setTotalPrice(totalPrices[i]+shippingFees[i]);
				order.setPaymentId(pBean);
				if(paymentMethod == 1) {
					order.setPayStatus((short)1);				
				}else {
					order.setPayStatus(statusValue);
				}
				order.setOrderStatus((short) 0);
				order.setCreatedAt(currentDate);
				order.setModifiedAt(currentDate);
				oService.insertToOrder(order);
			}
				cService.clearShopCarByMemberId(memberId);
				if(paymentMethod == 1) {
					Optional<GoodFormat> products = gService.findById(productIds[0]);
					GoodFormat product = products.get();
					String goodsName = product.getGood().getGoodsName();
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
					String StringDate = sdf.format(currentDate);
					String StringTotalAmount = String.valueOf(AlltotalPrice);
					String aioCheckOutALLForm = oService.ecpayCheckout(StringTotalAmount,StringDate,goodsName);

					m.addAttribute("aioCheckOutALLForm",aioCheckOutALLForm);
				
					return "redirect:/ecpayCheckout?aioCheckOutALLForm=" + URLEncoder.encode(aioCheckOutALLForm, StandardCharsets.UTF_8);
				}
					return "redirect:/goindex.controller";
		}
	
	@GetMapping("queryOrder.controller")
	public String QueryOrder(@RequestParam("queryType") String queryType, @RequestParam("orderId") String orderIdStr,
			@RequestParam(value = "startDate", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date startDate,
			@RequestParam(value = "endDate", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date endDate, Model m ) {
			m.addAttribute("page","query");
		switch (queryType) {
		case "all":
			List<Orders> orders = oService.findByOrderStatusNot(5);
			m.addAttribute("queryType", queryType);
			m.addAttribute("orders", orders);
			return "/Order/jsp/QueryAll";
		case "byOrderId":
			int orderId = Integer.parseInt(orderIdStr);
			Orders order = oService.findByOrderIdAndOrderStatusNot(orderId,5);
			m.addAttribute("orderId", orderId);
			m.addAttribute("queryType", queryType);
			m.addAttribute("order", order);
			return "/Order/jsp/QueryById";

		case "byDate":
			Calendar calendar = Calendar.getInstance();
	        calendar.setTime(endDate);
	        calendar.add(Calendar.DATE, 1);
	        endDate = calendar.getTime();
	        
			List<Orders> ordersByDate = oService.findByCreatedAtBetweenAndOrderStatusNot(startDate, endDate,5);
			m.addAttribute("startDate", startDate);
			m.addAttribute("endDate", endDate);
			m.addAttribute("queryType", queryType);
			m.addAttribute("orders", ordersByDate);
			return "/Order/jsp/QueryByDate";
		default:
			throw new IllegalArgumentException("Error");
		}
	}
	
	@PutMapping("fakeDelete.controller")
	public void DeleteOrder(@RequestParam("orderId") String orderIdStr,
			Model m) {
		int orderId = Integer.parseInt(orderIdStr);
		oService.cancelOrderById(orderId);

	}
	
	@PutMapping("updateOrder.controller")
	public void UpdateOrder(@RequestParam("orderId") String orderIdStr,
			@RequestParam("orderstatus") String orderStatusStr,
			@RequestParam("name") String name, @RequestParam("address") String address, @RequestParam("tel") String tel,
			Model m ) {
		int orderId = Integer.parseInt(orderIdStr);
		int orderStatus = Integer.parseInt(orderStatusStr);
		oService.updateOrderById(name,address,tel , orderStatus,orderId);
		
		
	}
}
