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
	<%@ include file="Index.jsp"%>
	<form id="orderForm" method="post" action="order.controller">
		<div class="container ">
			<div class="row justify-content-center mt-5">
				<div class="col-md-10">
					<h3 class="text-center m-3">商品結帳</h3>
					<div class="table-responsive border fs-5">
						<table class="table text-center align-middle">
							<thead class="thead-dark">
								<tr>
									<th class="col-2">商品</th>
									<th class="col-2"></th>
									<th class="col-2">單價</th>
									<th class="col-2">数量</th>
									<th class="col-2">總價</th>
								</tr>
							</thead>
						</table>
						<c:forEach items="${cartItems}" var="item">
							<input type="hidden" name="itemId" value="${item.carItemId}">
							<input type="hidden" name="productId" value="${item.good.formatID}">
							<input type="hidden" name="sellerId" value="${item.good.good.goodsSellerID.sid}">
							<input type="hidden" name="originalPrices" value="${item.price}">
							<input type="hidden" name="totalPrices" value="${item.price * item.quantity + shippingFee}">
							<div>
								<table class="table text-center align-middle ">
									<tbody class="">
										<tr>
											<td class="col-2"><img src="${item.good.goodImagePath}" class="card-img-top" alt="${item.good.good.goodsName}" style="height: 150px; width: 162px; object-fit: cover;"></td>
											<td class="col-2">${item.good.good.goodsName}<br>規格:${item.good.goodSize}
											</td>
											<td class="col-2">$${item.price}</td>
											<td class="col-2"><input type="hidden" name="quantity" value="${item.quantity}">${item.quantity}</td>
											<td class="total-price col-2">$${item.quantity * item.price}</td>
										</tr>
									</tbody>
								</table>
								<!-- 							<div class="input-group mb-3"> -->
								<!-- 								<button type="button" class="btn btn-outline-secondary" onclick="selectShippingMethod(1)">超商物流</button> -->
								<!-- 								<button type="button" class="btn btn-outline-secondary" onclick="selectShippingMethod(2)">宅配到家</button> -->
								<!-- 								<input type="text" class="form-control" name="shippingFee" id="shippingFee" required readonly> -->
								<!-- 							</div> -->
								<div class="row">
									<div class="col border-end border-top">
										<div style="padding: 50px;" class="fs-6 ">
											備註 : <input type="text" placeholder="管理室代收/方便取貨時間" style="margin-left: 20px; width: 300px; opacity: 0.5;">
										</div>
									</div>
									<div class="col border-top">
										<div class="p-3 ">
											<div class=" d-flex justify-content-between align-items-center">
												<div>
													<p class="mb-0">收件人 : ${member.name}</p>
													<p class="mb-0">地址 : ${member.address}</p>
													<p>聯絡電話 : ${member.phone}</p>
												</div>
												<button type="button" class="btn btn-link p-0 openFormBtn" style="text-decoration: none; color: #007bff;" aria-label="Close">
													<i class="fa-solid fa-gear"></i>變更
												</button>
											</div>
										</div>
									</div>
								</div>
								<div class="text-end border-top border-bottom" style="padding-right: 10px; padding-top: 16px">
									<P>訂單金額(${item.quantity}件商品):$${item.quantity * item.price}
								</div>
							</div>
						</c:forEach>
						<fieldset>
							<legend>支付信息</legend>
							<input type="hidden" name="memberId" value="${memberId}"> <label for="totalPrice">金額:</label> <input type="text" class="form-control" id="totalPrice" name="totalPrice" required> <br> <label for="paymentMethod">支付方式:</label> <select class="form-control" id="paymentMethod" name="paymentMethod" required>
								<option value="">請選擇支付方式</option>
								<option value="1">信用卡</option>
								<option value="2">貨到付款</option>
							</select> <br> <label for="status">狀態:</label> <input type="text" class="form-control" id="status" name="status" value="未付款" required readonly> <input type="hidden" id="statusValue" name="statusValue" value="0"> <br>
						</fieldset>
					</div>
					<div class="text-center">
						<button type="submit" class="btn btn-primary m-3 " id="placeOrderButton">下訂單</button>
					</div>
				</div>
			</div>
		</div>
	</form>
<div class="modal fade" id="formModal" tabindex="-1" aria-labelledby="formModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="formModalLabel">修改收件人資訊</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- 表單內容 -->
                <form id="recipientForm">
                    <div class="mb-3">
                        <label for="recipientName" class="form-label">收件人</label>
                        <input type="text" class="form-control" id="recipientName" placeholder="請輸入收件人姓名" value="${member.name}">
                    </div>
                    <div class="mb-3">
                        <label for="recipientAddress" class="form-label">地址</label>
                        <input type="text" class="form-control" id="recipientAddress" placeholder="請輸入收件人地址" value="${member.address}">
                    </div>
                    <div class="mb-3">
                        <label for="recipientPhone" class="form-label">聯絡電話</label>
                        <input type="text" class="form-control" id="recipientPhone" placeholder="請輸入收件人聯絡電話" value="${member.phone}">
                    </div>
                    <button type="submit" class="btn btn-primary">提交</button>
                </form>
            </div>
        </div>
    </div>
</div>
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
	 
	 $(".openFormBtn").on('click', function() {
	        // 找到與按鈕相同父級的<p>元素
	        var recipientNameParagraph = $(this).closest(".row").find(".recipientNameParagraph");
	        var recipientAddressParagraph = $(this).closest(".row").find(".recipientAddressParagraph");
	        var recipientPhoneParagraph = $(this).closest(".row").find(".recipientPhoneParagraph");

	        // 獲取原始的收件人姓名、地址和聯絡電話
	        var originalRecipientName = recipientNameParagraph.text();
	        var originalRecipientAddress = recipientAddressParagraph.text();
	        var originalRecipientPhone = recipientPhoneParagraph.text();

	        // 在模態對話框中填充原始值
	        $("#recipientName").val(originalRecipientName);
	        $("#recipientAddress").val(originalRecipientAddress);
	        $("#recipientPhone").val(originalRecipientPhone);

	        // 打開模態對話框
	        $("#formModal").modal("show");
	    });

	    $("#recipientForm").on('submit', function(event) {
	        event.preventDefault(); // 阻止表單提交的預設行為

	        // 獲取新的收件人姓名、地址和聯絡電話
	        var newRecipientName = $("#recipientName").val();
	        var newRecipientAddress = $("#recipientAddress").val();
	        var newRecipientPhone = $("#recipientPhone").val();

	        // 找到與表單相同父級的<p>元素並更新值
	        $(this).closest(".row").find(".recipientNameParagraph").text("收件人：" + newRecipientName);
	        $(this).closest(".row").find(".recipientAddressParagraph").text("地址：" + newRecipientAddress);
	        $(this).closest(".row").find(".recipientPhoneParagraph").text("聯絡電話：" + newRecipientPhone);

	        // 關閉模態對話框
	        $("#formModal").modal("hide");
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