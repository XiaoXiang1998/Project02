<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<%@ taglib uri="jakarta.tags.core" prefix="b"%>
<!DOCTYPE html>
<html>

<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>購物車</title>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10/dist/sweetalert2.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
<style>
input[type=number]::-webkit-inner-spin-button, input[type=number]::-webkit-outer-spin-button
	{
	-webkit-appearance: none;
	margin: 0;
}
</style>
</head>

<body>
	<%@ include file="../../FrontDeskNav.jsp"%>
	<div class="container" style="margin-top: 100px">
		<div class="row justify-content-center mt-5">
			<div class="col-md-10">
				<h3>購物車</h3>
				<c:choose>
					<c:when test="${empty carItems}">
						<div class="empty-cart mt-3 text-center p-5 d-flex flex-column align-items-center">
							<div class="rounded-circle overflow-hidden align-self-center ratio ratio-1x1" style="width: 120px">
								<img src="https://thumb.silhouette-ac.com/t/88/88011730a0e354a38deb024285583920_t.jpeg" alt="" class="object-fit-cover w-100 h-100" />
							</div>
							<p class="text-muted pt-2">你的購物車是空的。</p>
							<a href="EZBuyIndexWithoutLogin" class="btn btn-primary">前往購物</a>
						</div>
					</c:when>
					<c:otherwise>
						<table class="table border mt-3 text-center align-middle">
							<thead>
								<tr class="bg-primary text-light">
									<th class="col-1">
										<input type="checkbox" id="selectAllCheckbox">
										全選
									</th>
									<th class="col-2">商品</th>
									<th class="col-2"></th>
									<th class="col-2">價格</th>
									<th class="col-2">數量</th>
									<th class="col-2">總價</th>
									<th class="col-2">操作</th>
								</tr>
							</thead>
							<tbody>
								<b:forEach items="${carItems}" var="item">
									<tr>
										<td class="border">
											<input type="checkbox" name="selectedItems" class="form-check-input">
										</td>
										<td>
											<img src="${item.good.goodImagePath}" class="card-img-top" alt="${item.good.good.goodsName}" style="height: 150px; object-fit: cover;">
										</td>
										<td>${item.good.good.goodsName}</td>
										<td>${item.good.goodPrice}</td>
										<td class="quantity-adjust">
											<form id="updateForm_${item.carItemId}" action="updateQuantity.controller" method="post">
												<input type="hidden" name="_method" value="PUT">
												<input type="hidden" name="itemId" value="${item.carItemId}">
												<div class="input-group input-group-sm" style="width: 114px; height: 32px;">
													<button type="button" class="btn btn-outline-secondary border border-gray decrement" style="width: 32px; height: 32px;" data-id="${item.carItemId}">-</button>
													<input type="number" id="quantity_${item.carItemId}" name="quantity" class="form-control text-center border border-gray" style="width: 50px; height: 32px;" value="${item.quantity}" min="1" max="10">
													<button type="button" class="btn btn-outline-secondary border border-gray increment" style="width: 32px; height: 32px;" data-id="${item.carItemId}">+</button>
												</div>
											</form>
										</td>
										<td>${item.quantity * item.good.goodPrice}</td>
										<td>
											<button type="button" class="btn btn-danger delete" data-id="${item.carItemId}">删除</button>
										</td>
									</tr>
								</b:forEach>
								<tr class="cart-summary ">
									<td colspan="7" class="text-end">
										<span id="totalPrice" class="m-3">總共金額:$ 0</span>
										<a href="payment.controller" class="btn btn-primary">去買單</a>
									</td>
								</tr>
							</tbody>
						</table>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
	<script>
                    $(document).ready(function () {
                        $(document).on('click', '.increment, .decrement', function () {
                            let itemId = $(this).data('id');
                            let input = $('#quantity_' + itemId);
                            let newValue = parseInt(input.val()) + ($(this).hasClass('increment') ? 1 : -1);
                            if (newValue >= 1 && newValue <= 10) {
                                input.val(newValue);
                                updateQuantity(itemId, newValue);
                            }
                                calculateTotalPrice();
                        });
                        
						
                        $('input[name="quantity"]').on('change', function () {
                            let itemId = $(this).attr('id').split('_')[1];
                            let quantity = $(this).val();
                            updateQuantity(itemId, quantity);
                            calculateTotalPrice();
                        });
                        
                        
                        $('#selectAllCheckbox').on('change', function () {
                            let isChecked = $(this).prop('checked');
                            $('input[name="selectedItems"]').prop('checked', isChecked);
                            calculateTotalPrice();
                        });

                        $('input[name="selectedItems"]').on('change', function () {
                            let allChecked = $('input[name="selectedItems"]').length === $('input[name="selectedItems"]:checked').length;
                            $('#selectAllCheckbox').prop('checked', allChecked);
                            calculateTotalPrice();
                        });

                        $('.delete').on('click', function () {
                            let itemId = $(this).data('id');
                            let productName = $(this).closest('tr').find('td:first').text();

                            Swal.fire({
                                title: '確定要刪除 ' + productName + ' 嗎？',
                                icon: 'question',
                                showCancelButton: true,
                                confirmButtonColor: '#3085d6',
                                cancelButtonColor: '#d33',
                                confirmButtonText: '確定',
                                cancelButtonText: '取消'
                            }).then((result) => {
                                if (result.isConfirmed) {
                                    deleteCartItem(itemId);
                                }
                            });
                        });

                        function deleteCartItem(itemId) {
                            $.ajax({
                                type: "DELETE",
                                url: "deleteCartItem.controller?itemId=" + itemId,
                                data: { itemId: itemId },
                                success: function (data) {
                                    Swal.fire({
                                        title: '刪除成功!',
                                        icon: 'success',
                                        showConfirmButton: true,
                                    }).then((result) => {
                                        if (result.isConfirmed) {
                                        	location.reload();
                                        }
                                    });
                                },
                                error: function (xhr, status, error) {
                                    console.error("DeleteCartItem error:", xhr.responseText);
                                }
                            });
                        }

                        function updateQuantity(itemId, quantity) {
                            $.ajax({
                                type: "PUT",
                                url: "updateQuantity.controller?itemId=" + itemId + "&quantity=" + quantity,
                                data: { itemId: itemId, quantity: quantity },
                                success: function (data) {
                                    let totalPriceElement = $('#totalPrice');
                                    let updatedPrice = data.updatedPrice;
                                    totalPriceElement.text('$' + updatedPrice);
                                    totalPriceElement.text('總共金額: $' + updatedPrice);
                                    calculateTotalPrice();
                                },
                                error: function (xhr, status, error) {
                                    console.error("UpdateQuantity error:", xhr.responseText);
                                }
                            });
                        }
                        
                        function calculateTotalPrice() {
                            let totalPrice = 0;
                            
                            $('input[name="selectedItems"]:checked').each(function () {
                                let row = $(this).closest('tr');
                                let price = parseFloat(row.find('td:eq(3)').text());
                                let quantity = parseInt(row.find('input[name="quantity"]').val());
                                let itemTotalPrice = price * quantity;
                                totalPrice += itemTotalPrice;
                                row.find('td:eq(5)').text(itemTotalPrice);
 
                            });
                           $('#totalPrice').text('總共金額: $' + totalPrice);
                           let allChecked = $('input[name="selectedItems"]').length === $('input[name="selectedItems"]:checked').length;
                           $('#selectAllCheckbox').prop('checked', allChecked);
                           
                        }
                        $('a[href="payment.controller"]').on('click', function (e) {
                            e.preventDefault(); 

                            let checkedItemIds = [];
                            $('input[name="selectedItems"]:checked').each(function () {
                                checkedItemIds.push($(this).closest('tr').find('.delete').data('id'));
                            });

                            if (checkedItemIds.length === 0) {
                                alert('請至少選一個商品');
                                return;
                            }

                            console.log(checkedItemIds)
                            $.ajax({
                                type: "GET",
                                url: "payment.controller",
                                data: { checkedItemIds: checkedItemIds },
                                success: function (data) {
                                	window.location.href = "payment.controller?checkedItemIds="+checkedItemIds;
                                },
                                error: function (xhr, status, error) {
                                    console.error("錯誤:", error);
                                }
                            });
                        });
                        
                    });
		</script>
		<%@ include file="../../FrontDeskFooter.jsp" %>
</body>

</html>