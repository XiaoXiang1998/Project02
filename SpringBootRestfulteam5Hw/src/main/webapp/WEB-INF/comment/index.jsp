<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>評論系統</title>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f4f4f4;
}

.container {
	max-width: 800px;
	margin: 50px auto;
	text-align: center;
}

h1 {
	color: #333;
}

.navbar {
	overflow: hidden;
	background-color: #007bff;
}

.navbar a {
	float: left;
	display: block;
	color: #fff;
	text-align: center;
	padding: 14px 20px;
	text-decoration: none;
	transition: background-color 0.3s;
}

.navbar a:hover {
	background-color: #0056b3;
}
</style>
</head>
<body>
	<div class="navbar">
		<a href="insertcomment">新增評論</a> <a href="get">查詢單筆評論</a> <a
			href="comment">查詢全部評論</a>
			<a href="userInput">透過關鍵字搜尋</a>
			<a href="GoControlUI">返回前台</a>
	</div>
	<div class="container">
		<h1>歡迎來到評論系統</h1>
	</div>
</body>
</html>