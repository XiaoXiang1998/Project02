<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<title>新增會員等級制度</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
		<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.css">
		<link href="css/styles.css" rel="stylesheet" />
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
		<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
		<style>
			body {
				font-family: Arial, sans-serif;
				background-color: #f4f4f4;
				margin: 0;
				padding: 0;
				display: flex;
				justify-content: center;
				align-items: center;
				height: 100vh;
			}

			.container {
				width: 400px;
				padding: 30px;
				background-color: #fff;
				border-radius: 5px;
				border-top: 10px solid #ff6c6c;
				box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
				box-sizing: border-box;
				margin-top: 20px;
			}

			h2 {
				text-align: center;
				margin-bottom: 30px;
			}

			label {
				font-weight: bold;
			}

			input[type="text"].form-control,
			input[type="email"].form-control,
			input[type="password"].form-control {
				width: 100%;
				padding: 10px;
				margin-bottom: 20px;
				border: 1px solid #ccc;
				border-radius: 5px;
				box-sizing: border-box;
				outline: none;
			}

			button[type="submit"] {
				width: 100%;
				padding: 10px;
				background-color: #ff6c6c;
				color: #fff;
				border: none;
				border-radius: 5px;
				cursor: pointer;
				outline: none;
			}

			button[type="submit"]:hover {
				background-color: #ff4d00;
			}

			.alert {
				padding: 15px;
				margin-bottom: 20px;
				border: 1px solid transparent;
				border-radius: .25rem;
			}

			.alert-danger {
				color: #721c24;
				background-color: #f8d7da;
				border-color: #f5c6cb;
			}
		</style>
	</head>

	<body>
		<div class="container">
			<h2>註冊</h2>
			<form id="registerForm">
				<div class="form-floating mb-3">
					<input type="text" id="account" name="Account" class="form-control" placeholder="輸入帳號" required>
					<label for="account">帳號：</label>
				</div>
				<div class="form-floating mb-3">
					<input type="password" id="password" name="Password" class="form-control" placeholder="輸入密碼"
						required> <label for="password">密碼：</label>
				</div>
				<div class="form-floating mb-3">
					<input type="text" id="name" name="Name" class="form-control" placeholder="輸入姓名" required> <label
						for="name">姓名：</label>
				</div>
				<div class="form-floating mb-3">
					<input type="email" id="email" name="Email" class="form-control" placeholder="輸入電子郵件" required>
					<label for="email">電子郵件：</label>
				</div>
				<div class="form-floating mb-3">
					<input type="text" id="phone" name="Phone" class="form-control" placeholder="輸入電話號碼" required>
					<label for="phone">電話號碼：</label>
				</div>
				<div class="form-floating mb-3">
					<select id="gender" name="Gender" class="form-select" required>
						<option value="">選擇性別</option>
						<option value="male">男性</option>
						<option value="female">女性</option>
						<option value="other">其他</option>
					</select> <label for="gender">性別：</label>
				</div>
				<div class="form-floating mb-3">
					<textarea id="address" name="Address" class="form-control" placeholder="輸入地址" required></textarea>
					<label for="address">地址：</label>
				</div>
				<div class="mb-3">
					<input type="file" id="photo_sticker" name="Photo_Sticker" class="form-control">
				</div>
				<div class="form-check mb-3">
					<input type="checkbox" id="seller" name="Seller" class="form-check-input"> <label
						class="form-check-label" for="seller">是否為賣家</label>
				</div>
				<button type="submit" class="btn btn-primary">註冊</button>
			</form>
			<div id="alert" class="alert alert-danger" style="display: none;"></div>
		</div>

		<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
		<script>
			$('#registerForm').submit(function (e) {
				e.preventDefault();

				let formData = new FormData(this);

				$('#registerForm').submit(function (e) {
					e.preventDefault();

					let formData = new FormData(this);
					// 判斷是否勾選了 'Seller' 欄位
					let isSeller = $('#seller').is(':checked');

					// 將 'Seller' 的值添加到 formData 中
					formData.append('Seller', isSeller);

					$.ajax({
						url: 'InsertMember',
						type: 'POST',
						data: formData,
						processData: false,
						contentType: false,
						success: function (response) {
							// 成功接收到回應後的處理
							if (response.success) {
								// 如果後端返回的是成功註冊的回應，則顯示成功提示並導向其他頁面
								Swal.fire({
									title: '成功',
									text: '註冊成功',
									icon: 'success'
								}).then(() => {
									window.location.href = 'http://localhost:8081/ezbuy.com';
								});
							} else {
								// 如果後端返回的是註冊失敗的回應，則顯示錯誤提示
								Swal.fire({
									title: '錯誤',
									text: '該帳號已經註冊過',
									icon: 'error'
								});
							}
						},
						error: function (xhr, status, error) {
							// 處理發生錯誤時的情況
							let errorMessage = xhr.responseJSON.message;
							$('#alert').text(errorMessage).show();
						}
					});
				});
			});
		</script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
			crossorigin="anonymous"></script>
		<script src="js/scripts.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
			crossorigin="anonymous"></script>
		<script type="text/javascript" src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
	</body>

	</html>