<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<title>買單</title>
<style>

</style>
</head>
<body>
<%@ include file="Index.jsp" %>
	<form id="orderForm" method="post" action="order.controller">
    <div class="container">
        <h3 class="text-center m-3">訂單商品</h3>
        <div class="border border-secondary p-3">
    <div class="table-responsive">
        <table class="table table-bordered text-center align-middle">
            <c:forEach items="${cartItems}" var="item">
                <input type="hidden" name="itemId" value="${item.carItemId}">
				<input type="hidden" name="productId" value="${item.good.good.goodsID}">
				<input type="hidden" name="sellerId" value="${item.good.good.goodsSellerID.sid}">
				<input type="hidden" name="originalPrices" value="${item.price}">
				<input type="hidden" name="totalPrices" value="${item.price * item.quantity + shippingFee}">
            <thead class="thead-dark">
                <tr>
                    <th>商品名稱</th>
                    <th>價格</th>
                    <th>数量</th>
                    <th>總價</th>
                    <th>收件人姓名</th>
                    <th>收件人地址</th>
                    <th>收件人電話</th>
                    <th>運送方式</th>
                    <th>運費</th>
                </tr>
            </thead>
            <tbody>
                
                    <tr>
                        <td>${item.good.good.goodsName}</td>
                        <td>${item.price}</td>
                        <td><input type="hidden" name="quantity" value="${item.quantity}">${item.quantity}</td>
                        <td class="total-price">${item.quantity * item.price}</td>
                        <td>
                            <input type="text" class="form-control" name="name" required>
                        </td>
                        <td>
                            <input type="text" class="form-control" name="address" required>
                        </td>
                        <td>
                            <input type="tel" class="form-control" name="tel" required>
                        </td>
                        <td>
                            <select class="form-control" name="shippingMethod" onchange="calculateShippingFee" required>
                                <option value="">請選擇</option>
                                <option value="1">超商物流</option>
                                <option value="2">宅配到家</option>
                            </select>
                        </td>
                        <td>
                            <input type="text" class="form-control" name="shippingFee" required readonly>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    <fieldset>
        <legend>支付信息</legend>
        <input type="hidden" name="memberId" value="${memberId}">
        <label for="totalPrice">金額:</label>
        <input type="text" class="form-control" id="totalPrice" name="totalPrice" required>
        <br>
        <label for="paymentMethod">支付方式:</label>
        <select class="form-control" id="paymentMethod" name="paymentMethod" required>
            <option value="">請選擇支付方式</option>
            <option value="1">信用卡</option>
            <option value="2">貨到付款</option>
        </select>
        <br>
        <label for="status">狀態:</label>
        <input type="text" class="form-control" id="status" name="status" value="未付款" required readonly>
        <input type="hidden" id="statusValue" name="statusValue" value="0">
        <br>
    </fieldset>
</div>
        <div class="text-center">
            <button type="submit" class="btn btn-primary m-3" id="placeOrderButton">下訂單</button>
        </div>
    </div>
</form>
	<form method="post" action="ecpayCheckout">
		<button type="submit">付款</button>
	</form>
	<script>
	function calculateShippingFee(selectElement) {
	    let itemRow = selectElement.closest('tr');
	    let shippingMethodSelect = itemRow.querySelector('select[name="shippingMethod"]');
	    let shippingFeeInput = itemRow.querySelector('input[name="shippingFee"]');
	    let shippingFees = { "1": 60, "2": 120 };
	    let selectedOption = shippingMethodSelect.value;
	    let shippingFee = shippingFees[selectedOption] || 0;
	    shippingFeeInput.value = shippingFee;
	    calculateTotalPrice();
	}

	function calculateTotalPrice() {
		let totalTotalPrice = 0;
		let totalShippingFee = 0;
	    document.querySelectorAll('tbody tr').forEach(function(row) {
	    	let totalPrice = parseFloat(row.querySelector('.total-price').textContent);
	    	let shippingFeeInput = row.querySelector('input[name="shippingFee"]');
	    	let shippingFee = parseFloat(shippingFeeInput.value) || 0;
	        totalTotalPrice += totalPrice;
	        totalShippingFee += shippingFee;
	    });
	    document.getElementById('totalPrice').value = totalTotalPrice + totalShippingFee;
	}

	document.addEventListener("DOMContentLoaded", function() {
	    calculateTotalPrice();
	});

	$(document).ready(function() {
	    $("select[name='shippingMethod']").on('change', function() {
	        calculateShippingFee(this);
	    });

	    $("#placeOrderButton").on('click', function(event) {
	        event.preventDefault();
	        let isValid = $("form").toArray().every(function(form) {
	            return $(form).find("input[required], select[required]").toArray().every(function(input) {
	                return !!$(input).val();
	            });
	        });
	        if (!isValid) {
	            Swal.fire({
	                icon: 'error',
	                title: '請填寫所有必填欄位',
	                text: '請確保所有欄位都已填寫。',
	            });
	            return;
	        }
	        Swal.fire({
	            title: "確定要下訂單？",
	            icon: "warning",
	            showCancelButton: true,
	            confirmButtonColor: "#3085d6",
	            cancelButtonColor: "#d33",
	            confirmButtonText: "確定",
	            cancelButtonText: '取消'
	        }).then((result) => {
	            if (result.isConfirmed) {
	                Swal.fire("新增訂單成功", "", "success").then(() => {
	                    $("#orderForm").submit();
	                });
	            }
	        });
	    });
	});
</script>

</body>
</html>
