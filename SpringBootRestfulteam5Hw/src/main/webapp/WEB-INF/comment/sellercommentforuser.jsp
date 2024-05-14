
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

/* 标签按钮样式 */
  .tab {
    text-align: center;
  }

  .tab button {
    background-color: transparent;
    border: none;
    outline: none;
    cursor: pointer;
    padding: 10px 20px;
    margin: 0 5px;
    transition: background-color 0.3s, color 0.3s;
    border-radius: 20px;
    border: 2px solid #ccc;
  }

  .tab button:hover {
    background-color: #ddd;
  }

  .tab button.active {
    background-color: #ccc;
    color: white;
  }
  

</style>
</head>
<body>
		<%@ include file="indexcomment.jsp" %>
		
<div class="tab">
    ${avergeScore}
<button id="allBtn" class="tablinks active" onclick="filterComments('all')">全部(${totalCommentsCount})</button>
<button id="fiveStarBtn" class="tablinks" onclick="filterComments(5)">5顆星 (${ratingCounts.size() > 4 ? ratingCounts[4] : 0})</button>
<button id="fourStarBtn" class="tablinks" onclick="filterComments(4)">4顆星 (${ratingCounts.size() > 3 ? ratingCounts[3] : 0})</button>
<button id="threeStarBtn" class="tablinks" onclick="filterComments(3)">3顆星 (${ratingCounts.size() > 2 ? ratingCounts[2] : 0})</button>
<button id="twoStarBtn" class="tablinks" onclick="filterComments(2)">2顆星 (${ratingCounts.size() > 1 ? ratingCounts[1] : 0})</button>
<button id="oneStarBtn" class="tablinks" onclick="filterComments(1)">1顆星 (${ratingCounts.size() > 0 ? ratingCounts[0] : 0})</button>
</div>
<div id="sellerCommentsContainer">

		<!-- 循环显示评论 -->
<c:forEach var="comment" items="${sellerComments}">
    <div class="comment-container comment-container rating${comment.sellerrate}" >
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
                    <!-- 获取规格尺寸 -->
            <c:forEach var="goods" items="${comment.member.goods2}">
                <c:forEach var="format" items="${goods.format}">
                    <p class="order-details">規格尺寸: ${format.goodSize}</p>
                    <p class="order-details">商品名稱: ${goods.goodsName}</p>
                </c:forEach>
            </c:forEach>
                </div>
        <p>${comment.replayconetnt}</p>
    </div>
</c:forEach>
	</div>
<!-- 分页部件 -->
<nav aria-label="Page navigation">
    <ul class="pagination">
        <li class="page-item">
            <c:if test="${page > 0}">
                <a class="page-link" href="#" aria-label="Previous" onclick="filterComments(${rating}, ${page - 1})">
                    <span aria-hidden="true">&laquo;</span>
                    <span class="sr-only">Previous</span>
                </a>
            </c:if>
        </li>
        <c:forEach var="i" begin="0" end="${totalPages - 1}">
            <li class="page-item">
                <c:choose>
                    <c:when test="${i == page}">
                        <span class="page-link current">${i + 1}</span>
                    </c:when>
                    <c:otherwise>
                        <a class="page-link" href="#" onclick="filterComments(${rating}, ${i})">${i + 1}</a>
                    </c:otherwise>
                </c:choose>
            </li>
        </c:forEach>
        <li class="page-item">
            <c:if test="${page < totalPages - 1}">
                <a class="page-link" href="#" aria-label="Next" onclick="filterComments(${rating}, ${page + 1})">
                    <span aria-hidden="true">&raquo;</span>
                    <span class="sr-only">Next</span>
                </a>
            </c:if>
        </li>
    </ul>
</nav>		

<script>
// 页面加载后重新显示评论内容
window.onload = function() {
    // 页面加载后默认获取全部评论
    filterComments('all', 0);
}

// 根据评分级别过滤评论并进行分页处理
function filterComments(rating, page) {
    $.ajax({
        type: "GET",
        url: "/sellerCommentsForUser",
        data: {
            page: page,
            rating: rating
        },
        success: function(response) {
            // 将获取到的评论内容替换原有的评论内容
            $("#sellerCommentsContainer").html(response);
        }
    });
}

// 获取所有按钮元素
var btns = document.querySelectorAll('.tab button');

// 为每个按钮添加点击事件监听器
btns.forEach(function(btn) {
    btn.addEventListener('click', function() {
        // 移除所有按钮的 active 类
        btns.forEach(function(b) {
            b.classList.remove('active');
        });
        // 将当前点击的按钮添加 active 类
        this.classList.add('active');
        // 获取当前点击的按钮的评分级别
        var rating = this.innerText.charAt(0);
        // 过滤评论并进行分页处理
        filterComments(rating, 0);
    });
});
</script>
</body>
</html>
