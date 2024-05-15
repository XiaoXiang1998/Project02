<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<title>管理者頁面</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
		<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.css">
		<link href="css/styles.css" rel="stylesheet" />
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
		<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
	</head>
	</head>

	<body class="sb-nav-fixed">
		<nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
			<!-- Navbar Brand-->
			<a class="navbar-brand ps-3" href="index.html">EZ BUY</a>
			<!-- Sidebar Toggle-->
			<button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!">
				<i class="fas fa-bars"></i>
			</button>
			<!-- Navbar Search-->
			<form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
				<div class="input-group">
					<input class="form-control" type="text" placeholder="Search for..." aria-label="Search for..."
						aria-describedby="btnNavbarSearch" />
					<button class="btn btn-primary" id="btnNavbarSearch" type="button">
						<i class="fas fa-search"></i>
					</button>
				</div>
			</form>
			<!-- Navbar-->
			<ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
				<li class="nav-item dropdown"><a class="nav-link dropdown-toggle" id="navbarDropdown" href="#"
						role="button" data-bs-toggle="dropdown" aria-expanded="false"><i
							class="fas fa-user fa-fw"></i></a>
					<ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
						<li><a class="dropdown-item" href="#!">Settings</a></li>
						<li><a class="dropdown-item" href="#!">Activity Log</a></li>
						<li>
							<hr class="dropdown-divider" />
						</li>
						<li><a class="dropdown-item" href="#!">Logout</a></li>
					</ul>
				</li>
			</ul>
		</nav>
		<div id="layoutSidenav">
			<%@ include file="../AllNav.jsp"%>
			<div id="layoutSidenav_content">
				<main>
					<div class="container-fluid px-4">
						<h1 class="mt-4">會員數據</h1>
						<ol class="breadcrumb mb-4">
							<li class="breadcrumb-item active">人數總覽</li>
						</ol>
						<div class="row">
							<div class="col-xl-6">
								<div class="card mb-4">
									<div class="card-header">
										<i class="fas fa-chart-area me-1"></i> 註冊時間分布
									</div>
									<div class="card-body">
										<canvas id="myAreaChart" width="100%" height="40"></canvas>
									</div>
								</div>
							</div>
							<div class="col-xl-6">
								<div class="card mb-4">
									<div class="card-header">
										<i class="fas fa-chart-bar me-1"></i> 會員等級分布
									</div>
									<div class="card-body">
										<canvas id="myBarChart" width="100%" height="40"></canvas>
									</div>
								</div>
							</div>
						</div>
						<div class="card mb-4">
							<div class="card-header">
								<i class="fas fa-table me-1"></i> 會員資料總覽
							</div>
							<div class="card-body">
								<table id="datatablesSimple">
									<thead>
										<tr>
											<th>會員ID</th>
											<th>帳號</th>
											<th>密碼</th>
											<th>信箱</th>
											<th>電話</th>
											<th>姓名</th>
											<th>性別</th>
											<th>住址</th>
											<th>頭貼</th>
											<th>賣家身分</th>
											<th>被評論數</th>
											<th>總評分數</th>
											<th>總消費金額</th>
											<th>會員級別</th>
											<th>登入方式</th>
											<th>註冊時間</th>
											<th>操作功能</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
								<div class="modal fade" id="exampleModal" tabindex="-1"
									aria-labelledby="exampleModalLabel" aria-hidden="true">
									<div class="modal-dialog modal-dialog-centered">
										<div class="modal-content">
											<div class="modal-header">
												<h5 class="modal-title" id="exampleModalLabel">更新會員資料</h5>
												<button type="button" class="btn-close" data-bs-dismiss="modal"
													aria-label="Close"></button>
											</div>
											<div class="modal-body">
												<form id="editForm">
													<div class="form-floating mb-3">
														<input type="text" id="sid" name="sid" class="form-control"
															readonly>
														<label for="sid">會員ID:</label>
													</div>
													<div class="form-floating mb-3">
														<input type="text" id="account" name="account"
															class="form-control" readonly>
														<label for="account">帳號:</label>
													</div>
													<div class="form-floating mb-3">
														<input type="text" id="password" name="password"
															class="form-control">
														<label for="password">密碼:</label>
													</div>
													<div class="form-floating mb-3">
														<input type="email" id="email" name="email"
															class="form-control">
														<label for="email">信箱:</label>
													</div>
													<div class="form-floating mb-3">
														<input type="tel" id="phone" name="phone" class="form-control">
														<label for="phone">電話:</label>
													</div>
													<div class="form-floating mb-3">
														<input type="text" id="name" name="name" class="form-control">
														<label for="name">姓名:</label>
													</div>
													<div class="form-floating mb-3">
														<select id="gender" name="gender" class="form-select">
															<option value="male">男性</option>
															<option value="female">女性</option>
														</select>
														<label for="gender">性別:</label>
													</div>
													<div class="form-floating mb-3">
														<input type="text" id="address" name="address"
															class="form-control">
														<label for="address">住址:</label>
													</div>
													<div class="form-floating mb-3">
														<input type="number" id="reviewCount" name="reviewCount"
															class="form-control" readonly>
														<label for="reviewCount">被評論數:</label>
													</div>
													<div class="form-floating mb-3">
														<input type="number" id="cumulativeScore" name="cumulativeScore"
															class="form-control" readonly>
														<label for="cumulativeScore">總評分數:</label>
													</div>
													<div class="form-floating mb-3">
														<input type="number" id="totalSalesAmount"
															name="totalSalesAmount" class="form-control" readonly>
														<label for="totalSalesAmount">總消費金額:</label>
													</div>
													<div class="form-floating mb-3">
														<input type="number" id="level" name="level"
															class="form-control" readonly>
														<label for="level">會員級別:</label>
													</div>
													<div class="form-floating mb-3">
														<input type="text" id="thirdPartyProvider"
															name="thirdPartyProvider" class="form-control" readonly>
														<label for="thirdPartyProvider">登入方式:</label>
													</div>
													<div class="form-floating mb-3">
														<input type="text" id="registrationTime" name="registrationTime"
															class="form-control" readonly>
														<label for="registrationTime">註冊時間:</label>
													</div>
													<div class="mb-3">
														<label for="photoSticker" class="form-label">頭貼:</label> <input
															type="file" id="photoSticker" name="photoSticker"
															class="form-control">
													</div>
													<input type="text" name="oldPath" style="display: none;">
													<div class="form-check form-switch">
														<input class="form-check-input" type="checkbox"
															id="sellerSwitch" name="seller" data-bs-toggle="toggle"
															data-bs-on="enabled" data-bs-off="disabled">
														<label class="form-check-label" for="sellerSwitch">賣家身分</label>
													</div>
												</form>

											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-secondary"
													data-bs-dismiss="modal">取消</button>
												<button type="button" class="btn btn-primary"
													id="saveChangesBtn">確認更新</button>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</main>
				<footer class="py-4 bg-light mt-auto">
					<div class="container-fluid px-4">
						<div class="d-flex align-items-center justify-content-between small">
							<div class="text-muted">Copyright &copy; Your Website 2023</div>
							<div>
								<a href="#">Privacy Policy</a> &middot; <a href="#">Terms
									&amp; Conditions</a>
							</div>
						</div>
					</div>
				</footer>
			</div>
		</div>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
			crossorigin="anonymous"></script>
		<script src="js/scripts.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
			crossorigin="anonymous"></script>
		<script type="text/javascript" src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
		<!-- 抓取會員等級的分布數量 -->
		<script>
			$(document).ready(function () {
				$('#saveChangesBtn').click(function () {
					var form = $('#editForm')[0]; // 使用jQuery選擇DOM元素
					console.log(form);
					var formData = new FormData(form); // 使用原生JavaScript建立FormData

					var isSeller = $('#sellerSwitch').is(':checked');

					// 將 checkbox 的值添加到 FormData 中
					formData.append('seller', isSeller);


					fetch('UpdateMember', { // 發送fetch請求
						method: 'PUT',
						body: formData
					})
						.then(response => {
							if (response.ok) {
								// 更新成功的處理
								$('#exampleModal').modal('hide'); // 隱藏模態框
								var table = $('#datatablesSimple').DataTable();
								// 檢查 DataTable 是否已經被初始化
								if (table) {
									table.ajax.reload(); // 只重新載入資料
								}
							} else {
								// 更新失敗的處理
								console.error('Failed to update member data.');
							}
						})
					$('#exampleModal').modal('hide');
				});
			})

			function updateCharArea() {
				fetch('registerCount', {
					method: 'GET',
					headers: {
						'Content-Type': 'application/json' // 指定請求主體的類型為 JSON
					},
				}).then(response => response.json())
					.then(data => {
						var ctx = document.getElementById("myAreaChart");
						var registerData = data;
						var myLineChart = new Chart(ctx, {
							type: 'line',
							data: {
								labels: ["Mar 1", "Mar 2", "Mar 3", "Mar 4", "Mar 5"],
								datasets: [{
									label: "Sessions",
									lineTension: 0.3,
									backgroundColor: "rgba(2,117,216,0.2)",
									borderColor: "rgba(2,117,216,1)",
									pointRadius: 5,
									pointBackgroundColor: "rgba(2,117,216,1)",
									pointBorderColor: "rgba(255,255,255,0.8)",
									pointHoverRadius: 5,
									pointHoverBackgroundColor: "rgba(2,117,216,1)",
									pointHitRadius: 50,
									pointBorderWidth: 2,
									data: registerData
								}],
							},
							options: {
								scales: {
									xAxes: [{
										time: {
											unit: 'date'
										},
										gridLines: {
											display: false
										},
										ticks: {
											maxTicksLimit: 7
										}
									}],
									yAxes: [{
										ticks: {
											min: 0,
											max: 100,
											maxTicksLimit: 10
										},
										gridLines: {
											color: "rgba(0, 0, 0, .125)",
										}
									}],
								},
								legend: {
									display: false
								}
							}
						});
					})
			};

			function updateBarChart() {
				fetch('headcount', {
					method: 'GET', // 指定請求方法為 POST
					headers: {
						'Content-Type': 'application/json' // 指定請求主體的類型為 JSON
					},
				})
					.then(response => response.json())
					.then(data => {
						var memberData = data;
						var ctx = document.getElementById("myBarChart");
						var myLineChart = new Chart(ctx, {
							type: 'bar',
							data: {
								labels: ["初心者", "銅", "銀", "金", "白金"],
								datasets: [{
									label: "Revenue",
									backgroundColor: "rgba(2,117,216,1)",
									borderColor: "rgba(2,117,216,1)",
									data: memberData,
								}],
							},
							options: {
								scales: {
									xAxes: [{
										time: {
											unit: 'month'
										},
										gridLines: {
											display: false
										},
										ticks: {
											maxTicksLimit: 6
										}
									}],
									yAxes: [{
										ticks: {
											min: 0,
											max: 100,
											maxTicksLimit: 10
										},
										gridLines: {
											display: true
										}
									}],
								},
								legend: {
									display: false
								}
							}
						});
					});
			}

			function getAllMember() {
				$('#datatablesSimple').DataTable({
					"ajax": {
						"url": "adminGetAllMember",
						"method": "GET",
						"dataSrc": ""
					},
					language: {
						"lengthMenu": "顯示 _MENU_ 筆資料",
						"sProcessing": "處理中...",
						"sZeroRecords": "没有匹配结果",
						"sInfo": "目前有 _MAX_ 筆資料",
						"sInfoEmpty": "目前共有 0 筆紀錄",
						"sInfoFiltered": " ",
						"sInfoPostFix": "",
						"sSearch": "搜尋:",
						"sUrl": "",
						"sEmptyTable": "尚未有資料紀錄存在",
						"sLoadingRecords": "載入資料中...",
						"sInfoThousands": ",",
						"oPaginate": {
							"sFirst": "首頁",
							"sPrevious": "上一頁",
							"sNext": "下一頁",
							"sLast": "末頁"
						},
						"order": [[0, "desc"]],
						"oAria": {
							"sSortAscending": ": 以升序排列此列",
							"sSortDescending": ": 以降序排列此列"
						}
					},
					"columns": [
						{ "data": "sid" },
						{ "data": "account" },
						{ "data": "password" },
						{ "data": "email" },
						{ "data": "phone" },
						{ "data": "name" },
						{ "data": "gender" },
						{ "data": "address" },
						{
							"data": "photoSticker",
							"render": function (data, type, row) {
								return '<div style="width: 50px; height: 50px; border-radius: 50%; overflow: hidden;">' +
									'    <img src="' + data + '" alt="沒有頭貼" style="width: 100%; height: 100%; object-fit: cover; object-position: center;">' +
									'</div>';
							}
						},
						{ "data": "seller" },
						{ "data": "reviewCount" },
						{ "data": "cumulativeScore" },
						{ "data": "totalSalesAmount" },
						{ "data": "level" },
						{ "data": "thirdPartyProvider" },
						{ "data": "registrationTime" },
						{
							"data": null,
							"render": function (data, type, row) {
								return '<div class="button-container">' +
									'<button type="button" class="btn btn-warning btn-sm editBtn" data-bs-toggle="modal" data-bs-target="#exampleModal">修改</button>' +
									'<button type="button" class="btn btn-danger btn-sm deleteBtn">刪除</button>' +
									'</div>';
							}
						}
					]
				});
			}

			window.onload = function () {
				// 加載完成後更新圖表
				updateBarChart();
				updateCharArea();
				getAllMember();

				$('#datatablesSimple tbody').on('click', 'button.deleteBtn', function () {
					var data = $('#datatablesSimple').DataTable().row($(this).closest('tr')).data();
					let sid = parseInt(data.sid);

					const swalWithBootstrapButtons = Swal.mixin({
						customClass: {
							confirmButton: "btn btn-primary",
							cancelButton: "btn btn-danger"
						},
						buttonsStyling: false
					});
					swalWithBootstrapButtons.fire({
						title: "是否確認要刪除?",
						text: "你將無法回復這個條件!",
						icon: "warning",
						showCancelButton: true,
						confirmButtonText: "刪除!",
						cancelButtonText: "取消!",
						reverseButtons: true
					}).then((result) => {
						if (result.isConfirmed) {

							console.log(sid);
							fetch('/DeleteMember/' + sid, {
								method: 'DELETE',
								headers: {
									'Content-Type': 'application/json'
								}
							}).then(response => {
								if (response.ok) {
									// 更新成功的處理
									var table = $('#datatablesSimple').DataTable();
									// 檢查 DataTable 是否已經被初始化
									if (table) {
										table.ajax.reload(); // 只重新載入資料
									}
								} else {
									// 更新失敗的處理
									console.error('Failed to update member data.');
								}
							})

							swalWithBootstrapButtons.fire({
								title: "刪除成功!",
								text: "你的檔案已成功刪除",
								icon: "success"
							});
						} else if (
							/* Read more about handling dismissals below */
							result.dismiss === Swal.DismissReason.cancel
						) {
							swalWithBootstrapButtons.fire({
								title: "已取消",
								text: "你的檔案依舊安全",
								icon: "error"
							});
						}
					});

				})

				$('#datatablesSimple tbody').on('click', 'button.editBtn', function () {
					// 獲取所在行的資料
					var data = $('#datatablesSimple').DataTable().row($(this).closest('tr')).data();
					let isSeller = Boolean(data.seller);
					console.log(isSeller);

					// 將資料填充到表單的input欄位中
					$('#editForm input[name="sid"]').val(data.sid);
					$('#editForm input[name="account"]').val(data.account);
					$('#editForm input[name="password"]').val(data.password);
					$('#editForm input[name="email"]').val(data.email);
					$('#editForm input[name="phone"]').val(data.phone);
					$('#editForm input[name="name"]').val(data.name);
					$('#editForm select[name="gender"]').val(data.gender);
					$('#editForm input[name="address"]').val(data.address);
					$('#editForm input[name="oldPath"]').val(data.photoSticker);
					$('#editForm input[name="seller"]').prop('checked', isSeller);
					// $('#sellerSwitch').prop('checked', true);
					$('#editForm input[name="reviewCount"]').val(data.reviewCount);
					$('#editForm input[name="cumulativeScore"]').val(data.cumulativeScore);
					$('#editForm input[name="totalSalesAmount"]').val(data.totalSalesAmount);
					$('#editForm input[name="level"]').val(data.level);
					$('#editForm input[name="thirdPartyProvider"]').val(data.thirdPartyProvider);
					$('#editForm input[name="registrationTime"]').val(data.registrationTime);

					// 顯示表單
					$('#editForm').show();
				});

				// 防止表單提交後刷新頁面
				$('#editForm').submit(function (event) {
					event.preventDefault();
					// 在這裡處理表單提交的邏輯
				});
			};

			// 每隔一段時間定期更新圖表（例如每 5 秒更新一次）
			setInterval(updateBarChart, 300000); // 5000 毫秒（即 5 秒）
			setInterval(updateCharArea, 300000); // 5000 毫秒（即 5 秒）
		</script>
	</body>

	</html>