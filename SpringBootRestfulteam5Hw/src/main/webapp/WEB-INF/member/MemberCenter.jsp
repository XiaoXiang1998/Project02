<%@page import="com.member.model.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>會員中心</title>
<script src="https://kit.fontawesome.com/92a295a0cf.js"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
	rel="stylesheet">
<!-- Libraries Stylesheet -->
<link href="/frontlib/lightbox/css/lightbox.min.css" rel="stylesheet">
<link href="/frontlib/owlcarousel/assets/owl.carousel.min.css"
	rel="stylesheet">
<link href="/frontcss/bootstrap.min.css" rel="stylesheet">
<link href="frontcss/style.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
<style>
.list-group {
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1), 0 6px 20px rgba(0, 0, 0, 0.1);
	/* 陰影效果 */
	background-color: #fff;
	/* 背景顏色 */
}

.bordered-pane {
	border: 1px solid #ccc;
	/* 邊框樣式 */
	padding: 15px;
	/* 內部間隔 */
	overflow-y: auto;
	/* 若內容超過高度，自動顯示滾動條 */
	max-height: 850px;
	/* 最大高度，避免整體內容過高 */
	border-radius: 10px;
	/* 邊框圓角 */
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1), 0 6px 20px rgba(0, 0, 0, 0.1);
	/* 陰影效果 */
	background-color: #fff;
	/* 背景顏色 */
}

.error-message {
	color: red;
	margin-top: 10px;
}
</style>
</head>

<body>
	<%@ include file="../FrontDeskNav.jsp"%>
	<%
	HttpSession MemberSession = request.getSession();
	MemberBean member = (MemberBean) MemberSession.getAttribute("member");
	boolean isSeller = member.isSeller();
	%>
	<div class="container mt-5">
		<div class="row">
			<div class="col-md-3">
				<div class="list-group" id="list-tab" role="tablist">
					<a class="list-group-item list-group-item-action active"
						id="list-info-list" data-bs-toggle="list" href="#list-info"
						role="tab" aria-controls="info">個人資訊</a> <a
						class="list-group-item list-group-item-action"
						id="list-account-list" data-bs-toggle="list" href="#list-account"
						role="tab" aria-controls="account">帳號詳情</a> <a
						class="list-group-item list-group-item-action"
						id="list-password-list" data-bs-toggle="list"
						href="#list-password" role="tab" aria-controls="password">修改密碼</a>
					<a class="list-group-item list-group-item-action"
						id="Buy-list-orders-list" data-bs-toggle="list"
						href="#Buy-list-orders" role="tab" aria-controls="orders">買家訂單</a>
					<a class="list-group-item list-group-item-action"
						id="Sell-list-orders-list" data-bs-toggle="list"
						href="#Sell-list-orders" role="tab" aria-controls="orders">賣家訂單</a>
					<a class="list-group-item list-group-item-action"
						id="list-coupons-list" data-bs-toggle="list" href="#list-coupons"
						role="tab" aria-controls="coupons">我的優惠券</a>
					<%
					if (isSeller) {
					%>
					<a class="list-group-item list-group-item-action"
						id="list-managereplies-list" href="sellerComments" role="tab">管理回覆</a>
					<a class="list-group-item list-group-item-action"
						id="list-myreply-list" href="repliedComments" role="tab">查看回覆</a>
					<%
					} else {
					%>
					<a class="list-group-item list-group-item-action"
						id="list-comments-list" href="userComments" role="tab">查看評論</a> <a
						class="list-group-item list-group-item-action"
						id="list-buyerreviews-list" href="sellerCommentsForUser"
						role="tab">買家評價</a>
					<%
					}
					%>
					<a class="list-group-item list-group-item-action"
						id="list-sellerMarket-list" href="sellerMarket" role="tab">我的賣場</a>
					<a class="list-group-item list-group-item-action"
						id="list-sellerGood-list" href="sellerGoodQueryAll" role="tab">我的商品</a>
						<a class="list-group-item list-group-item-action"
						id="list-talk-list" href="chat" role="tab">聊聊</a>
				</div>
			</div>
			<div class="col-md-9">
				<div class="tab-content" id="nav-tabContent">
					<!-- 個人資訊 -->
					<div class="tab-pane fade show active bordered-pane" id="list-info"
						role="tabpanel" aria-labelledby="list-info-list">
						<h3>個人資訊</h3>
						<div class="d-flex justify-content-center mt-3 w-100">
							<div
								style="width: 100px; height: 100px; border-radius: 50%; overflow: hidden;">
								<img src="<%=member.getPhotoSticker()%>" alt="沒有頭貼"
									style="width: 100%; height: 100%; object-fit: cover; object-position: center;">
							</div>
						</div>
						<form action="#" class="mt-3" id="editForm">
							<div class="form-floating mb-3">
								<input type="text" class="form-control" id="floatingUsername"
									placeholder="帳號名稱" name="account" readonly> <label
									for="floatingUsername">帳號名稱</label>
							</div>
							<div class="form-floating mb-3">
								<input type="email" class="form-control" id="floatingEmail"
									placeholder="電子信箱" name="email" readonly> <label
									for="floatingEmail">電子信箱</label>
							</div>
							<div class="form-floating mb-3">
								<input type="text" class="form-control" id="floatingPhone"
									placeholder="手機號碼" name="phone" readonly> <label
									for="floatingPhone">手機號碼</label>
							</div>
							<div class="form-floating mb-3">
								<input type="text" class="form-control" id="floatingName"
									placeholder="會員姓名" name="name" readonly> <label
									for="floatingName">會員姓名</label>
							</div>
							<div class="form-floating mb-3">
								<select class="form-select" id="floatingGender"
									aria-label="會員性別" name="gender" disabled>
									<option selected>選擇性別</option>
									<option value="male">男</option>
									<option value="female">女</option>
								</select> <label for="floatingGender">會員性別</label>
							</div>
							<div class="form-floating mb-3">
								<input type="text" class="form-control" id="floatingAddress"
									placeholder="會員住址" name="address" readonly> <label
									for="floatingAddress">會員住址</label>
							</div>
							<div class="d-flex justify-content-center">
								<button type="button" class="btn btn-primary" id="editButton">修改會員資料</button>
							</div>
							<!-- 新增送出和取消按鈕，預設隱藏 -->
							<div class="d-flex justify-content-center mt-2"
								id="actionButtons" style="display: none;">
								<button type="button" class="btn btn-success mx-2 controlButton"
									style="display: none;" id="updateButton">送出</button>
								<button type="button" class="btn btn-danger mx-2 controlButton"
									style="display: none;" id="cancelButton">取消</button>
							</div>
						</form>
					</div>
					<!-- 帳號詳情 -->
					<div class="tab-pane fade bordered-pane" id="list-account"
						role="tabpanel" aria-labelledby="list-account-list">
						<h3>帳號詳情</h3>
						<div class="form-floating mb-3 mt-5">
							<input type="text" class="form-control" id="isSeller"
								placeholder="是否具有賣家身分" readonly> <label for="isSeller">是否具有賣家身分</label>
						</div>
						<div class="form-floating mb-3 mt-3">
							<input type="text" class="form-control" id="reviewCount"
								placeholder="被評論總數" readonly> <label for="reviewCount">被評論總數</label>
						</div>
						<div class="form-floating mb-3 mt-3">
							<input type="text" class="form-control" id="cumulativeScore"
								placeholder="當前平均評分數" readonly> <label
								for="cumulativeScore">當前平均評分數</label>
						</div>
						<div class="form-floating mb-3 mt-3">
							<input type="text" class="form-control" id="totalSalesAmount"
								placeholder="當前累計消費金額" readonly> <label
								for="totalSalesAmount">當前累計消費金額</label>
						</div>
						<div class="form-floating mb-3 mt-3">
							<input type="text" class="form-control" id="third_party_provider"
								placeholder="登入方式" readonly> <label
								for="third_party_provider">登入方式</label>
						</div>
						<div class="form-floating mb-3 mt-3">
							<input type="text" class="form-control" id="registrationTime"
								placeholder="註冊時間" readonly> <label
								for="registrationTime">註冊時間</label>
						</div>
					</div>
					<!-- 修改密碼 -->
					<div class="tab-pane fade bordered-pane" id="list-password"
						role="tabpanel" aria-labelledby="list-password-list">
						<h3>修改密碼</h3>
						<form action="" method="post" onsubmit="return validateForm()">
							<div class="form-floating mb-3 mt-5">
								<input type="password" class="form-control"
									id="floatingPassword" placeholder="請輸入密碼"> <label
									for="floatingPassword">請輸入密碼</label>
							</div>
							<div class="form-floating mb-3 mt-3">
								<input type="password" class="form-control"
									id="floatingCheckPassword" placeholder="請再確認密碼"> <label
									for="floatingCheckPassword">請再確認密碼</label>
							</div>
							<div id="error-message" class="error-message"></div>
							<div class="d-flex justify-content-center">
								<button type="submit" class="btn btn-primary mt-3"
									id="changePassword">送出</button>
							</div>
						</form>
					</div>
					<!-- 買家訂單 -->
					<div class="tab-pane fade" id="Buy-list-orders" role="tabpanel"
						aria-labelledby="Buy-list-orders-list">
						<h3>買家訂單</h3>
						<nav>
							<div class="nav nav-tabs" id="nav-tab" role="tablist">
								<button class="nav-link active" id="nav-all-tab"
									data-bs-toggle="tab" data-bs-target="#nav-all" type="button"
									role="tab" aria-controls="nav-all" aria-selected="true">全部</button>
								<button class="nav-link" id="nav-1-tab" data-bs-toggle="tab"
									data-bs-target="#nav-1" type="button" role="tab"
									aria-controls="nav-1" aria-selected="false">待出貨</button>
								<button class="nav-link" id="nav-2-tab" data-bs-toggle="tab"
									data-bs-target="#nav-2" type="button" role="tab"
									aria-controls="nav-2" aria-selected="false">待收貨</button>
								<button class="nav-link" id="nav-3-tab" data-bs-toggle="tab"
									data-bs-target="#nav-3" type="button" role="tab"
									aria-controls="nav-3" aria-selected="false">待評論</button>
								<button class="nav-link" id="nav-4-tab" data-bs-toggle="tab"
									data-bs-target="#nav-4" type="button" role="tab"
									aria-controls="nav-4" aria-selected="false">已完成</button>
								<button class="nav-link" id="nav-5-tab" data-bs-toggle="tab"
									data-bs-target="#nav-5" type="button" role="tab"
									aria-controls="nav-5" aria-selected="false">已取消</button>
							</div>
						</nav>
						<div class="tab-content" id="nav-tabContent">
							<div class="tab-pane fade show active" id="nav-all"
								role="tabpanel" aria-labelledby="nav-all-tab"></div>
							<div class="tab-pane fade" id="nav-1" role="tabpanel"
								aria-labelledby="nav-1-tab"></div>
							<div class="tab-pane fade" id="nav-2" role="tabpanel"
								aria-labelledby="nav-2-tab"></div>
							<div class="tab-pane fade" id="nav-3" role="tabpanel"
								aria-labelledby="nav-3-tab"></div>
							<div class="tab-pane fade" id="nav-4" role="tabpanel"
								aria-labelledby="nav-4-tab"></div>
							<div class="tab-pane fade" id="nav-5" role="tabpanel"
								aria-labelledby="nav-5-tab"></div>
						</div>
					</div>
					<!-- 賣家訂單 -->
					<div class="tab-pane fade" id="Sell-list-orders" role="tabpanel"
						aria-labelledby="Sell-list-orders-list">
						<h3>賣家訂單</h3>
						<nav>
							<div class="nav nav-tabs" id="nav-tab2" role="tablist">
								<button class="nav-link active" id="nav-all-tab2"
									data-bs-toggle="tab" data-bs-target="#nav-all2" type="button"
									role="tab" aria-controls="nav-all2" aria-selected="true">全部</button>
								<button class="nav-link" id="nav-1-tab2" data-bs-toggle="tab"
									data-bs-target="#nav-12" type="button" role="tab"
									aria-controls="nav-12" aria-selected="false">待出貨</button>
								<button class="nav-link" id="nav-2-tab2" data-bs-toggle="tab"
									data-bs-target="#nav-22" type="button" role="tab"
									aria-controls="nav-22" aria-selected="false">待收貨</button>
								<button class="nav-link" id="nav-3-tab2" data-bs-toggle="tab"
									data-bs-target="#nav-32" type="button" role="tab"
									aria-controls="nav-32" aria-selected="false">待評論</button>
								<button class="nav-link" id="nav-4-tab2" data-bs-toggle="tab"
									data-bs-target="#nav-42" type="button" role="tab"
									aria-controls="nav-42" aria-selected="false">已完成</button>
								<button class="nav-link" id="nav-5-tab2" data-bs-toggle="tab"
									data-bs-target="#nav-52" type="button" role="tab"
									aria-controls="nav-52" aria-selected="false">已取消</button>
							</div>
						</nav>
						<div class="tab-content" id="nav-tabContent">
							<div class="tab-pane fade show active" id="nav-all2"
								role="tabpanel" aria-labelledby="nav-all-tab2">.all.</div>
							<div class="tab-pane fade" id="nav-12" role="tabpanel"
								aria-labelledby="nav-12-tab">.1.</div>
							<div class="tab-pane fade" id="nav-22" role="tabpanel"
								aria-labelledby="nav-22-tab">.2.</div>
							<div class="tab-pane fade" id="nav-32" role="tabpanel"
								aria-labelledby="nav-32-tab">.3.</div>
							<div class="tab-pane fade" id="nav-42" role="tabpanel"
								aria-labelledby="nav-42-tab">.4.</div>
							<div class="tab-pane fade" id="nav-52" role="tabpanel"
								aria-labelledby="nav-52-tab">.5.</div>
						</div>
					</div>
					<!-- 優惠卷 -->
					<div class="tab-pane fade" id="list-coupons" role="tabpanel"
						aria-labelledby="list-coupons-list">
						<h3>我的優惠券</h3>
						<p>這裡顯示用戶的優惠券。</p>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-p34f1UUtsS3wqzfto5wAAmdvj+osOnFyQFpp4Ua3gs/ZVWx6oOypYoCJhGGScy+8"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
	<script>
						$(document).ready(function () {
							$("#Buy-list-orders-list").click(function () {
								$.ajax({
									type: "GET",
									url: "/BuyAllOrderall",
									success: function (data) {
										$("#nav-all").html(data);
									},
									error: function (xhr, status, error) {
										console.error(6);
									}
								});
								$.ajax({
									type: "GET",
									url: "/BuyAllOrder1",
									success: function (data) {
										$("#nav-1").html(data);
									},
									error: function (xhr, status, error) {
										console.error(6);
									}
								});
								$.ajax({
									type: "GET",
									url: "/BuyAllOrder2",
									success: function (data) {
										$("#nav-2").html(data);
									},
									error: function (xhr, status, error) {
										console.error(6);
									}
								});
								$.ajax({
									type: "GET",
									url: "/BuyAllOrder3",
									success: function (data) {
										$("#nav-3").html(data);
									},
									error: function (xhr, status, error) {
										console.error(6);
									}
								});
								$.ajax({
									type: "GET",
									url: "/BuyAllOrder4",
									success: function (data) {
										$("#nav-4").html(data);
									},
									error: function (xhr, status, error) {
										console.error(6);
									}
								});
								$.ajax({
									type: "GET",
									url: "/BuyAllOrder5",
									success: function (data) {
										$("#nav-5").html(data);
									},
									error: function (xhr, status, error) {
										console.error(6);
									}
								});
							});

							$("#Sell-list-orders-list").click(function () {
								$.ajax({
									type: "GET",
									url: "/SellAllOrderall",
									success: function (data) {
										$("#nav-all2").html(data);
									},
									error: function (xhr, status, error) {
										console.error(6);
									}
								});
								$.ajax({
									type: "GET",
									url: "/SellAllOrder1",
									success: function (data) {
										$("#nav-12").html(data);
									},
									error: function (xhr, status, error) {
										console.error(6);
									}
								});
								$.ajax({
									type: "GET",
									url: "/SellAllOrder2",
									success: function (data) {
										$("#nav-22").html(data);
									},
									error: function (xhr, status, error) {
										console.error(6);
									}
								});
								$.ajax({
									type: "GET",
									url: "/SellAllOrder3",
									success: function (data) {
										$("#nav-32").html(data);
									},
									error: function (xhr, status, error) {
										console.error(6);
									}
								});
								$.ajax({
									type: "GET",
									url: "/SellAllOrder4",
									success: function (data) {
										$("#nav-42").html(data);
									},
									error: function (xhr, status, error) {
										console.error(6);
									}
								});
								$.ajax({
									type: "GET",
									url: "/SellAllOrder5",
									success: function (data) {
										$("#nav-52").html(data);
									},
									error: function (xhr, status, error) {
										console.error(6);
									}
								});
							});

							var userData = {};

							$('#editButton').click(function () {
								userData.username = $('#floatingUsername').val();
								userData.email = $('#floatingEmail').val();
								userData.phone = $('#floatingPhone').val();
								userData.name = $('#floatingName').val();
								userData.address = $('#floatingAddress').val();
								userData.gender = $('#floatingGender').val();

								// 創建一個新的檔案上傳輸入框
								var fileInput = $('<div class="mb-3" id="fileUpload"><label for="photoSticker" class="form-label">上傳頭貼:</label> <input type="file"id="photoSticker" name="photoSticker" class="form-control"></div>');

								// 將檔案上傳輸入框添加到表單中
								$('#actionButtons').before(fileInput);
								// 顯示送出和取消按鈕
								$('.controlButton').show();
								// 隱藏編輯按鈕
								$(this).hide();
								// 將所有具有 readonly 屬性的 input 元素變為可編輯
								$('input').prop('readonly', false);
								// 將會員性別下拉菜單的 disabled 屬性移除
								$('#floatingGender').prop('disabled', false);
							});

							$('#updateButton').click(function () {
								let form = $('#editForm')[0];
								let formData = new FormData(form);

								fetch('UpdateMember', {
									method: 'PUT',
									body: formData
								}).then(response => {
									if (!response.ok) {
										throw new Error('網路響應失敗');
									}
									return response.json(); // 解析 JSON
								}).then(data => {
									if (data.success) {
										Swal.fire({
											title: "成功",
											text: "新增成功",
											icon: "success"
										}).then((result) => {
											if (result.value) {
												location.reload();
											}
										});
									} else {
										Swal.fire({
											title: "錯誤",
											text: "新增失敗",
											icon: "error"
										});
									}
								}).catch(error => {
									console.error('Error:', error);
									Swal.fire({
										title: "錯誤",
										text: "發生了一個錯誤",
										icon: "error"
									});
								});
							});

							$('#cancelButton').click(function () {
								$('#fileUpload').remove();
								$('.controlButton').hide();
								$('#editButton').show();
								$('input').prop('readonly', true);
								$('#floatingGender').prop('disabled', true);

								$('#floatingUsername').val(userData.username);
								$('#floatingEmail').val(userData.email);
								$('#floatingPhone').val(userData.phone);
								$('#floatingName').val(userData.name);
								$('#floatingAddress').val(userData.address);
								$('#floatingGender').val(userData.gender);
							})

							$('#changePassword').click(function () {
								var password = document.getElementById("floatingPassword").value;
								var confirmPassword = document.getElementById("floatingCheckPassword").value;
								var errorMessage = document.getElementById("error-message");
								if (password !== confirmPassword) {
									errorMessage.innerText = "兩次密碼不一致，請重新輸入。";
									return false;
								}
								return true;
							})

							//初始化給值
							$(document).ready(function () {
								// 從JSP獲取UserBean資料
								var user = {
									username: '<%=member.getAccount()%>',
									email: '<%=member.getEmail()%>',
									phone: '<%=member.getPhone()%>',
									name: '<%=member.getName()%>',
									gender: '<%=member.getGender()%>',
									address: '<%=member.getAddress()%>',
									photoSticker: '<%=member.getPhotoSticker()%>',
									seller: '<%=member.isSeller()%>',
									reviewCount: '<%=member.getReviewCount()%>',
									cumulativeScore: '<%=member.getCumulativeScore()%>',
									totalSalesAmount: '<%=member.getTotalSalesAmount()%>',
									level: '<%=member.getLevel()%>',
									third_party_provider: '<%=member.getThirdPartyProvider()%>',
									registrationTime: '<%=member.getRegistrationTime()%>'
								};

								// 設置表單元素的預設值
								$('#floatingUsername').val(user.username);
								$('#floatingEmail').val(user.email);
								$('#floatingPhone').val(user.phone);
								$('#floatingName').val(user.name);
								$('#floatingGender').val(user.gender);
								$('#floatingAddress').val(user.address);
								$('#isSeller').val(user.seller ? "是" : "否");
								$('#reviewCount').val(user.reviewCount);
								$('#cumulativeScore').val(user.cumulativeScore);
								$('#totalSalesAmount').val(user.totalSalesAmount);
								$('#third_party_provider').val(user.third_party_provider);
								$('#registrationTime').val(user.registrationTime);

								// 設定性別選項
								$('#floatingGender option').each(function () {
									if ($(this).val() === user.gender) {
										$(this).prop('selected', true);
									}
								});
							});
						});
					</script>
	<%@ include file="../FrontDeskFooter.jsp"%>
</body>

</html>