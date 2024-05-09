<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>買家評價</title>
<style>
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
   .comment-container {
    width: 80%; /* 设置评论容器的宽度 */
    margin: 20px auto; /* 将评论容器水平居中显示，并添加上下间距 */
    border: 3px solid #ccc; /* 添加边框 */
        border-radius: 10px; /* 设置圆角 */
    
    padding: 10px; /* 添加内边距 */
    background-color: #f9f9f9; /* 设置背景颜色 */
}

.comment-container + .comment-container {
    margin-top: 20px; /* 设置相邻评论容器之间的上间距 */
}
</style>
</head>
<body>
		<%@ include file="indexcomment.jsp" %>
		

		<!-- 循环显示评论 -->
<c:forEach var="comment" items="${sellerComments}">
    <div class="comment-container">
        <!-- 显示评论内容 -->
        <!-- 显示其他评论相关信息 -->
        <p>${comment.member.name}</p>
        <p>
                <c:forEach begin="1" end="${comment.sellerrate}">
                      <img src="commentPicture/output.png" alt="star" width="20" height="20">
                    </c:forEach>
                </p>
         <div class="time-and-details">
          <fmt:formatDate value="${comment.replaytime}" pattern="yyyy-MM-dd HH:mm" var="formattedCommentTime" />
                    <p class="time">${formattedCommentTime}</p>
                    <p class="order-details"><span class="separator">|</p>
                    <p class="order-details">規格尺寸: ${comment.orders.formatgoodId.goodSize}</p>
                    <p class="order-details">商品名稱: ${comment.orders.formatgoodId.good.goodsName}</p>
                </div>
        <p>${comment.replayconetnt}</p>
    </div>
</c:forEach>
</body>
</html>