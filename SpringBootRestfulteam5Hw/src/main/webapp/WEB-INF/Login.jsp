<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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

			#username,
			#password,
			h3 {
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
				height: 350px;
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
				justify-content: flex-start;
				/* 讓內容靠左對齊 */
				margin-left: 10px;
				/* 調整左側間距 */
			}

			#seePassword {
				margin-right: 5px;
				/* 調整 "顯示密碼" 文字與複選框之間的間距 */
			}

			.g_id_signin {
				margin: 0 auto;
				/* 將元素水平置中 */
				text-align: center;
				/* 文字內容置中 */
				display: block;
				/* 讓元素佔據整個寬度 */
				width: fit-content;
				/* 讓寬度根據內容自動調整 */
			}

			/* 將兩個 h5 元素並排排列 */
			.login_page h5 {
				display: inline-block;
				margin-right: 20px;
				/* 調整 h5 元素之間的間距 */
			}

			/* 設定 h5 元素內的連結文字顏色 */
			.login_page h5 a {
				color: black;
				/* 黑色字體 */
				text-decoration: none;
				/* 移除底線 */
				transition: transform 0.3s, font-size 0.3s;
				/* 添加過渡效果 */
			}

			/* 當滑鼠懸停在連結上時 */
			.login_page h5 a:hover {
				color: #ff6c6c;
				/* 變更字體顏色為紅色 */
				transform: scale(1.1);
				/* 放大連結文字 */
				font-size: 16px;
				/* 變更字體大小為16像素 */
			}
		</style>
	</head>

	<body>
		<div class="login_page">
			<div id="container1">
				<div class="login">

					<h3>登入 Login</h3>

					<form method="post" action="MemberLogin.controller">
						<input type="text" id="username" name="username" placeholder="帳號" required>
						<div class="tab"></div>
						<input type="password" id="password" name="password" placeholder="密碼" required>
						<div class="checkbox-container">
							<input type="checkbox" id="seePassword" onclick="togglePassword()">
							<label for="seePassword" style="font-size: 12px;">顯示密碼</label>
						</div>
						<div class="tab"></div>
						<input type="submit" value="登入" class="submit">
						<div id="g_id_onload"
							data-client_id="892237680262-jsfn5kl8g9a7ks0nj2sh9vgeem2o4tla.apps.googleusercontent.com"
							data-context="signin" data-ux_mode="popup"
							data-login_uri="http://localhost:8081/google.login" data-auto_prompt="false"></div>

						<div class="g_id_signin" data-type="standard" data-shape="pill" data-theme="outline"
							data-text="signin_with" data-size="large" data-logo_alignment="left">
						</div>

					</form>
				</div>
				<h5><a href="#">註冊帳號</a></h5>
				<h5><a href="forgotPassword">忘記密碼</a></h5>
			</div>
		</div>

		<script src="https://accounts.google.com/gsi/client?hl=en" async></script>
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