package com.sean.controller;

import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.net.URLEncoder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
import com.sean.model.Notifications;
import com.sean.model.NotificationsService;
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
	private NotificationsService nService;
	
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
		MemberBean member =(MemberBean)session.getAttribute("member");
		List<Notifications> notifications = nService.findByRecipientIdOrderBySendTimeDesc(member);
		Integer count = nService.noReadCounts(member);
		session.setAttribute("count", count);
		session.setAttribute("notifications", notifications);
		return "Order/jsp/Index";
	}
	@PutMapping("readMessage")
	public void readMessage(@RequestParam("notificationId") Integer notificationId) {
	    nService.readMessage(notificationId); 
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

	@GetMapping("test")
	public String test() {
		return "Order/jsp/Test";
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
    @GetMapping("shopcar.controller")
    public String ShopCar(Integer MemberId, Model m) {
        MemberBean member =(MemberBean)session.getAttribute("member");
        Integer memberId = member.getSid();
        List<CarItem> carItems = cService.findByMemberId(memberId);
        m.addAttribute("page","shopcar");
        m.addAttribute("carItems", carItems);
        return "Order/jsp/ShopCar";
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
				Orders o = oService.insertToOrder(order);
				String goodsName = product.getGood().getGoodsName();
				int orderId = o.getOrderId();			
				String buyerName = member.getName();
				Notifications n = new Notifications();
				String buyerMessage = "親愛的 <span style='color: blue;'>" + buyerName + "</span> 您好，您的訂單 <span style='color: red;'>" + orderId + "</span> 已成立";
				n.setOrderId(o);
				n.setRecipientId(member);
				n.setContent(buyerMessage);
				n.setSendTime(currentDate);
				n.setReads(0);
				nService.sendMessage(n);
				Notifications n2 = new Notifications();
				String sellerMessgae = "用戶 <span style='color: blue;'>" + buyerName + "</span> 已向你的商品 <span style='color: green;'>" + goodsName + "</span> 下訂單，訂單編號為: <span style='color: red;'>" + orderId + "</span>";
				n2.setOrderId(o);
				n2.setRecipientId(seller);
				n2.setContent(sellerMessgae);
				n2.setSendTime(currentDate);
				n2.setReads(0);
				nService.sendMessage(n2);
			}
				cService.clearShopCarByMemberId(memberId);
				if(paymentMethod == 1) {
					StringBuilder concatenatedGoodsNames = new StringBuilder();
					for (Integer productId : productIds) {
					    Optional<GoodFormat> products = gService.findById(productId);
					    if (products.isPresent()) {
					        GoodFormat product = products.get();
					        String goodsName = product.getGood().getGoodsName();
					        concatenatedGoodsNames.append(goodsName).append("#");
					    }
					}
					String goodsNamesString = concatenatedGoodsNames.toString();
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
					String StringDate = sdf.format(currentDate);
					String StringTotalAmount = String.valueOf(AlltotalPrice);
					String aioCheckOutALLForm = oService.ecpayCheckout(StringTotalAmount,StringDate,goodsNamesString);

					m.addAttribute("aioCheckOutALLForm",aioCheckOutALLForm);
				
					return "redirect:/ecpayCheckout?aioCheckOutALLForm=" + URLEncoder.encode(aioCheckOutALLForm, StandardCharsets.UTF_8);
				}
					return "redirect:/goindex.controller";
		}
	
	@GetMapping("queryOrder.controller")
	public String QueryOrder(Model m ) {

		List<Orders> orders = oService.findByOrderStatusNot(5);
		m.addAttribute("orders", orders);
		Map<String, Integer> monthOrdersMap = new LinkedHashMap<>();
	    LocalDate today = LocalDate.now();
	    
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM");

	    for (int i = 4; i >= 0; i--) {
	        LocalDate startOfMonth = today.minusMonths(i).withDayOfMonth(1);
	        String monthLabel = startOfMonth.format(formatter);

	        LocalDate endOfMonth = startOfMonth.withDayOfMonth(startOfMonth.lengthOfMonth());

	        Integer ordersCount = oService.findOrdersCount(java.sql.Date.valueOf(startOfMonth), java.sql.Date.valueOf(endOfMonth));
	        monthOrdersMap.put(monthLabel, ordersCount);
	    }
	    Map<String, Integer> monthOrdersPrice = new LinkedHashMap<>();
	    
	    for (int i = 4; i >= 0; i--) {
	    	LocalDate startOfMonth = today.minusMonths(i).withDayOfMonth(1);
	    	String monthLabel = startOfMonth.format(formatter);
	    	
	    	LocalDate endOfMonth = startOfMonth.withDayOfMonth(startOfMonth.lengthOfMonth());
	    	
	    	Integer ordersPrice = oService.findOrdersPrice(java.sql.Date.valueOf(startOfMonth), java.sql.Date.valueOf(endOfMonth));
	    	System.out.println("6666666666"+ordersPrice);
	    	monthOrdersPrice.put(monthLabel, ordersPrice);
	    }

	    m.addAttribute("monthOrdersMap", monthOrdersMap);
	    m.addAttribute("monthOrdersPrice",monthOrdersPrice);
	    return "/Order/jsp/Test";

	}
	
	
	@PutMapping("fakeDelete.controller")
	public void DeleteOrder(@RequestParam("orderId") Orders order,
			Model m) {
		int orderId = order.getOrderId();
		oService.cancelOrderById(orderId);
		Date currentDate = new Date();
		Integer buyerId = order.getBuyerId().getSid();
		String buyerName = order.getBuyerId().getName();
		Integer sellerId = order.getSellerId().getSid();
		Optional<MemberBean> members = mService.findById(buyerId);
		MemberBean member = members.get();
		Optional<MemberBean> members2 = mService.findById(sellerId);
		MemberBean seller = members2.get();
		
		Notifications n = new Notifications();
		String buyerMessage = "親愛的" + buyerName +"您好，您的訂單編號為:" + orderId + "的訂單已成功取消";
		n.setOrderId(order);
		n.setRecipientId(member);
		n.setContent(buyerMessage);
		n.setSendTime(currentDate);
		n.setReads(0);
		nService.sendMessage(n);
		Notifications n2 = new Notifications();
		String sellerMessgae = "用戶" + buyerName + "已取消編號為:" + orderId + "的訂單";
		n2.setOrderId(order);
		n2.setRecipientId(seller);
		n2.setContent(sellerMessgae);
		n2.setSendTime(currentDate);
		n2.setReads(0);
		nService.sendMessage(n2);
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
