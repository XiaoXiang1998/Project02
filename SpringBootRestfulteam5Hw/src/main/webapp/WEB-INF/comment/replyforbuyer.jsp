<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.comments {
	margin-bottom: 20px;
}

.comment {
	padding: 15px;
	margin-bottom: 15px;
}
/* 添加评论框之间的分隔线 */
.comment:not(:last-child) {
	border-bottom: 1px solid #ccc; /* 添加分隔线 */
	margin-bottom: 15px; /* 调整间距 */
}

.comment p {
	margin: 5px 0;
}

.comment .time-and-details {
	margin-top: 10px;
}

.comment .time-and-details p {
	display: inline-block;
	margin-right: 10px;
}

.comment .separator {
	margin: 0 5px;
}

.comment img {
	vertical-align: middle;
}

.comment .order-details {
	margin: 5px 0;
}

.pagination {
	text-align: center;
}

.pagination ul {
	display: inline-block;
	padding: 0;
	margin: 0;
}

.pagination ul li {
	display: inline-block;
	margin: 0 5px;
}

.pagination ul li.active a {
	background-color: #007bff;
	color: #fff;
	border-radius: 5px;
	padding: 5px 10px;
}

.pagination ul li a {
	text-decoration: none;
	color: #007bff;
	padding: 5px 10px;
	border: 1px solid #007bff;
	border-radius: 5px;
}

.pagination ul li a:hover {
	background-color: #007bff;
	color: #fff;
}

.nav-link {
	text-align: center;
}

.star-img {
	display: inline-block; /* 將圖片設置為 inline-block */
	margin: auto; /* 使圖片水平置中 */
}

#replayconetnt {
	font-size: 16px; /* 放大字体 */
}

.name {
	color: #FB7299;
	font-size: 16px;
	font-weight: bold;
	margin: 0 0 10px 0;
}

.nav-link.active {
	background-color: #007bff; /* 高亮時背景顏色 */
}
.goods-container {
    display: flex;
    align-items: center;
    margin-bottom: 10px;
}

.goods-container img {
    margin-right: 10px;
    border: 1px solid #ccc; /* 边框颜色 */
}

.goods-container span {
    font-size: 1.1em; /* 设置字体大小，根据实际情况调整 */
    color: black; /* 设置文字颜色为黑色 */
    background-color: #e0e0e0; /* 设置背景颜色为浅灰色 */
    padding: 5px; /* 可选：添加一些内边距 */
}
</style>
</head>
<body>

	<%@ include file="../FrontDeskNav.jsp"%>


	<div class="row">
		<div class="col">
			<ul class="nav nav-tabs">
				<!-- 平均分數和星星圖示 -->
				<li class="nav-item"><span class="nav-link"
					style="font-weight: bold; color: black; font-size: 22px;">
						${averageScore} </span> <!-- 顯示星星圖示 --> <span class="nav-link"> <c:forEach
							begin="1" end="${averageScore}">
							<img src="commentPicture/output.png" alt="star" class="star-img"
								width="20" height="20">
						</c:forEach>
				</span></li>

				<li class="nav-item"><a
					class="nav-link ${selectedRating == 0 ? 'active' : ''}"
					href="?rating=0">全部</a></li>
				<li class="nav-item"><a
					class="nav-link ${selectedRating == 5 ? 'active' : ''}"
					href="?rating=5">5顆星 (${ratingCounts[4]})</a></li>
				<li class="nav-item"><a
					class="nav-link ${selectedRating == 4 ? 'active' : ''}"
					href="?rating=4">4顆星 (${ratingCounts[3]})</a></li>
				<li class="nav-item"><a
					class="nav-link ${selectedRating == 3 ? 'active' : ''}"
					href="?rating=3">3顆星 (${ratingCounts[2]})</a></li>
				<li class="nav-item"><a
					class="nav-link ${selectedRating == 2 ? 'active' : ''}"
					href="?rating=2">2顆星 (${ratingCounts[1]})</a></li>
				<li class="nav-item"><a
					class="nav-link ${selectedRating == 1 ? 'active' : ''}"
					href="?rating=1">1顆星 (${ratingCounts[0]})</a></li>
			</ul>
		</div>
	</div>

	<!-- 显示当前评分级别的评论数据 -->
	<div class="comments">
		<c:forEach var="comment" items="${comments}">
			<div class="comment">
				<!-- 显示评论内容 -->
				<p class="name">${comment.member.name}</p>
				<p>
					<c:forEach begin="1" end="${comment.sellerrate}">
						<img src="commentPicture/output.png" alt="star" width="20"
							height="20">
					</c:forEach>
				</p>
				<div class="time-and-details">
					<fmt:formatDate value="${comment.replaytime}"
						pattern="yyyy-MM-dd HH:mm" var="formattedCommentTime" />
					<p class="time">${formattedCommentTime}</p>
					<p class="order-details">
						<span class="separator">|</span>
					</p>
					<!-- 获取规格尺寸 -->
					<c:forEach var="goods" items="${comment.member.goods2}">
						<c:forEach var="format" items="${goods.format}">
							<p class="order-details">規格尺寸: ${format.goodSize}</p>
							<p class="order-details">商品名稱: ${goods.goodsName}</p>
						</c:forEach>
					</c:forEach>
				</div>
				<p id="replayconetnt">${comment.replayconetnt}</p>
				<c:forEach var="good" items="${comment.member.goods2}">
					<c:forEach var="format" items="${good.format}">
						<div class="goods-container">
							<a href="goodDetail.controller?GoodID=${good.goodsID}"> <img
								src="${format.goodImagePath}" alt="商品標題圖片" width="100px"
								height="100px" />
							</a> 
								<span>${good.goodsDirection}</span>
						</div>
					</c:forEach>
				</c:forEach>
			</div>
		</c:forEach>
	</div>

	<!-- 显示分页 -->
	<div class="pagination">
		<ul>
			<c:forEach var="i" begin="1" end="${totalPages}">
				<li class="page-item ${currentPage == i-1 ? 'active' : ''}"><a
					class="page-link" href="?page=${i-1}&rating=${selectedRating}">${i}</a>
				</li>
			</c:forEach>
		</ul>
	</div>

	<%@ include file="../FrontDeskFooter.jsp"%>

	<script>
		document.addEventListener("DOMContentLoaded", function() {
			document.querySelectorAll('.name').forEach(function(nameElement) {
				let name = nameElement.innerText;
				if (name.length === 3) {
					let maskedName = maskName(name);
					nameElement.innerText = maskedName;
				}
			});
		});

		function maskName(name) {
			if (name.length !== 3) {
				return name; // 如果名字不是三個字，直接返回名字
			}
			let firstChar = name.charAt(0);
			let lastChar = name.charAt(2);
			return firstChar + '***' + lastChar; // 將中間字符替換為星號
		}
	</script>

</body>
</html>