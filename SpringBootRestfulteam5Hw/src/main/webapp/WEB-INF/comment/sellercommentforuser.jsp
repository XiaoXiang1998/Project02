
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
<button id="fiveStarBtn" class="tablinks" onclick="filterComments(5)">5顆星 (${ratingCounts.get(5)})</button>
<button id="fourStarBtn" class="tablinks" onclick="filterComments(4)">4顆星 (${ratingCounts.get(4)})</button>
<button id="threeStarBtn" class="tablinks" onclick="filterComments(3)">3顆星 (${ratingCounts.get(3)})</button>
<button id="twoStarBtn" class="tablinks" onclick="filterComments(2)">2顆星 (${ratingCounts.get(2)})</button>
<button id="oneStarBtn" class="tablinks" onclick="filterComments(1)">1顆星 (${ratingCounts.get(1)})</button>
</div>

		<!-- 循环显示评论 -->
<c:forEach var="comment" items="${sellerComments}">
    <div class="comment-container comment-container rating${comment.sellerrate}">
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


<script>
    // 根据评分级别过滤评论
    function filterComments(rating) {
        var comments = document.getElementsByClassName('comment-container');
        if (rating === 'all') {
            for (var i = 0; i < comments.length; i++) {
                comments[i].style.display = 'block';
            }
        } else {
            for (var i = 0; i < comments.length; i++) {
                var comment = comments[i];
                var commentRating = parseInt(comment.classList[1].substring(6)); // 获取评论的评分级别
                if (commentRating === rating) {
                    comment.style.display = 'block';
                } else {
                    comment.style.display = 'none';
                }
            }
        }
    }

    // 页面加载后重新显示评论内容
    window.onload = function() {
        filterComments('all');
    }
</script>

<script>
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
    });
  });
</script>
</body>
</html>
