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
                        <h1 class="mt-4">會員等級規範</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">階級一覽</li>
                        </ol>
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                員工資料
                            </div>
                            <div class="card-body">
                                <table id="levelDataTables">
                                    <thead>
                                        <tr>
                                            <th>會員級別</th>
                                            <th>會員級別名稱</th>
                                            <th>累計金額上限</th>
                                            <th>功能操作</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                                <div class="modal fade" id="exampleModal" tabindex="-1"
                                    aria-labelledby="exampleModalLabel" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="exampleModalLabel">會員級別</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                    aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <form id="editForm">
                                                    <div class="form-floating mb-3">
                                                        <input type="text" id="level" name="level"
                                                            class=" form-control">
                                                        <label for="levelId">會員級別:</label>
                                                    </div>
                                                    <div class="form-floating mb-3">
                                                        <input type="text" id="title" name="title" class="form-control"
                                                            readonly>
                                                        <label for="title">會員級別名稱:</label>
                                                    </div>
                                                    <div class="form-floating mb-3">
                                                        <input type="text" id="threshold" name="threshold"
                                                            class="form-control">
                                                        <label for="threshold">累積金額上限:</label>
                                                    </div>
                                                </form>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary"
                                                    data-bs-dismiss="modal">取消</button>
                                                <button type="button" class="btn btn-primary"
                                                    id="saveChangesBtn">確認更新</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
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
            $(document).ready(function () {
                $('#saveChangesBtn').click(function () {
                    var form = $('#editForm')[0]; // 使用jQuery選擇DOM元素
                    console.log(form);
                    var formData = new FormData(form); // 使用原生JavaScript建立FormData

                    var isSeller = $('#sellerSwitch').is(':checked');

                    // 將 checkbox 的值添加到 FormData 中
                    formData.append('seller', isSeller);


                    fetch('UpdateMember', { // 發送fetch請求
                        method: 'PUT',
                        body: formData
                    })
                        .then(response => {
                            if (response.ok) {
                                // 更新成功的處理
                                $('#exampleModal').modal('hide'); // 隱藏模態框
                                var table = $('#levelDataTables').DataTable();
                                // 檢查 DataTable 是否已經被初始化
                                if (table) {
                                    table.ajax.reload(); // 只重新載入資料
                                }
                            } else {
                                // 更新失敗的處理
                                console.error('Failed to update member data.');
                            }
                        })
                    $('#exampleModal').modal('hide');
                });
            })



            function getAllAdmin() {
                $('#levelDataTables').DataTable({
                    "ajax": {
                        "url": "getAllLevel",
                        "method": "GET",
                        "dataSrc": ""
                    },
                    language: {
                        "lengthMenu": "顯示 _MENU_ 筆資料",
                        "sProcessing": "處理中...",
                        "sZeroRecords": "没有匹配结果",
                        "sInfo": "目前有 _MAX_ 筆資料",
                        "sInfoEmpty": "目前共有 0 筆紀錄",
                        "sInfoFiltered": " ",
                        "sInfoPostFix": "",
                        "sSearch": "搜尋:",
                        "sUrl": "",
                        "sEmptyTable": "尚未有資料紀錄存在",
                        "sLoadingRecords": "載入資料中...",
                        "sInfoThousands": ",",
                        "oPaginate": {
                            "sFirst": "首頁",
                            "sPrevious": "上一頁",
                            "sNext": "下一頁",
                            "sLast": "末頁"
                        },
                        "order": [[0, "desc"]],
                        "oAria": {
                            "sSortAscending": ": 以升序排列此列",
                            "sSortDescending": ": 以降序排列此列"
                        }
                    },
                    "columns": [
                        { "data": "level" },
                        { "data": "title" },
                        { "data": "threshold" },
                        {
                            "data": null,
                            "render": function (data, type, row) {
                                return '<div class="button-container">' +
                                    '<button type="button" class="btn btn-warning btn-sm editBtn" data-bs-toggle="modal" data-bs-target="#exampleModal">修改</button>' +
                                    '<button type="button" class="btn btn-danger btn-sm deleteBtn">刪除</button>' +
                                    '</div>';
                            }
                        }
                    ]
                });
            }

            window.onload = function () {
                // 加載完成後更新圖表
                getAllAdmin();

                $('#levelDataTables tbody').on('click', 'button.deleteBtn', function () {
                    var data = $('#levelDataTables').DataTable().row($(this).closest('tr')).data();
                    let sid = parseInt(data.sid);

                    const swalWithBootstrapButtons = Swal.mixin({
                        customClass: {
                            confirmButton: "btn btn-primary",
                            cancelButton: "btn btn-danger"
                        },
                        buttonsStyling: false
                    });
                    swalWithBootstrapButtons.fire({
                        title: "是否確認要刪除?",
                        text: "你將無法回復這個條件!",
                        icon: "warning",
                        showCancelButton: true,
                        confirmButtonText: "刪除!",
                        cancelButtonText: "取消!",
                        reverseButtons: true
                    }).then((result) => {
                        if (result.isConfirmed) {

                            console.log(sid);
                            fetch('/DeleteMember/' + sid, {
                                method: 'DELETE',
                                headers: {
                                    'Content-Type': 'application/json'
                                }
                            }).then(response => {
                                if (response.ok) {
                                    // 更新成功的處理
                                    var table = $('#levelDataTables').DataTable();
                                    // 檢查 DataTable 是否已經被初始化
                                    if (table) {
                                        table.ajax.reload(); // 只重新載入資料
                                    }
                                } else {
                                    // 更新失敗的處理
                                    console.error('Failed to update member data.');
                                }
                            })

                            swalWithBootstrapButtons.fire({
                                title: "刪除成功!",
                                text: "你的檔案已成功刪除",
                                icon: "success"
                            });
                        } else if (
                            /* Read more about handling dismissals below */
                            result.dismiss === Swal.DismissReason.cancel
                        ) {
                            swalWithBootstrapButtons.fire({
                                title: "已取消",
                                text: "你的檔案依舊安全",
                                icon: "error"
                            });
                        }
                    });

                })

                $('#levelDataTables tbody').on('click', 'button.editBtn', function () {
                    // 獲取所在行的資料
                    var data = $('#levelDataTables').DataTable().row($(this).closest('tr')).data();

                    // 將資料填充到表單的input欄位中
                    $('#editForm input[name="level"]').val(data.level);
                    $('#editForm input[name="title"]').val(data.title);
                    $('#editForm input[name="threshold"]').val(data.threshold);

                    // 顯示表單
                    $('#editForm').show();
                });

                // 防止表單提交後刷新頁面
                $('#editForm').submit(function (event) {
                    event.preventDefault();
                    // 在這裡處理表單提交的邏輯
                });
            };

        </script>
    </body>

    </html>