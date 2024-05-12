<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>首頁</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-p34f1UUtsS3wqzfto5wAAmdvj+osOnFyQFpp4Ua3gs/ZVWx6oOypYoCJhGGScy+8" crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/92a295a0cf.js" crossorigin="anonymous"></script>

</head>

<body>
	<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
		<div class="container-fluid">
			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav">
					<li class="nav-item">
						<a class="nav-link ${page eq 'index' ? 'active' : ''}" href="goindex.controller">首頁</a>
					</li>
					<li class="nav-item">
						<a class="nav-link ${page eq 'product' ? 'active' : ''}" href="product.controller">商品列表</a>
					</li>
					<li class="nav-item">
						<a class="nav-link ${page eq 'shopcar' ? 'active' : ''}" href="shopcar.controller">購物車</a>
					</li>
					<li class="nav-item">
						<a class="nav-link ${page eq 'query' ? 'active' : ''}" href="queryOrder.controller">訂單管理</a>
					</li>
					<li class="nav-item">
						<a class="nav-link ${page eq 'admin' ? 'active' : ''}" href="goui.controller">管理系統</a>
					</li>
				</ul>
				<ul class="navbar-nav ms-auto">
					<li class="nav-item">
						<span class="nav-link">${member.name}</span>
					</li>
					<li class="nav-item">
						<div class="dropdown">
							<button class="btn btn-primary position-relative dropdown-toggle" type="button" id="notificationsDropdown" data-bs-toggle="dropdown" aria-expanded="false">
								<i class="fa-regular fa-bell"></i>
								<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">${count}</span>
							</button>
							<ul class="dropdown-menu dropdown-menu-end" aria-labelledby="notificationsDropdown">
								<c:forEach var="notification" items="${notifications}" varStatus="loop">
									<c:if test="${loop.index != 0}">
										<li class="dropdown-divider"></li>
									</c:if>
									<li>
										<a class="dropdown-item fs-md" href="#" onclick="readNotification(${notification.id})">${notification.content}
										<input type="hidden" name="reads" value="${notification.reads}">
											<div class="text-end">
												<fmt:formatDate value="${notification.sendTime}" pattern="MM月dd日 HH時mm分" />
											</div>
										</a>
									</li>
								</c:forEach>
							</ul>
						</div>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="ezbuy.com" id="log">登出</a>
					</li>
				</ul>
			</div>
		</div>
	</nav>
	<script>
		let errorMessage = document.querySelector('span.nav-link');
		let log = document.querySelector('#log');
		if (errorMessage.innerHTML.trim() === "") {
			log.innerHTML = "登入";
		}
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