<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>重設密碼</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
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

            input[type="password"].form-control {
                width: 100%;
                padding: 10px;
                margin-bottom: 20px;
                border: 1px solid #ccc;
                border-radius: 5px;
                box-sizing: border-box;
                outline: none;
            }

            .form-check {
                margin-bottom: 20px;
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

            .error-message {
                color: red;
                margin-top: 10px;
            }
        </style>
    </head>

    <body>
        <div class="container">
            <h2>重設密碼</h2>
            <form action="memberResetPassword" method="post" onsubmit="return validateForm()">
                <div class="form-floating mb-3">
                    <input type="password" id="password" name="password" class="form-control" placeholder="輸入新密碼"
                        required>
                    <label for="password">輸入新密碼：</label>
                </div>
                <div class="form-floating mb-3">
                    <input type="password" id="confirm-password" name="confirm-password" class="form-control"
                        placeholder="再次輸入新密碼" required>
                    <label for="confirm-password">再次輸入新密碼：</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="show-password" onclick="togglePassword()">
                    <label class="form-check-label" for="show-password">顯示密碼</label>
                </div>
                <button type="submit" class="btn btn-primary">重設密碼</button>
                <div id="error-message" class="error-message"></div>
            </form>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function togglePassword() {
                var passwordInput = document.getElementById("password");
                var confirmPasswordInput = document.getElementById("confirm-password");
                var checkbox = document.getElementById("show-password");
                if (checkbox.checked) {
                    passwordInput.type = "text";
                    confirmPasswordInput.type = "text";
                } else {
                    passwordInput.type = "password";
                    confirmPasswordInput.type = "password";
                }
            }

            function validateForm() {
                var password = document.getElementById("password").value;
                var confirmPassword = document.getElementById("confirm-password").value;
                var errorMessage = document.getElementById("error-message");
                if (password !== confirmPassword) {
                    errorMessage.innerText = "兩次密碼不一致，請重新輸入。";
                    return false;
                }
                return true;
            }
        </script>
    </body>

    </html>