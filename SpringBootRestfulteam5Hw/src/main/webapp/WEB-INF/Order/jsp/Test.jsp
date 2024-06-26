<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="BIG5">
<title>訂單管理</title>
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
<link href="css/styles.css" rel="stylesheet" />
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/plug-ins/2.0.7/i18n/zh-HANT.json"></script>
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10/dist/sweetalert2.min.css">


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
				<input class="form-control" type="text" placeholder="Search for..." aria-label="Search for..." aria-describedby="btnNavbarSearch" />
				<button class="btn btn-primary" id="btnNavbarSearch" type="button">
					<i class="fas fa-search"></i>
				</button>
			</div>
		</form>
		<!-- Navbar-->
		<ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
					<i class="fas fa-user fa-fw"></i>
				</a>
				<ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
					<li>
						<a class="dropdown-item" href="#!">Settings</a>
					</li>
					<li>
						<a class="dropdown-item" href="#!">Activity Log</a>
					</li>
					<li>
						<hr class="dropdown-divider" />
					</li>
					<li>
						<a class="dropdown-item" href="#!">Logout</a>
					</li>
				</ul>
			</li>
		</ul>
	</nav>
	<div id="layoutSidenav">
		<%@ include file="../../AllNav.jsp"%>
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<h1 class="mt-4">訂單管理</h1>
					<div class="row">
						<div class="col-xl-6">
							<div class="card mb-4">
								<div class="card-header">
									<i class="fas fa-chart-area me-1"></i>
									近五月訂單數量
								</div>
								<div class="card-body">
									<canvas id="myAreaChart" width="100%" height="40"></canvas>
								</div>
							</div>
						</div>
						<div class="col-xl-6">
							<div class="card mb-4">
								<div class="card-header">
									<i class="fas fa-chart-bar me-1"></i>
									近五月訂單金額
								</div>
								<div class="card-body">
									<canvas id="myBarChart" width="100%" height="40"></canvas>
								</div>
							</div>
						</div>
					</div>
					<div class="card mb-4">
						<div class="card-header">
							<i class="fas fa-table me-1"></i>
							訂單詳情
						</div>
						<div class="card-body">
							<button class="btn btn-primary mb-3" onclick="exportToJSON()">匯出為 JSON</button>
							<button class="btn btn-secondary mb-3" onclick="exportToCSV()">匯出為 CSV</button>
							<button class="btn btn-success mb-3" onclick="exportToXML()">匯出為 XML</button>
							<table id="datatablesSimple">
								<thead>
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
								<tbody>
									<c:forEach items="${orders}" var="order">
										<tr style="height: 80px" class="text-center align-middle">
											<td>${order.orderId}</td>
											<td>${order.buyerId.name}</td>
											<td>${order.sellerId.name}</td>
											<td>${order.shippingMethod == 1 ? '宅配到家' :
																	order.shippingMethod == 2 ?
																	'超商物流' : ''}</td>
											<td>${order.name}</td>
											<td>${order.address}</td>
											<td>${order.tel}</td>
											<td>${order.formatgoodId.good.goodsName}</td>
											<td>${order.originalPrice}</td>
											<td>${order.quantity}</td>
											<td>${order.shippingFee}</td>
											<td>${order.totalPrice}</td>
											<td>
												<c:choose>
													<c:when test="${order.orderStatus == 0}">已成立
																		</c:when>
													<c:when test="${order.orderStatus == 1}">待出貨
																		</c:when>
													<c:when test="${order.orderStatus == 2}">待收貨
																		</c:when>
													<c:when test="${order.orderStatus == 3}">待評論
																		</c:when>
													<c:when test="${order.orderStatus == 4}">已完成
																		</c:when>
													<c:when test="${order.orderStatus == 5}">已取消
																		</c:when>
													<c:otherwise></c:otherwise>
												</c:choose>
											</td>
											<td>${order.payStatus == 0 ? '未付款' : '已付款'}</td>
											<td>
												<fmt:formatDate value="${order.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" />
											</td>
											<c:set var="queryType" value="${param.queryType}" />
											<td>
												<a href="#" onclick="showEditForm('${order.orderId}','${order.name}','${order.tel}','${order.address}',${order.orderStatus})" class="btn btn-primary btn-sm">修改</a>
											</td>
											<c:choose>
												<c:when test="${order.orderStatus == 3}">
													<td>
														<form action="insertPost" method="get">
															<input type="hidden" id="comment" name="commentId" value="${order.orderId}">
															<button class="btn btn-warning btn-sm" type="submit">評論</button>
														</form>
													</td>
												</c:when>
												<c:otherwise>
													<td>
														<a href="#" onclick="confirmDelete(${order.orderId})" class="btn btn-danger btn-sm">刪除</a>
													</td>
												</c:otherwise>
											</c:choose>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</main>
			<footer class="py-4 bg-light mt-auto">
				<div class="container-fluid px-4">
					<div class="d-flex align-items-center justify-content-between small">
						<div class="text-muted">Copyright &copy; Your Website 2023</div>
						<div>
							<a href="#">Privacy Policy</a>
							&middot;
							<a href="#">Terms &amp; Conditions</a>
						</div>
					</div>
				</div>
			</footer>
		</div>
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
							<option value="1">待出貨</option>
							<option value="2">待收貨</option>
							<option value="3">待評論</option>
							<option value="4">已完成</option>
							<option value="5">已取消</option>
						</select>
					</div>
					<button type="button" class="btn btn-primary" onclick="confirmSave()">保存</button>
					<button type="button" class="btn btn-secondary" onclick="hideEditForm()">取消</button>
				</form>
			</div>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
	<script src="Order/js/scripts.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
	<script src="Order/js/datatables-simple-demo.js"></script>

	<script>
						var ctx = document.getElementById("myAreaChart");
						var myLineChart = new Chart(ctx, {
							type: 'line',
							data: {
								labels: [<c:forEach var="monthLabel" items="${monthOrdersMap.keySet()}">${monthLabel}+"月",</c:forEach>],
								datasets: [{
									label: "訂單數量",
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
									data: [<c:forEach var="ordersCount" items="${monthOrdersMap.values()}">${ordersCount},</c:forEach>],
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
						var ctx = document.getElementById("myBarChart");
						var myLineChart = new Chart(ctx, {
							type: 'bar',
							data: {
								labels: [<c:forEach var="monthLabel" items="${monthOrdersPrice.keySet()}">${monthLabel}+"月",</c:forEach>],
								datasets: [{
									label: "金額(NTD)",
									backgroundColor: "rgba(2,117,216,1)",
									borderColor: "rgba(2,117,216,1)",
									data: [<c:forEach var="ordersPrice" items="${monthOrdersPrice.values()}">${ordersPrice},</c:forEach>],
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
											max: 1000000,
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
						function showEditForm(orderId, shippingName, shippingTel, shippingAddress, orderStatus) {
							document.getElementById('editOrderId').value = orderId;
							document.getElementById('editShippingName').value = shippingName;
							document.getElementById('editShippingTel').value = shippingTel;
							document.getElementById('editShippingAddress').value = shippingAddress;
							document.getElementById('editOrderStatus').value = orderStatus;

							document.getElementById('editForm').classList.remove('d-none');
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

						function hideEditForm() {
							document.getElementById('editForm').classList.add('d-none');
						}

						function confirmDelete(orderId) {
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
									fetch("fakeDelete.controller?orderId=" + orderId, {
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
						function exportToJSON() {
							const table = document.getElementById('datatablesSimple');
							const rows = table.querySelectorAll('tbody tr');
							const jsonArray = [];

							rows.forEach(row => {
								const cells = row.querySelectorAll('td');
								const jsonObj = {
									"訂單ID": cells[0].innerText,
									"買家": cells[1].innerText,
									"賣家": cells[2].innerText,
									"送達方式": cells[3].innerText,
									"收件人姓名": cells[4].innerText,
									"收件人地址": cells[5].innerText,
									"收件人電話": cells[6].innerText,
									"商品名稱": cells[7].innerText,
									"商品單價": cells[8].innerText,
									"數量": cells[9].innerText,
									"運費": cells[10].innerText,
									"支付金額": cells[11].innerText,
									"訂單狀態": cells[12].innerText,
									"付款狀態": cells[13].innerText,
									"創建時間": cells[14].innerText
								};
								jsonArray.push(jsonObj);
							});

							const jsonString = JSON.stringify(jsonArray, null, 2);
							download(jsonString, 'orders.json', 'application/json');
						}

						function exportToCSV() {
							const table = document.getElementById('datatablesSimple');
							const rows = table.querySelectorAll('tbody tr');
							let csvContent = '訂單ID,買家,賣家,送達方式,收件人姓名,收件人地址,收件人電話,商品名稱,商品單價,數量,運費,支付金額,訂單狀態,付款狀態,創建時間\n';

							rows.forEach(row => {
								const cells = row.querySelectorAll('td:not(:nth-last-child(-n+2))');
								const rowArray = Array.from(cells).map(cell => cell.innerText);
								csvContent += rowArray.join(',') + '\n';
							});

							download(csvContent, 'orders.csv', 'text/csv');
						}

						function download(data, filename, type) {
							const file = new Blob([data], { type: type });
							if (window.navigator.msSaveOrOpenBlob) {
								window.navigator.msSaveOrOpenBlob(file, filename);
							} else {
								const a = document.createElement('a');
								const url = URL.createObjectURL(file);
								a.href = url;
								a.download = filename;
								document.body.appendChild(a);
								a.click();
								setTimeout(() => {
									document.body.removeChild(a);
									window.URL.revokeObjectURL(url);
								}, 0);
							}
						}
						function exportToXML() {
							const table = document.getElementById('datatablesSimple');
							const allRows = table.querySelectorAll('tbody tr');

							const xmlRoot = document.createElement('orders');

							allRows.forEach(row => {
								const xmlOrder = document.createElement('order');

								row.querySelectorAll('td').forEach((cell, index) => {
									const columnHeader = table.querySelector('thead tr th:nth-child(' + (index + 1) + ')');

									const cellName = columnHeader ? columnHeader.textContent.trim().replace(/\s+/g, '_') : 'unknown';

									if (cellName !== '操作') {
										const xmlElement = document.createElement(cellName);
										xmlElement.textContent = cell.textContent.trim();

										xmlOrder.appendChild(xmlElement);
									}
								});

								xmlRoot.appendChild(xmlOrder);
							});

							const xmlString = new XMLSerializer().serializeToString(xmlRoot);

							download(xmlString, 'orders.xml', 'application/xml');
						}



					</script>

</body>

</html>