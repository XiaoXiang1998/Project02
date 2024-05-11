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
                        <li><a class="dropdown-item" href="#!">Logout</a></li>
                    </ul>
                </li>
            </ul>
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
                            <div class="sb-sidenav-menu-heading">功能列表</div>
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
                                data-bs-target="#collapsePages" aria-expanded="false" aria-controls="collapsePages">
                                <div class="sb-nav-link-icon"><i class="fa-solid fa-user-pen"></i></div>
                                人員管理
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapsePages" aria-labelledby="headingTwo"
                                data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPages">
                                    <a class="nav-link" href="AdminIndex">
                                        會員管理
                                    </a>
                                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
                                        data-bs-target="#pagesCollapseAuth" aria-expanded="false"
                                        aria-controls="pagesCollapseAuth">
                                        後台人員管理
                                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                                    </a>
                                    <div class="collapse" id="pagesCollapseAuth" aria-labelledby="headingOne"
                                        data-bs-parent="#sidenavAccordionPages">
                                        <nav class="sb-sidenav-menu-nested nav">
                                            <a class="nav-link" href="AdminManagement">檢視後台人員</a>
                                            <a class="nav-link" href="AdminInsert">新增後台人員</a>
                                        </nav>
                                    </div>

                                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
                                        data-bs-target="#MembershipLevel" aria-expanded="false"
                                        aria-controls="pagesCollapseAuth">
                                        會員規範管理
                                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                                    </a>
                                    <div class="collapse" id="MembershipLevel" aria-labelledby="headingOne"
                                        data-bs-parent="#sidenavAccordionPages">
                                        <nav class="sb-sidenav-menu-nested nav">
                                            <a class="nav-link" href="MembershipLevelGuidelines">檢視會員等級規範</a>
                                            <a class="nav-link" href="InsertMembershipLevel">新增會員等級規範</a>
                                        </nav>
                                    </div>
                                </nav>
                            </div>
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#order"
                                aria-expanded="false" aria-controls="collapsePages">
                                <div class="sb-nav-link-icon"><i class="fa-solid fa-sheet-plastic"></i></div>
                                訂單管理
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="order" aria-labelledby="headingTwo"
                                data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPages">
                                    <a class="nav-link" href="queryOrder.controller">
                                        訂單詳情
                                    </a>
                                </nav>
                            </div>
                        </div>
                    </div>
                    <div class="sb-sidenav-footer">
                        <div class="small">Logged in as:</div>
                        Start Bootstrap
                    </div>
                </nav>
            </div>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">新增會員等級規範</h1>
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                新增規範
                            </div>
                            <div class="card-body">
                                <form id="editForm" method="post" action="InsertAdmin">
                                    <div class="form-floating mb-3">
                                        <input type="text" id="level" name="level" class=" form-control">
                                        <label for="levelId">會員級別:</label>
                                    </div>
                                    <div class="form-floating mb-3">
                                        <input type="text" id="title" name="title" class="form-control">
                                        <label for="title">會員級別名稱:</label>
                                    </div>
                                    <div class="form-floating mb-3">
                                        <input type="text" id="threshold" name="threshold" class="form-control">
                                        <label for="threshold">累積金額上限:</label>
                                    </div>
                                    <div class="d-flex justify-content-center">
                                        <button type="button" class="btn btn-primary" id="saveChangesBtn">確認</button>
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
                var levelInput = document.getElementById('level');
                var titleInput = document.getElementById('title');
                var thresholdInput = document.getElementById('threshold');

                // 重置所有輸入框的樣式
                resetInputStyles();

                // 檢查所有必填字段是否為空
                if (levelInput.value.trim() === '' ||
                    titleInput.value.trim() === '' ||
                    thresholdInput.value.trim() === '') {
                    // 如果有必填字段為空，則添加紅色邊框和晃動效果
                    addErrorStyle(levelInput);
                    addErrorStyle(titleInput);
                    addErrorStyle(thresholdInput);
                    return;
                }
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
                        url: 'InsertLevel',
                        type: 'POST',
                        data: formData,
                        contentType: false, // 不要設置內容類型頭部
                        processData: false, // 不處理發送的數據
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
                                        window.location.href = "MembershipLevelGuidelines"; // 修改此處以對應實際的 URL 路徑
                                    }
                                });
                            } else {
                                Swal.fire("錯誤", "新增失敗", "error");
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error('Error:', error);
                            Swal.fire("錯誤", "發生了一個錯誤", "error");
                        }
                    });

                });
            });
        </script>
    </body>

    </html>