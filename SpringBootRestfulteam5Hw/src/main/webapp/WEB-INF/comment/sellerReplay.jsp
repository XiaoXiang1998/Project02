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
    position: relative;

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
    overflow: hidden; 
    vertical-align: middle;
}

.avatar img {
    width: 100%;
    height: 100%;
    object-fit: cover; 
}

.info {

      display: inline-block;
    vertical-align: top;
    width: calc(100% - 70px);
    position: relative;
}

.time-and-details {
        flex-grow: 1; 
        display: flex;
        flex-direction: row;
    }
    .order-details {
        margin-right: 10px; 
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
	    margin-right: 5px; 
	
}

.separator {
    margin-right: 5px; 
    margin-left: 5px; 
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
.rating-tab .btn {
    border: 1px solid rgba(0, 0, 0, 0.2);
    border-radius: 5px;
    background-color: transparent;
    outline: none;
    cursor: pointer;
    padding: 10px 15px;
    transition: background-color 0.3s;
    margin: 0 5px; 
    text-align: center;
}

.rating-tab .btn.active {
    background-color: #007bff; 
    color: #fff; 
}

.rating-tab .btn:hover {
    background-color: rgba(0, 0, 0, 0.1); 
}

/.custom-pagination-container {
    text-align: center;
    margin-top: 20px;
}

.custom-pagination {
    list-style: none;
    padding: 0;
    display: inline-block; 
}

.custom-page-item {
    display: inline-block;
    margin-right: 5px; 
}

.custom-page-link {
    padding: 5px 10px;
    background-color: #eee;
    border: 1px solid #ccc;
    text-decoration: none;
    color: #333;
    cursor: pointer;
}

.custom-page-link:hover {
    background-color: #ddd;
}

.custom-page-link.active {
    background-color: #007bff;
    color: #fff;
}
</style>
</head>
<body>
			<%@ include file="../FrontDeskNav.jsp"%>
	
	
	<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="form-group">
                <label for="productName">商品名稱</label>
                <input type="text" class="form-control" id="productName" name="productName" placeholder="商品名稱">
            </div>
            <div class="form-group">
                <label for="productSpec">規格尺寸</label>
                <input type="text" class="form-control" id="productSpec" name="productSpec" placeholder="規格尺寸">
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label for="userName">用戶名稱</label>
                <input type="text" class="form-control" id="userName" name="userName" placeholder="用戶名稱">
            </div>
            <div class="form-group">
                <label for="commentTime">評論時間</label>
                <input type="date" class="form-control" id="commentTime" name="commentTime">
            </div>
        </div>
    </div>
    <div class="row mt-3">
        <div class="col-md-6 offset-md-3 text-center">
            <button type="button" class="btn btn-primary" onclick="searchComments()">搜索</button>
                        <button type="button" class="btn btn-secondary" onclick="resetForm()">重置</button>
            
        </div>
    </div>
</div>
	
<div class="rating-tab" style="text-align: center; margin-top: 20px;">
    <ul class="nav nav-pills justify-content-center">
        <li class="nav-item">
            <button class="btn ${rating eq 0 ? 'active' : ''}" onclick="viewAllComments()">全部(${totalComments})</button>
        </li>
        <c:forEach begin="1" end="5" var="i">
            <li class="nav-item">
                <button class="btn ${rating eq i ? 'active' : ''}" onclick="filterByRating(${i})">${i}顆星(${starCounts[i-1]})</button>
            </li>
        </c:forEach>
    </ul>
</div>
	<div id="commentAndPaginationContainer">
	<div class="container" id="commentContainer">
    <c:forEach items="${comments}" var="comment">
        <div class="item" data-comment-id="${comment.commentid}">
		<i class="avatar"><img src="${comment.member.photoSticker}"/></i>
            <div class="info">
                <p class="name">${comment.member.name}</p>                
                    <c:forEach begin="1" end="${comment.buyerrate}">
                        <img src="commentPicture/output.png" alt="star" width="20" height="20">
                    </c:forEach>
                </p>
                <div class="time-and-details">
                    <c:if test="${not empty comment.commenttime}">
                        <fmt:formatDate value="${comment.commenttime}" pattern="yyyy-MM-dd HH:mm" var="formattedCommentTime" />
                        <p class="time">${formattedCommentTime}</p>
                    </c:if>
                    <p class="order-details"><span class="separator">|</span>訂單編號: ${comment.orders.orderId}</p>
                    <p class="order-details">規格尺寸: ${comment.orders.formatgoodId.goodSize}</p>
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
               <c:if test="${!repliedCommentIds.contains(comment.commentid)}">
        <button class="reply-btn" onclick="toggleReplyForm('${comment.commentid}')">回覆</button>
    </c:if>
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
                            <textarea id="replyContent${comment.commentid}" name="replyContent" rows="10" cols="30" maxlength="100" placeholder="Your Reply"  required></textarea>
                        </label>
                        <span class="replyContent${comment.commentid}" id="replyContent" >輸入的字數:0/100</span><br />
                        <div class="bit-com">
                            評分:<span class="bit" id="bit1"></span> <span class="bit" id="bit2"></span> <span class="bit" id="bit3"></span> <span class="bit" id="bit4"></span> <span class="bit" id="bit5"></span>
                        </div>
                        <input type="hidden" name="rate" id="replyRate${comment.commentid}" value="0">
                        <label><span>&nbsp;</span><input type="submit" class="button" value="Send Reply" /></label>
                    </form>
                </div>
        </div>
    </c:forEach>
    <!-- 分页链接 -->
<div class="custom-pagination-container" style="text-align: center; margin-top: 20px;" id="pagination">
    <ul class="custom-pagination" style="list-style: none; padding: 0; display: inline-block;">
        <c:forEach begin="1" end="${totalPages}" var="pageNumber">
            <li class="custom-page-item" style="display: inline-block; margin-right: 5px;">
                <button class="custom-page-link" data-page="${pageNumber}" onclick="filterByPage(${pageNumber})">${pageNumber}</button>
            </li>
        </c:forEach>
    </ul>
</div>
</div>
</div>


			<%@ include file="../FrontDeskFooter.jsp"%>


<script>


    function toggleReplyForm(commentId) {
        var formContainer = document.getElementById('replyFormContainer' + commentId);
        if (formContainer.style.display === 'none') {
            formContainer.style.display = 'block';
            
            // Set default reply value when showing the form
            var textarea = document.getElementById('replyContent' + commentId);
            if (textarea.value.trim() === '') {
                textarea.value = "感謝您的支持喔!";
            }
            
            
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
var rating = 0;

$('body').on('click', '.bit-com .bit', function() {
    $(this).siblings().removeClass('on');
    $(this).prevAll().addBack().addClass('on');
    
    var index = $(this).index() + 1;
    rating = index;
});

$('body').on('submit', '.bootstrap-frm', function() {
    var commentId = $(this).attr('id').replace('replyForm', '');
    
    $('#replyRate' + commentId).val(rating);

    if (rating < 1) {
        alert('請選擇服務1~5顆星之間的評分值');
        return false;
    }
});


</script>

<script>
$('body').on(
		'input',
		'textarea[id^="replyContent"]',
		function() {
			var commentId = $(this).attr('id').replace(
					'replyContent', '');
			var text = $(this).val();
			var charCount = text.length;
			$('.replyContent' + commentId).text(
					'輸入的字數:' + charCount + '/100');
			if (charCount > 100) {
				$(this).val(text.slice(0, 100));
				$('.replyContent' + commentId)
						.text('輸入的字數:100/100');
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

<script>
var rating = 0;
var currentPage = 1; 
var lastSearch = {}; // 保存上一次搜索的条件

function filterByRating(ratingValue) {
    rating = ratingValue; 
    currentPage = 1; 
    console.log("Rating: " + rating); 
    
    $('.nav-pills .btn').removeClass('active'); 
    $('.nav-pills .btn').eq(ratingValue).addClass('active'); 

    $('.pagination .page-item').removeClass('active'); 
    $('.pagination .page-btn[data-page="1"]').parent().addClass('active'); 
	
    $('#productName').val('');
    $('#productSpec').val('');
    $('#userName').val('');
    $('#commentTime').val('');
    lastSearch = {}; 

    
    
    
    filterComments(); 
}

// 分页链接
function filterByPage(pageNumber) {
    console.log("Clicked page " + pageNumber); 
    currentPage = pageNumber;
    
    $('.pagination .page-item').removeClass('active'); 
    $('.pagination .page-btn[data-page="' + pageNumber + '"]').parent().addClass('active'); 
    
    filterComments(); 
}

function viewAllComments() {
    rating = 0; 
    currentPage = 1; 

    $('.nav-pills .btn').removeClass('active'); 
    $('.nav-pills .btn').eq(0).addClass('active'); 

    $('.pagination .page-item').removeClass('active'); 
    
    $('#productName').val('');
    $('#productSpec').val('');
    $('#userName').val('');
    $('#commentTime').val('');

    lastSearch = {}; 
    
    filterComments(); 
}

function searchComments() {
    currentPage = 1; 

    $('.nav-pills .btn').removeClass('active');
    
    lastSearch = { 
        rating: rating,
        productName: $('#productName').val(),
        productSpec: $('#productSpec').val(),
        userName: $('#userName').val(),
        commentTime: $('#commentTime').val()
    };
    
    filterComments(); 
    
    $('#productName').val('');
    $('#productSpec').val('');
    $('#userName').val('');
    $('#commentTime').val('');
}

function filterComments() {
    var productName = lastSearch.productName || $('#productName').val();
    var productSpec = lastSearch.productSpec || $('#productSpec').val();
    var userName = lastSearch.userName || $('#userName').val();
    console.log("User Name: " + userName); 
    var commentTime = lastSearch.commentTime || $('#commentTime').val();

    $.ajax({
        type: "GET",
        url: "/sellerComments",
        data: {
            page: currentPage - 1, 
            rating: lastSearch.rating || rating,
            productName: productName,
            productSpec: productSpec,
            userName: userName,
            commentTime: commentTime
        },
        success: function (data) {
            $('#commentContainer').html($(data).find('#commentContainer').html());
            $('#pagination').html($(data).find('#pagination').html());
            
            maskNameFunction();
        },
        error: function() {
        }
    });
}

document.addEventListener("DOMContentLoaded", function() {
    maskNameFunction();
    setDefaultReplyValues();
   
});

function setDefaultReplyValues() {
    var defaultReply = "感謝您的支持喔!";

    document.querySelectorAll('.bootstrap-frm').forEach(function (form) {
        var commentId = form.id.replace('replyForm', '');
        console.log(commentId);

        var textareaId = "replyContent" + commentId;

        document.getElementById(textareaId).innerText = defaultReply;
    });
}

function resetForm() {
    $('#productName').val('');
    $('#productSpec').val('');
    $('#userName').val('');
    $('#commentTime').val('');
}

function maskNameFunction() {
    document.querySelectorAll('.name').forEach(function(nameElement) {
        let name = nameElement.innerText;
        if (name.length === 3) {
            let maskedName = maskName(name);
            nameElement.innerText = maskedName;
        }
    });
}

function maskName(name) {
    if (name.length !== 3) {
        return name; 
    }
    let firstChar = name.charAt(0);
    let lastChar = name.charAt(2);
    return firstChar + '***' + lastChar; 
}

</script>


</body>
</html>