<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Replied Comments</title>
</head>
<body>
    <!-- 遍历卖家回复的评论 -->
    <c:forEach items="${repliedComments}" var="seller">
        <div>
            <!-- 显示卖家回复内容 -->
            <p>卖家姓名: ${seller.member.name}</p>
            <p>回复内容: ${seller.replayconetnt}</p>
            <p>
                <c:forEach begin="1" end="${seller.sellerrate}">
                    <img src="commentPicture/output.png" alt="star" width="20" height="20">
                </c:forEach>
            </p>
            
            <!-- 遍历对应的买家评论 -->
            <c:forEach items="${sellerCommentsForUser}" var="buyer">
                <!-- 如果买家评论与当前卖家回复匹配，则显示买家评论信息 -->
                <c:if test="${buyer.commentid eq seller.repliedcommentid}">
                    <p>买家姓名: ${buyer.member.name}</p>
                    <p>买家评论内容: ${buyer.commentcontent}</p>
                    <p>买家评论时间: ${buyer.commenttime}</p>
                    <!-- 如果存在产品图片，则显示 -->
                    <c:if test="${not empty buyer.productphoto}">
                        <img src="${buyer.productphoto}" alt="产品图片">
                    </c:if>
                    <!-- 显示买家评分 -->
                    <p>买家评分:
                        <c:forEach begin="1" end="${buyer.buyerrate}">
                            <img src="commentPicture/output.png" alt="star" width="20" height="20">
                        </c:forEach>
                    </p>
                </c:if>
            </c:forEach>
        </div>
    </c:forEach>

    <!-- 显示分页按钮 -->
    <c:if test="${totalPages > 1}">
        <div>
            <c:if test="${currentPage > 0}">
                <a href="?page=${currentPage - 1}">上一頁</a>
            </c:if>

            <c:forEach begin="0" end="${totalPages - 1}" var="i">
                <c:choose>
                    <c:when test="${i == currentPage}">
                        <span>${i + 1}</span>
                    </c:when>
                    <c:otherwise>
                        <a href="?page=${i}">${i + 1}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <c:if test="${currentPage < totalPages - 1}">
                <a href="?page=${currentPage + 1}">下一頁</a>
            </c:if>
        </div>
    </c:if>
</body>
</html>