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
</head>
<body>
	<%@ include file="../../FrontDeskNav.jsp"%>
	<div class="container" style="white-space: nowrap">
		<h3 class="text-center mt-3">訂單詳情</h3>
		<div class="table-responsive mt-3">
		<table class="table table-bordered">
			<thead class="thead-dark text-center align-middle" style="height: 50px">
				<tr>
					<th>訂單ID</th>
					<th>買家</th>
					<th>賣家</th>
					<th>運送方式</th>
					<th>收件人姓名</th>
					<th>收件人地址</th>
					<th>收件人電話</th>
					<th>商品名稱</th>
					<th>商品單價</th>
					<th>數量</th>
					<th>運費</th>
					<th>支付金額</th>
					<th>訂單狀態</th>
					<th>付款狀態</th>
					<th>創建時間</th>
					<th>操作</th>
					<th>操作</th>
				</tr>
			</thead>
			<tr class="${empty order.orderId ? 'd-none' : ''} text-center align-middle" style="height: 80px">
				<td>${order.orderId}</td>
				<td>${order.buyerId.name}</td>
				<td>${order.sellerId.name}</td>
				<td>${order.shippingMethod == 1 ? '宅配到家' : order.shippingMethod == 2 ? '超商物流' : ''}</td>
				<td>${order.name}</td>
				<td>${order.address}</td>
				<td>${order.tel}</td>
				<td>${order.formatgoodId.good.goodsName}</td>
				<td>${order.originalPrice}</td>
				<td>${order.quantity}</td>
				<td>${order.shippingFee}</td>
				<td>${order.totalPrice}</td>
				<td>${order.orderStatus == 0 ? '已成立' : order.orderStatus == 1 ? '已出貨' : order.orderStatus == 2 ? '已完成' : ''}</td>
				<td>${order.payStatus == 0 ? '未付款' : '已付款'}</td>
				<td>
					<fmt:formatDate value="${order.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" />
				<td>
					<a href="#" onclick="showEditForm('${order.orderId}','${order.name}','${order.tel}','${order.address}',${order.orderStatus})" class="btn btn-primary btn-sm">修改</a>
				</td>
				<td>
					<a href="#" onclick="confirmDelete(${order.orderId}, '${queryType}')" class="btn btn-danger btn-sm">刪除</a>
				</td>
			</tr>
		</table>
	</div>
	</div>
	<div class="footer mt-3 text-center">
		<b:choose>
			<b:when test="${empty order.orderId}">
				<p class="fs-5 fw-bold">沒有訂單</p>
			</b:when>
			<b:otherwise>
			</b:otherwise>
		</b:choose>
	</div>

	<div id="editForm" class="d-none" style="position: fixed; top: 0; left: 0; right: 0; bottom: 0; background-color: rgba(255, 255, 255, 0.9); z-index: 1000;">
    <div class="row justify-content-center align-items-center h-100">
        <div class="col-md-6 border p-4">
            <h2 class="mt-5">修改訂單</h2>
            <form id="editOrderForm" action="updateOrder.controller" method="post">
                <input type="hidden" name="_method" value="PUT" />
                <input type="hidden" id="editOrderId" name="orderId" value="${order.orderId}">
                <input type="hidden" id="editQueryType" name="queryType" value="${queryType}">
                <div class="mb-3">
                    <label for="editShippingName" class="form-label">收件人姓名:</label>
                    <input type="text" id="editShippingName" name="name" class="form-control">
                </div>
                <div class="mb-3">
                    <label for="editShippingTel" class="form-label">收件人電話:</label>
                    <input type="text" id="editShippingTel" name="tel" class="form-control">
                </div>
                <div class="mb-3">
                    <label for="editShippingAddress" class="form-label">收件人地址:</label>
                    <input type="text" id="editShippingAddress" name="address" class="form-control">
                </div>
                <div class="mb-3">
                    <label for="editOrderStatus" class="form-label">訂單狀態:</label>
                    <select id="editOrderStatus" name="orderstatus" class="form-select">
                        <option value="0">已成立</option>
                        <option value="1">已出貨</option>
                        <option value="2">已完成</option>
                    </select>
                </div>
                <button type="button" class="btn btn-primary" onclick="confirmSave()">保存</button>
                <button type="button" class="btn btn-secondary" onclick="hideEditForm()">取消</button>
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
    <%@ include file="../../FrontDeskFooter.jsp" %>
</body>
</html>