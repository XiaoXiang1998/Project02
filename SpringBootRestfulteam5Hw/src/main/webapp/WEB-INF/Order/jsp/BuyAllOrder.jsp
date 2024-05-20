<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.custom-active {
    background-color: #81c408;
    color: white;
}
</style>
</head>
<body>
	<div class="card-deck mt-3">
		<c:forEach items="${BuyAllorders.content}" var="Buyorder">
			<div class="card mt-3">
				<div class="card-body border-bottom">
					<div class="row">
						<div class="col-2">
							<h5 class="card-title">訂單編號: ${Buyorder.orderId}</h5>
						</div>
						<div class="col">
							<div>賣家: ${Buyorder.sellerId.name}</div>
						</div>
						<div class="col-auto">
							<div class="text-end me-3">
								訂單狀態:
								<c:choose>
									<c:when test="${Buyorder.orderStatus == 1}">待出貨</c:when>
									<c:when test="${Buyorder.orderStatus == 2}">待收貨</c:when>
									<c:when test="${Buyorder.orderStatus == 3}">待評論</c:when>
									<c:when test="${Buyorder.orderStatus == 4}">已完成</c:when>
									<c:when test="${Buyorder.orderStatus == 5}">已取消</c:when>
									<c:otherwise>未知狀態</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
				</div>
				<div>
					<div class="row p-3">
						<div class="col-auto ">
							<img src="${Buyorder.formatgoodId.goodImagePath}" class="card-img border" alt="Good Image" style="height: 150px; object-fit: cover;">
						</div>
						<div class="col p-3">
							<div>商品名稱: ${Buyorder.formatgoodId.good.goodsName}</div>
							<div>規格: ${Buyorder.formatgoodId.goodSize}</div>
							<div class="row">
								<div class="col">
									<div>x${Buyorder.quantity }</div>
								</div>
								<div class="col">
									<div class="text-end me-3">單價: $${Buyorder.originalPrice}</div>
								</div>
							</div>
						</div>
					</div>
					<div class="border-top">
						<div class="text-end me-3 fs-4 p-3">訂單金額: $${Buyorder.totalPrice}</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
	<div class="text-center mt-3">
		<ul class="pagination d-flex justify-content-center">
			<c:forEach begin="0" end="${totalPages - 1}" var="i">
				<li class="page-item ">
					<a class="page-link${button} ${currentPage == i ? 'custom-active' : ''}" href="?page=${i}">${i + 1}</a>
				</li>
			</c:forEach>
		</ul>
	</div>
	<script>
		$(document).ready(function() {
			$(".page-link${button}").click(function(event) {
				event.preventDefault();

				var page = $(this).attr("href").split("=")[1];
				$.ajax({
					type : "GET",
					url : "BuyAllOrder${button}?page=" + page,
					success : function(data) {
						$("#nav-${button}").html(data);
					},
					error : function(xhr, status, error) {
						console.error("發生了一個錯誤：", error);
					}
				});
			});
		});
	</script>
</body>
</html>