<%@page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://kit.fontawesome.com/92a295a0cf.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
<!-- Libraries Stylesheet -->
<link href="/frontlib/lightbox/css/lightbox.min.css" rel="stylesheet">
<link href="/frontlib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
<link href="/frontcss/bootstrap.min.css" rel="stylesheet">
<link href="frontcss/style.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
<div class="container-fluid bg-info">
	<div class="container topbar bg-info d-none d-lg-block mb-3">
		<div class="d-flex justify-content-between">
			<div class="top-info ps-2">
				<small class="me-3"> <i class="fas fa-envelope me-2 text-secondary"></i> <a href="#" class="text-white">ezbuycompany@gmail.com</a>
				</small>
			</div>
			<div class="top-link pe-2">
				<a href="#" class="text-white"> <small class="text-white mx-2">Privacy Policy</small> /
				</a> <a href="#" class="text-white"> <small class="text-white mx-2">Terms of Use</small> /
				</a> <a href="#" class="text-white"> <small class="text-white ms-2">Sales and Refunds</small>
				</a>
			</div>
		</div>
	</div>
	<div class="container px-0">
		<nav class="navbar navbar-light bg-info navbar-expand-xl">
			<a href="EZBuyIndexWithoutLogin" class="navbar-brand">
				<h1 class="text-secondary display-6">EZBuy</h1>
			</a>
			<button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
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
							<input type="text" class="form-control border-2 border-secondary py-3 px-4 rounded-pill" style="width: 850px; height: 60px;" name="GoodName">
						</div>
						<button class="btn btn-primary border-2 border-secondary py-3 px-4 rounded-pill position-relative" style="left: -80px; height: 60px;" type="button" id="GoToSearchGood">
							<i class="fas fa-search"></i>
						</button>
					</form>
					<a href="shopcar.controller" class="position-relative me-4 my-auto ms-5"> <i class="fa fa-shopping-bag fa-2x text-secondary"></i> <span class="position-absolute bg-white rounded-circle d-flex align-items-center justify-content-center text-dark px-1 ${carItemCount == 0 ? 'd-none' : ''}" style="top: -5px; left: 15px; height: 20px; min-width: 20px;">${carItemCount}</span>
					</a>
					<div class="my-auto nav-item dropdown">
						<button class="btn dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false" style="color: #ffb524">
							<i class="fas fa-user fa-2x"></i>
						</button>
						<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
							<li><a class="dropdown-item" href="membercenter">會員中心</a></li>
							<li>
								<hr class="dropdown-divider" />
							</li>
							<li><a class="dropdown-item" href="logout">登出</a></li>
						</ul>
					</div>
					<div class="dropdown position-relative my-auto">
						<button class="btn position-relative dropdown-toggle" type="button" id="notificationsDropdown" data-bs-toggle="dropdown" aria-expanded="false" style="color: #ffb524">
							<i class="fa-solid fa-bell fa-2x"></i> <span class="position-absolute bg-white rounded-circle d-flex align-items-center justify-content-center text-dark px-1 ${count == 0 ? 'd-none' : ''}" style="top: 2px; left: 28px; height: 20px; min-width: 20px;">${count}</span>
						</button>
						<div class="dropdown-menu dropdown-menu-end" aria-labelledby="notificationsDropdown">
							<ul class="list-group" style="max-height: 615px; overflow-y: auto;">
								<c:forEach var="notification" items="${notifications}" varStatus="loop">
									<c:if test="${loop.index != 0}">
										<li class="dropdown-divider"></li>
									</c:if>
									<li><a class="nav-link dropdown-item fs-md ${notification.reads == 1 ? 'text-muted' : 'fw-bold'}" href="#" <c:if test="${notification.reads == 0}">
                                                        onclick="readNotification(${notification.id})"
                                                        </c:if>> <img src="${notification.orderId.formatgoodId.goodImagePath}" alt="商品图片" style="max-width: 60px; max-height: 60px; margin-right: 10px"> ${notification.content} <input type="hidden" name="reads" value="${notification.reads}">
											<div class="text-end">
												<fmt:formatDate value="${notification.sendTime}" pattern="MM月dd日 HH時mm分" />
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