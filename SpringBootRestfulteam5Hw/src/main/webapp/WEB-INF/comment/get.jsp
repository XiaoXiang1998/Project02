<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>輸入使用者ID</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f4f4f4;
}

.container {
	max-width: 400px;
	margin: 50px auto;
	text-align: center;
	background-color: #fff;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

h1 {
	color: #333;	
}

input[type="text"] {
	width: 100%;
	padding: 10px;
	margin-top: 20px;
	box-sizing: border-box;
	border: 1px solid #ccc;
	border-radius: 5px;
	font-size: 16px;
}

input[type="submit"] {
	background-color: #007bff;
	color: #fff;
	border: none;
	padding: 10px 20px;
	font-size: 16px;
	border-radius: 5px;
	cursor: pointer;
	margin-top: 20px;
	transition: background-color 0.3s;
}

input[type="submit"]:hover {
	background-color: #0056b3;
}
.backButton {
	background-color: #ccc;
	color: #333;
	border: none;
	padding: 10px 20px;
	font-size: 16px;
	border-radius: 5px;
	cursor: pointer;
	margin-top: 20px;
	transition: background-color 0.3s;
}

.backButton:hover {
	background-color: #999;
}
</style>
</head>
<body>
	<div class="container">
    <h1>輸入使用者ID</h1>
    <form id="commentForm" action="ffffff" method="get"> 
    <input type="text" id="cid" name="cid" placeholder="請輸入評論ID" required>
    <p id="error">${errors.errors}</p>
    <button type="button" id="button" value="提交">提交</button>
</form>
    <button onclick="redirectToHomepage()" class="backButton">返回首頁</button>
</div>
	 <script>
	    var cidInput = document.getElementById("cid");
	    var button = document.getElementById("button");

	    button.addEventListener('click', function() {
	        document.getElementById("commentForm").action ="/comment/"+ cidInput.value;
	        document.getElementById("commentForm").submit();
	    });
       
    </script>

	<script>
	
		function redirectToHomepage() {
			window.location.href ='/index';
		}
		
		
	</script>
</body>
</html>