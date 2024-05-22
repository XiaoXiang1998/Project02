
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="b"%>
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
	<%@ include file="../../FrontDeskNav.jsp"%>
	<form id="orderForm" method="post" action="order.controller">
		<input type="hidden" name="itemId" value=-1>
		<div class="container ">
			<div class="row justify-content-center mt-5">
				<div class="col-md-10">
					<h3 class="text-center mb-3">商品結帳</h3>
					<div class="table border fs-5">
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
							<input type="hidden" name="productId" value="${formatID}">
							<input type="hidden" name="sellerId" value="${sellerId}">
							<input type="hidden" name="originalPrices" value="${price}">

							<div>
								<table class="table text-center align-middle ">
									<tbody class="">
										<tr>
											<td class="col-2">
												<img src="${imagePath}" class="card-img-top border" alt="${goodsName}" style="height: 150px; width: 162px; object-fit: cover;">
											</td>
											<td class="col-2">${goodsName}<br>
												規格:${goodSize}
											</td>
											<td class="col-2 itemPrice">$${price}</td>
											<td class="col-2">
												<input type="hidden" class="quantity" name="quantity" value="${quantity}">${quantity}</td>
											<td class="total-price col-2">$${quantity * price}</td>
										</tr>
									</tbody>
								</table>
								<div class="row ">
									<div class="col ">
										<div style="padding: 50px;" class="fs-6 ">
											備註 :
											<input type="text" placeholder="管理室代收/方便取貨時間" style="margin-left: 20px; width: 300px; opacity: 0.5;">
										</div>
									</div>
									<div class="col ">
										<div class="p-3 ">
											<div class=" d-flex justify-content-between align-items-center">
												<div>
													<input type="hidden" name="shippingMethod" value="1">
													<p class="mb-0 shippingMethod">運送方式:超商物流</p>
													<p class="mb-0 recipientNameParagraph">收件人:${member.name}</p>
													<p class="mb-0 recipientAddressParagraph">地址:${member.address}</p>
													<p class="mb-0 recipientPhoneParagraph">聯絡電話:${member.phone}</p>
													<p class="mb-0 shippingFee">運費:60</p>
													<input type="hidden" name="name" value="${member.name}">
													<input type="hidden" name="address" value="${member.address}">
													<input type="hidden" name="tel" value="${member.phone}">
													<input type="hidden" name="shippingFee" value="60">
													<input type="hidden" class="totalPrices" name="totalPrices" value="${price * quantity + shippingFee}">
												</div>
												<button type="button" class="btn btn-link p-0 openFormBtn" style="text-decoration: none; color: #007bff;" aria-label="Close">
													<i class="fa-solid fa-gear"></i>
													變更
												</button>
											</div>
										</div>
									</div>
								</div>
								<div class="text-end border-top border-bottom" style="padding-right: 10px; padding-top: 16px">
									<P class="test">訂單金額(${quantity}件商品):$${quantity * price + shippingFee}</P>

								</div>
							</div>
						<fieldset>
							<input type="hidden" name="memberId" value="${memberId}">
							<div class="form-group row  mt-2" style="padding-left: 20px">
								<label for="paymentMethod" class="col-2 col-form-label" style="margin-top: 5px; margin-left: 10px">付款方式</label>
								<div class="col-md-7">
									<button type="button" class="btn btn-secondary payBtn" data-pay-method="1" style="margin-right: 20px">信用卡</button>
									<button type="button" class="btn btn-outline-secondary payBtn" data-pay-method="2">貨到付款</button>
									<input type="hidden" id="paymentMethod" name="paymentMethod" value="1">
								</div>
							</div>
							<div class="form-group row  mt-3">
								<input type="hidden" id="totalPrice1" name="totalPrice1" value="100">
								<input type="hidden" id="totalPrice2" name="totalPrice2" value="100">
								<input type="hidden" id="totalPrice" name="totalPrice" value="100">
								<div class="d-flex justify-content-star align-items-center mb-2">
									<p class="mb-0" style="margin-left: 80%">商品總金額</p>
									<span class="1" style="margin-left: 35px"></span>
								</div>
								<div class="d-flex justify-content-star align-items-center mb-2">
									<p class="mb-0" style="margin-left: 80%">運費總金額</p>
									<span class="2" style="margin-left: 35px"></span>
								</div>
								<div class="d-flex justify-content-star align-items-center mb-2">
									<p class="mb-0" style="margin-left: 80%">總付款金額</p>
									<span class="3" style="margin-left: 35px"></span>
								</div>
								<input type="hidden" id="statusValue" name="statusValue" value="1">
								<div class="text-end" style="padding-right: 50px">
									<button type="submit" class="btn btn-primary m-3 " id="placeOrderButton">下訂單</button>
								</div>
							</div>
						</fieldset>
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
					<form id="recipientForm">
						<button type="button" class="btn btn-outline-secondary shippingMethodBtn mb-3 me-3" data-shipping-method="1">超商物流</button>
						<button type="button" class="btn btn-outline-secondary shippingMethodBtn mb-3" data-shipping-method="2">宅配到家</button>
						<div class="mb-3">
							<label for="recipientName" class="form-label">收件人</label>
							<input type="text" class="form-control" id="recipientName" placeholder="請輸入收件人姓名" value="">
						</div>
						<div class="mb-3">
							<label for="recipientAddress" class="form-label">地址</label>
							<input type="text" class="form-control" id="recipientAddress" placeholder="請輸入收件人地址" value="">
						</div>
						<div class="mb-3">
							<label for="recipientPhone" class="form-label">聯絡電話</label>
							<input type="text" class="form-control" id="recipientPhone" placeholder="請輸入收件人聯絡電話" value="">
						</div>
						<div class="mb-3">
							<label for="shippingFee2" class="form-label">運費</label>
							<input type="text" class="form-control" name="shippingFee2" id="shippingFee2" value="60" readonly>
						</div>
						<button type="submit" class="btn btn-primary recipientFormBtn">提交</button>
					</form>
				</div>
			</div>
		</div>
	</div>
	<script>
	    $(document).ready(function() {
			
	    	totalPrice();
	    	
	    	$(".openFormBtn").click(function(event) {
	            event.preventDefault();
	            var formModal = $("#formModal");
	            var parentDiv = $(this).closest(".col");
				
	            var recipientName = parentDiv.find(".recipientNameParagraph").text().split(":")[1].trim();
	            var recipientAddress = parentDiv.find(".recipientAddressParagraph").text().split(":")[1].trim();
	            var recipientPhone = parentDiv.find(".recipientPhoneParagraph").text().split(":")[1].trim();
	            var shippingMethod = parentDiv.find("input[name='shippingMethod']").val();
	            var shippingFee = parentDiv.find("input[name='shippingFee']").val();
	            console.log(shippingFee)
	            var shippingFee2 = $("#shippingFee2");
	            $("#recipientName").val(recipientName);
	            $("#recipientAddress").val(recipientAddress);
	            $("#recipientPhone").val(recipientPhone);
	            if (shippingMethod == 1) {
	                $("#shippingFee2").val(60)
	            } else if (shippingMethod == 2) {
	                $("#shippingFee2").val(120)
	            }
	            console.log("shippingFee2:" + shippingFee2.val())
			    if (shippingFee2.val() == 60) {
				    $(".shippingMethodBtn[data-shipping-method='1']").removeClass("btn-outline-secondary").addClass("btn-secondary");
				    $(".shippingMethodBtn[data-shipping-method='2']").removeClass("btn-secondary").addClass("btn-outline-secondary");
				} else if (shippingFee2.val() == 120) {
				    $(".shippingMethodBtn[data-shipping-method='1']").removeClass("btn-secondary").addClass("btn-outline-secondary");
				    $(".shippingMethodBtn[data-shipping-method='2']").removeClass("btn-outline-secondary").addClass("btn-secondary");
				}
			
	            formModal.data("parentDiv", parentDiv); 
	            formModal.modal('show');
	        });
	        
	        $(".shippingMethodBtn").click(function() {
	            var method = $(this).data("shipping-method"); 
	            $("#formModal").data("shippingMethod", method); 
	            selectShippingMethod(method); 
	
	        });
	        $("#recipientForm").submit(function(event) {
	            event.preventDefault();
	            
	            var updatedRecipientName = $("#recipientName").val();
	            var updatedRecipientAddress = $("#recipientAddress").val();
	            var updatedRecipientPhone = $("#recipientPhone").val();
	            var shippingMethod = $("#formModal").data("shippingMethod"); 
	            var parentDiv = $("#formModal").data("parentDiv"); 
	
	            parentDiv.find(".recipientNameParagraph").text("收件人:" + updatedRecipientName);
	            parentDiv.find(".recipientAddressParagraph").text("地址:" + updatedRecipientAddress);
	            parentDiv.find(".recipientPhoneParagraph").text("聯絡電話:" + updatedRecipientPhone);
	            parentDiv.find("input[name='shippingMethod']").val(shippingMethod);
	            parentDiv.find("input[name='name']").val(updatedRecipientName);
	            parentDiv.find("input[name='address']").val(updatedRecipientAddress);
	            parentDiv.find("input[name='tel']").val(updatedRecipientPhone);
	            var newValue = parentDiv.find("input[name='shippingMethod']").val();
	            console.log(newValue)
	            console.log(typeof shippingMethod)
	
	            if (shippingMethod == 1) {
	                parentDiv.find(".shippingMethod").text("運送方式:超商物流");
	                parentDiv.find(".shippingFee").text("運費:60");
	                parentDiv.find("input[name='shippingFee']").val(60);
	            } else if (shippingMethod == 2) {
	                parentDiv.find(".shippingMethod").text("運送方式:宅配到家");
	                parentDiv.find(".shippingFee").text("運費: 120");
	                parentDiv.find("input[name='shippingFee']").val(120);
	            }
	            
				totalPrice();
	            $("#formModal").modal('hide');
	        });
	        
	        var totalItemPrice = 0;
	        var totalShippingFee = 0;
	        function totalPrice() {
	        	totalItemPrice = 0; 
	            totalShippingFee = 0;
	            $(".total-price").each(function() {
	                var container = $(this).closest("div"); 
	                var itemPrice = parseFloat(container.find(".itemPrice").text().replace("$", ""));
	                var itemQuantity = parseFloat(container.find(".quantity").val().trim());
	                var shippingFee = parseFloat(container.find(".shippingFee").text().split(":")[1].trim());
	                var totalPrice = itemPrice * itemQuantity + shippingFee;
	                
	                totalItemPrice += itemPrice * itemQuantity;
	                totalShippingFee += shippingFee;
	                
	                container.find(".test").text("訂單金額(" + itemQuantity + "件商品): $" + totalPrice);
	                container.find(".totalPrices").val(totalPrice)
	            });

	                var finallyTotal = totalItemPrice + totalShippingFee;
	                $("#totalPrice1").val(totalItemPrice);
	                $("#totalPrice2").val(totalShippingFee);
	                $("#totalPrice").val(finallyTotal);
	                $(".1").text("$" + totalItemPrice);
	                $(".2").text("$" + totalShippingFee);
	                $(".3").text("$" + finallyTotal);
	        }
	
	        function selectShippingMethod(method) {
	            var shippingMethod = parseInt(method); 
	            var parentDiv = $("#formModal").data("parentDiv"); 
	            console.log(typeof shippingMethod)
	            if (shippingMethod === 1) { 
	                $("#shippingFee2").val(60);
	                $(".shippingMethodBtn[data-shipping-method='1']").removeClass("btn-outline-secondary").addClass("btn-secondary");
	                $(".shippingMethodBtn[data-shipping-method='2']").removeClass("btn-secondary").addClass("btn-outline-secondary");
	            } else if (shippingMethod === 2) { 
	                $("#shippingFee2").val(120);
	                $(".shippingMethodBtn[data-shipping-method='1']").removeClass("btn-secondary").addClass("btn-outline-secondary");
				    $(".shippingMethodBtn[data-shipping-method='2']").removeClass("btn-outline-secondary").addClass("btn-secondary");
	            }
	            console.log(parentDiv)
	            var shippingFee = $("#shippingFee2").val();
	            console.log(shippingFee);
	        }
	        
	        $(".payBtn").click(function() {
	            var method = $(this).data("pay-method"); 
				$("#paymentMethod").val(method);
				if (method == 1) {
				    $(".payBtn[data-pay-method='1']").removeClass("btn-outline-secondary").addClass("btn-secondary");
				    $(".payBtn[data-pay-method='2']").removeClass("btn-secondary").addClass("btn-outline-secondary");
				} else if (method == 2) {
				    $(".payBtn[data-pay-method='1']").removeClass("btn-secondary").addClass("btn-outline-secondary");
				    $(".payBtn[data-pay-method='2']").removeClass("btn-outline-secondary").addClass("btn-secondary");
				}
	        });
	        
	        
	        $("#placeOrderButton").on('click', function(event) {
	            event.preventDefault();
	            let isValid = $("#orderForm").toArray().every(function(form) {
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
	    <%@ include file="../../FrontDeskFooter.jsp" %>
</body>
</html>
