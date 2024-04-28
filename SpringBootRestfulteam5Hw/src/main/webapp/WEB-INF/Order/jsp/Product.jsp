<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

		<!DOCTYPE html>
		<html>

		<head>
			<meta charset="UTF-8">
			<title>商品列表</title>
			
			<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10/dist/sweetalert2.min.css">
			 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
			<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

		</head>
		<body>
	<%@ include file="Index.jsp"%>
	<div class="container">
    <h3 class="text-center m-3">商品列表</h3>
    <div class="table-responsive">
        <table class="table table-striped table-bordered text-center align-middle">
            <thead class="thead-dark">
                <tr>
                    <th class="col-2">產品ID</th>
                    <th class="col-2">賣家</th>
                    <th class="col-3">產品名稱</th>
                    <th class="col-2">價格</th>
                    <th class="col-2">操作</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${products}" var="product">
                    <tr>
                        <td>${product}</td>
                        <td>${product.goodsSellerID.name}</td>
                        <td>${product.goodsName}</td>
                        <td>${product}</td>
                        <td>
                            <button class="btn btn-primary" onclick="confirmAddToCart(${product.goodsId}, '${product.goodsName}',${product.goodsPrice})">增加到購物車</button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>


			<script>
	
				function confirmAddToCart(productId, productName, productPrice) {
					Swal.fire({
						title: '確定要將 ' + productName + ' 添加到購物車嗎？',
						icon: 'question',
						showCancelButton: true,
						confirmButtonColor: '#3085d6',
						cancelButtonColor: '#d33',
						confirmButtonText: '確定',
						cancelButtonText: '取消'
					}).then((result) => {
						if (result.isConfirmed) {
							insertToCar(productId, productName,productPrice);
						}
					});
				}

				function insertToCar(productId, productName,productPrice) {
					let xhr = new XMLHttpRequest();
					let url = "inserttoshopcar.controller";
					let quantity = 1;
					let data = "productId=" + productId + "&quantity=" + quantity + "&productPrice=" + productPrice;
					xhr.open("POST", url, true);
					xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
					xhr.onreadystatechange = function () {
						if (xhr.readyState === XMLHttpRequest.DONE) {
							if (xhr.status === 200) {
								Swal.fire({
									title: '添加成功！',
									icon: 'success'
								});
							} else {
								Swal.fire({
									title: '添加失敗...',
									icon: 'error'
								});
							}
						}
					};
					xhr.send(data);
				}
			</script>

		</body>

		</html>