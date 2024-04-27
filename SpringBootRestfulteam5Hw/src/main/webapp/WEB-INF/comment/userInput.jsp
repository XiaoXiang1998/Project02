<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>模糊查詢</title>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f5f5f5;
}

.container {
	width: 80%;
	margin: 0 auto;
	padding: 20px;
	text-align: center;
}

h1 {
	color: #333;
}

.search-box {
	width: 60%;
	padding: 10px;
	border: 2px solid #ccc;
	border-radius: 5px;
	font-size: 16px;
	margin-top: 20px;
}

.search-button {
	background-color: #4CAF50;
	color: white;
	padding: 10px 20px;
	border: none;
	border-radius: 5px;
	font-size: 16px;
	cursor: pointer;
	transition: background-color 0.3s ease;
	margin-top: 20px;
}

.search-button:hover {
	background-color: #45a049;
}

.home-button {
	background-color: #333;
	color: white;
	padding: 10px 20px;
	border: none;
	border-radius: 5px;
	font-size: 16px;
	cursor: pointer;
	transition: background-color 0.3s ease;
	margin-top: 20px;
}

.home-button:hover {
	background-color: #555;
}
</style>
</head>
<body>
	<div class="container">
		<h1>關鍵字查詢</h1>
		<form action="GetCommentsByUserInput" method="get">
			<input type="text" class="search-box" name="keyword"
				placeholder="請輸入關鍵字" required> <br>
			<br>
			<button type="submit" class="search-button">搜索</button>
			<p>${errors.errors}</p>
		</form>
		<button class="home-button" onclick="redirectToHomepage()">返回首頁</button>
	</div>

	<script>
		function redirectToHomepage() {
			window.location.href = 'index.controller';
		}
	</script>
</body>
</html>