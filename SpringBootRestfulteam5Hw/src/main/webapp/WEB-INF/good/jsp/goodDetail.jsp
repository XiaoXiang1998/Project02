<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@page import="com.member.model.MemberBean" %>
		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
			<!DOCTYPE html>
			<html>

			<head>
				<meta charset="BIG5">
				<title>Insert title here</title>
				<!-- Google Web Fonts -->
				<link rel="preconnect" href="https://fonts.googleapis.com">
				<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

				<!-- <link
                href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
                rel="stylesheet"> -->
				<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet"
					integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU"
					crossorigin="anonymous">
				<!-- Icon Font Stylesheet -->
				<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
				<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
					rel="stylesheet">

				<link href="../../frontlib/lightbox/css/lightbox.min.css" rel="stylesheet">
				<link href="../../frontlib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
				<link href="../../frontcss/bootstrap.min.css" rel="stylesheet">
				<link href="../../frontcss/style.css" rel="stylesheet">
				<!--  -->
				<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.css">
				<link rel="stylesheet"
					href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick-theme.css">

				<!--  -->
				<style>
					.time-and-details {
						flex-grow: 1;
						/* 彈性增長，以填滿可用空間 */
						display: flex;
						flex-direction: row;
					}

					.order-details {
						margin-right: 10px;
						/* 增加右邊距，使得各項目之間有一定間距 */
					}

					.time {
						margin-right: 5px;
						/* 調整時間和 | 之間的間距 */
					}

					.separator {
						margin-right: 5px;
						/* 調整右側間距 */
						margin-left: 5px;
						/* 調整左側間距 */
					}
				</style>

			</head>

			<body>
				<%@ include file="../../FrontDeskNav.jsp" %>
					<% HttpSession MemberSession=request.getSession(); MemberBean member=(MemberBean)
						MemberSession.getAttribute("member"); %>
						<!-- Single Product Start -->
						<div class="container-fluid">
							<div class="container">
								<div class="row mt-5">
									<div class="col-lg-12 col-xl-12">
										<div class="row g-4">
											<div class="col-lg-6">
												<!-- 圖片輪播功能癱瘓中(不知道問題出在哪) -->
												<div class="owl-carousel">
													<div>
														<img class="img-fluid w-100" src="${Good.titleImage}"
															alt="${Good.titleImage}" style="height: 400px;">
													</div>
													<c:forEach var="j" begin="0" end="${GoodImageNumber}" step="1"
														items="${GoodImage}" varStatus="loop">
														<div>
															<img class="img-fluid w-100" src="${j.imagePath}"
																alt="${j.imagePath}" style="height: 400px;">
														</div>
													</c:forEach>
													<c:forEach var="j" begin="0" end="${GoodFormatImagePathNumber}"
														step="1" items="${GoodFormatImagePath}" varStatus="loop">
														<div data-hash="${loop.index+1}">
															<img class="img-fluid w-100" src="${j.goodImagePath}"
																alt="${j.goodImagePath}" style="height: 400px;">
														</div>
													</c:forEach>
												</div>

												<!-- 商品規格(呈現該商品編號下對應的所有規格) -->
											</div>
											<div class="col-lg-6">
												<h4 class="fw-bold mb-3" id="GoodName">${GoodBasicInfo.goodName}</h4>
												<!-- 商品名稱 -->
												<div class="d-flex mb-4" id="GoodRate">
													<!-- 平均分數 EX(3.5/5) -->
													<c:forEach var="j" begin="1" end="5" step="1" varStatus="loop">
														<c:if test="${GoodBasicInfo.goodAVG>=loop.index}">
															<i class="fa fa-star text-secondary py-1"></i>
														</c:if>
														<c:if test="${loop.index>GoodBasicInfo.goodAVG}">
															<i class="fa fa-star py-1"></i>
														</c:if>
													</c:forEach>
													<p class="mx-3 mb-1" id="GoodSold">已售出: ${GoodBasicInfo.goodsold}
													</p>
													<!-- 商品售出量 -->
												</div>
												<p class="mb-3" id="GoodType">Category: ${GoodBasicInfo.goodType}</p>
												<!-- 商品種類 -->
												<h5 class="fw-bold mb-3" id="GoodPriceRange">
													${GoodBasicInfo.minprice}-${GoodBasicInfo.maxprice}$</h5>
												<!-- 商品價格(以範圍表示) -->
												<div class="row row-cols-2">
													<c:forEach var="j" begin="0" end="${GoodFormatNumber}" step="1"
														items="${GoodFormatCarouslDtoList}" varStatus="loop">
														<div class="col">
															<!-- 點擊規格表按鈕影響輪播圖片 -->
															<a class="button secondary url" href="#${j.index}"><button
																	class="btn btn-outline-primary round-pill CategoryItem w-100 mb-1">
																	<img src="${j.formatImagePath}"
																		alt="${j.formatImagePath}"
																		style="width: 20px; height: 20px;">
																	<span class="CategorySize">${j.formatSize}</span>
																	<span hidden
																		class="CategoryPrice">${j.formatPrice}</span>
																	<span hidden
																		class="CategoryNumber">${j.formatStock}</span>
																	<span hidden class="formatID">${j.formatID}</span>

																</button></a>

														</div>
													</c:forEach>
												</div>
												<div class="input-group quantity mb-3 d-flex" id="BuyItemNumber" hidden>
													<!--買入數量  -->
													<div class="input-group-btn" hidden>
														<button
															class="btn btn-sm btn-minus rounded-circle bg-light border">
															<i class="fa fa-minus"></i>
															<!-- 降低數量按鈕 -->
														</button>
													</div>
													<input type="text"
														class="form-control form-control-sm text-center border-0"
														value="1" id="BuyNumber" style="width: 10px;" hidden>
													<!-- 當點擊到庫存上限時 會出現紅字 -->

													<div class="input-group-btn" hidden>
														<button
															class="btn btn-sm btn-plus rounded-circle bg-light border">
															<i class="fa fa-plus"></i>
															<!-- 增加數量按鈕 -->
														</button>
													</div>
												</div>
												<p id="errormsg" style="color: red;"></p>
												<div class="row" id="formatmsg">
													<div class="col-3">
														<span>剩餘:</span> <span id="remainingNumber"></span>
													</div>
													<div class="col-3">
														<span>價格:</span> <span id="CategoryPrice"></span>
													</div>
												</div>
												<div class="d-flex">
													<div class="col">
														<!-- formatId goodsSellerId price quantity goodsName goodSize -->
														<form action="" id="orderDetail">
															<!-- 進入訂單環節(跳轉頁面) -->
															<!-- 下單後對應規格的庫存量會下降 -->
															<input type="text" class="form-control"
																id="orderformatimagepath" name="orderformatimagepath"
																hidden>
															<!-- 規格圖片 -->
															<input type="text" class="form-control" id="orderformatID"
																name="orderformatID" hidden>
															<!-- 規格表編號(OK) -->
															<input type="text" class="form-control" id="ordersellerID"
																name="ordersellerID" value="${sellerID}" hidden>
															<!-- 賣家編號 -->
															<input type="text" class="form-control"
																id="orderformatprice" name="orderformatprice" hidden>
															<!-- 對應規格單價 -->
															<input type="text" class="form-control" id="orderNumber"
																name="orderNumber" hidden>
															<!-- 購買數量 -->
															<input type="text" class="form-control" id="orderGoodName"
																name="orderGoodName" value="${Good.goodsID}" hidden>
															<!-- 商品名稱 -->
															<input type="text" class="form-control" id="orderGoodSize"
																name="orderGoodSize" hidden>
															<!-- 商品尺寸 -->
															<button type="button" id="GoToOrder"
																class="btn btn-primary mt-3 mb-1">去結帳</button>
														</form>
													</div>
													<div class="col">
														<form action="" id="cartDetail">
															<!-- 進入購物車(透過ajax將值傳到後端) -->
															<input type="text" class="form-control" id="cartNumber"
																name="quantity" hidden>
															<!-- 購買數量 -->
															<input type="text" class="form-control" id="cartPrice"
																name="productPrice" hidden>
															<!-- 購買單價 -->
															<input type="text" class="form-control" id="cartformatID"
																name="ProductId" hidden>
															<!-- 規格表編號 -->
															<button type="button" id="GoToCart"
																class="btn btn-primary mt-3 mb-1">加入購物車</button>
														</form>
													</div>
													<!-- 一個是直接購買(直接進入訂單環節) 另一個是加入購物車(將購買的商品放入購物車內) -->
													<!-- 在購買之前需要選擇特定規格 -->

												</div>


											</div>
											<!-- 商品圖片(用輪播呈現) -->
										</div>
									</div>




									<div class="col-lg-12">
										<nav>
											<div class="nav nav-tabs mb-3">
												<button class="nav-link active border-white border-bottom-0"
													type="button" role="tab" id="nav-about-tab" data-bs-toggle="tab"
													data-bs-target="#nav-about" aria-controls="nav-about"
													aria-selected="true">商品使用說明</button>
												<button class="nav-link border-white border-bottom-0" type="button"
													role="tab" id="nav-mission-tab" data-bs-toggle="tab"
													data-bs-target="#nav-mission" aria-controls="nav-mission"
													aria-selected="false">評論</button>
											</div>
										</nav>
										<div class="tab-content mb-5">
											<div class="tab-pane active" id="nav-about" role="tabpanel"
												aria-labelledby="nav-about-tab">
												<div class="px-2">
													<div class="row g-4">
														<div class="col-6" id="GoodDirectionContent">
															<!-- 裡面放入商品描述 -->
															${GoodBasicInfo.goodDirection}
														</div>
													</div>
												</div>
											</div>

											<div class="tab-pane" id="nav-mission" role="tabpanel"
												aria-labelledby="nav-mission-tab">
												<c:if test="${not empty posts}">
													<div class="nav nav-tabs" id="nav-tab" role="tablist">
														<button class="nav-link " id="all-tab" data-bs-toggle="tab"
															data-bs-target="#all" role="tab" aria-controls="all"
															aria-selected="true">全部(${totalPostsCount})</button>
														<button class="nav-link" id="star5-tab" data-bs-toggle="tab"
															data-bs-target="#star5" role="tab" aria-controls="star5"
															aria-selected="false">5顆星(${rateCounts[0]})</button>
														<button class="nav-link" id="star4-tab" data-bs-toggle="tab"
															data-bs-target="#star4" role="tab" aria-controls="star4"
															aria-selected="false">4顆星(${rateCounts[1]})</button>
														<button class="nav-link" id="star3-tab" data-bs-toggle="tab"
															data-bs-target="#star3" role="tab" aria-controls="star3"
															aria-selected="false">3顆星(${rateCounts[2]})</button>
														<button class="nav-link" id="star2-tab" data-bs-toggle="tab"
															data-bs-target="#star2" role="tab" aria-controls="star2"
															aria-selected="false">2顆星(${rateCounts[3]})</button>
														<button class="nav-link" id="star1-tab" data-bs-toggle="tab"
															data-bs-target="#star1" role="tab" aria-controls="star1"
															aria-selected="false">1顆星(${rateCounts[4]})</button>
														<button class="nav-link" id="comment-tab" data-bs-toggle="tab"
															data-bs-target="#comment" role="tab" aria-controls="comment"
															aria-selected="false">附上評論(${contentCount})</button>
														<button class="nav-link" id="photo-tab" data-bs-toggle="tab"
															data-bs-target="#photo" role="tab" aria-controls="photo"
															aria-selected="false">附上照片(${photosCount})</button>
														<!-- 添加缺少的标签 -->
													</div>
													<c:forEach var="post" items="${posts}">
														<div class="d-flex mb-4" id="comment-container">
															<img src="${post.member.photoSticker}" class="img-fluid rounded-circle p-3"
																style="width: 100px; height: 100px;" alt="">
															<!-- 評論用戶的大頭貼 -->
															<div class="ml-3">
																<h5 class="mb-1">
																	<c:out value="${post.member.name}" />
																</h5>
																<div class="d-flex mb-3">
																	<!-- 評論星數(星星數可用迴圈去寫) -->
																	<c:forEach begin="1" end="${post.buyerrate}">
																		<i class="fa fa-star text-secondary"></i>
																	</c:forEach>
																</div>
																<div
																	class="d-flex align-items-center mb-2 time-and-details">
																	<!-- 顯示時間和規格尺寸 -->
																	<c:if test="${not empty post.commenttime}">
																		<fmt:formatDate value="${post.commenttime}"
																			pattern="yyyy-MM-dd HH:mm"
																			var="formattedCommentTime" />
																		<p class="time mb-0">${formattedCommentTime}</p>
																	</c:if>
																	<!-- 分隔線 -->
																	<span class="mx-2">|</span>
																	<!-- 規格尺寸 -->
																	<p class="mb-0">規格:
																		${post.orders.formatgoodId.goodSize}
																	</p>
																</div>

																<p class="mb-2">
																	<c:out value="${post.commentcontent}" />
																</p>
																<!-- 評論內容 -->
																<!-- 評論照片 -->
																<c:if test="${not empty post.productphoto}">
																	<div class="comment-photos">
																		<img src="${post.productphoto}"
																			class="img-fluid rounded mr-2"
																			style="width: 100px; height: 100px;"
																			alt="comment photo">
																	</div>
																</c:if>
															</div>
														</div>
													</c:forEach>
													<div>
														<div id="pagination-links">
															<!-- 这里是您现有的分页链接 -->
															<c:forEach var="i" begin="0" end="${totalPages - 1}">
																<a href="#" class="pagination-link" data-page="${i}">${i
																	+1}</a>
															</c:forEach>
														</div>
													</div>
												</c:if>
												<!-- 如果沒有評論，顯示提示信息 -->
												<c:if test="${empty posts}">
													<p>還沒有任何相關的評論喔!</p>
												</c:if>
											</div>

										</div>
									</div>
									<span id="sellerIDHint" hidden>${sellerID}</span>

									<h1 class="fw-bold mb-0">相關商品</h1>
									<div class="row">
										<!-- 透過迴圈去寫 -->
										<c:forEach var="j" begin="0" step="1" items="${relatedGood}">

											<div class="col-3 card" style="height: 25rem;">
												<form>
													<img class="card-img-top" src="${j.titleImage}"
														alt="${j.titleImage}" style="height: 18rem;"> <input type="text"
														value="${j.goodsID}" name="GoodID" hidden>
													<div>
														<h6 class="mb-2">${j.goodName}</h6>
														<div class="mb-2">
															<c:forEach var="i" begin="1" end="5" step="1"
																varStatus="loop">
																<c:if test="${j.goodAVG>=loop.index}">
																	<i class="fa fa-star text-secondary"></i>
																</c:if>
																<c:if test="${loop.index>j.goodAVG}">
																	<i class="fa fa-star"></i>
																</c:if>
															</c:forEach>
														</div>
														<div class="mb-2">
															<h5 class="fw-bold me-2">${j.minprice}-${j.maxprice}$</h5>
														</div>
													</div>
												</form>
											</div>
										</c:forEach>
										<div>

											<!-- 透過商品種類去查詢商品基本資料表 -->

											<button type="button" class="btn btn-primary mt-5">
												<h1 id="GoToSellerMarket">前往賣家的賣場</h1>
											</button>

										</div>
									</div>
								</div>

								<!-- Single Product End -->


								<!-- Footer Start -->
								<div class="container-fluid bg-dark text-white-50 footer pt-5 mt-5">
									<div class="container py-5">
										<div class="pb-4 mb-4"
											style="border-bottom: 1px solid rgba(226, 175, 24, 0.5);">
											<div class="row g-4">
												<div class="col-lg-3">
													<a href="#">
														<h1 class="text-primary mb-0">Fruitables</h1>
														<p class="text-secondary mb-0">Fresh products</p>
													</a>
												</div>
												<div class="col-lg-6">
													<div class="position-relative mx-auto">
														<input
															class="form-control border-0 w-100 py-3 px-4 rounded-pill"
															type="number" placeholder="Your Email">
														<button type="submit"
															class="btn btn-primary border-0 border-secondary py-3 px-4 position-absolute rounded-pill text-white"
															style="top: 0; right: 0;">Subscribe Now</button>
													</div>
												</div>
												<div class="col-lg-3">
													<div class="d-flex justify-content-end pt-3">
														<a class="btn  btn-outline-secondary me-2 btn-md-square rounded-circle"
															href=""> <i class="fab fa-twitter"></i>
														</a> <a
															class="btn btn-outline-secondary me-2 btn-md-square rounded-circle"
															href=""> <i class="fab fa-facebook-f"></i>
														</a> <a
															class="btn btn-outline-secondary me-2 btn-md-square rounded-circle"
															href=""> <i class="fab fa-youtube"></i>
														</a> <a
															class="btn btn-outline-secondary btn-md-square rounded-circle"
															href=""> <i class="fab fa-linkedin-in"></i>
														</a>
													</div>
												</div>
											</div>
										</div>
										<div class="row g-5">
											<div class="col-lg-3 col-md-6">
												<div class="footer-item">
													<h4 class="text-light mb-3">Why People Like us!</h4>
													<p class="mb-4">typesetting, remaining essentially
														unchanged. It was popularised in the 1960s with the like
														Aldus
														PageMaker including of Lorem Ipsum.</p>
													<a href=""
														class="btn border-secondary py-2 px-4 rounded-pill text-primary">Read
														More</a>
												</div>
											</div>
											<div class="col-lg-3 col-md-6">
												<div class="d-flex flex-column text-start footer-item">
													<h4 class="text-light mb-3">Shop Info</h4>
													<a class="btn-link" href="">About Us</a> <a class="btn-link"
														href="">Contact Us</a> <a class="btn-link" href="">Privacy
														Policy</a> <a class="btn-link" href="">Terms & Condition</a>
													<a class="btn-link" href="">Return Policy</a> <a class="btn-link"
														href="">FAQs & Help</a>
												</div>
											</div>
											<div class="col-lg-3 col-md-6">
												<div class="d-flex flex-column text-start footer-item">
													<h4 class="text-light mb-3">Account</h4>
													<a class="btn-link" href="">My Account</a> <a class="btn-link"
														href="">Shop details</a> <a class="btn-link" href="">Shopping
														Cart</a> <a class="btn-link" href="">Wishlist</a> <a
														class="btn-link" href="">Order History</a> <a class="btn-link"
														href="">International Orders</a>
												</div>
											</div>
											<div class="col-lg-3 col-md-6">
												<div class="footer-item">
													<h4 class="text-light mb-3">Contact</h4>
													<p>Address: 1429 Netus Rd, NY 48247</p>
													<p>Email: Example@gmail.com</p>
													<p>Phone: +0123 4567 8910</p>
													<p>Payment Accepted</p>
													<img src="img/payment.png" class="img-fluid" alt="">
												</div>
											</div>
										</div>
									</div>
								</div>
								<!-- Footer End -->

								<!-- Copyright Start -->
								<div class="container-fluid copyright bg-dark py-4">
									<div class="container">
										<div class="row">
											<div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
												<span class="text-light"> <a href="#"> <i
															class="fas fa-copyright text-light me-2"></i> Your Site
														Name
													</a> , All right reserved.
												</span>
											</div>
											<div class="col-md-6 my-auto text-center text-md-end text-white">
												<!--/*** This template is free as long as you keep the below author’s credit link/attribution link/backlink. ***/-->
												<!--/*** If you'd like to use the template without the below author’s credit link/attribution link/backlink, ***/-->
												<!--/*** you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". ***/-->
												Designed By <a class="border-bottom" href="https://htmlcodex.com">HTML
													Codex</a> Distributed By <a class="border-bottom"
													href="https://themewagon.com">ThemeWagon</a>
											</div>
										</div>
									</div>
								</div>
								<!-- Copyright End -->



								<!-- Back to Top -->
								<a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top">
									<i class="fa fa-arrow-up"></i>
								</a>


								<h1 id="limitbuyerID">買家編號:${buyerID}</h1>
								<h1 id="limitsellerID">賣家編號:${sellerID}</h1>
							</div>
						</div>
						<!-- JavaScript Libraries -->
						<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
						<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.js"></script>
						<script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.js"></script>

						<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"
							integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ"
							crossorigin="anonymous"></script>
						<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script> -->

						<script src="../../frontlib/easing/easing.js"></script>
						<script src="../../frontlib/waypoints/waypoints.min.js"></script>
						<script src="../../frontlib/lightbox/js/lightbox.min.js"></script>
						<script src="../../frontlib/owlcarousel/owl.carousel.min.js"></script>
						<script src="../../frontjs/main.js"></script>
						<script>
							//前往賣家賣場
							$('#GoToSellerMarket').click(function () {
								let sellerID = $('#sellerIDHint').prop("innerHTML");
								let form = document.createElement("form");
								form.setAttribute("method", "get");
								form.setAttribute("action", "sellerMarket");
								let input1 = document.createElement("input");
								input1.setAttribute("type", "text");
								input1.setAttribute("name", "SellerID");
								input1.setAttribute("value", sellerID);
								form.append(input1);
								$(document.body).append(form);
								form.submit();
							})

							$('.CategoryItem')
								.click(
									function () {//取得對應規格編號[要顯示價格和數量]
										if ($('#BuyItemNumber').prop("hidden") == true) {//假若欄位被影藏
											$('#BuyItemNumber').prop("hidden",
												false);//取消影藏
											let targethidden = $('#BuyItemNumber')
												.find(
													'div[class="input-group-btn"]');
											console.log(targethidden);
											targethidden.prop("hidden", false);
											let targethidden1 = $('#BuyItemNumber')
												.find('input');
											targethidden1.prop("hidden", false);
										} else {
											//假若從規格A按成規格B 數量直接回到1

											// 將規格編號塞入form標籤內
										}
										let formatID = $(this).find(
											'span[class="formatID"]').prop(
												"innerHTML");//取得規格編號
										$('#BuyNumber').prop("value", 1);
										$('#orderformatID').prop("value", formatID);
										$('#cartformatID').prop("value", formatID);
										// 還需要取得大小
										let goodstock = $(this).find(
											'span[class="CategoryNumber"]')
											.prop("innerHTML");
										let formatprice = $(this).find(
											'span[class="CategoryPrice"]')
											.prop("innerHTML");
										let formatSize = $(this).find(
											'span[class="CategorySize"]').prop(
												"innerHTML");//大小
										let formatimagePathTarget = $(this).find(
											'img').prop("src");//圖片
										let ps = formatimagePathTarget
											.lastIndexOf("/");
										let formatimagePath = "../../goodImages/"
											+ formatimagePathTarget
												.substring(ps + 1);
										console.log(formatimagePath);
										//
										$('#cartPrice').prop("value", formatprice);
										$('#orderformatprice').prop("value",
											formatprice);
										$('#remainingNumber').prop("innerHTML",
											goodstock);
										$('#CategoryPrice').prop("innerHTML",
											formatprice);
										$('#orderGoodSize').prop("value",
											formatSize);
										$('#orderformatimagepath').prop("value",
											formatimagePath);
									})

							//改變買入數量[有防呆機制]
							$('#BuyNumber').change(
								function () {
									let InputNumber = $(this).prop("value");
									let goodstock = $('#formatmsg').find(
										'span[id="remainingNumber"]').prop(
											"innerHTML");

									if (Number(goodstock) > InputNumber
										&& InputNumber >= 1) {
										$('#errormsg').prop("innerHTML", "");
									} else {
										if (InputNumber > Number(goodstock)) {
											$('#errormsg').prop("innerHTML", "操作不當");//最多只能購買剩餘的數量
											$(this).closest('div').find(
												'input[id="BuyNumber"]').prop(
													"value", 1);//不讓數字增加
										}
										if (InputNumber < 1) {
											$(this).closest('div').find(
												'input[id="BuyNumber"]').prop(
													"value", 1);//最少購買一筆
										}
									}

								})

							//增加購買數量
							$(
								'button[class="btn btn-sm btn-plus rounded-circle bg-light border"]')
								.click(
									function () {
										let InputNumber = $(this).closest(
											'div[id="BuyItemNumber"]').find(
												'input[id="BuyNumber"]').prop(
													"value");
										let goodstock = $('#formatmsg').find(
											'span[id="remainingNumber"]').prop(
												"innerHTML");

										if (InputNumber > Number(goodstock)) {
											$('#errormsg')
												.prop("innerHTML", "操作不當");//最多只能購買剩餘的數量
											$(this).closest(
												'div[id="BuyItemNumber"]')
												.find('input[id="BuyNumber"]')
												.prop("value",
													Number(goodstock));//不讓數字增加
										}
									})

							//降低購買數量
							$(
								'button[class="btn btn-sm btn-minus rounded-circle bg-light border"]')
								.click(
									function () {
										let InputNumber = $(this).closest(
											'div[id="BuyItemNumber"]').find(
												'input[id="BuyNumber"]').prop(
													"value");
										console.log(InputNumber);
										let goodstock = $('#formatmsg').find(
											'span[id="remainingNumber"]').prop(
												"innerHTML");//
										if (InputNumber <= Number(goodstock)) {
											$('#errormsg').prop("innerHTML", "");//將錯誤訊息抹消
										}
										if (InputNumber < 1) {
											$(this).closest(
												'div[id="BuyItemNumber"]')
												.find('input[id="BuyNumber"]')
												.prop("value", 1);//最少購買一筆
										}
									})

							//加入購物車
							$('#GoToCart').click(function () {
								let limitbuyerID = $('#limitbuyerID').prop("innerHTML");
								let limitsellerID = $('#limitsellerID').prop("innerHTML");
								let BuyNumber = $('#BuyNumber').val();
								$('#cartNumber').prop("value", BuyNumber);
								buyerID = limitbuyerID.substring(5);
								sellerID = limitsellerID.substring(5);
								console.log(sellerID);
								console.log(buyerID);
								if (buyerID == sellerID) {
									$('#errormsg').prop("innerHTML", "不能對自己操作");
									setTimeout(function () {
										$('#errormsg').prop("innerHTML", "");
									}, 1000)
								} else {
									if ($('#orderformatID').prop("value") == "") {
										$('#errormsg').prop("innerHTML", "要先按規格按鈕");
										setTimeout(function () {
											$('#errormsg').prop("innerHTML", "");
										}, 1000)
									} else {
										let form = $(this).closest('form');
										form.prop("method", "get");
										form.prop("action", "inserttoshopcar.controller");
										form.submit();
									}
								}

							})

							//加入訂單
							$('#GoToOrder').click(function () {
								//取得購買數量後插入$('#orderNumber')
								let buynumber = $('#BuyNumber').val();
								$('#orderNumber').prop("value", buynumber);
								//
								let limitbuyerID = $('#limitbuyerID').prop("innerHTML");
								let limitsellerID = $('#limitsellerID').prop("innerHTML");
								buyerID = limitbuyerID.substring(5);
								sellerID = limitsellerID.substring(5);
								if (buyerID == sellerID) {
									$('#errormsg').prop("innerHTML", "不能對自己操作");
									setTimeout(function () {
										$('#errormsg').prop("innerHTML", "");
									}, 1000)
								} else {
									if ($('#orderformatID').prop("value") == "") {
										$('#errormsg').prop("innerHTML", "要先按規格按鈕");
										setTimeout(function () {
											$('#errormsg').prop("innerHTML", "");
										}, 1000);
									} else {
										let form = $(this).closest('form');
										form.prop("method", "get");
										form.prop("action", "DirectlyBuy");
										form.submit();
									}

								}

							})
							$('.your-class').slick();
							//相關商品的輪播
							$('.owl-carousel').owlCarousel({
								loop: true,
								margin: 10,
								nav: true,
								loop: false,
								items: 1
							})

							$(document).on('click', 'div[class="col-3 card"]', function () {
								console.log("你點到相關商品了");
								let form = $(this).find("form");
								console.log(form);
								form.prop("action", "goodDetail.controller");
								form.prop("method", "get");
								form.submit();
							})

							//搜尋商品
							$('#GoToSearchGood').click(
								function () {
									let searchGoodInput = $(this).closest('form').find(
										'input');
									console.log(searchGoodInput.prop('value'));
									if (searchGoodInput.prop('value') == null) {
										console.log(searchGoodInput);
									} else {
										let form = $(this).closest('form');
										form.attr("action", "/searchGood");
										form.attr("method", "get");
										// console.log(form.prop("innerHTML"));
										form.submit();
									}
								})
						</script>
						<!-- 下面是OK的  -->
					<script>
    $(document).ready(function() {
        var goodId = ${Good.goodsID}; 
        var page = 0;
        var currentRate = null; 
        var currentTabId = 'all-tab'; 

        
        function maskNameFunction() {
            document.querySelectorAll('.tab-pane#nav-mission .mb-1').forEach(function(nameElement) {
                let name = nameElement.innerText;
                if (name.length === 3) {
                    let maskedName = maskName(name);
                    nameElement.innerText = maskedName;
                }
            });
        }

        
        function maskName(name) {
            if (name.length !== 3) {
                return name; 
            }
            let firstChar = name.charAt(0);
            let lastChar = name.charAt(2);
            return firstChar + '***' + lastChar; 
        }
        
        
        
        function loadComments(goodId, rate, content, photos, page) {
            $.ajax({
                type: "GET",
                url: "/goodDetail.controller",
                data: {
                    "GoodID": goodId,
                    "rate": rate,
                    "content": content,
                    "photos": photos,
                    "page": page // 传递当前页数
                },
                success: function(data) {
                    $('#nav-mission').html($(data).find('#nav-mission').html());
					
                    
                    maskNameFunction();

                    
                    bindClickHandlers();
                    bindPaginationClickHandlers(); 
                    updateTabCounts(data);
                },
                error: function(xhr, status, error) {
                    console.error("Error:", error);
                }
            });
        }
        
       
        
        function updateTabCounts(data) {
            var rateCounts = data.rateCounts; 
            $('#all-tab').text(`全部(${totalPostsCount})`);
            $('#star5-tab').text(`5顆星(${rateCounts[0]})`);
            $('#star4-tab').text(`4顆星(${rateCounts[1]})`);
            $('#star3-tab').text(`3顆星(${rateCounts[2]})`);
            $('#star2-tab').text(`2顆星(${rateCounts[3]})`);
            $('#star1-tab').text(`1顆星(${rateCounts[4]})`);
            $('#photo-tab').text(`附上照片(${photosCount})`);
            $('#comment-tab').text(`附上評論(${contentCount})`);
        }

        function handleClick(event) {
            console.log("handleClick triggered");
            page = 0;
            currentRate = null; 
            currentTabId = $(this).attr('id'); 
            console.log("Clicked tabId:", currentTabId);
            var rate = null;
            var content = null;
            var photos = null;

            if (currentTabId === 'star5-tab') {
                rate = 5;
            } else if (currentTabId === 'star4-tab') {
                rate = 4;
            } else if (currentTabId === 'star3-tab') {
                rate = 3;
            } else if (currentTabId === 'star2-tab') {
                rate = 2;
            } else if (currentTabId === 'star1-tab') {
                rate = 1;
            } else if (currentTabId === 'photo-tab') {
                photos = true;
            } else if (currentTabId === 'comment-tab') {
                content = true;
            }
            console.log("Selected rate:", rate);
            currentRate = rate;

            loadComments(goodId, rate, content, photos, page);
            
           
        }

        function bindClickHandlers() {
            console.log("Binding click handlers");
            $('#nav-tab').off('click').on('click', '.nav-link', handleClick);
        }

        function handlePaginationClick(event) {
            event.preventDefault(); 
            var newPage = $(this).data('page');
            console.log("Current active tabId:", currentTabId);

            if (newPage !== page) { 
                page = newPage;
                if (currentRate !== null) {
                    loadComments(goodId, currentRate, null, null, page); 
                } else if (currentTabId === 'photo-tab') {
                    loadComments(goodId, null, null, true, page); 
                } else if (currentTabId === 'comment-tab') {
                    loadComments(goodId, null, true, null, page); 
                } else {
                    loadComments(goodId, null, null, null, page); 
                }
            }
        }

        function bindPaginationClickHandlers() {
            console.log("Binding pagination click handlers");
            $('.pagination-link').off('click').on('click', handlePaginationClick);
        }

        bindClickHandlers();
        bindPaginationClickHandlers();
    });
</script>
			</body>

			</html>