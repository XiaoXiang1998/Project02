<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>首頁</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>    
      <style>
        /* 聊天按钮样式 */
        .chat-button {
            position: fixed;
            bottom: 20px;
            right: 20px;
            z-index: 9999; /* 确保按钮在其他内容上方 */
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <a class="navbar-brand" href="indexcomment">你的網站</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="insertPost">評論</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="userComments">查看我的評論</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="allUsersComments">查看其他人評論</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="returnToControlUI">返回管理介面</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">歡迎 ${member.name}</a> <!-- 在這裡顯示使用者名稱 -->
        </li>
        <li class="nav-item"><a class="nav-link" href="chat">聊聊</a> 
		</li>
      </ul>
    </div>
  </div>
</nav>

<!-- 聊天按钮 -->
<button class="chat-button" onclick="loadChatRoom()">聊聊</button>

<!-- 聊天室内容容器 -->
<div id="chat-room" style="display: none;">
    <!-- 这里放置聊天室的内容 -->
</div>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
	
	<script>
    // 使用 AJAX 加载聊天页面的内容并添加到首页中
     function loadChatRoom() {
        $.ajax({
            url: "/chat", // 聊天页面的 URL
            type:"GET",
            success: function(data) {
                $("#chat-room").html(data).slideDown();
            }
        });
    }
</script>
</body>
</html>