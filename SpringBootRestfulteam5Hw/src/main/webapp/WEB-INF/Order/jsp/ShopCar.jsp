<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>購物車</title>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10/dist/sweetalert2.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">

</head>

<body>
	<%@ include file="Index.jsp"%>
	<div class="container">
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
							<a href="product.controller" class="btn btn-primary">前往購物</a>
						</div>
					</c:when>
					<c:otherwise>
						<table class="table table-bordered mt-3 text-center align-middle">
							<thead>
								<tr class="bg-primary text-light">
									<th class="col-2">商品名稱</th>
									<th class="col-2">價格</th>
									<th class="col-2">數量</th>
									<th class="col-2">總價</th>
									<th class="col-2">操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${carItems}" var="item">
									<tr>
										<td>${item.good.goodsName}</td>
										<td>${item.price}</td>
										<td class="quantity-adjust">
											<form id="updateForm_${item.carItemId}" action="updateQuantity.controller" method="post">
												<input type="hidden" name="_method" value="PUT">
												<input type="hidden" name="itemId" value="${item.carItemId}">
												<div class="input-group">
													<button type="button" class="btn btn-outline-secondary decrement" data-id="${item.carItemId}">-</button>
													<input type="number" id="quantity_${item.carItemId}" name="quantity" class="form-control input-sm" value="${item.quantity}" min="1" max="10">
													<button type="button" class="btn btn-outline-secondary increment" data-id="${item.carItemId}">+</button>
												</div>
											</form>
										</td>
										<td>${item.quantity * item.price}</td>
										<td>
											<button type="button" class="btn btn-danger delete" data-id="${item.carItemId}">删除</button>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<c:set var="totalPrice" value="0" />
						<c:forEach items="${carItems}" var="item">
							<c:set var="subtotal" value="${item.quantity * item.price}" />
							<c:set var="totalPrice" value="${totalPrice + subtotal}" />
						</c:forEach>
						<div class="cart-summary mt-3 text-center">
							<p>總共金額: $${totalPrice}</p>
							<a href="payment.controller" class="btn btn-primary">去買單</a>
						</div>
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
                        });

                        $('input[name="quantity"]').on('change', function () {
                            let itemId = $(this).attr('id').split('_')[1];
                            let quantity = $(this).val();
                            updateQuantity(itemId, quantity);
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
                                    console.log("DeleteCartItem response:", data);
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
                                    console.log("UpdateQuantity response:", data);
                                    let totalPriceElement = $('#totalPrice');
                                    let updatedPrice = data.updatedPrice;
                                    totalPriceElement.text('$' + updatedPrice);
                                    location.reload();
                                },
                                error: function (xhr, status, error) {
                                    console.error("UpdateQuantity error:", xhr.responseText);
                                }
                            });
                        }
                    });
                </script>
</body>

</html>