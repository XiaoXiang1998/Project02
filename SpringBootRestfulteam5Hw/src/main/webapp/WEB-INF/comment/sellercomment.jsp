
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<meta charset="UTF-8">
<title>賣家回覆區</title>
<style>
        /* 添加样式使得聊天小框框定位在右下角 */
        .chat-link {
            position: fixed;
            bottom: 20px; /* 距离底部的距离 */
            right: 20px; /* 距离右侧的距离 */
            background-color: #ffffff; /* 背景颜色 */
            border: 1px solid #000000; /* 边框 */
            padding: 10px; /* 内边距 */
            border-radius: 5px; /* 边框圆角 */
            box-shadow: 0 0 10px rgba(0,0,0,0.2); /* 添加阴影效果 */
        }
    </style>
</head>
<body>
	<header class="bg-dark py-3">
		<div class="container">
			<h1 class="text-white text-center">評價管理</h1>
		</div>
	</header>
	<nav class="bg-light py-3">
		<div class="container">
			<ul class="nav justify-content-center">
				<li class="nav-item"><a class="nav-link" href="sellerComments">查看賣場評價</a>
				</li>
				<li class="nav-item"><a class="nav-link" href="#">查看所有買家的評論</a>
				</li>
				<li class="nav-item"><a class="nav-link" href="repliedComments">查看我的回覆</a>
				</li>
				<li class="nav-item"><a class="nav-link"
					href="returnToControlUI">返回管理介面</a></li>
				<li class="nav-item"><a class="nav-link" href="#">Welcome,${member.name}</a>
				</li>
				<li class="nav-item"><a class="nav-link" href="chat">聊聊</a> 
				</li>
			</ul>
		</div>
	</nav>
	



	
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
		
		
</body>
</html>