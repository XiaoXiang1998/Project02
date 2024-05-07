<%@page import="java.sql.Time"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isErrorPage="true"   import="java.util.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="basePath" value="${pageContext.request.contextPath}" />
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>評論資料</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.3/css/lightbox.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.3/js/lightbox.min.js"></script>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f4f4f4;
	margin: 0;
	padding: 0;
}

.container {
    position: relative; /* 让容器相对定位 */

	max-width: 800px;
	margin: 0 auto;
	padding: 20px;
}

.item {
	position: relative;
	background-color: #fff;
	border-radius: 8px;
	padding: 20px;
	margin-bottom: 20px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.avatar {
	width: 50px;
	height: 50px;
	background-color: #ccc;
	border-radius: 50%;
	display: inline-block;
	margin-right: 20px;
}

.info {

    display: inline-block;
    vertical-align: top;
    width: calc(100% - 70px);
    position: relative;
}

.name {
	color: #FB7299;
	font-size: 16px;
	font-weight: bold;
	margin: 0 0 10px 0;
}

.stars img {
	width: 20px;
	height: 20px;
	margin-right: 5px;
}

.time {
	color: #999;
	font-size: 14px;
	margin-bottom: 10px;
}

.product-photo {
	margin-bottom: 10px;
	width: 80px;
	height: 80px;
}

.no-image {
	display: none;
}

.text {
	color: #333;
	font-size: 14px;
	line-height: 1.5;
}
.dropdown {
    position: absolute;
    top: 10px; /* 调整按钮与评论条目顶部的距离 */
    right: 10px; /* 调整按钮与评论条目右侧的距离 */
    z-index: 1; /* 确保按钮位于其他内容之上 */
}

.dropdown-content {
    display: none;
    position: relative; /* 将下拉菜单设置为相对定位 */
    background-color: #fff;
    min-width: 120px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    z-index: 1;
    border-radius: 5px;
}

.dropdown-content a {
    color: #333;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
}

.dropdown-content a:hover {
    background-color: #f9f9f9;
}

.dropdown:hover .dropdown-content {
    display: block;
}

.edit-window {
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background-color: #fff;
    padding: 20px;
    border: 1px solid #ccc;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    z-index: 9999;
    display: none;
}

.edit-window textarea {
      width: 100%;
    height: 100px;
    resize: none;
    margin-bottom: 10px;
    border: 1px solid #ccc; /* 添加邊框 */
    border-radius: 5px; /* 圓角 */
    padding: 10px; /* 內邊距 */
    font-size: 14px; /* 字體大小 */
    line-height: 1.5; /* 行高 */
}
/* 擴展 textarea 在 hover 狀態下的樣式 */
.edit-window textarea:hover {
    border-color: #999;
}
/* 擴展 textarea 在 focus 狀態下的樣式 */
.edit-window textarea:focus {
    outline: none;
    border-color: #007bff; /* 更改 focus 狀態下的邊框顏色 */
    box-shadow: 0 0 5px rgba(0, 123, 255, 0.5); /* 添加 focus 狀態下的陰影效果 */
}

.close-btn {
    position: absolute;
    top: 5px;
    right: 5px;
    cursor: pointer;
}

.page-separator {
    margin: 0 5px; /* 調整分頁連結之間的間距 */
}

.pagination {
    margin-top: 20px;
    padding-left: 0;
    list-style: none;
    text-align: center;
}

.pagination strong,
.pagination a {
    color: #007bff;
    text-decoration: none;
    padding: 8px 12px;
    border: 1px solid #007bff;
    border-radius: 5px;
}

.pagination strong:hover,
.pagination a:hover {
    background-color: #007bff;
    color: #fff;
}

.pagination strong,
.pagination a {
    margin-right: 5px;
}

.pagination .active a {
    background-color: #007bff;
    color: #fff;
    pointer-events: none;
    cursor: default;
}

.pagination .disabled a {
    color: #6c757d;
    background-color: #fff;
    border-color: #6c757d;
    pointer-events: none;
    cursor: default;
}

.time-and-details {
        flex-grow: 1; /* 彈性增長，以填滿可用空間 */
        display: flex;
        flex-direction: row;
    }
    .order-details {
        margin-right: 10px; /* 增加右邊距，使得各項目之間有一定間距 */
    }
    
    .time{
	    margin-right: 5px; /* 調整時間和 | 之間的間距 */
	
}

.separator {
    margin-right: 5px; /* 調整右側間距 */
    margin-left: 5px; /* 調整左側間距 */
}
</style>
</head>
<body>
	<%@ include file="indexcomment.jsp" %>

	<div class="container">
    <c:forEach items="${comments}" var="comment">
        <div class="item" data-comment-id="${comment.commentid}">
            <i class="avatar"></i>
            <div class="info">
                <p class="name">${comment.member.name}</p>
                <p>
                    <c:forEach begin="1" end="${comment.buyerrate}">
                        <img src="commentPicture/output.png" alt="star" width="20" height="20">
                    </c:forEach>
                </p>
                <div class="time-and-details">
                    <c:if test="${not empty comment.commenttime}">
                        <fmt:formatDate value="${comment.commenttime}" pattern="yyyy-MM-dd HH:mm" var="formattedCommentTime" />
                        <p class="time">${formattedCommentTime}</p>
                    </c:if>
                        <!-- 顯示訂單的ID -->
                    <p class="order-details"><span class="separator">|</span>訂單編號: ${comment.orders.orderId}</p>
                        <!-- 顯示規格的尺寸 -->
                    <p class="order-details">規格尺寸: ${comment.orders.formatgoodId.goodSize}</p>
                        <!-- 顯示商品的名稱 -->
                    <p class="order-details">商品名稱: ${comment.orders.formatgoodId.good.goodsName}</p>  
                </div>
                <c:choose>
                    <c:when test="${not empty comment.productphoto}">
                        <a href="${pageContext.request.contextPath}/${comment.productphoto}" data-lightbox="product-images-${comment.commentid}">
                            <img class="product-photo" src="${pageContext.request.contextPath}/${comment.productphoto}" alt="產品圖片">
                        </a>
                    </c:when>
                    <c:otherwise>
                        <div class="no-image"></div>
                    </c:otherwise>
                </c:choose>
                <p class="text">${comment.commentcontent}</p>
                <div class="dropdown">
                    <button class="dropbtn">&#8942;</button>
                    <div class="dropdown-content">
                        <a href="#" onclick="showEditForm(${comment.commentid}, '${comment.commentcontent}');" >編輯</a>
                        <a href="#" onclick="deleteComment(${comment.commentid}); return false;">刪除</a>
                    </div>
                </div>
                <div id="editForm${comment.commentid}" style="display: none;" class="edit-window">
                    <!-- 編輯表單 -->
                    <span class="close-btn" onclick="closeEditWindow(${comment.commentid})">×</span>
                    <form id="commentForm${comment.commentid}" action="post/${comment.commentid}" method="post">
                        <input type="hidden" name="_method" value="PUT">
                        <textarea name="commentContent" id="commentContent_${comment.commentid}"></textarea>
                        <button type="button" onclick="updateComment(${comment.commentid});">提交</button>
                    </form>
                </div>
            </div>
        </div>
    </c:forEach>
</div>

<c:if test="${totalPages > 1}">
    <div class="pagination">
        <c:forEach begin="0" end="${totalPages - 1}" var="pageNumber">
            <c:url value="?page=${pageNumber}" var="pageUrl"/>
            <c:if test="${pageNumber == currentPage}">
                <strong>${pageNumber + 1}</strong>
            </c:if>
            <c:if test="${pageNumber != currentPage}">
                <a href="${pageUrl}">${pageNumber + 1}</a>
            </c:if>
            <!-- 添加分页链接之间的间隔 -->
            <span class="page-separator">&nbsp;</span>
        </c:forEach>
    </div>
</c:if>
		
	
	<script>
	function deleteComment(commentId) {
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
	                        window.location.href = "/userComments";
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
<script>
function showEditForm(commentId, commentContent) {
    var editFormId = "editForm" + commentId;
    document.getElementById(editFormId).style.display = "block";
    document.getElementById("commentContent_" + commentId).value = commentContent;
}

function closeEditWindow(commentId) {
    console.log('Close button clicked for comment ID:', commentId);
    var editFormId = "editForm" + commentId;
    var editWindow = document.getElementById(editFormId);
    editWindow.style.display = "none";
}

function updateComment(commentId) {
    // 隱藏文本域和按鈕
    var editForm = document.getElementById('editForm' + commentId);
    editForm.style.display = 'none';

    var commentContent = document.getElementById("commentContent_" + commentId).value;

    // 使用 SweetAlert 顯示確認訊息
    Swal.fire({
        title: '你確定要修改評論嗎？',
        icon: 'question',
        showCancelButton: true,
        confirmButtonText: '確認',
        cancelButtonText: '取消',
    }).then((result) => {
        if (result.isConfirmed) {
            // 使用 AJAX 將更新後的評論內容發送到後端
            $.ajax({
                url: 'post/' + commentId, // 使用 PUT 請求的路由
                type: 'POST', // 使用 POST 方法
                data: {
                    _method: 'PUT', // 以 PUT 方式提交表單
                    commentContent: commentContent // 要更新的評論內容
                },
                success: function(result) {
                    // 顯示修改成功的提示訊息
                    Swal.fire({
                        title: '修改成功',
                        icon: 'success',
                        confirmButtonText: '確認'
                    }).then(() => {
                        window.location.reload(); // 修改成功後重新加載頁面
                    });
                },
                error: function(xhr, status, error) {
                    console.error('修改評論失敗：' + error);
                }
            });
        } else {
            // 如果取消，則重新顯示文本域和按鈕
            editForm.style.display = 'block';
        }
    });
}
</script>
<script>
/*document.querySelectorAll('.item').forEach(item => {
    item.querySelector('.dropdown-content a:nth-of-type(1)').addEventListener('click', function(event) {
        event.preventDefault();
        const commentId = item.dataset.commentId;
        const editForm = document.getElementById('editForm' + commentId);
        const rect = item.getBoundingClientRect();
        const top = rect.top + window.scrollY;
        const left = rect.left + window.scrollX;
        editForm.style.display = 'block';
        editForm.style.top = `${top}px`;
        editForm.style.left = `${left}px`;
    });
});*/
document.querySelectorAll('.item').forEach(item => {
    item.querySelector('.dropdown-content a:nth-of-type(1)').addEventListener('click', function(event) {
        event.preventDefault();
        const commentId = item.dataset.commentId;
        const editForm = document.getElementById('editForm' + commentId);
        const rect = item.getBoundingClientRect();
        const containerRect = document.querySelector('.container').getBoundingClientRect();
        const top = containerRect.top - window.scrollY; // 使用容器顶部位置
        const left = containerRect.right - editForm.offsetWidth - window.scrollX; // 使用容器右侧位置减去编辑表单宽度
        editForm.style.display = 'block';
        editForm.style.top = `${top}px`;
        editForm.style.left = `${left}px`;
    });
});
</script>
</body>
</html>