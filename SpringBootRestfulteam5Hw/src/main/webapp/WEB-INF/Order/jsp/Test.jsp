<%@ page language="java" contentType="text/html; charset=BIG5"
	pageEncoding="BIG5"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="BIG5">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
	rel="stylesheet" />
<link href="Order/css/styles.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@10/dist/sweetalert2.min.css">
</head>

<body class="sb-nav-fixed">
	<nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
		<!-- Navbar Brand-->
		<a class="navbar-brand ps-3" href="index.html">Start Bootstrap</a>
		<!-- Sidebar Toggle-->
		<button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0"
			id="sidebarToggle" href="#!">
			<i class="fas fa-bars"></i>
		</button>
		<!-- Navbar Search-->
		<form
			class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
			<div class="input-group">
				<input class="form-control" type="text" placeholder="Search for..."
					aria-label="Search for..." aria-describedby="btnNavbarSearch" />
				<button class="btn btn-primary" id="btnNavbarSearch" type="button">
					<i class="fas fa-search"></i>
				</button>
			</div>
		</form>
		<!-- Navbar-->
		<ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
			<li class="nav-item dropdown"><a
				class="nav-link dropdown-toggle" id="navbarDropdown" href="#"
				role="button" data-bs-toggle="dropdown" aria-expanded="false"><i
					class="fas fa-user fa-fw"></i></a>
				<ul class="dropdown-menu dropdown-menu-end"
					aria-labelledby="navbarDropdown">
					<li><a class="dropdown-item" href="#!">Settings</a></li>
					<li><a class="dropdown-item" href="#!">Activity Log</a></li>
					<li>
						<hr class="dropdown-divider" />
					</li>
					<li><a class="dropdown-item" href="#!">Logout</a></li>
				</ul></li>
		</ul>
	</nav>
	<div id="layoutSidenav">
		<div id="layoutSidenav_nav">
			<nav class="sb-sidenav accordion sb-sidenav-dark"
				id="sidenavAccordion">
				<div class="sb-sidenav-menu">
					<div class="nav">
						<div class="sb-sidenav-menu-heading">Core</div>
						<a class="nav-link" href="index.html">
							<div class="sb-nav-link-icon">
								<i class="fas fa-tachometer-alt"></i>
							</div> Dashboard
						</a>
						<div class="sb-sidenav-menu-heading">Interface</div>
						<a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
							data-bs-target="#collapseLayouts" aria-expanded="false"
							aria-controls="collapseLayouts">
							<div class="sb-nav-link-icon">
								<i class="fas fa-columns"></i>
							</div> Layouts
							<div class="sb-sidenav-collapse-arrow">
								<i class="fas fa-angle-down"></i>
							</div>
						</a>
						<div class="collapse" id="collapseLayouts"
							aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
							<nav class="sb-sidenav-menu-nested nav">
								<a class="nav-link" href="layout-static.html">Static
									Navigation</a> <a class="nav-link" href="layout-sidenav-light.html">Light
									Sidenav</a>
							</nav>
						</div>
						<a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
							data-bs-target="#collapsePages" aria-expanded="false"
							aria-controls="collapsePages">
							<div class="sb-nav-link-icon">
								<i class="fas fa-book-open"></i>
							</div> Pages
							<div class="sb-sidenav-collapse-arrow">
								<i class="fas fa-angle-down"></i>
							</div>
						</a>
						<div class="collapse" id="collapsePages"
							aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
							<nav class="sb-sidenav-menu-nested nav accordion"
								id="sidenavAccordionPages">
								<a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
									data-bs-target="#pagesCollapseAuth" aria-expanded="false"
									aria-controls="pagesCollapseAuth"> Authentication
									<div class="sb-sidenav-collapse-arrow">
										<i class="fas fa-angle-down"></i>
									</div>
								</a>
								<div class="collapse" id="pagesCollapseAuth"
									aria-labelledby="headingOne"
									data-bs-parent="#sidenavAccordionPages">
									<nav class="sb-sidenav-menu-nested nav">
										<a class="nav-link" href="login.html">Login</a> <a
											class="nav-link" href="register.html">Register</a> <a
											class="nav-link" href="password.html">Forgot Password</a>
									</nav>
								</div>
								<a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
									data-bs-target="#pagesCollapseError" aria-expanded="false"
									aria-controls="pagesCollapseError"> Error
									<div class="sb-sidenav-collapse-arrow">
										<i class="fas fa-angle-down"></i>
									</div>
								</a>
								<div class="collapse" id="pagesCollapseError"
									aria-labelledby="headingOne"
									data-bs-parent="#sidenavAccordionPages">
									<nav class="sb-sidenav-menu-nested nav">
										<a class="nav-link" href="401.html">401 Page</a> <a
											class="nav-link" href="404.html">404 Page</a> <a
											class="nav-link" href="500.html">500 Page</a>
									</nav>
								</div>
							</nav>
						</div>
						<div class="sb-sidenav-menu-heading">Addons</div>
						<a class="nav-link" href="charts.html">
							<div class="sb-nav-link-icon">
								<i class="fas fa-chart-area"></i>
							</div> Charts
						</a> <a class="nav-link" href="tables.html">
							<div class="sb-nav-link-icon">
								<i class="fas fa-table"></i>
							</div> Tables
						</a>
					</div>
				</div>
				<div class="sb-sidenav-footer">
					<div class="small">Logged in as:</div>
					Start Bootstrap
				</div>
			</nav>
		</div>
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<h1 class="mt-4">Dashboard</h1>
					<ol class="breadcrumb mb-4">
						<li class="breadcrumb-item active">Dashboard</li>
					</ol>
					<div class="row">
						<div class="col-xl-6">
							<div class="card mb-4">
								<div class="card-header">
									<i class="fas fa-chart-area me-1"></i> Area Chart Example
								</div>
								<div class="card-body">
									<canvas id="myAreaChart" width="100%" height="40"></canvas>
								</div>
							</div>
						</div>
						<div class="col-xl-6">
							<div class="card mb-4">
								<div class="card-header">
									<i class="fas fa-chart-bar me-1"></i> Bar Chart Example
								</div>
								<div class="card-body">
									<canvas id="myBarChart" width="100%" height="40"></canvas>
								</div>
							</div>
						</div>
					</div>
					<div class="card mb-4">
						<div class="card-header">
							<i class="fas fa-table me-1"></i> DataTable Example
						</div>
						<div class="card-body">
							<table id="datatablesSimple">
								<thead>
									<tr>
										<th>�q��ID</th>
										<th>�R�a</th>
										<th>��a</th>
										<th>�B�e�覡</th>
										<th>����H�m�W</th>
										<th>����H�a�}</th>
										<th>����H�q��</th>
										<th>�ӫ~�W��</th>
										<th>�ӫ~���</th>
										<th>�ƶq</th>
										<th>�B�O</th>
										<th>��I���B</th>
										<th>�q�檬�A</th>
										<th>�I�ڪ��A</th>
										<th>�Ыخɶ�</th>
										<th>�ާ@</th>
										<th>�ާ@</th>
									</tr>
								</thead>
								<tfoot>
									<tr>
										<th>�q��ID</th>
										<th>�R�a</th>
										<th>��a</th>
										<th>�B�e�覡</th>
										<th>����H�m�W</th>
										<th>����H�a�}</th>
										<th>����H�q��</th>
										<th>�ӫ~�W��</th>
										<th>�ӫ~���</th>
										<th>�ƶq</th>
										<th>�B�O</th>
										<th>��I���B</th>
										<th>�q�檬�A</th>
										<th>�I�ڪ��A</th>
										<th>�Ыخɶ�</th>
										<th>�ާ@</th>
										<th>�ާ@</th>
									</tr>
								</tfoot>
								<tbody>
									<c:forEach items="${orders}" var="order">
						<tr style="height: 80px" class="text-center align-middle">
							<td>${order.orderId}</td>
							<td>${order.buyerId.name}</td>
							<td>${order.sellerId.name}</td>
							<td>${order.shippingMethod == 1 ? '�v�t��a' : order.shippingMethod == 2 ?
													'�W�Ӫ��y' : ''}</td>
							<td>${order.name}</td>
							<td>${order.address}</td>
							<td>${order.tel}</td>
							<td>${order.formatgoodId.good.goodsName}</td>
							<td>${order.originalPrice}</td>
							<td>${order.quantity}</td>
							<td>${order.shippingFee}</td>
							<td>${order.totalPrice}</td>
							<td><c:choose>
									<c:when test="${order.orderStatus == 0}">�w����</c:when>
									<c:when test="${order.orderStatus == 1}">�ݥX�f</c:when>
									<c:when test="${order.orderStatus == 2}">�ݦ��f</c:when>
									<c:when test="${order.orderStatus == 3}">�ݵ���</c:when>
									<c:when test="${order.orderStatus == 4}">�w����</c:when>
									<c:when test="${order.orderStatus == 5}">�w����</c:when>
									<c:otherwise></c:otherwise>
								</c:choose></td>
							<td>${order.payStatus == 0 ? '���I��' : '�w�I��'}</td>
							<td><fmt:formatDate value="${order.createdAt}"
									pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<c:set var="queryType" value="${param.queryType}" />
							<td><a href="#"
								onclick="showEditForm('${order.orderId}','${order.name}','${order.tel}','${order.address}',${order.orderStatus})"
								class="btn btn-primary btn-sm">�ק�</a></td>
							<c:choose>
								<c:when test="${order.orderStatus == 3}">
									<td>
										<form action="insertPost" method="get">
											<input type="hidden" id="comment" name="commentId"
												value="${order.orderId}">
											<button class="btn btn-warning btn-sm" type="submit">����</button>
										</form>
									</td>
								</c:when>
								<c:otherwise>
									<td><a href="#"
										onclick="confirmDelete(${order.orderId}, '${queryType}')"
										class="btn btn-danger btn-sm">�R��</a></td>
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
					<div
						class="d-flex align-items-center justify-content-between small">
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
	<div id="editForm" class="d-none"
			style="position: fixed; top: 0; left: 0; right: 0; bottom: 0; background-color: rgba(255, 255, 255, 0.9); z-index: 1000;">
			<div class="row justify-content-center align-items-center h-100">
				<div class="col-md-6 border p-4">
					<h2 class="mt-5">�ק�q��</h2>
					<form id="editOrderForm" action="updateOrder.controller"
						method="post">
						<input type="hidden" name="_method" value="PUT" /> <input
							type="hidden" id="editOrderId" name="orderId"
							value="${order.orderId}"> <input type="hidden"
							id="editQueryType" name="queryType" value="${queryType}">
						<div class="mb-3">
							<label for="editShippingName" class="form-label">����H�m�W:</label> <input
								type="text" id="editShippingName" name="name"
								class="form-control">
						</div>
						<div class="mb-3">
							<label for="editShippingTel" class="form-label">����H�q��:</label> <input
								type="text" id="editShippingTel" name="tel" class="form-control">
						</div>
						<div class="mb-3">
							<label for="editShippingAddress" class="form-label">����H�a�}:</label>
							<input type="text" id="editShippingAddress" name="address"
								class="form-control">
						</div>
						<div class="mb-3">
							<label for="editOrderStatus" class="form-label">�q�檬�A:</label> <select
								id="editOrderStatus" name="orderstatus" class="form-select">
								<option value="0">�w����</option>
								<option value="1">�ݥX�f</option>
								<option value="2">�ݦ��f</option>
								<option value="3">�ݵ���</option>
								<option value="4">�w����</option>
								<option value="5">�w����</option>
							</select>
						</div>
						<button type="button" class="btn btn-primary"
							onclick="confirmSave()">�O�s</button>
						<button type="button" class="btn btn-secondary"
							onclick="hideEditForm()">����</button>
					</form>
				</div>
			</div>
		</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="Order/js/scripts.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
		crossorigin="anonymous"></script>
	<script src="Order/assets/demo/chart-area-demo.js"></script>
	<script src="Order/assets/demo/chart-bar-demo.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
		crossorigin="anonymous"></script>
	<script src="Order/js/datatables-simple-demo.js"></script>
	<script>
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
									title: "�T�{�ק�q��s����" + orderId + "���q���?",
									showDenyButton: true,
									confirmButtonText: "�T�{",
									denyButtonText: "����"
								}).then((result) => {
									if (result.isConfirmed) {
										Swal.fire({
											icon: "success",
											title: "�ק令�\"
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
											title: "�����ק�"
										}).then((result) => {
											hideEditForm();
										});
									}
								});
							}

							function hideEditForm() {
								document.getElementById('editForm').classList.add('d-none');
							}

							function confirmDelete(orderId, queryType) {
								Swal.fire({
									title: "�T�w�n�R����?",
									icon: "warning",
									showCancelButton: true,
									confirmButtonColor: "#3085d6",
									cancelButtonColor: "#d33",
									confirmButtonText: "�T�w",
									cancelButtonText: '����'
								}).then((result) => {
									if (result.isConfirmed) {
										fetch("fakeDelete.controller?orderId=" + orderId + "&queryType=" + queryType, {
											method: 'PUT'
										})
											.then(response => response.text())
											.then(result => {
												Swal.fire({
													title: "�R�����\�I",
													text: "�z�w�g�R���q��s����" + orderId + "���q��",
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
</body>

</html>