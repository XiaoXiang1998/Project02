<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Comment Admin</title>
<link
	href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
	rel="stylesheet" />
<link href="commentcss/styles.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.3/css/lightbox.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.3/js/lightbox.min.js"></script>
</head>
<body class="sb-nav-fixed">
	<%@ include file="../Order/jsp/allindex.jsp"%>
	<div id="layoutSidenav">
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<h1 class="mt-4">評論管理</h1>
					<ol class="breadcrumb mb-4">
						<li class="breadcrumb-item active">評論資料</li>
					</ol>
					<div class="card mb-4">
						<div class="card-header">
							<i class="fas fa-table me-1"></i>評論表
						</div>
						<div class="card-body">
							<table id="datatablesSimple">
								<thead>
									<tr>
										<th>編號</th>
										<th>名字</th>
										<th>評論內容</th>
										<th>商品圖片</th>
										<th>建立時間</th>
										<th>修改時間</th>
										<th>買家評價</th>
										<th>賣家回覆</th>
										<th>回覆時間</th>
										<th>賣家評分</th>
										<th>回覆編號</th>
										<th>刪除</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="post" items="${Post}">
										<!-- 將 var 改為 post，items 改為 ${posts} -->
										<tr>
											<td>${post.commentid}</td>
											<td>${post.member.name}</td>
											<!-- 訪問 post 所屬的會員名稱 -->
											<td>${post.commentcontent}</td>
											<td><c:if test="${not empty post.productphoto}">
													<a
														href="${pageContext.request.contextPath}/${post.productphoto}"
														data-lightbox="imagee-${post.commentid}"> <img
														class="product-photo"
														src="${pageContext.request.contextPath}/${post.productphoto}"
														alt="產品圖片" width="60px" height="60px">
													</a>
												</c:if></td>
											<td><fmt:formatDate value="${post.commenttime}"
													pattern="yyyy-MM-dd HH:mm" var="formattedCommentTime" />${formattedCommentTime}</td>
											<td><fmt:formatDate value="${post.lastmodifiedtime}"
													pattern="yyyy-MM-dd HH:mm" var="formattedLastModifiedTime" />${formattedLastModifiedTime}</td>
											<td>${post.buyerrate}</td>
											<td>${post.replayconetnt}</td>
											<td><fmt:formatDate value="${post.replaytime}"
													pattern="yyyy-MM-dd HH:mm" var="formattedReplayTime" />${formattedReplayTime}</td>
											<td>${post.sellerrate}</td>
											<td>${post.repliedcommentid}</td>
											<td><button onclick="deleteComment(${post.commentid});">刪除</button></td>
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
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="commentjs/scripts.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
		crossorigin="anonymous"></script>
	<script src="commentjs/datatables-simple-demo.js"></script>
	<script>
	function deleteComment(commentId) {
		
		console.log(commentId)
	    Swal.fire({
	        title: "你確定要刪除評論嗎？",
	        text: "您將無法恢復此狀態！",
	        icon: "warning",
	        showCancelButton: true,
	        confirmButtonColor: "#3085d6",
	        cancelButtonColor: "#d33",
	        confirmButtonText: "刪除"
	    }).then((result) => {
	        if (result.isConfirmed) {
	            $.ajax({
	                url: 'post/' + commentId, 
	                type: 'DELETE', 
	                success: function(result) {
	                    Swal.fire({
	                        title: "已刪除!",
	                        text: "您的評論已刪除",
	                        icon: "success",
	                        confirmButtonText: "OK",
	                        showConfirmButton: true,
	                        showCloseButton: true
	                    }).then(() => {
	                        console.log(result);
	                        window.location.href = "/commentadmin";
	                    });
	                },
	                error: function(xhr, status, error) {
	                    console.error('刪除評論失敗：' + error);
	                }
	            });
	        }
	    });
	}
		
	</script>
</body>
</html>