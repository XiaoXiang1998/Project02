<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<%@ taglib prefix="b" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>訂單詳情</title>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10/dist/sweetalert2.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<style>
.progress-container {
	position: relative;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.progress-bar {
	height: 5px;
	position: absolute;
	top: 25px;
	left: 123px;
	width: 80%;
	z-index: 0;
}

.circle {
	width: 50px;
	height: 50px;
	left:100px;
	background-color: white;
	border: 5px solid #28a745;
	border-radius: 50%;
	display: flex;
	justify-content: center;
	align-items: center;
	position: relative;
	z-index: 1;
}

.step {
	text-align: center;
	flex: 1;
	position: relative;
}

.step .circle {
	z-index: 2;
}

</style>
</head>
<body>
	<%@ include file="../../FrontDeskNav.jsp"%>
	<div class="container">
		<h3 class="text-center mt-3">訂單詳情</h3>
		<div class="row mt-3">
			<div class="col-md-12">
				<div class="card fs-5">
					<div class="card-header">訂單編號: ${order.orderId}</div>
					<div class="card-body">
						<div class="row">
							<div class="col-md-6">
								<p>
									<strong>賣家:</strong>
									${order.sellerId.name}
								</p>
								<p>
									<strong>運送方式:</strong>
									<b:choose>
										<b:when test="${order.shippingMethod == 1}">宅配到家</b:when>
										<b:when test="${order.shippingMethod == 2}">超商物流</b:when>
										<b:otherwise>未知</b:otherwise>
									</b:choose>
								</p>
							</div>
							<div class="col-md-6">
								<p>
									<strong>收件人姓名:</strong>
									${order.name}
								</p>
								<p>
									<strong>收件人地址:</strong>
									${order.address}
								</p>
								<p>
									<strong>收件人電話:</strong>
									${order.tel}
								</p>
							</div>
						</div>
						<div class="progress-container m-3">
								    <div class="step">
								        <div class="circle">
								            <i class="fa-solid fa-file-lines"></i>
								        </div>
								        <p>訂單已成立</p>
								    </div>
								    <div class="step">
								        <div class="circle">
								            <i class="fa-solid fa-truck"></i>
								        </div>
								        <p>訂單待出貨</p>
								    </div>
								    <div class="step">
								        <div class="circle">
								            <i class="fa-solid fa-box"></i>
								        </div>
								        <p>訂單待收貨</p>
								    </div>
								    <div class="step">
								        <div class="circle">
								            <i class="fa-solid fa-file-pen"></i>
								        </div>
								        <p>訂單待評論</p>
								    </div>
								    <div class="step">
								        <div class="circle">
								            <i class="fas fa-check"></i>
								        </div>
								        <p>訂單已完成</p>
								    </div>
								    <c:choose>
        <c:when test="${order.orderStatus == 1}">
            <div class="progress-bar" style="width: 20%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100"></div>
        </c:when>
        <c:when test="${order.orderStatus == 2}">
            <div class="progress-bar" style="width: 40%" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100"></div>
        </c:when>
        <c:when test="${order.orderStatus == 3}">
            <div class="progress-bar" style="width: 60%" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"></div>
        </c:when>
        <c:when test="${order.orderStatus == 4}">
            <div class="progress-bar" style="width: 80%" aria-valuenow="80" aria-valuemin="0" aria-valuemax="100"></div>
        </c:when>
        <c:when test="${order.orderStatus == 5}">
            <div class="progress-bar" style="width: 100%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
        </c:when>
    </c:choose>
								</div>
						<div class="row mt-3">
							<div class="col-md-4">
								<img src="${order.formatgoodId.goodImagePath}" class="card-img border" alt="商品圖片">
							</div>
							<div class="col-md-8">
								<p>
									<strong>商品名稱:</strong>
									${order.formatgoodId.good.goodsName}
								</p>
								<p>
									<strong>商品單價:</strong>
									$${order.originalPrice}
								</p>
								<p>
									<strong>數量:</strong>
									${order.quantity}
								</p>
								<p>
									<strong>運費:</strong>
									$${order.shippingFee}
								</p>
								<p>
									<strong>支付金額:</strong>
									$${order.totalPrice}
								</p>

								
								
								<p>
									<strong>付款狀態:</strong>
									${order.payStatus == 0 ? '未付款' : '已付款'}
								</p>
								<p>
									<strong>成立時間:</strong>
									<fmt:formatDate value="${order.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" />
								</p>
							</div>
						</div>
						<div class="row mt-3">
							<div class="col-md-12 text-right">
								<a href="#" onclick="showEditForm('${order.orderId}','${order.name}','${order.tel}','${order.address}',${order.orderStatus})" class="btn btn-primary btn-sm">修改</a>
								<a href="#" onclick="confirmDelete(${order.orderId}, '${queryType}')" class="btn btn-danger btn-sm">刪除</a>
							</div>
						</div>
					</div>
				</div>
				<b:choose>
					<b:when test="${empty order.orderId}">
						<p class="text-center fs-5 fw-bold mt-3">沒有訂單</p>
					</b:when>
				</b:choose>
			</div>
		</div>
	</div>

	<!-- Edit Form -->
	<div id="editForm" class="d-none" style="position: fixed; top: 0; left: 0; right: 0; bottom: 0; background-color: rgba(255, 255, 255, 0.9); z-index: 1000;">
		<div class="row justify-content-center align-items-center h-100">
			<div class="col-md-6 border p-4">
				<h2 class="mt-5">修改訂單</h2>
				<form id="editOrderForm" action="updateOrder.controller" method="post">
					<input type="hidden" name="_method" value="PUT" />
					<input type="hidden" id="editOrderId" name="orderId" value="${order.orderId}">
					<input type="hidden" id="editQueryType" name="queryType" value="${queryType}">
					<div class="mb-3">
						<label for="editName" class="form-label">收件人姓名</label>
						<input type="text" class="form-control" id="editName" name="name" required>
					</div>
					<div class="mb-3">
						<label for="editTel" class="form-label">收件人電話</label>
						<input type="tel" class="form-control" id="editTel" name="tel" required>
					</div>
					<div class="mb-3">
						<label for="editAddress" class="form-label">收件人地址</label>
						<input type="text" class="form-control" id="editAddress" name="address" required>
					</div>
					<div class="mb-3">
						<label for="editOrderStatus" class="form-label">訂單狀態</label>
						<select class="form-select" id="editOrderStatus" name="orderStatus">
							<option value="1">訂單已成立</option>
							<option value="2">訂單處理中</option>
							<option value="3">訂單已出貨</option>
							<option value="4">訂單配送中</option>
							<option value="5">訂單已完成</option>
						</select>
					</div>
					<div class="text-end">
						<button type="submit" class="btn btn-primary">儲存</button>
						<button type="button" class="btn btn-secondary" onclick="hideEditForm()">取消</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<script>
	
        function showEditForm(orderId, shippingName, shippingTel, shippingAddress, orderStatus) {
            document.getElementById('editOrderId').value = orderId;
            document.getElementById('editShippingName').value = shippingName;
            document.getElementById('editShippingTel').value = shippingTel;
            document.getElementById('editShippingAddress').value = shippingAddress;
            document.getElementById('editOrderStatus').value = orderStatus;
            document.getElementById('editForm').classList.remove('d-none');
        }

        function hideEditForm() {
            document.getElementById('editForm').classList.add('d-none');
        }
        
        function confirmSave() {
    	    var orderId = document.getElementById('editOrderId').value;
    	    Swal.fire({
    	        title: "確認修改訂單編號為" + orderId + "的訂單嗎?",
    	        showDenyButton: true,
    	        confirmButtonText: "確認",
    	        denyButtonText: "取消"
    	    }).then((result) => {
    	        if (result.isConfirmed) {
    	            Swal.fire({
    	                icon: "success",
    	                title: "修改成功"
    	            }).then((result) => {
    	                if (result.isConfirmed) {
    	                    var formData = new FormData(document.getElementById('editOrderForm'));   	                    
    	                    fetch("updateOrder.controller", {
    	                        method: 'PUT',
    	                        body: formData
    	                    })
    	                    .then(response => response.text())
    	                    .then(result => {
    	                        console.log(result);
    	                        location.reload();
    	                    })
    	                    .catch(error => {
    	                        console.error('Error:', error);
    	                    });
    	                }
    	            });
    	        } else if (result.isDenied) {
    	            Swal.fire({
    	                icon: "error",
    	                title: "取消修改"
    	            }).then((result) => {
    	                hideEditForm();
    	            });
    	        }
    	    });
    	}
    	function confirmDelete(orderId, queryType) {
            Swal.fire({
                title: "確定要刪除嗎?",
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: "#3085d6",
                cancelButtonColor: "#d33",
                confirmButtonText: "確定",
                cancelButtonText: '取消'
            }).then((result) => {
            	if (result.isConfirmed) {
                    fetch("fakeDelete.controller?orderId=" + orderId + "&queryType=" + queryType, {
                        method: 'PUT'
                    })
                    .then(response => response.text())
                    .then(result => {
                        Swal.fire({
                            title: "刪除成功！",
                            text: "您已經刪除訂單編號為" + orderId + "的訂單",
                            icon: "success"
                        }).then((result) => {
                            if (result.isConfirmed) {
                           	 location.reload();
                            }
                        });
                    })
                    .catch(error => {
                        console.error('Error:', error);
                    });
               }
           });
       }
    </script>
	<%@ include file="../../FrontDeskFooter.jsp"%>
</body>
</html>
