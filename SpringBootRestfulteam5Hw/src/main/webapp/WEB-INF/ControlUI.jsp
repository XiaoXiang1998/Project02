<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.member.model.MemberBean"  %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html>
<html>
<head>
<script src="https://kit.fontawesome.com/f5d8105b16.js" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>總管理頁面</title>
<style>
        * {
            margin: 0;
            padding: 0;
            list-style: none;
        }

        html,
        body {
            height: 100%;
        }

        body {
            background-color: rgb(255, 179, 116);
        }

        .side-menu {
            width: 300px;
            height: 100%;
            padding: 50px 0;
            box-sizing: border-box;
            background-image: linear-gradient(0deg, white, rgb(255, 137, 41));
            display: flex;
            flex-direction: column;
            box-shadow: 5px 0px 10px hsla(240, 40%, 20%, .6);
        }

        nav a {
            display: block;
            padding: 10px;
            color: white;
            font-weight: bold;
            text-decoration: none;
            position: relative;
        }

        nav a+a::before {
            content: "";
            position: absolute;
            border-top: 1px solid #fff;
            left: 10px;
            right: 10px;
            top: 0;
        }

        nav a .fa {
            transition: transform 0.3s ease, margin-right 0.3s ease;
            /* 添加平滑過渡效果 */
            margin-right: -1.1em;
            transform: scale(0);
        }

        nav a:hover .fa {
            margin-right: 0;
            /* 懸停時右邊距歸零 */
            transform: scale(1);
        }
    </style>
</head>
<body>
<div class="side-menu">
        <nav>
            <a href="goToAdminUI"><i class="fa fa-solid fa-users"></i>會員管理</a>
            <a href="goodqueryallpage.controller"><i class="fa fa-solid fa-cart-shopping"></i>商品管理</a>
            
            <a href="goindex.controller"><i class="fa fa-solid fa-clipboard"></i>訂單管理</a>
			<a href="#" onclick="handleCommentManagement()"><i class="fa fa-regular fa-comments"></i>評論管理</a>
            <a href="#"><i class="fa fa-solid fa-chart-line"></i>活動管理</a>
            <a href="Crudindex"><i class="fa fa-solid fa-user-xmark"></i>申訴管理</a>
            <a href="logOut"><i class="fa fa-solid fa-right-from-bracket"></i>登出</a>
        </nav>
    </div>
    
    <script>
    var isSeller = <%= session.getAttribute("member") != null && ((MemberBean)session.getAttribute("member")).isSeller() %>;
    
    function handleCommentManagement() {
        if (isSeller) {
            window.location.href = "sellerComments";
        } else {
            window.location.href = "indexcomment";
        }
    }
</script>
</body>
</html>