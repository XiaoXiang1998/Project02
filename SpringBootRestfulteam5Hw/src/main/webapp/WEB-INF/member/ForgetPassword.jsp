<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>忘記密碼</title>
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

            input[type="email"].form-control {
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
        </style>
    </head>

    <body>
        <div class="container">
            <h2>忘記密碼</h2>
            <form action="/forgot-password" method="post">
                <div class="form-floating mb-3">
                    <input type="email" id="email" name="email" class="form-control" placeholder="輸入您的郵箱地址" required>
                    <label for="email">輸入您的郵箱地址：</label>
                </div>
                <button type="submit" class="btn btn-primary">提交</button>
            </form>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </body>

    </html>