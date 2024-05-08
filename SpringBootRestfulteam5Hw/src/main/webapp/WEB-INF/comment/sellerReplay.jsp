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
<link rel="stylesheet" id="templatecss" type="text/css"
	href="/commentcss/style.css">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.3/css/lightbox.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.3/js/lightbox.min.js"></script>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f4f4f4;
	margin: 0;
	padding: 0;
}

.container {
    position: relative; /* 让容器相对定位 */

	max-width: 600px;
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

.time-and-details {
        flex-grow: 1; /* 彈性增長，以填滿可用空間 */
        display: flex;
        flex-direction: row;
    }
    .order-details {
        margin-right: 10px; /* 增加右邊距，使得各項目之間有一定間距 */
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

.time{
	    margin-right: 5px; /* 調整時間和 | 之間的間距 */
	
}

.separator {
    margin-right: 5px; /* 調整右側間距 */
    margin-left: 5px; /* 調整左側間距 */
}

.bit-com .bit {
	display: inline-block;
	width: 32px;
	height: 24px;
	background: url(commentPicture/star8.jpg) no-repeat;
	background-size: 24px 24px;
	text-align: center;
}

.bit-com .bit.on {
	background: url(commentPicture/output.png) no-repeat;
	background-size: 24px 24px;
}
    .tab .page-link {
        border: 1px solid rgba(0, 0, 0, 0.2);
        border-radius: 5px;
        background-color: transparent;
        outline: none;
        cursor: pointer;
        padding: 10px 15px;
        transition: background-color 0.3s;
        margin: 0 5px; /* 調整按鈕之間的間距 */
        position: relative; /* 將span元素定位相對於按鈕 */
        text-align: center;
    }

    .tab .page-link .badge {
        position: absolute; /* 使用絕對位置 */
        top: -10px; /* 調整數字在按鈕上的位置 */
        right: -10px; /* 調整數字在按鈕上的位置 */
        background-color: #ff0000; /* 設置背景顏色 */
        color: #ffffff; /* 設置文字顏色 */
        border-radius: 50%; /* 圓形邊框 */
        padding: 5px; /* 調整內邊距 */
        font-size: 12px; /* 調整字體大小 */
        display: inline-block; /* 使span元素顯示為行內塊 */
        opacity: 1; /* 初始時顯示 */
        transition: opacity 0.3s; /* 添加過渡效果 */
    }

    /* 鼠標懸停時的效果 */
    .tab .page-link:hover {
        background-color: rgba(0, 0, 0, 0.1);
    }

    /* 激活/選中按鈕的樣式 */
    .tab .page-link.active {
        background-color: rgba(0, 0, 0, 0.2);
        color: #fff; /* 設置文字顏色 */
    }

 
</style>
</head>
<body>

	<%@ include file="sellercomment.jsp"%>
	
	
	

	<div class="container">
    <ul class="nav nav-tabs" id="myTab" role="tablist">
        <li class="nav-item">
            <a class="nav-link active" id="all-tab" data-toggle="tab" href="#all" role="tab" aria-controls="all" aria-selected="true">全部</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" id="five-star-tab" data-toggle="tab" href="#five-star" role="tab" aria-controls="five-star" aria-selected="false">五星評論</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" id="four-star-tab" data-toggle="tab" href="#four-star" role="tab" aria-controls="four-star" aria-selected="false">四星評論</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" id="three-star-tab" data-toggle="tab" href="#three-star" role="tab" aria-controls="three-star" aria-selected="false">三星評論</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" id="two-star-tab" data-toggle="tab" href="#two-star" role="tab" aria-controls="two-star" aria-selected="false">二星評論</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" id="one-star-tab" data-toggle="tab" href="#one-star" role="tab" aria-controls="one-star" aria-selected="false">一星評論</a>
        </li>
    </ul>
    <div class="tab-content" id="myTabContent">
        <!-- 全部 -->
        <div class="tab-pane fade show active" id="all" role="tabpanel" aria-labelledby="all-tab">
            <c:forEach items="${comments}" var="comment">
                <div class="item" data-comment-id="${comment.commentid}">
                    <!-- 评论内容展示 -->
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
                                    <img class="product-photo" src="${pageContext.request.contextPath}/${comment.productphoto}" alt="產品圖片" width="60px" height="60px">
                                </a>
                            </c:when>
                            <c:otherwise>
                                <div class="no-image"></div>
                            </c:otherwise>
                        </c:choose>
                        <p class="text">${comment.commentcontent}</p>
                    </div>
                    <!-- 回覆按鈕 -->
                    <button class="reply-btn" onclick="toggleReplyForm('${comment.commentid}')">回覆</button>
                    <!-- 回覆表單 -->
                    <div id="replyFormContainer${comment.commentid}" style="display: none;">
                        <form action="/submitReply" method="post" class="bootstrap-frm" id="replyForm${comment.commentid}">
                            <span class="close-btn" onclick="closeReplyForm('${comment.commentid}')">×</span>
                            <h1 id="alter">
                                回覆<span>請填寫回覆內容</span>
                            </h1>
                            <input type="hidden" name="memberId" value="${comment.member.sid}">
                            <input type="hidden" name="commentId" value="${comment.commentid}">
                            <label><span>回覆內容:</span>
                                <textarea id="replyContent${comment.commentid}" name="replyContent" rows="10" cols="30" maxlength="100" placeholder="Your Reply" required></textarea>
                            </label>
                            <span class="replyContent${comment.commentid}" id="replyContent" data->輸入的字數:0/100</span><br />
                            <div class="bit-com">
                                評分:<span class="bit" id="bit1"></span> <span class="bit" id="bit2"></span> <span class="bit" id="bit3"></span> <span class="bit" id="bit4"></span> <span class="bit" id="bit5"></span>
                            </div>
                            <input type="hidden" name="rate" id="replyRate${comment.commentid}" value="0">
                            <label><span>&nbsp;</span><input type="submit" class="button" value="Send Reply" /></label>
                        </form>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- 五星評論 -->
        <div class="tab-pane fade" id="five-star" role="tabpanel" aria-labelledby="five-star-tab">
            <c:forEach items="${comments}" var="comment">
                <c:if test="${comment.buyerrate == 5}">
                    <!-- 评论内容展示 -->
                    <div class="item" data-comment-id="${comment.commentid}">
                        <!-- 评论内容展示 -->
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
                                        <img class="product-photo" src="${pageContext.request.contextPath}/${comment.productphoto}" alt="產品圖片" width="60px" height="60px">
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <div class="no-image"></div>
                                </c:otherwise>
                            </c:choose>
                            <p class="text">${comment.commentcontent}</p>
                        </div>
                        <!-- 回覆按鈕 -->
                        <button class="reply-btn" onclick="toggleReplyForm('${comment.commentid}')">回覆</button>
                        <!-- 回覆表單 -->
                        <div id="replyFormContainer${comment.commentid}" style="display: none;">
                            <form action="/submitReply" method="post" class="bootstrap-frm" id="replyForm${comment.commentid}">
                                <span class="close-btn" onclick="closeReplyForm('${comment.commentid}')">×</span>
                                <h1 id="alter">
                                    回覆<span>請填寫回覆內容</span>
                                </h1>
                                <input type="hidden" name="memberId" value="${comment.member.sid}">
                                <input type="hidden" name="commentId" value="${comment.commentid}">
                                <label><span>回覆內容:</span>
                                    <textarea id="replyContent${comment.commentid}" name="replyContent" rows="10" cols="30" maxlength="100" placeholder="Your Reply" required></textarea>
                                </label>
                                <span class="replyContent${comment.commentid}" id="replyContent" data->輸入的字數:0/100</span><br />
                                <div class="bit-com">
                                    評分:<span class="bit" id="bit1"></span> <span class="bit" id="bit2"></span> <span class="bit" id="bit3"></span> <span class="bit" id="bit4"></span> <span class="bit" id="bit5"></span>
                                </div>
                                <input type="hidden" name="rate" id="replyRate${comment.commentid}" value="0">
                                <label><span>&nbsp;</span><input type="submit" class="button" value="Send Reply" /></label>
                            </form>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </div>

        <!-- 四星評論 -->
        <div class="tab-pane fade" id="four-star" role="tabpanel" aria-labelledby="four-star-tab">
            <c:forEach items="${comments}" var="comment">
                <c:if test="${comment.buyerrate == 4}">
                    <!-- 评论内容展示 -->
                    <div class="item" data-comment-id="${comment.commentid}">
                        <!-- 评论内容展示 -->
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
                                        <img class="product-photo" src="${pageContext.request.contextPath}/${comment.productphoto}" alt="產品圖片" width="60px" height="60px">
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <div class="no-image"></div>
                                </c:otherwise>
                            </c:choose>
                            <p class="text">${comment.commentcontent}</p>
                        </div>
                        <!-- 回覆按鈕 -->
                        <button class="reply-btn" onclick="toggleReplyForm('${comment.commentid}')">回覆</button>
                        <!-- 回覆表單 -->
                        <div id="replyFormContainer${comment.commentid}" style="display: none;">
                            <form action="/submitReply" method="post" class="bootstrap-frm" id="replyForm${comment.commentid}">
                                <span class="close-btn" onclick="closeReplyForm('${comment.commentid}')">×</span>
                                <h1 id="alter">
                                    回覆<span>請填寫回覆內容</span>
                                </h1>
                                <input type="hidden" name="memberId" value="${comment.member.sid}">
                                <input type="hidden" name="commentId" value="${comment.commentid}">
                                <label><span>回覆內容:</span>
                                    <textarea id="replyContent${comment.commentid}" name="replyContent" rows="10" cols="30" maxlength="100" placeholder="Your Reply" required></textarea>
                                </label>
                                <span class="replyContent${comment.commentid}" id="replyContent" data->輸入的字數:0/100</span><br />
                                <div class="bit-com">
                                    評分:<span class="bit" id="bit1"></span> <span class="bit" id="bit2"></span> <span class="bit" id="bit3"></span> <span class="bit" id="bit4"></span> <span class="bit" id="bit5"></span>
                                </div>
                                <input type="hidden" name="rate" id="replyRate${comment.commentid}" value="0">
                                <label><span>&nbsp;</span><input type="submit" class="button" value="Send Reply" /></label>
                            </form>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </div>

        <!-- 三星評論 -->
        <div class="tab-pane fade" id="three-star" role="tabpanel" aria-labelledby="three-star-tab">
            <c:forEach items="${comments}" var="comment">
                <c:if test="${comment.buyerrate == 3}">
                    <!-- 评论内容展示 -->
                    <div class="item" data-comment-id="${comment.commentid}">
                        <!-- 评论内容展示 -->
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
                                        <img class="product-photo" src="${pageContext.request.contextPath}/${comment.productphoto}" alt="產品圖片" width="60px" height="60px">
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <div class="no-image"></div>
                                </c:otherwise>
                            </c:choose>
                            <p class="text">${comment.commentcontent}</p>
                        </div>
                        <!-- 回覆按鈕 -->
                        <button class="reply-btn" onclick="toggleReplyForm('${comment.commentid}')">回覆</button>
                        <!-- 回覆表單 -->
                        <div id="replyFormContainer${comment.commentid}" style="display: none;">
                            <form action="/submitReply" method="post" class="bootstrap-frm" id="replyForm${comment.commentid}">
                                <span class="close-btn" onclick="closeReplyForm('${comment.commentid}')">×</span>
                                <h1 id="alter">
                                    回覆<span>請填寫回覆內容</span>
                                </h1>
                                <input type="hidden" name="memberId" value="${comment.member.sid}">
                                <input type="hidden" name="commentId" value="${comment.commentid}">
                                <label><span>回覆內容:</span>
                                    <textarea id="replyContent${comment.commentid}" name="replyContent" rows="10" cols="30" maxlength="100" placeholder="Your Reply" required></textarea>
                                </label>
                                <span class="replyContent${comment.commentid}" id="replyContent" data->輸入的字數:0/100</span><br />
                                <div class="bit-com">
                                    評分:<span class="bit" id="bit1"></span> <span class="bit" id="bit2"></span> <span class="bit" id="bit3"></span> <span class="bit" id="bit4"></span> <span class="bit" id="bit5"></span>
                                </div>
                                <input type="hidden" name="rate" id="replyRate${comment.commentid}" value="0">
                                <label><span>&nbsp;</span><input type="submit" class="button" value="Send Reply" /></label>
                            </form>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </div>

        <!-- 二星評論 -->
        <div class="tab-pane fade" id="two-star" role="tabpanel" aria-labelledby="two-star-tab">
            <c:forEach items="${comments}" var="comment">
                <c:if test="${comment.buyerrate == 2}">
                    <!-- 评论内容展示 -->
                    <div class="item" data-comment-id="${comment.commentid}">
                        <!-- 评论内容展示 -->
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
                                        <img class="product-photo" src="${pageContext.request.contextPath}/${comment.productphoto}" alt="產品圖片" width="60px" height="60px">
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <div class="no-image"></div>
                                </c:otherwise>
                            </c:choose>
                            <p class="text">${comment.commentcontent}</p>
                        </div>
                        <!-- 回覆按鈕 -->
                        <button class="reply-btn" onclick="toggleReplyForm('${comment.commentid}')">回覆</button>
                        <!-- 回覆表單 -->
                        <div id="replyFormContainer${comment.commentid}" style="display: none;">
                            <form action="/submitReply" method="post" class="bootstrap-frm" id="replyForm${comment.commentid}">
                                <span class="close-btn" onclick="closeReplyForm('${comment.commentid}')">×</span>
                                <h1 id="alter">
                                    回覆<span>請填寫回覆內容</span>
                                </h1>
                                <input type="hidden" name="memberId" value="${comment.member.sid}">
                                <input type="hidden" name="commentId" value="${comment.commentid}">
                                <label><span>回覆內容:</span>
                                    <textarea id="replyContent${comment.commentid}" name="replyContent" rows="10" cols="30" maxlength="100" placeholder="Your Reply" required></textarea>
                                </label>
                                <span class="replyContent${comment.commentid}" id="replyContent" data->輸入的字數:0/100</span><br />
                                <div class="bit-com">
                                    評分:<span class="bit" id="bit1"></span> <span class="bit" id="bit2"></span> <span class="bit" id="bit3"></span> <span class="bit" id="bit4"></span> <span class="bit" id="bit5"></span>
                                </div>
                                <input type="hidden" name="rate" id="replyRate${comment.commentid}" value="0">
                                <label><span>&nbsp;</span><input type="submit" class="button" value="Send Reply" /></label>
                            </form>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </div>

        <!-- 一星評論 -->
        <div class="tab-pane fade" id="one-star" role="tabpanel" aria-labelledby="one-star-tab">
            <c:forEach items="${comments}" var="comment">
                <c:if test="${comment.buyerrate == 1}">
                    <!-- 评论内容展示 -->
                    <div class="item" data-comment-id="${comment.commentid}">
                        <!-- 评论内容展示 -->
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
                                        <img class="product-photo" src="${pageContext.request.contextPath}/${comment.productphoto}" alt="產品圖片" width="60px" height="60px">
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <div class="no-image"></div>
                                </c:otherwise>
                            </c:choose>
                            <p class="text">${comment.commentcontent}</p>
                        </div>
                        <!-- 回覆按鈕 -->
                        <button class="reply-btn" onclick="toggleReplyForm('${comment.commentid}')">回覆</button>
                        <!-- 回覆表單 -->
                        <div id="replyFormContainer${comment.commentid}" style="display: none;">
                            <form action="/submitReply" method="post" class="bootstrap-frm" id="replyForm${comment.commentid}">
                                <span class="close-btn" onclick="closeReplyForm('${comment.commentid}')">×</span>
                                <h1 id="alter">
                                    回覆<span>請填寫回覆內容</span>
                                </h1>
                                <input type="hidden" name="memberId" value="${comment.member.sid}">
                                <input type="hidden" name="commentId" value="${comment.commentid}">
                                <label><span>回覆內容:</span>
                                    <textarea id="replyContent${comment.commentid}" name="replyContent" rows="10" cols="30" maxlength="100" placeholder="Your Reply" required></textarea>
                                </label>
                                <span class="replyContent${comment.commentid}" id="replyContent" data->輸入的字數:0/100</span><br />
                                <div class="bit-com">
                                    評分:<span class="bit" id="bit1"></span> <span class="bit" id="bit2"></span> <span class="bit" id="bit3"></span> <span class="bit" id="bit4"></span> <span class="bit" id="bit5"></span>
                                </div>
                                <input type="hidden" name="rate" id="replyRate${comment.commentid}" value="0">
                                <label><span>&nbsp;</span><input type="submit" class="button" value="Send Reply" /></label>
                            </form>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </div>
    </div>
</div>




<!-- 分頁連結 -->
<div class="tab" style="text-align: center; margin-top: 20px;">
    <ul class="pagination justify-content-center" style="margin-left: -20px;">
        <c:forEach begin="1" end="${totalPages}" var="pageNumber">
            <li class="page-item" style="margin-right: 5px;">
                <a class="page-link ${pageNumber eq currentPage + 1 ? 'active' : ''}" href="?page=${pageNumber - 1}">${pageNumber}</a>
            </li>
        </c:forEach>
    </ul>
</div>

<script>


    function toggleReplyForm(commentId) {
        var formContainer = document.getElementById('replyFormContainer' + commentId);
        if (formContainer.style.display === 'none') {
            formContainer.style.display = 'block';
        } else {
            formContainer.style.display = 'none';
        }
    }

    function closeReplyForm(commentId) {
        var formContainer = document.getElementById('replyFormContainer' + commentId);
        formContainer.style.display = 'none';
    }
</script>

<script>
// 定義變數 rating，初始值為 0
var rating = 0;

// 當點擊星星時觸發事件
$('body').on('click', '.bit-com .bit', function() {
    // 移除同級元素的 on 類，並為當前元素及其前面的所有元素添加 on 類
    $(this).siblings().removeClass('on');
    $(this).prevAll().addBack().addClass('on');
    
    // 獲取星星的索引位置，並將索引值加一賦值給 rating
    var index = $(this).index() + 1;
    rating = index;
});

// 當提交表單時觸發事件
$('body').on('submit', '.bootstrap-frm', function() {
    // 獲取評論的 commentid
    var commentId = $(this).attr('id').replace('replyForm', '');
    
    // 將評分值設置到相應的 hidden input 中
    $('#replyRate' + commentId).val(rating);

    // 如果評分小於 1，則彈出提示框並返回 false
    if (rating < 1) {
        alert('請選擇服務1~5顆星之間的評分值');
        return false;
    }
});
</script>

<script>
    $(document).ready(function () {
        $(".nav-link").click(function () {
            $(".nav-link").removeClass("active");
            $(this).addClass("active");
            $(".tab-pane").removeClass("show active");
            $($(this).attr("href")).addClass("show active");
        });
    });
</script>
</body>
</html>