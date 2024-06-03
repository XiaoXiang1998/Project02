
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
   .comment-container {
    width: 80%; 
    margin: 20px auto; 
    border: 3px solid #ccc; 
        border-radius: 10px; 
    
    padding: 10px; 
    background-color: #f9f9f9; 
}

.comment-container + .comment-container {
    margin-top: 20px; 
}

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
    function filterComments(rating) {
        var comments = document.getElementsByClassName('comment-container');
        if (rating === 'all') {
            for (var i = 0; i < comments.length; i++) {
                comments[i].style.display = 'block';
            }
        } else {
            for (var i = 0; i < comments.length; i++) {
                var comment = comments[i];
                var commentRating = parseInt(comment.classList[1].substring(6)); 
                if (commentRating === rating) {
                    comment.style.display = 'block';
                } else {
                    comment.style.display = 'none';
                }
            }
        }
    }

    window.onload = function() {
        filterComments('all');
    }
</script>

<script>
  var btns = document.querySelectorAll('.tab button');

  btns.forEach(function(btn) {
    btn.addEventListener('click', function() {
      btns.forEach(function(b) {
        b.classList.remove('active');
      });
      this.classList.add('active');
    });
  });
</script>
</body>
</html>