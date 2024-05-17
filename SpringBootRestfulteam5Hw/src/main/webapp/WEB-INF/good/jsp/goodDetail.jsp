<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="BIG5">
<title>Insert title here</title>
<!-- Google Web Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU"
	crossorigin="anonymous">
<!-- Icon Font Stylesheet -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.css" />
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
	rel="stylesheet">
<link href="../../frontlib/lightbox/css/lightbox.min.css"
	rel="stylesheet">
<head>
<meta charset="BIG5">
<title>Insert title here</title>
<!-- Google Web Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU"
	crossorigin="anonymous">
<!-- Icon Font Stylesheet -->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
	rel="stylesheet">
<link href="../../frontlib/lightbox/css/lightbox.min.css"
	rel="stylesheet">

<link href="../../frontlib/owlcarousel/assets/owl.carousel.min.css"
	rel="stylesheet">


<link href="../../frontcss/bootstrap.min.css" rel="stylesheet">

<link href="../../frontcss/style.css" rel="stylesheet">

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
	// $.ajax({ //會用到多次ajax去抓評論、訂單(透過檢查訂單是否完成來開放評論)
	//     type: 'get',

	//     url: '/good/' + ID,

	//     contentType: 'application/json',

	//     success: function (data) { //將基本商品資訊鑲嵌在本網頁上

	//     }
	// })
</script>
<style>
.ml-3 {
	margin-left: 1rem;
}

.comment-photos img {
	margin-right: 0.5rem;
	margin-bottom: 0.5rem;
}

.time-and-details {
	display: flex;
	align-items: center;
	white-space: nowrap;
}

.time-and-details p, .time-and-details span {
	margin-bottom: 0;
}

.time {
	margin-right: 0.5rem;
}
</style>
</head>
<!-- 建立個人賣場太花時間 拿掉 -->
<!-- 聯絡賣家需要寫聊天室API 拿掉 -->

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
					<small class="me-3"><i
						class="fas fa-envelope me-2 text-secondary"></i><a href="#"
						class="text-white">ezbuycompany@gmail.com</a></small>
				</div>
				<div class="top-link pe-2">
					<a href="#" class="text-white"><small class="text-white mx-2">Privacy
							Policy</small>/</a> <a href="#" class="text-white"><small
						class="text-white mx-2">Terms of Use</small>/</a> <a href="#"
						class="text-white"><small class="text-white ms-2">Sales
							and Refunds</small></a>
				</div>
			</div>
		</div>
		<div class="container px-0">
			<nav class="navbar navbar-light bg-info navbar-expand-xl">
				<a href="MemberLogin.controller" class="navbar-brand">
					<h1 class="text-secondary display-6">EZBuy</h1>
				</a>
				<button class="navbar-toggler py-2 px-3" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
					<span class="fa fa-bars text-secondary"></span>
				</button>
				<div class="collapse navbar-collapse bg-info" id="navbarCollapse">
					<div class="d-flex m-3 me-0">
						<form class="form-inline d-flex">
							<div class="form-group mx-sm-3 mb-2">
								<input type="text"
									class="form-control border-2 border-secondary py-3 px-4 rounded-pill"
									style="width: 850px; height: 60px;" name="GoodName">
							</div>
							<button
								class="btn btn-primary border-2 border-secondary py-3 px-4 rounded-pill position-relative"
								style="left: -80px; height: 60px;" type="button"
								id="GoToSearchGood">
								<i class="fas fa-search"></i>
							</button>
						</form>
						<a href="#" class="position-relative me-4 my-auto ms-5"> <i
							class="fa fa-shopping-bag fa-2x text-secondary"></i> <span
							class="position-absolute bg-white rounded-circle d-flex align-items-center justify-content-center text-dark px-1 ${carItemCount == 0 ? 'd-none' : ''}"
							style="top: -5px; left: 15px; height: 20px; min-width: 20px;">${carItemCount}</span>
						</a>
						<div class="my-auto nav-item dropdown">
							<button class="btn dropdown-toggle" type="button"
								id="dropdownMenuButton1" data-bs-toggle="dropdown"
								aria-expanded="false" style="color: #ffb524">
								<i class="fas fa-user fa-2x"></i>
							</button>
							<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
								<li><a class="dropdown-item" href="#!">會員中心</a></li>
								<li><a class="dropdown-item" href="#!">訂單查詢</a></li>
								<li><a class="dropdown-item" href="#!">評論紀錄</a></li>
								<li><a class="dropdown-item" href="#!">申訴紀錄</a></li>
								<li><a class="dropdown-item" href="#!">活動紀錄</a></li>
								<li>
									<hr class="dropdown-divider" />
								</li>
								<li><a class="dropdown-item" href="#!">登出</a></li>
							</ul>
						</div>
						<div class="dropdown position-relative my-auto">
							<button class="btn position-relative dropdown-toggle"
								type="button" id="notificationsDropdown"
								data-bs-toggle="dropdown" aria-expanded="false"
								style="color: #ffb524">
								<i class="fa-solid fa-bell fa-2x"></i> <span
									class="position-absolute bg-white rounded-circle d-flex align-items-center justify-content-center text-dark px-1 ${count == 0 ? 'd-none' : ''}"
									style="top: 2px; left: 28px; height: 20px; min-width: 20px;">${count}</span>
							</button>
							<div class="dropdown-menu dropdown-menu-end"
								aria-labelledby="notificationsDropdown">
								<ul class="list-group"
									style="max-height: 615px; overflow-y: auto;">
									<c:forEach var="notification" items="${notifications}"
										varStatus="loop">
										<c:if test="${loop.index != 0}">
											<li class="dropdown-divider"></li>
										</c:if>
										<li><a
											class="nav-link dropdown-item fs-md ${notification.reads == 1 ? 'text-muted' : 'fw-bold'}"
											href="#"
											<c:if test="${notification.reads == 0}">
                                                        onclick="readNotification(${notification.id})"
                                                        </c:if>>>
												<img
												src="${notification.orderId.formatgoodId.goodImagePath}"
												alt="商品图片"
												style="max-width: 60px; max-height: 60px; margin-right: 10px">
												${notification.content} <input type="hidden" name="reads"
												value="${notification.reads}">
												<div class="text-end">
													<fmt:formatDate value="${notification.sendTime}"
														pattern="MM月dd日 HH時mm分" />
												</div>
										</a></li>
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

	<!-- Single Product Start -->
	<div class="container-fluid py-5 mt-5">
		<div class="container py-5">
			<div class="row g-4 mt-5">
				<div class="col-lg-12 col-xl-12">
					<div class="row g-4">
						<div class="col-lg-6">
							<div id="carouselExampleControls" class="carousel slide"
								data-ride="carousel">
								<!-- 圖片輪播功能癱瘓中 -->
								<div class="carousel-inner">
									<div class="carousel-item active">
										<img class="img-fluid" src="${Good.titleImage}"
											alt="${Good.titleImage}">
									</div>
									<c:forEach var="j" begin="0" end="${GoodImageNumber}" step="1"
										items="${GoodImage}" varStatus="loop">
										<div class="carousel-item">
											<img class="img-fluid" src="${j.imagePath}"
												alt="${j.imagePath}">
										</div>
									</c:forEach>
									<c:forEach var="j" begin="0" end="${GoodFormatImagePathNumber}"
										step="1" items="${GoodFormatImagePath}" varStatus="loop">
										<div class="carousel-item">
											<img class="img-fluid" src="${j.goodImagePath}"
												alt="${j.goodImagePath}">
										</div>
									</c:forEach>
								</div>
								<a class="carousel-control-prev" href="#carouselExampleControls"
									role="button" data-slide="prev"> <span
									class="carousel-control-prev-icon" aria-hidden="true"></span> <span
									class="sr-only">Previous</span>
								</a> <a class="carousel-control-next"
									href="#carouselExampleControls" role="button" data-slide="next">
									<span class="carousel-control-next-icon" aria-hidden="true"></span>
									<span class="sr-only">Next</span>
								</a>
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
								<p class="mx-3 mb-1" id="GoodSold">已售出:
									${GoodBasicInfo.goodsold}</p>
								<!-- 商品售出量 -->
							</div>
							<p class="mb-3" id="GoodType">Category:
								${GoodBasicInfo.goodType}</p>
							<!-- 商品種類 -->
							<h5 class="fw-bold mb-3" id="GoodPriceRange">
								${GoodBasicInfo.minprice}-${GoodBasicInfo.maxprice}$</h5>
							<!-- 商品價格(以範圍表示) -->
							<div class="row row-cols-2">
								<c:forEach var="j" begin="0" end="${GoodFormatNumber}" step="1"
									items="${GoodFormat}" varStatus="loop">
									<div class="col">
										<button
											class="btn btn-outline-primary round-pill CategoryItem w-100 mb-1">
											<img src="${j.goodImagePath}" alt="${j.goodImagePath}"
												style="width: 20px; height: 20px;"> <span>${j.goodSize}</span>
											<span hidden class="CategoryPrice">${j.goodPrice}</span> <span
												hidden class="CategoryNumber">${j.goodsStock}</span>
										</button>
									</div>
								</c:forEach>
							</div>
							<div class="input-group quantity mb-5 d-flex" id="BuyItemNumber"
								hidden>
								<!--買入數量  -->
								<div class="input-group-btn">
									<button
										class="btn btn-sm btn-minus rounded-circle bg-light border">
										<i class="fa fa-minus"></i>
										<!-- 降低數量按鈕 -->
									</button>
								</div>
								<input type="text"
									class="form-control form-control-sm text-center border-0"
									value="1" id="BuyNumber" style="width: 10px;">
								<!-- 當點擊到庫存上限時 會出現紅字 -->
								<p id="errormsg"></p>
								<div class="input-group-btn">
									<button
										class="btn btn-sm btn-plus rounded-circle bg-light border">
										<i class="fa fa-plus"></i>
										<!-- 增加數量按鈕 -->
									</button>
								</div>
								<div class="row">
									<div class="col-6">
										<span id="remainingNumber"></span>
									</div>
									<div class="col-6">
										<span id="CategoryPrice"></span>
									</div>
								</div>
							</div>
						</div>
						<!-- 商品圖片(用輪播呈現) -->
					</div>
				</div>
				<div class="col-lg-6">
					<!-- Single Product Start -->
					<div class="container-fluid py-5 mt-5">
						<div class="container py-5">
							<div class="row g-4 mt-5">
								<div class="col-lg-12 col-xl-12">
									<div class="row g-4">
										<div class="col-lg-6">
											<!-- 圖片輪播功能(缺箭頭圖標) -->
											<div class="your-class">
												<div>
													<img class="img-fluid w-100" src="${Good.titleImage}"
														alt="${Good.titleImage}" style="height: 400px;">
												</div>
												<c:forEach var="j" begin="0" end="${GoodImageNumber}"
													step="1" items="${GoodImage}" varStatus="loop">
													<div>
														<img class="img-fluid w-100" src="${j.imagePath}"
															alt="${j.imagePath}" style="height: 400px;">
													</div>
												</c:forEach>
												<c:forEach var="j" begin="0"
													end="${GoodFormatImagePathNumber}" step="1"
													items="${GoodFormatImagePath}" varStatus="loop">
													<div>
														<img class="img-fluid w-100" src="${j.goodImagePath}"
															alt="${j.goodImagePath}" style="height: 400px;">
													</div>
												</c:forEach>
											</div>

											<!-- 商品規格(呈現該商品編號下對應的所有規格) -->

										</div>
										<div class="col-lg-6">
											<h4 class="fw-bold mb-3" id="GoodName">
												${GoodBasicInfo.goodName}</h4>
											<!-- 商品名稱 -->
											<div class="d-flex mb-4" id="GoodRate">
												<!-- 平均分數 EX(3.5/5) -->
												<c:forEach var="j" begin="1" end="5" step="1"
													varStatus="loop">
													<c:if test="${GoodBasicInfo.goodAVG>=loop.index}">
														<i class="fa fa-star text-secondary py-1"></i>
													</c:if>
													<c:if test="${loop.index>GoodBasicInfo.goodAVG}">
														<i class="fa fa-star py-1"></i>
													</c:if>
												</c:forEach>
												<p class="mx-3 mb-1" id="GoodSold">已售出:
													${GoodBasicInfo.goodsold}</p>
												<!-- 商品售出量 -->
											</div>
											<p class="mb-3" id="GoodType">Category:
												${GoodBasicInfo.goodType}</p>
											<!-- 商品種類 -->
											<h5 class="fw-bold mb-3" id="GoodPriceRange">
												${GoodBasicInfo.minprice}-${GoodBasicInfo.maxprice}$</h5>
											<!-- 商品價格(以範圍表示) -->
											<div class="row row-cols-2">
												<c:forEach var="j" begin="0" end="${GoodFormatNumber}"
													step="1" items="${GoodFormat}" varStatus="loop">
													<div class="col">
														<button
															class="btn btn-outline-primary round-pill CategoryItem w-100 mb-1">
															<img src="${j.goodImagePath}" alt="${j.goodImagePath}"
																style="width: 20px; height: 20px;"> <span>${j.goodSize}</span>
															<span hidden class="CategoryPrice">${j.goodPrice}</span>
															<span hidden class="CategoryNumber">${j.goodsStock}</span>
															<span hidden class="formatID">${j.good.goodsID}</span>
														</button>
													</div>
												</c:forEach>
											</div>
											<div class="input-group quantity mb-5 d-flex"
												id="BuyItemNumber" hidden>
												<!--買入數量  -->
												<div class="input-group-btn">
													<button
														class="btn btn-sm btn-minus rounded-circle bg-light border">
														<i class="fa fa-minus"></i>
														<!-- 降低數量按鈕 -->
													</button>
												</div>
												<input type="text"
													class="form-control form-control-sm text-center border-0"
													value="1" id="BuyNumber" style="width: 10px;">
												<!-- 當點擊到庫存上限時 會出現紅字 -->
												<p id="errormsg"></p>
												<div class="input-group-btn">
													<button
														class="btn btn-sm btn-plus rounded-circle bg-light border">
														<i class="fa fa-plus"></i>
														<!-- 增加數量按鈕 -->
													</button>
												</div>
												<div class="row">
													<div class="col-6">
														<span id="remainingNumber"></span>
													</div>
													<div class="col-6">
														<span id="CategoryPrice"></span>
													</div>
												</div>
											</div>
											<div class="d-flex">
												<div class="col">
													<form action="" id="orderDetail">
														<!-- 進入訂單環節(跳轉頁面) -->
														<!-- 下單後對應規格的庫存量會下降 -->
														<input type="text" class="form-control" id="orderNumber"
															name="orderNumber" hidden>
														<!-- 購買數量 -->
														<input type="text" class="form-control" id="orderformatID"
															name="orderformatID" hidden>
														<!-- 規格表編號 -->
														<input type="text" class="form-control" id="buyerorderID"
															name="buyerorderID" hidden>
														<!-- 買家編號 -->
														<button type="button" id="GoToOrder">去結帳</button>
													</form>
												</div>
												<div class="col">
													<form action="" id="cartDetail">
														<!-- 進入購物車(透過ajax將值傳到後端) -->
														<input type="text" class="form-control" id="cartNumber"
															name="cartNumber" hidden>
														<!-- 購買數量 -->
														<input type="text" class="form-control" id="cartformatID"
															name="cartformatID" hidden>
														<!-- 規格表編號 -->
														<input type="text" class="form-control" id="buyercartID"
															name="buyercartID" hidden>
														<!-- 買家編號 -->
														<button type="button" id="GoToCart">加入購物車</button>
													</form>
												</div>
												<!-- 一個是直接購買(直接進入訂單環節) 另一個是加入購物車(將購買的商品放入購物車內) -->
												<!-- 在購買之前需要選擇特定規格 -->
												<form action="" id="orderDetail">
													<!-- 進入訂單環節(跳轉頁面) -->
													<!-- 下單後對應規格的庫存量會下降 -->
													<input type="text" class="form-control" id="orderNumber"
														name="orderNumber" hidden>
													<!-- 購買數量 -->
													<input type="text" class="form-control" id="formatID"
														name="formatID" hidden>
													<!-- 規格表編號 -->
													<input type="text" class="form-control" id="formatID"
														name="formatID" hidden>
													<!-- 買家編號 -->
													<button>去結帳</button>
												</form>
												<form action="" id="cartDetail">
													<!-- 進入購物車(透過ajax將值傳到後端) -->
													<input type="text" hidden>
													<!-- 購買數量 -->
													<input type="text" hidden>
													<!-- 規格表編號 -->
													<input type="text" hidden>
													<!-- 買家編號 -->
													<button>加入購物車</button>
												</form>

											</div>
											<div class="col-lg-12">
												<nav>
													<div class="nav nav-tabs mb-3">
														<button
															class="nav-link active border-white border-bottom-0"
															type="button" role="tab" id="nav-about-tab"
															data-bs-toggle="tab" data-bs-target="#nav-about"
															aria-controls="nav-about" aria-selected="true">商品使用說明</button>
														<button class="nav-link border-white border-bottom-0"
															type="button" role="tab" id="nav-mission-tab"
															data-bs-toggle="tab" data-bs-target="#nav-mission"
															aria-controls="nav-mission" aria-selected="false">評論</button>
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
															<c:forEach var="post" items="${posts}">
																<div class="d-flex mb-4" >
																	<img src="" class="img-fluid rounded-circle p-3"
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
																				${post.orders.formatgoodId.goodSize}</p>
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
														</c:if>
														<!-- 如果沒有評論，顯示提示信息 -->
														<c:if test="${empty posts}">
															<p>還沒有任何相關的評論喔!</p>
														</c:if>
														<div>
															<h2>Pagination</h2>
															<div id="pagination-links">
																<!-- 这里是您现有的分页链接 -->
																<c:forEach var="i" begin="0" end="${totalPages - 1}">
																	<a href="#" class="pagination-link" data-page="${i}">${i + 1}</a>
																</c:forEach>
															</div>
														</div>
													</div>

												</div>
											</div>

										</div>
									</div>

								</div>
								<h1 class="fw-bold mb-0">Related products</h1>
								<!-- 透過商品種類去查詢商品基本資料表 -->
								<div class="vesitable">
									<div
										class="owl-carousel vegetable-carousel justify-content-center">
										<!-- 透過迴圈去寫 -->
										<form action="" method="">
											<div
												class="border border-primary rounded position-relative vesitable-item">
												<div class="vesitable-img">
													<!-- 商品封面圖片 -->
													<img src="img/vegetable-item-6.jpg"
														class="img-fluid w-100 rounded-top" alt="">
												</div>
												<div
													class="text-white bg-primary px-3 py-1 rounded position-absolute"
													style="top: 10px; right: 10px;">Vegetable</div>
												<!-- 商品名稱 -->
											</div>
										</form>
									</div>
								</div>
							</div>
						</div>
						<!-- Single Product End -->


						<!-- Footer Start -->
						<div
							class="container-fluid bg-dark text-white-50 footer pt-5 mt-5">
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
												<a
													class="btn  btn-outline-secondary me-2 btn-md-square rounded-circle"
													href=""><i class="fab fa-twitter"></i></a> <a
													class="btn btn-outline-secondary me-2 btn-md-square rounded-circle"
													href=""><i class="fab fa-facebook-f"></i></a> <a
													class="btn btn-outline-secondary me-2 btn-md-square rounded-circle"
													href=""><i class="fab fa-youtube"></i></a> <a
													class="btn btn-outline-secondary btn-md-square rounded-circle"
													href=""><i class="fab fa-linkedin-in"></i></a>
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
												Aldus PageMaker including of Lorem Ipsum.</p>
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
												Policy</a> <a class="btn-link" href="">Terms & Condition</a> <a
												class="btn-link" href="">Return Policy</a> <a
												class="btn-link" href="">FAQs & Help</a>
										</div>
									</div>
									<div class="col-lg-3 col-md-6">
										<div class="d-flex flex-column text-start footer-item">
											<h4 class="text-light mb-3">Account</h4>
											<a class="btn-link" href="">My Account</a> <a
												class="btn-link" href="">Shop details</a> <a
												class="btn-link" href="">Shopping Cart</a> <a
												class="btn-link" href="">Wishlist</a> <a class="btn-link"
												href="">Order History</a> <a class="btn-link" href="">International
												Orders</a>
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
										<span class="text-light"><a href="#"><i
												class="fas fa-copyright text-light me-2"></i>Your Site Name</a>,
											All right reserved.</span>
									</div>
									<div
										class="col-md-6 my-auto text-center text-md-end text-white">
										<!--/*** This template is free as long as you keep the below author’s credit link/attribution link/backlink. ***/-->
										<!--/*** If you'd like to use the template without the below author’s credit link/attribution link/backlink, ***/-->
										<!--/*** you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". ***/-->
										Designed By <a class="border-bottom"
											href="https://htmlcodex.com">HTML Codex</a> Distributed By <a
											class="border-bottom" href="https://themewagon.com">ThemeWagon</a>
									</div>
								</div>
							</div>
						</div>
						<!-- Copyright End -->



						<!-- Back to Top -->
						<a href="#"
							class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i
							class="fa fa-arrow-up"></i></a>


						<!-- JavaScript Libraries -->

						<script
							src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"
							integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ"
							crossorigin="anonymous">
							
						</script>
						<script
							src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
						<script
							src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
						<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
						<script
							src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.js"></script>
						<script src="../../frontlib/easing/easing.js"></script>
						<script src="../../frontlib/waypoints/waypoints.min.js"></script>

						<script
							src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"
							integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ"
							crossorigin="anonymous"></script>
						<script
							src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
						<script
							src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
						<!--  -->
						<script src="../../frontlib/easing/easing.js"></script>
						<script src="../../frontlib/waypoints/waypoints.min.js"></script>


						<script src="../../frontlib/lightbox/js/lightbox.min.js"></script>

						<script src="../../frontlib/owlcarousel/owl.carousel.min.js"></script>

						<script src="../../frontjs/main.js"></script>
						<script>
							$('#search-icon-1').click(function() {//查詢賣家底下的商品
								// action="" method="get" id="gotoSearchGoodForm"
								let form = $(this).closest('form');
								form.prop("action", "....");//目標網址
								form.submit();
							})

							$('.CategoryItem')
									.click(
											function() {//取得對應規格編號
												if ($('#BuyItemNumber').prop(
														"hidden") == true) {//假若欄位被影藏
													$('#BuyItemNumber').prop(
															"hidden", false);//取消影藏
												} else {
													//假若從規格A按成規格B 數量直接回到1
													let formatID = $(this)
															.find(
																	'span[class="formatID"]')
															.prop("innerHTML");//取得規格編號
													$('#BuyNumber').prop(
															"value", 1);
													$('#orderformatID').prop(
															"value", formatID);
													$('#cartformatID').prop(
															"value", formatID);
													// 將規格編號塞入form標籤內
												}
												let goodstock = $(this)
														.find(
																'span[class="CategoryNumber"]')
														.prop("innerHTML");
												let formatprice = $(this)
														.find(
																'span[class="CategoryPrice"]')
														.prop("innerHTML");
											})

							$('#BuyNumber')
									.change(
											function() {
												let InputNumber = $(this).prop(
														"value");
												let goodstockmsg = $(
														'#BuyItemNumber')
														.find(
																'span[id="remainingNumber"]')
														.prop("innerHTML");
												let goodstock = goodstockmsg
														.substring(
																2,
																goodstockmsg.length - 1);
												if (Number(goodstock) > InputNumber
														&& InputNumber >= 1) {
													$('#errormsg').prop(
															"innerHTML", "");
												} else {
													if (InputNumber > Number(goodstock)) {
														$('#errormsg').prop(
																"innerHTML",
																"操作不當");//最多只能購買剩餘的數量
														$(this)
																.closest('div')
																.find(
																		'input[id="BuyNumber"]')
																.prop("value",
																		1);//不讓數字增加
													}
													if (InputNumber < 1) {
														$(this)
																.closest('div')
																.find(
																		'input[id="BuyNumber"]')
																.prop("value",
																		1);//最少購買一筆
													}
												}

											})

							$(
									'button[class="btn btn-sm btn-plus rounded-circle bg-light border"]')
									.click(
											function() {
												let InputNumber = $(this)
														.closest('div')
														.find(
																'input[id="BuyNumber"]')
														.prop("value");
												let goodstockmsg = $(
														'#BuyItemNumber')
														.find(
																'span[id="remainingNumber"]')
														.prop("innerHTML");
												let goodstock = goodstockmsg
														.substring(
																2,
																goodstockmsg.length - 1);
												if (InputNumber > Number(goodstock)) {
													$('#errormsg')
															.prop("innerHTML",
																	"操作不當");//最多只能購買剩餘的數量
													$(this)
															.closest('div')
															.find(
																	'input[id="BuyNumber"]')
															.prop(
																	"value",
																	Number(goodstock));//不讓數字增加
												}
											})

							$(
									'button[class="btn btn-sm btn-minus rounded-circle bg-light border"]')
									.click(
											function() {
												let InputNumber = $(this)
														.closest('div')
														.find(
																'input[id="BuyNumber"]')
														.prop("value");
												let goodstockmsg = $(
														'#BuyItemNumber')
														.find(
																'span[id="remainingNumber"]')
														.prop("innerHTML");//
												let goodstock = goodstockmsg
														.substring(
																2,
																goodstockmsg.length - 1);//取得剩餘數量
												if (InputNumber <= Number(goodstock)) {
													$('#errormsg').prop(
															"innerHTML", "");//將錯誤訊息抹消
												}
												if (InputNumber <= 1) {
													$(this)
															.closest('div')
															.find(
																	'input[id="BuyNumber"]')
															.prop("value", 1);//最少購買一筆
												}
											})

							$('#GoToCart').click(function() {
								let buynumber = $('#BuyNumber').val();
								$('#cartNumber').prop("value", buynumber);
								// 透過ajax傳資料
								let form = $(this).closest('form');

							})

							$('#GoToOrder').click(function() {
								let buynumber = $('#BuyNumber').val();
								$('#orderNumber').prop("value", buynumber);
								// 頁面跳轉
								let form = $(this).closest('form');

							})
						/*	$(document).ready(function() {
								$('.your-class').slick({
									arrows : true
								});
							});*/
							$(
									'button[class="btn btn-sm btn-plus rounded-circle bg-light border"]')
									.click(
											function() {
												let InputNumber = $(this)
														.closest('div')
														.find(
																'input[id="BuyNumber"]')
														.prop("value");
												let goodstockmsg = $(
														'#BuyItemNumber')
														.find(
																'p[id="remainingNumber"]')
														.prop("innerHTML");
												let goodstock = goodstockmsg
														.substring(
																2,
																goodstockmsg.length - 1);
												if (ItemNumber > Number(goodstock)) {
													$('#errormsg')
															.prop("innerHTML",
																	"操作不當");//最多只能購買剩餘的數量
													$(this)
															.closest('div')
															.find(
																	'input[id="BuyNumber"]')
															.prop(
																	"value",
																	Number(goodstock));//不讓數字增加
												}
											})
							$(
									'button[class="btn btn-sm btn-minus rounded-circle bg-light border"]')
									.click(
											function() {
												let InputNumber = $(this)
														.closest('div')
														.find(
																'input[id="BuyNumber"]')
														.prop("value");
												let goodstockmsg = $(
														'#BuyItemNumber')
														.find(
																'p[id="remainingNumber"]')
														.prop("innerHTML");//
												let goodstock = goodstockmsg
														.substring(
																2,
																goodstockmsg.length - 1);//取得剩餘數量
												if (ItemNumber <= Number(goodstock)) {
													$('#errormsg').prop(
															"innerHTML", "");//將錯誤訊息抹消 } 
													if (ItemNumber <= 1) {
														$(this)
																.closest('div')
																.find(
																		'input[id="BuyNumber"]')
																.prop("value",
																		1);//最少購買一筆 } 
													}
												}
											})
						</script>

						<script type="text/javascript">
						$(document).ready(function () {
						    loadComments(0);

						    // 点击分页链接时加载对应页码的评论数据
						    $(document).on('click', '.pagination-link', function (e) {
						        e.preventDefault();
						        var page = $(this).data('page');
						        loadComments(page);
						    });
						});

						function loadComments(page) {
						    console.log(page);
						    $.ajax({
						        url: '/goodDetail.controller', // 控制器路径
						        type: 'GET',
						        data: {
						            GoodID: ${Good.goodsID},
						            page: page
						        },
						        success: function (data) {
						            console.log(data);
						            // 清空评论容器内容
						            $('#nav-mission').empty();
						            // 更新评论部分
						            $('#nav-mission').html($(data).find('#nav-mission').html());
						            
						            // 更新分页链接
						            $('#pagination-links').html($(data).find('#pagination-links').html());
						        },
						        error: function () {
						            console.error('Failed to fetch comments data.');
						        }
						    });
						}	
</script>
</body>

</html>