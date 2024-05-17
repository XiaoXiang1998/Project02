<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

			<!DOCTYPE html>
			<html>

			<head>
				<meta charset="BIG5">
				<title>Insert title here</title>
				<!-- Google Web Fonts -->
				<link rel="preconnect" href="https://fonts.googleapis.com">
				<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
				<script src="https://kit.fontawesome.com/92a295a0cf.js" crossorigin="anonymous"></script>
				<link
					href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
					rel="stylesheet">

				<!-- Icon Font Stylesheet -->
				<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
				<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
					rel="stylesheet">

				<!-- Libraries Stylesheet -->
				<link href="../../frontlib/lightbox/css/lightbox.min.css" rel="stylesheet">

				<link href="../../frontlib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


				<link href="../../frontcss/bootstrap.min.css" rel="stylesheet">

				<!-- Template Stylesheet -->
				<link href="../../frontcss/style.css" rel="stylesheet">
				<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
				<script>
					$.ajax({// 透過ajax取得商品基本資料表中所有種類商品(目前order資料表中沒有資料)
						// select TOP 5 GoodType 
						// from Orders o join GoodFormat gf on o.FK_FORMATGOODID = gf.goodFormatID
						//               join Good g on gf.goodID = g.goodID
						// group by g.goodType
						// order by sum(o.quantity)
						/**/
						// select TOP 5 GoodType 
						// from Good g 
						// group by g.goodType
						type: 'get',
						url: "indexpopulargoodtype",
						contentType: 'application/json',
						success: function (data) {//取得五筆商品種類 還需要取得各種類中的前20名商品
							if (data.length == 0) {
								//沒有商品
							}
							else {
								let check = 0;
								$.each(data, function (i, n) { //將得到的種類插入置網頁內
									let li = document.createElement('li'); li.classList.add("nav-item");
									let a = document.createElement('a');
									a.classList.add("d-flex"); a.classList.add("m-2"); a.classList.add("py-2"); a.classList.add("bg-light");
									a.classList.add("rounded-pill");
									if (check == 0) {
										a.classList.add("active");
										check++;
									}
									a.setAttribute("data-bs-toggle", "pill"); a.setAttribute("href", "#tab-" + (i + 1));
									let span = document.createElement('span');
									span.classList.add("text-dark"); span.setAttribute("style", "width: 130px"); span.setAttribute("data-typeName", n);
									span.innerHTML = n;
									a.append(span); li.append(a);

									$('#CategoryList').append(li);
								})
							}
						}
					}).then(function (res) {// 還需要取得各種類中的前10名商品
						// select GoodType 
						// from Orders o join GoodFormat gf on o.FK_FORMATGOODID = gf.goodFormatID
						//               join Good g on gf.goodID = g.goodID
						// group by g.goodType
						// where g.goodsType = ? 
						// order by sum(o.quantity)
						/*訂單內沒資料 所以只取商品種類中的所有商品*/
						// select * 
						// from Good g 
						// where g.goodsType = ? 
						$.each(res, function (i, n) { //透過商品種類名稱個別去取得10筆資料
							// n是商品種類名稱
							let GoodType = n;
							GetGoodTypePopular(GoodType);
						})
					})
					function GetGoodTypePopular(GoodType) {
						console.log("GoodType in GetGoodTypePopular = " + GoodType);
						let check = 0
						$.ajax({
							type: "get",
							// data: { GoodType: n },
							url: "indexpopulargood/" + GoodType,
							contentType: 'application/json',
							success: function (data) {//取得該種類中的10筆資料
								let tabhref = $('span[data-typeName="' + GoodType + '"]').closest('a').attr("href");
								let tabhrefID = tabhref.substring(5); console.log(tabhrefID);
								let divcontain0 = document.createElement('div'); divcontain0.setAttribute("id", "tab-" + tabhrefID);
								divcontain0.classList.add("tab-pane"); divcontain0.classList.add("fade"); divcontain0.classList.add("show");
								divcontain0.classList.add("p-0");
								if (check == 0 && tabhrefID == 1) {
									divcontain0.classList.add("active");
									check++;
								}
								//
								let divcontain1 = document.createElement('div'); divcontain1.classList.add("row"); divcontain1.classList.add("g-4");
								let divcontain2 = document.createElement('div'); divcontain2.classList.add("col-lg-12");
								let divcontain3 = document.createElement('div'); divcontain3.classList.add("row"); divcontain3.classList.add("g-4");

								divcontain0.append(divcontain1); divcontain1.append(divcontain2); divcontain2.append(divcontain3);

								$.each(data, function (i, n) {
									//n:[GoodsID,GoodsType,GoodsName,TitleImage](要不要加入販賣數量、評分數)
									let div0 = document.createElement('div'); div0.classList.add("col-md-6"); div0.classList.add("col-lg-4"); div0.classList.add("col-xl-3");
									let div1 = document.createElement('div'); div1.classList.add("rounded"); div1.classList.add("position-relative"); div1.classList.add("fruite-item");
									let div2 = document.createElement('div'); div2.classList.add("fruite-img");
									let img0 = document.createElement('img');//將圖片插入
									img0.setAttribute("src", n[3]); img0.classList.add("img-fluid"); img0.classList.add("w-100");
									img0.classList.add("rounded-top"); img0.setAttribute("alt", n[3]);//封面照片
									div2.append(img0);
									let div3 = document.createElement('div'); div3.classList.add("text-white"); div3.classList.add("bg-secondary"); div3.classList.add("px-3");
									div3.classList.add("py-1"); div3.classList.add("rounded"); div3.classList.add("position-absolute");
									div3.setAttribute("style", "top: 10px; left: 10px;"); div3.innerHTML = n[1];//商品種類
									let div4 = document.createElement('div'); div4.classList.add("p-4"); div4.classList.add("border"); div4.classList.add("border-secondary"); div4.classList.add("border-top-0"); div4.classList.add("rounded-bottom");
									let h4 = document.createElement("h4"); h4.innerHTML = n[2]//商品名稱
									// <div class="d-flex justify-content-between flex-lg-wrap">
									let div5 = document.createElement("div"); div5.classList.add("d-flex"); div5.classList.add("justify-content-between");
									div5.classList.add("flex-lg-wrap");
									// <p class="text-dark fs-5 fw-bold mb-0">$4.99 / kg</p> 商品價格(用ajax抓)
									let ID = n[0];
									$.ajax({
										// [minprice,maxprice,goodsID]
										type: "get",
										// data: { GoodType: n[0] },
										url: "/indexpopulargoodPrice/" + ID,
										contentType: 'application/json',
										success: function (data) {
											// console.log(data);
											let content = [...data][0][0] + "-" + [...data][0][1] + "$";
											let p = document.createElement('p'); p.classList.add("text-dark"); p.classList.add("fs-5"); p.classList.add("fw-bold");
											p.classList.add("mb-0"); p.innerHTML = content;
											div5.append(p);
										}
									})
									//
									div4.append(h4); div4.append(div5); div1.append(div2); div1.append(div3); div1.append(div4); div0.append(div1);
									divcontain3.append(div0);
									// console.log($('#tabContentList'));
									$('#tabContentList').append(divcontain0);
								})
							}
						})
					}


				</script>
			</head>

			<body>

				<!-- Spinner Start -->
				<div id="spinner"
					class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
					<div class="spinner-grow text-primary" role="status"></div>
				</div>
				<!-- Spinner End -->



				<!-- Navbar start -->
				<div class="container-fluid fixed-top bg-info">
					<div class="container topbar bg-info d-none d-lg-block mb-3">
						<div class="d-flex justify-content-between">
							<div class="top-info ps-2">
								<small class="me-3">
									<i class="fas fa-envelope me-2 text-secondary"></i>
									<a href="#" class="text-white">ezbuycompany@gmail.com</a>
								</small>
							</div>
							<div class="top-link pe-2">
								<a href="#" class="text-white">
									<small class="text-white mx-2">Privacy Policy</small>
									/
								</a>
								<a href="#" class="text-white">
									<small class="text-white mx-2">Terms of Use</small>
									/
								</a>
								<a href="#" class="text-white">
									<small class="text-white ms-2">Sales and Refunds</small>
								</a>
							</div>
						</div>
					</div>
					<div class="container px-0">
						<nav class="navbar navbar-light bg-info navbar-expand-xl">
							<a href="EZBuyIndexWithoutLogin" class="navbar-brand">
								<h1 class="text-secondary display-6">EZBuy</h1>
							</a>
							<button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse"
								data-bs-target="#navbarCollapse">
								<span class="fa fa-bars text-secondary"></span>
							</button>
							<div class="collapse navbar-collapse bg-info" id="navbarCollapse">
								<!-- <div class="navbar-nav">
                                    <a href="#" class="nav-item nav-link">購物車</a>
                                    <a href="#" class="nav-item nav-link">訂單紀錄</a>
                                    <a href="#" class="nav-item nav-link">官方申訴</a>
                                </div> -->
								<!-- <div class="d-flex flex-row bd-highlight"> -->
								<div class="d-flex m-3 me-0">
									<form class="form-inline d-flex">
										<div class="form-group mx-sm-3 mb-2">
											<input type="text"
												class="form-control border-2 border-secondary py-3 px-4 rounded-pill"
												style="width: 850px; height: 60px;" name="GoodName">
										</div>
										<button
											class="btn btn-primary border-2 border-secondary py-3 px-4 rounded-pill position-relative"
											style="left: -80px; height: 60px;" type="button" id="GoToSearchGood">
											<i class="fas fa-search"></i>
										</button>
									</form>
									<a href="shopcar.controller" class="position-relative me-4 my-auto ms-5">
										<i class="fa fa-shopping-bag fa-2x text-secondary"></i>
										<span
											class="position-absolute bg-white rounded-circle d-flex align-items-center justify-content-center text-dark px-1 ${carItemCount == 0 ? 'd-none' : ''}"
											style="top: -5px; left: 15px; height: 20px; min-width: 20px;">${carItemCount}</span>
									</a>
									<div class="my-auto nav-item dropdown">
										<button class="btn dropdown-toggle" type="button" id="dropdownMenuButton1"
											data-bs-toggle="dropdown" aria-expanded="false" style="color: #ffb524">
											<i class="fas fa-user fa-2x"></i>
										</button>
										<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
											<li>
												<a class="dropdown-item" href="#!">會員中心</a>
											</li>
											<li>
												<a class="dropdown-item" href="#!">訂單查詢</a>
											</li>
											<li>
												<a class="dropdown-item" href="#!">評論紀錄</a>
											</li>
											<li>
												<a class="dropdown-item" href="#!">申訴紀錄</a>
											</li>
											<li>
												<a class="dropdown-item" href="#!">活動紀錄</a>
											</li>
											<li>
												<hr class="dropdown-divider" />
											</li>
											<li>
												<a class="dropdown-item" href="#!">登出</a>
											</li>
										</ul>
									</div>
									<div class="dropdown position-relative my-auto">
										<button class="btn position-relative dropdown-toggle" type="button"
											id="notificationsDropdown" data-bs-toggle="dropdown" aria-expanded="false"
											style="color: #ffb524">
											<i class="fa-solid fa-bell fa-2x"></i>
											<span
												class="position-absolute bg-white rounded-circle d-flex align-items-center justify-content-center text-dark px-1 ${count == 0 ? 'd-none' : ''}"
												style="top: 2px; left: 28px; height: 20px; min-width: 20px;">${count}</span>
										</button>
										<div class="dropdown-menu dropdown-menu-end"
											aria-labelledby="notificationsDropdown">
											<ul class="list-group" style="max-height: 615px; overflow-y: auto;">
												<c:forEach var="notification" items="${notifications}" varStatus="loop">
													<c:if test="${loop.index != 0}">
														<li class="dropdown-divider"></li>
													</c:if>
													<li>
														<a class="nav-link dropdown-item fs-md ${notification.reads == 1 ? 'text-muted' : 'fw-bold'}"
															href="#" <c:if test="${notification.reads == 0}">
															onclick="readNotification(${notification.id})"
															</c:if>>
															<img src="${notification.orderId.formatgoodId.goodImagePath}"
																alt="商品图片"
																style="max-width: 60px; max-height: 60px; margin-right: 10px">
															${notification.content}
															<input type="hidden" name="reads"
																value="${notification.reads}">
															<div class="text-end">
																<fmt:formatDate value="${notification.sendTime}"
																	pattern="MM月dd日 HH時mm分" />
															</div>
														</a>
													</li>
												</c:forEach>
											</ul>
										</div>
									</div>
								</div>
							</div>
						</nav>
					</div>
				</div>
				<!-- Navbar End -->


				<!-- Fruits Shop Start-->
				<div class="container-fluid fruite py-5">
					<div class="container py-5">
						<div class="tab-class text-center">
							<div class="row g-4">
								<div class="col-lg-4 text-start">
									<h1>熱門商品</h1>
								</div>
								<div class="col-lg-8 text-end">
									<ul class="nav nav-pills d-inline-flex text-center mb-5" id="CategoryList">

									</ul>
								</div>
							</div>
							<div class="tab-content" id="tabContentList"></div>
						</div>
					</div>
				</div>
				<!-- Fruits Shop End-->


				<!-- Featurs Start(加入商城特色 鼓勵大家過來購買 成為EZBuy的電商) -->

				<!-- Featurs End -->
				<!--Vesitable Shop Start-->
				<div class="container-fluid vesitable py-5">
					<div class="container py-5" id="testtarget">
						<h1 class="mb-0">近期商品</h1>
						<div class="owl-carousel vegetable-carousel justify-content-center">


							<c:forEach var="i" begin="1" end="${GoodNumber}" step="1">
								<c:forEach var="j" items="${findGoodPriceRange}">
									<form action="">
										<div class="border border-primary rounded position-relative vesitable-item">
											<div class="vesitable-img">
												<img src="${j.titleImage}" class="img-fluid w-100 rounded-top" alt=""
													style="width: 150px; height: 250px;">
											</div>
											<div class="text-white bg-primary px-3 py-1 rounded position-absolute"
												style="top: 10px; right: 10px;">${j.goodType}</div>
											<div class="p-4 rounded-bottom">
												<h4>${j.goodName}</h4>
												<input type="text" name="GoodID" class="form-control"
													value="${j.goodsID}">
												<p>${j.minprice}-${j.maxprice}$</p>
												<div class="d-flex justify-content-between flex-lg-wrap">
													<div class="d-flex my-3">
														<c:forEach var="k" begin="1" end="5" step="1">
															<c:if test="${j.goodAVG>k}">
																<i class="fas fa-star text-primary"></i>
															</c:if>
															<c:if test="${k>j.goodAVG}">
																<i class="fas fa-star"></i>
															</c:if>
														</c:forEach>
													</div>
												</div>
											</div>
										</div>
									</form>
								</c:forEach>
							</c:forEach>
						</div>
					</div>
				</div>
				<!-- Vesitable Shop End -->

				<!-- Navbar End -->







				<!-- Footer Start -->
				<div class="container-fluid bg-dark text-white-50 footer pt-5 mt-5">
					<div class="container py-5">
						<div class="pb-4 mb-4" style="border-bottom: 1px solid rgba(226, 175, 24, 0.5);">
							<div class="row g-4">
								<div class="col-lg-3">
									<a href="#">
										<h1 class="text-primary mb-0">EZBuy</h1>
										<p class="text-secondary mb-0">品質保證</p>
									</a>
								</div>
								<div class="col-lg-6">
									<div class="position-relative mx-auto">
										<input class="form-control border-0 w-100 py-3 px-4 rounded-pill" type="number"
											placeholder="Your Email">
										<button type="submit"
											class="btn btn-primary border-0 border-secondary py-3 px-4 position-absolute rounded-pill text-white"
											style="top: 0; right: 0;">Subscribe Now</button>
									</div>
								</div>
								<div class="col-lg-3">
									<div class="d-flex justify-content-end pt-3">
										<a class="btn  btn-outline-secondary me-2 btn-md-square rounded-circle" href="">
											<i class="fab fa-twitter"></i>
										</a>
										<a class="btn btn-outline-secondary me-2 btn-md-square rounded-circle" href="">
											<i class="fab fa-facebook-f"></i>
										</a>
										<a class="btn btn-outline-secondary me-2 btn-md-square rounded-circle" href="">
											<i class="fab fa-youtube"></i>
										</a>
										<a class="btn btn-outline-secondary btn-md-square rounded-circle" href="">
											<i class="fab fa-linkedin-in"></i>
										</a>
									</div>
								</div>
							</div>
						</div>
						<div class="row g-5">
							<div class="col-lg-3 col-md-6">
								<div class="footer-item">
									<h4 class="text-light mb-3">Why People Like us!</h4>
									<p class="mb-4">因為我們保證7天內貨到付款，提供買家申訴管道，杜絕劣質賣家，定期提供免運活動讓買家減少支出，並且鼓勵大家在這裡成為電商</p>
									<a href="" class="btn border-secondary py-2 px-4 rounded-pill text-primary">Read
										More</a>
								</div>
							</div>
							<div class="col-lg-3 col-md-6">
								<div class="d-flex flex-column text-start footer-item">
									<h4 class="text-light mb-3">Shop Info</h4>
									<a class="btn-link" href="">About Us</a>
									<a class="btn-link" href="">Contact Us</a>
									<a class="btn-link" href="">Privacy Policy</a>
									<a class="btn-link" href="">Terms & Condition</a>
									<a class="btn-link" href="">Return Policy</a>
									<a class="btn-link" href="">FAQs & Help</a>
								</div>
							</div>
							<div class="col-lg-3 col-md-6">
								<div class="d-flex flex-column text-start footer-item">
									<h4 class="text-light mb-3">Account</h4>
									<a class="btn-link" href="">My Account</a>
									<a class="btn-link" href="">Shop details</a>
									<a class="btn-link" href="">Shopping Cart</a>
									<a class="btn-link" href="">Wishlist</a>
									<a class="btn-link" href="">Order History</a>
									<a class="btn-link" href="">International Orders</a>
								</div>
							</div>
							<div class="col-lg-3 col-md-6">
								<div class="footer-item">
									<h4 class="text-light mb-3">Contact</h4>
									<p>Address: 1429 Netus Rd, NY 48247</p>
									<p>Email: Example@gmail.com</p>
									<p>Phone: +0123 4567 8910</p>
									<p>Payment Accepted</p>
									<img src="../../frontimg/payment.png" class="img-fluid" alt="">
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
								<span class="text-light">
									<a href="#">
										<i class="fas fa-copyright text-light me-2"></i>
										Your Site Name
									</a>
									, All right reserved.
								</span>
							</div>
							<div class="col-md-6 my-auto text-center text-md-end text-white">
								<!--/*** This template is free as long as you keep the below author’s credit link/attribution link/backlink. ***/-->
								<!--/*** If you'd like to use the template without the below author’s credit link/attribution link/backlink, ***/-->
								<!--/*** you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". ***/-->
								Designed By
								<a class="border-bottom" href="https://htmlcodex.com">HTML Codex</a>
								Distributed By
								<a class="border-bottom" href="https://themewagon.com">ThemeWagon</a>
							</div>
						</div>
					</div>
				</div>
				<!-- Copyright End -->



				<!-- Back to Top -->
				<a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top">
					<i class="fa fa-arrow-up"></i>
				</a>


				<!-- JavaScript Libraries -->
				<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
				<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
				<!--  -->
				<script src="../../frontlib/easing/easing.min.js"></script>

				<script src="../../frontlib/waypoints/waypoints.min.js"></script>

				<script src="../../frontlib/lightbox/js/lightbox.min.js"></script>

				<script src="../../frontlib/owlcarousel/owl.carousel.min.js"></script>

				<script src="../../frontjs/main.js"></script>
				<script>
					$('#GoToSearchGood').click(function () {
						let searchGoodInput = $(this).closest('form').find('input');
						console.log(searchGoodInput.prop('value'));
						if (searchGoodInput.prop('value') == null) {
							console.log(searchGoodInput);
						}
						else {
							let form = $(this).closest('form');
							form.attr("action", "/searchGood");
							form.attr("method", "get");
							// console.log(form.prop("innerHTML"));
							form.submit();
						}
					})
					$(document).on('click', 'div[class="border border-primary rounded position-relative vesitable-item"]',
						function () {
							//檢視商品頁面(需要頁面跳轉)
							console.log("123123123123123");
							let form = $(this).closest("form");
							form.prop("action", "/goodDetail.controller");
							form.prop("method", "get");
							form.submit();
						})

					$('#GoodSearch').keyup(function () {
						let inputresult = $(this).val();
						$.ajax({
							method: "get",
							url: "/keywordsearch",
							data: { "inputresult": inputresult },
							success: function (data) {
								$('#result').prop("innerHTML", "");
								$.each(data, function (i, n) {
									let resli = document.createElement("li");
									resli.innerHTML = n.goodsName;
									$('#result').append(resli);
								})
							}
						})
					})
					function readNotification(notificationId) {
						fetch("readMessage?notificationId=" + notificationId, {
							method: 'PUT'
						})
							.then(response => {
								location.reload();
							})
					}
				</script>
			</body>

			</html>