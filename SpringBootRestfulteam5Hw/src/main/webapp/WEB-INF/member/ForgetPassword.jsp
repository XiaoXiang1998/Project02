<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>忘記密碼</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
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
            <form action="forgot-password" method="post" id="Form">
                <div class="form-floating mb-3">
                    <input type="email" id="email" name="email" class="form-control" placeholder="輸入您的郵箱地址" required>
                    <label for="email">輸入您的郵箱地址：</label>
                </div>
                <button type="button" id="submitButton" class="btn btn-primary">提交</button>
            </form>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
        <script>
            $('#submitButton').click(function () {
                let form = $('#Form')[0];
                let formData = new FormData(form);

                fetch('forgot-password', {
                    method: 'POST',
                    body: formData
                }).then(response => {
                    if (!response.ok) {
                        throw new Error('網路響應失敗');
                    }
                    return response.json(); // 解析 JSON
                }).then(data => {
                    if (data.success) {
                        Swal.fire({
                            title: "成功",
                            text: "新增成功",
                            icon: "success"
                        }).then(() => {
                            window.location.href = "http://localhost:8081/ezbuy.com"; // 跳轉到 ezbuy.com
                        });
                    } else {
                        Swal.fire({
                            title: "錯誤",
                            text: "信件已發送",
                            icon: "error"
                        });
                    }
                }).catch(error => {
                    console.error('Error:', error);
                    Swal.fire({
                        title: "錯誤",
                        text: "請重新檢查信箱是否輸入正確",
                        icon: "error"
                    });
                });
            });
        </script>
    </body>

    </html>