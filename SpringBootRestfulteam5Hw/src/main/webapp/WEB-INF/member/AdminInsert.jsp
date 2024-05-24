<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>後台管理</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.css">
        <link href="css/styles.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <style>
            .is-invalid {
                border-color: #dc3545 !important;
                /* 紅色邊框顏色 */
            }

            .is-invalid-shake {
                animation: shake 0.3s;
                /* 晃動效果 */
            }

            @keyframes shake {
                0% {
                    transform: translateX(0);
                }

                25% {
                    transform: translateX(-5px);
                }

                50% {
                    transform: translateX(5px);
                }

                75% {
                    transform: translateX(-5px);
                }

                100% {
                    transform: translateX(0);
                }
            }
        </style>
    </head>

    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="index.html">EZ BUY</a>
            <!-- Sidebar Toggle-->
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i
                    class="fas fa-bars"></i></button>
            <!-- Navbar Search-->
            <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
                <div class="input-group">
                    <input class="form-control" type="text" placeholder="Search for..." aria-label="Search for..."
                        aria-describedby="btnNavbarSearch" />
                    <button class="btn btn-primary" id="btnNavbarSearch" type="button"><i
                            class="fas fa-search"></i></button>
                </div>
            </form>
            <!-- Navbar-->
            <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button"
                        data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="#!">Settings</a></li>
                        <li><a class="dropdown-item" href="#!">Activity Log</a></li>
                        <li>
                            <hr class="dropdown-divider" />
                        </li>
                        <li><a class="dropdown-item" href="LogoutBackstage">Logout</a></li>
                    </ul>
                </li>
            </ul>
        </nav>
        <div id="layoutSidenav">
            <%@ include file="../AllNav.jsp" %>
                <div id="layoutSidenav_content">
                    <main>
                        <div class="container-fluid px-4">
                            <h1 class="mt-4">人員數據</h1>
                            <ol class="breadcrumb mb-4">
                                <li class="breadcrumb-item active">員工總覽</li>
                            </ol>
                            <div class="card mb-4">
                                <div class="card-header">
                                    <i class="fas fa-table me-1"></i>
                                    員工資料
                                </div>
                                <div class="card-body">
                                    <form id="editForm" method="post" action="InsertAdmin">
                                        <div class="form-floating mb-3">
                                            <input type="text" id="account" name="account" class="form-control">
                                            <label for="account">帳號:</label>
                                        </div>
                                        <div class="form-floating mb-3">
                                            <input type="text" id="password" name="password" class="form-control">
                                            <label for="password">密碼:</label>
                                        </div>
                                        <div class="form-floating mb-3">
                                            <input type="email" id="email" name="email" class="form-control">
                                            <label for="email">信箱:</label>
                                        </div>
                                        <div class="form-floating mb-3">
                                            <input type="tel" id="phone" name="phone" class="form-control">
                                            <label for="phone">電話:</label>
                                        </div>
                                        <div class="form-floating mb-3">
                                            <input type="text" id="name" name="name" class="form-control">
                                            <label for="name">姓名:</label>
                                        </div>
                                        <div class="form-floating mb-3">
                                            <select id="gender" name="gender" class="form-select">
                                                <option value="">請選擇</option>
                                                <option value="male">男性</option>
                                                <option value="female">女性</option>
                                            </select>
                                            <label for="gender">性別:</label>
                                        </div>
                                        <div class="form-floating mb-3">
                                            <input type="text" id="address" name="address" class="form-control">
                                            <label for="address">住址:</label>
                                        </div>
                                        <div class="mb-3">
                                            <label for="photoSticker" class="form-label">頭貼:</label> <input type="file"
                                                id="photoSticker" name="photoSticker" class="form-control">
                                        </div>
                                        <div class="d-flex justify-content-center">
                                            <button type="button" class="btn btn-primary"
                                                id="saveChangesBtn">確認</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </main>
                    <footer class="py-4 bg-light mt-auto">
                        <div class="container-fluid px-4">
                            <div class="d-flex align-items-center justify-content-between small">
                                <div class="text-muted">Copyright &copy; Your Website 2023</div>
                                <div>
                                    <a href="#">Privacy Policy</a>
                                    &middot;
                                    <a href="#">Terms &amp; Conditions</a>
                                </div>
                            </div>
                        </div>
                    </footer>
                </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
            crossorigin="anonymous"></script>
        <script src="js/scripts.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
            crossorigin="anonymous"></script>
        <script type="text/javascript" src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
        <!-- 抓取會員等級的分布數量 -->
        <script>
            document.getElementById('saveChangesBtn').addEventListener('click', function () {
                var accountInput = document.getElementById('account');
                var passwordInput = document.getElementById('password');
                var emailInput = document.getElementById('email');
                var phoneInput = document.getElementById('phone');
                var nameInput = document.getElementById('name');
                var genderInput = document.getElementById('gender');
                var addressInput = document.getElementById('address');

                // 重置所有輸入框的樣式
                resetInputStyles();

                // 檢查所有必填字段是否為空
                if (accountInput.value.trim() === '' ||
                    passwordInput.value.trim() === '' ||
                    emailInput.value.trim() === '' ||
                    phoneInput.value.trim() === '' ||
                    nameInput.value.trim() === '' ||
                    genderInput.value.trim() === '' ||
                    addressInput.value.trim() === '') {
                    // 如果有必填字段為空，則添加紅色邊框和晃動效果
                    addErrorStyle(accountInput);
                    addErrorStyle(passwordInput);
                    addErrorStyle(emailInput);
                    addErrorStyle(phoneInput);
                    addErrorStyle(nameInput);
                    addErrorStyle(genderInput);
                    addErrorStyle(addressInput);
                    return;
                }

                // 檢查信箱格式
                var email = emailInput.value.trim();
                var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(email)) {
                    // 如果信箱格式不正確，則添加紅色邊框和晃動效果
                    addErrorStyle(emailInput);
                    return;
                }

                // 檢查電話格式
                var phone = phoneInput.value.trim();
                var phoneRegex = /^\d{10}$/; // 假設電話號碼為10位數
                if (!phoneRegex.test(phone)) {
                    // 如果電話格式不正確，則添加紅色邊框和晃動效果
                    addErrorStyle(phoneInput);
                    return;
                }

                // 其他格式驗證...

                // 其他提交表單的相關操作
            });

            // 函數：重置所有輸入框的樣式
            function resetInputStyles() {
                var inputs = document.getElementsByTagName('input');
                for (var i = 0; i < inputs.length; i++) {
                    inputs[i].classList.remove('is-invalid');
                }
            }

            // 函數：添加紅色邊框和晃動效果
            function addErrorStyle(input) {
                input.classList.add('is-invalid');
                input.addEventListener('animationend', function () {
                    input.classList.remove('is-invalid-shake');
                });
                input.classList.add('is-invalid-shake');
            }
            $(document).ready(function () {
                $('#saveChangesBtn').click(function () {
                    // 使用 jQuery 收集表單數據
                    var formData = new FormData($('#editForm')[0]);

                    // 使用 jQuery 發送 POST 請求
                    $.ajax({
                        url: 'InsertAdmin',
                        type: 'POST',
                        data: formData,
                        contentType: false,  // 不要設置內容類型頭部
                        processData: false,  // 不處理發送的數據
                        success: function (data) {
                            // 根據後端回應顯示 SweetAlert 提示消息
                            if (data.success) {
                                Swal.fire({
                                    title: "成功",
                                    text: "新增成功",
                                    icon: "success"
                                }).then((result) => {
                                    // 當點擊確認按鈕後，進行頁面跳轉
                                    if (result.value) {
                                        window.location.href = "AdminManagement";  // 修改此處以對應實際的 URL 路徑
                                    }
                                });
                            } else {
                                Swal.fire({
                                    title: "錯誤",
                                    text: "新增失敗",
                                    icon: "error"
                                });
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error('Error:', error);
                            Swal.fire({
                                title: "錯誤",
                                text: "發生了一個錯誤",
                                icon: "error"
                            });
                        }
                    });

                });
            });
        </script>
    </body>

    </html>