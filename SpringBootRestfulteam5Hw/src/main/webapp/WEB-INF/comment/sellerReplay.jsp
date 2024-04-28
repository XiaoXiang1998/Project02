<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="basePath" value="${pageContext.request.contextPath}" />
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>查看回覆</title>
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
</style>
</head>
<body>

	<%@ include file="sellercomment.jsp"%>


	<div class="container">
	    <c:forEach items="${post}" var="comment">
	        <div class="item">
	            <i class="avatar"></i>
	            <div class="info">
	                <p class="name">${comment.member.name}</p>
	                <p>
	                    <c:forEach begin="1" end="${comment.sellerrate}">
	                        <img src="commentPicture/output.png" alt="star" width="20" height="20">
	                    </c:forEach>
	                </p>
	                <c:if test="${not empty comment.replaytime}">
	                    <fmt:formatDate value="${comment.replaytime}" pattern="yyyy-MM-dd HH:mm" var="formattedCommentTime" />
	                    <p class="time">${formattedCommentTime}</p>
	                </c:if>
	                <p class="text">${comment.replayconetnt}</p>
	            </div>
	        </div>
	    </c:forEach>
	</div>
</body>
</html>