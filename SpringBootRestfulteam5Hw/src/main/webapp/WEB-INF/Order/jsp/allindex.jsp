<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>Insert title here</title>
</head>
<body class="sb-nav-fixed">
	<nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
		<!-- Navbar Brand-->
		<a class="navbar-brand ps-3" href="index.html">EZ BUY</a>
		<!-- Sidebar Toggle-->
		<button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!">
			<i class="fas fa-bars"></i>
		</button>
		<!-- Navbar Search-->
		<form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
			<div class="input-group">
				<input class="form-control" type="text" placeholder="Search for..." aria-label="Search for..." aria-describedby="btnNavbarSearch" />
				<button class="btn btn-primary" id="btnNavbarSearch" type="button">
					<i class="fas fa-search"></i>
				</button>
			</div>
		</form>
		<!-- Navbar-->
		<ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
			<li class="nav-item dropdown"><a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
				<ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
					<li><a class="dropdown-item" href="#!">Settings</a></li>
					<li><a class="dropdown-item" href="#!">Activity Log</a></li>
					<li>
						<hr class="dropdown-divider" />
					</li>
					<li><a class="dropdown-item" href="#!">Logout</a></li>
				</ul></li>
		</ul>
	</nav>
		<div id="layoutSidenav">
			<div id="layoutSidenav_nav">
				<nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
					<div class="sb-sidenav-menu">
						<div class="nav">
							<div class="sb-sidenav-menu-heading">功能列表666</div>
							<a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
								data-bs-target="#collapsePages" aria-expanded="false" aria-controls="collapsePages">
								<div class="sb-nav-link-icon"><i class="fa-solid fa-user-pen"></i></div>
								人員管理
								<div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
							</a>
							<div class="collapse" id="collapsePages" aria-labelledby="headingTwo"
								data-bs-parent="#sidenavAccordion">
								<nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPages">
									<a class="nav-link" href="AdminIndex">
										會員管理
									</a>
									<a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
										data-bs-target="#pagesCollapseAuth" aria-expanded="false"
										aria-controls="pagesCollapseAuth">
										後台人員管理
										<div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
									</a>
									<div class="collapse" id="pagesCollapseAuth" aria-labelledby="headingOne"
										data-bs-parent="#sidenavAccordionPages">
										<nav class="sb-sidenav-menu-nested nav">
											<a class="nav-link" href="AdminManagement">檢視後台人員</a>
											<a class="nav-link" href="AdminInsert">新增後台人員</a>
										</nav>
									</div>
									<a class="nav-link" href="MembershipLevelGuidelines">
										會員等級規範
									</a>
								</nav>
							</div>
							<a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
								data-bs-target="#order" aria-expanded="false" aria-controls="collapsePages">
								<div class="sb-nav-link-icon"><i class="fa-solid fa-sheet-plastic"></i></div>
								訂單管理
								<div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
							</a>
							<div class="collapse" id="order" aria-labelledby="headingTwo"
								data-bs-parent="#sidenavAccordion">
								<nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPages">
									<a class="nav-link" href="queryOrder.controller">
										訂單詳情
									</a>
								</nav>
							</div>
						</div>
					</div>
				<div class="sb-sidenav-footer">
					<div class="small">Logged in as:</div>
					Start Bootstrap
				</div>
			</nav>
		</div>
</body>
</html>