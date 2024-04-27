<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
<style>
* {
	font-family: 微軟正黑體;
}

body {
	background-color: white;
}

#username, #password, h3 {
	/* 字體顏色寬度邊框 */
	width: 200px;
	height: 20px;
	margin: 10px;
	color: #ff6c6c;
}

h5 {
	margin: 20px;
	color: #a3a2a3;
}

h5:hover {
	/* 對應註冊帳號 */
	color: black;
}

#container1 {
	margin: 50px;
	padding: 10px;
	width: 230px;
	height: 300px;
	background-color: white;
	border-radius: 5px;
	border-top: 10px solid #ff6c6c;
	box-shadow: 0 0px 70px rgba(0, 0, 0, 0.1);
	/*定位對齊*/
	position: relative;
	margin: auto;
	top: 100px;
	text-align: center;
}

.submit {
	color: white;
	background: #ff6c6c;
	width: 200px;
	height: 30px;
	margin: 10px;
	padding: 5px;
	border-radius: 5px;
	border: 0px;
}

.submit:hover {
	background: #ff4d00;
}

input {
	padding: 5px;
	border: none;
	border: solid 1px #ccc;
	border-radius: 5px;
}

.checkbox-container {
	display: flex;
	align-items: center;
	justify-content: center;
}
</style>
</head>
<body>
	<div class="login_page">
		<div id="container1">

			<div class="login">

				<h3>登入 Login</h3>

				<form method="post" action="MemberLogin.controller">
					<input type="text" id="username" name="username" placeholder="帳號"
						required>
					<div class="tab"></div>
					<input type="password" id="password" name="password" placeholder="密碼"
						required>
					<div class="checkbox-container">
						<input type="checkbox" id="seePassword" onclick="togglePassword()">
						<label for="seePassword" style="font-size: 12px;">顯示密碼</label>
					</div>
					<div class="tab"></div>
					<input type="submit" value="登入" class="submit">
				</form>
				<h5><a href="../View/register.jsp">註冊帳號</a></h5>
			</div>
		</div>
	</div>

	<script>
		function togglePassword() {
			let passwordInput = document.getElementById("password");
			let checkbox = document.getElementById("seePassword");
			if (checkbox.checked) {
				passwordInput.type = "text";
			} else {
				passwordInput.type = "password";
			}
		}
	</script>

</body>
</html>