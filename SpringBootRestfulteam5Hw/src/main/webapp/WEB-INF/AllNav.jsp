<%@page pageEncoding="UTF-8" %>
	<div id="layoutSidenav_nav">
		<nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
			<div class="sb-sidenav-menu">
				<div class="nav">
					<div class="sb-sidenav-menu-heading">功能列表</div>
					<a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapsePages"
						aria-expanded="false" aria-controls="collapsePages">
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

							<a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
								data-bs-target="#MembershipLevel" aria-expanded="false"
								aria-controls="pagesCollapseAuth">
								會員規範管理
								<div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
							</a>
							<div class="collapse" id="MembershipLevel" aria-labelledby="headingOne"
								data-bs-parent="#sidenavAccordionPages">
								<nav class="sb-sidenav-menu-nested nav">
									<a class="nav-link" href="MembershipLevelGuidelines">檢視會員等級規範</a>
									<a class="nav-link" href="InsertMembershipLevel">新增會員等級規範</a>
								</nav>
							</div>
						</nav>
					</div>
					<a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#order"
						aria-expanded="false" aria-controls="collapsePages">
						<div class="sb-nav-link-icon"><i class="fa-solid fa-sheet-plastic"></i></div>
						訂單管理
						<div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
					</a>
					<div class="collapse" id="order" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
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