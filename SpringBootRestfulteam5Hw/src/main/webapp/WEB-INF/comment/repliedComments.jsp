<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Replied Comments</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.3/css/lightbox.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.3/js/lightbox.min.js"></script>

	<style>
	.seller-reply {
	    background-color: #f9f9f9;
	    padding: 20px;
	    margin-bottom: 20px;
	}
	
	.buyer-comment {
	    background-color: #e3f2fd;
	    padding: 10px;
	    margin-bottom: 20px;
	}
	
	.pagination-container {
	    text-align: center;
	    margin-top: 20px;
	}
	
	.pagination-container a {
	    display: inline-block;
	    padding: 5px 10px;
	    margin-right: 5px;
	    border: 1px solid #ccc;
	    border-radius: 3px;
	    text-decoration: none;
	    color: #333;
	    background-color: #fff;
	}
	
	.pagination-container a:hover {
	    background-color: #f0f0f0;
	}
	
	.time-and-details {
	        flex-grow: 1; 
	        display: flex;
	        flex-direction: row;
	    }
	    .order-details {
	        margin-right: 10px;
	    }
	    
	    .time{
		    margin-right: 5px; 
		
	}
	
	.separator {
	    margin-right: 5px; 
	    margin-left: 5px; 
	}
	.name {
		color: #FB7299;
		font-size: 16px;
		font-weight: bold;
		margin: 0 0 10px 0;
	}

.sellerrate {
    margin: 10px 0;
}
.reply-content {
    margin-top: 10px; 
}
.avatar {
    width: 50px;
    height: 50px;
    background-color: #ccc;
    border-radius: 50%;
    display: inline-block;
    margin-right: 20px;
    overflow: hidden; 
    vertical-align: middle; 
}

.avatar img {
    width: 100%;
    height: 100%;
    object-fit: cover; 
}

</style>
</head>
<body>

				<%@ include file="../FrontDeskNav.jsp"%>
	
<div class="row">
	<div class="col">
		<ul class="nav nav-tabs">
			<li class="nav-item">
				<span class="nav-link" style="font-weight: bold; color: black; font-size: 22px; position: relative; top: 10px;">
					${averageScore}
				</span>
				<span class="nav-link" style="position: relative; top: -5px;">
					<c:forEach begin="1" end="${averageScore}">
						<img src="commentPicture/output.png" alt="star" class="star-img" width="20" height="20">
					</c:forEach>
				</span>
			</li>
		</ul>
	</div>
</div>
	
	
<c:forEach items="${repliedComments}" var="seller">
    <div class="seller-reply">
    <i class="avatar"><img src="${seller.member.photoSticker}"/></i>
        <p class="name">${seller.member.name}</p>
        <c:forEach begin="1" end="${seller.sellerrate}">
                <img src="commentPicture/output.png" alt="star" width="20" height="20"  class="sellerrate">
            </c:forEach>
        <p class="reply-content">${seller.replayconetnt}</p>
        <p>
            
        </p>
         <c:if test="${not empty seller.replaytime}">
                        <fmt:formatDate value="${seller.replaytime}" pattern="yyyy-MM-dd HH:mm" var="formattedCommentTime" />
                        <p class="time">${formattedCommentTime}</p>
                    </c:if>

        <c:forEach items="${sellerCommentsForUser}" var="buyer">
            <c:if test="${buyer.commentid eq seller.repliedcommentid}">
                <div class="buyer-comment">
                    <i class="avatar"><img src="${buyer.member.photoSticker}"/></i>
                
                    <p class="name"> ${buyer.member.name}</p>
                    <p>
                        <c:forEach begin="1" end="${buyer.buyerrate}">
                            <img src="commentPicture/output.png" alt="star" width="20" height="20">
                        </c:forEach>
                    </p>
                    <p> ${buyer.commentcontent}</p>
                   <div class="time-and-details">
                <c:if test="${not empty buyer.commenttime}">
                        <fmt:formatDate value="${buyer.commenttime}" pattern="yyyy-MM-dd HH:mm" var="formattedCommentTime" />
                        <p class="time">${formattedCommentTime}</p>
                    </c:if>
                    <p class="order-details"><span class="separator">|</span>訂單編號: ${buyer.orders.orderId}</p>
                    <p class="order-details">規格尺寸: ${buyer.orders.formatgoodId.goodSize}</p>
                    <p class="order-details">商品名稱: ${buyer.orders.formatgoodId.good.goodsName}</p>
                </div>
                     <c:choose>
                    <c:when test="${not empty buyer.productphoto}">
                        <a href="${pageContext.request.contextPath}/${buyer.productphoto}" data-lightbox="product-images-${buyer.commentid}">
                            <img class="product-photo" src="${pageContext.request.contextPath}/${buyer.productphoto}" alt="產品圖片" width="100px" height="100px">
                        </a>
                    </c:when>
                    <c:otherwise>
                        <div class="no-image"></div>
                    </c:otherwise>
                </c:choose>                    
                </div>
            </c:if>
        </c:forEach>
    </div>
</c:forEach>

    <c:if test="${totalPages > 1}">
        <div  class="pagination-container">
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

           
        </div>
    </c:if>
			<%@ include file="../FrontDeskFooter.jsp"%>

</body>
</html>