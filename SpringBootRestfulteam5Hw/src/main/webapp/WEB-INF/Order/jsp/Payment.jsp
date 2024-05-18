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
                                            <td class="col-2">
                                                <img src="${item.good.goodImagePath}" class="card-img-top border" alt="${item.good.good.goodsName}" style="height: 150px; width: 162px; object-fit: cover;">
                                            </td>
                                            <td class="col-2">${item.good.good.goodsName}<br>
                                                規格:${item.good.goodSize}
                                            </td>
                                            <td class="col-2 itemPrice">$${item.price}</td>
                                            <td class="col-2">
                                                <input type="hidden" class="quantity" name="quantity" value="${item.quantity}">${item.quantity}</td>
                                            <td class="total-price col-2">$${item.quantity * item.price}</td>
                                        </tr>
                                    </tbody>
                                </table>
                                <div class="row">
                                    <div class="col border-end border-top">
                                        <div style="padding: 50px;" class="fs-6 ">
                                            備註 :
                                            <input type="text" placeholder="管理室代收/方便取貨時間" style="margin-left: 20px; width: 300px; opacity: 0.5;">
                                        </div>
                                    </div>
                                    <div class="col border-top">
                                        <div class="p-3 ">
                                            <div class=" d-flex justify-content-between align-items-center">
                                                <div>
                                                    <input type="hidden"  name="shippingMethod" value="1">
                                                    <p class="mb-0 shippingMethod">運送方式:超商物流</p>
                                                    <p class="mb-0 recipientNameParagraph">收件人:${member.name}</p>
                                                    <p class="mb-0 recipientAddressParagraph">地址:${member.address}</p>
                                                    <p class="mb-0 recipientPhoneParagraph">聯絡電話:${member.phone}</p>
                                                    <p class="mb-0 shippingFee">運費:60</p>
                                                    <input type="hidden" name="shippingFee" value="60">
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
                                    <P class="test">訂單金額(${item.quantity}件商品):$${item.quantity * item.price + shippingFee}</P>
                                </div>
                            </div>
                        </c:forEach>
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
                    <form id="recipientForm">
                        <button type="button"  class="btn btn-outline-secondary shippingMethodBtn" data-shipping-method="1">超商物流</button>
                        <button type="button"  class="btn btn-outline-secondary shippingMethodBtn" data-shipping-method="2">宅配到家</button>
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

            $("#recipientName").val(recipientName);
            $("#recipientAddress").val(recipientAddress);
            $("#recipientPhone").val(recipientPhone);
            if (shippingMethod === "1") {
                $("#convenienceStoreBtn").addClass("active");
                $("#homeDeliveryBtn").removeClass("active ");
                $("#shippingFee2").val("60");
            } else if (shippingMethod === "2") {
                $("#convenienceStoreBtn").removeClass("active");
                $("#homeDeliveryBtn").addClass("active");
                $("#shippingFee2").val("120");
            }
            formModal.data("parentDiv", parentDiv); // 保存父元素
            formModal.modal('show');
        });
        
        $(".shippingMethodBtn").click(function() {
            var method = $(this).data("shipping-method"); // 获取按钮所关联的运输方式
            $("#formModal").data("shippingMethod", method); // 将运输方式保存到模态框的 data 属性中
            selectShippingMethod(method); // 调用selectShippingMethod函数

        });
        $("#recipientForm").submit(function(event) {
            event.preventDefault();
            
            var updatedRecipientName = $("#recipientName").val();
            var updatedRecipientAddress = $("#recipientAddress").val();
            var updatedRecipientPhone = $("#recipientPhone").val();
            var shippingMethod = $("#formModal").data("shippingMethod"); // 从模态框的数据属性中获取运输方式
            var parentDiv = $("#formModal").data("parentDiv"); // 获取保存的父元素

            parentDiv.find(".recipientNameParagraph").text("收件人:" + updatedRecipientName);
            parentDiv.find(".recipientAddressParagraph").text("地址:" + updatedRecipientAddress);
            parentDiv.find(".recipientPhoneParagraph").text("聯絡電話:" + updatedRecipientPhone);
            parentDiv.find("input[name='shippingMethod']").val(shippingMethod);
            var newValue = parentDiv.find("input[name='shippingMethod']").val();
            console.log(newValue)
            console.log(shippingMethod)

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
        
        function totalPrice() {
            $(".total-price").each(function() {
                var container = $(this).closest("div"); // 获取包含当前 .total-price 元素的整个容器
                var itemPrice = parseFloat(container.find(".itemPrice").text().replace("$", ""));
                var itemQuantity = parseFloat(container.find(".quantity").val().trim());
                var shippingFee = parseFloat(container.find(".shippingFee").text().split(":")[1].trim());
                var totalPrice = itemPrice * itemQuantity + shippingFee;
                container.find(".test").text("訂單金額(" + itemQuantity + "件商品): $" + totalPrice);
            });
        }

        function selectShippingMethod(method) {
            var shippingMethod = method;
            var parentDiv = $("#formModal").data("parentDiv"); // 获取保存的父元素
            console.log(shippingMethod);
            parentDiv.find("input[name='shippingMethod']").val(shippingMethod);
        }
        $("#placeOrderButton").on('click', function(event) {
            event.preventDefault();
            let isValid = true;
            $("form").each(function() {
                if (!$(this).find("input[required], select[required]").val()) {
                    isValid = false;
                    return false;
                }
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
