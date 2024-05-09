<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge" />
            <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
            <meta name="description" content="" />
            <meta name="author" content="" />
            <title>Product Query All</title>
            <link
                href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
                rel="stylesheet">
            <!-- Icon Font Stylesheet -->
            <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
            <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
            <!--  -->
            <link href="../../frontlib/lightbox/css/lightbox.min.css" rel="stylesheet">
            <link href="../../frontlib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
            <link href="../../frontcss/bootstrap.min.css" rel="stylesheet">
            <link href="../../frontcss/style.css" rel="stylesheet">
            <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

            <style>
                img {
                    height: 150px;
                    width: 150px;
                }

                table {
                    tr:hover {
                        cursor: pointer;
                    }
                }
            </style>
            <script>
                $.ajax({

                    type: 'get',

                    url: '/getallgood.controller',

                    contentType: 'application/json',

                    success: function (data) {

                        $('#GoodBasicData').empty("");

                        if (data == null) {

                            $('#GoodBasicData').prepend('<tr><td>No Result</td></tr>');

                        }

                        else {

                            var tbody = $('tbody');
                            console.log(tbody);
                            $.each(data, function (i, n) {
                                // <input type="text" readonly class="form-control-plaintext" id="staticEmail" value="email@example.com">
                                console.log(n.titleImage);
                                var tr = "<tr data-index=\"" + i + "\"><td><form><input type=\"text\" readonly class=\"form-control-plaintext\" value=\"" + n.goodsID + "\" name=\"GoodID\"></form></td><td>" + n.goodsName + "</td><td><img src=" + n.titleImage + " alt=" + n.titleImage + "></td><td>" + n.goodsType + "</td><td>" + n.launchDate + "</td><td>" + n.brand + "</td><td>" + n.shipmentPlace + "</td><td>" + n.goodsSellerID.sid + + "</td><td><form><input type=\"text\" readonly class=\"form-control-plaintext\" value=\"" + n.goodsID + "\" name=\"GoodID\"></form></td></tr>";
                                tbody.append(tr);
                            });
                            const datatablesSimple = document.getElementById('datatablesSimple');
                            // console.log(datatablesSimple);
                            // if (datatablesSimple) {
                            //     new simpleDatatables.DataTable(datatablesSimple);
                            // }
                        }
                    }
                })
                $(document).on('click', 'tr[data-index]', function () {
                    let targetForm = $(this).find('form');
                    targetForm.attr("method", "post");
                    targetForm.attr("enctype", "multipart/form-data");
                    targetForm.attr("action", "goodDetail.controller");
                    console.log(targetForm);
                    // targetForm.submit();
                    // let formdata = new FormData([...targetForm][0]);
                    // console.log([...targetForm][0]);
                })

            </script>
        </head>

        <body>
            <!-- Spinner Start -->
            <div id="spinner"
                class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
                <div class="spinner-grow text-primary" role="status"></div>
            </div>
            <!-- Spinner End -->
            <!-- Navbar start -->
            <div class="container-fluid fixed-top">
                <div class="container topbar bg-primary d-none d-lg-block">
                    <div class="d-flex justify-content-between">
                        <div class="top-info ps-2">
                            <small class="me-3"><i class="fas fa-map-marker-alt me-2 text-secondary"></i> <a href="#"
                                    class="text-white">123 Street, New York</a></small>
                            <small class="me-3"><i class="fas fa-envelope me-2 text-secondary"></i><a href="#"
                                    class="text-white">Email@Example.com</a></small>
                        </div>
                        <div class="top-link pe-2">
                            <a href="#" class="text-white"><small class="text-white mx-2">Privacy Policy</small>/</a>
                            <a href="#" class="text-white"><small class="text-white mx-2">Terms of Use</small>/</a>
                            <a href="#" class="text-white"><small class="text-white ms-2">Sales and Refunds</small></a>
                        </div>
                    </div>
                </div>
                <div class="container px-0">
                    <nav class="navbar navbar-light bg-white navbar-expand-xl">
                        <a href="index.html" class="navbar-brand">
                            <h1 class="text-primary display-6">EZBuy.com</h1> <!-- (點擊前往首頁) -->
                        </a>
                        <button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarCollapse">
                            <span class="fa fa-bars text-primary"></span>
                        </button>
                        <div class="collapse navbar-collapse bg-white" id="navbarCollapse">
                            <div class="navbar-nav mx-auto">
                                <a href="shop.html" class="nav-item nav-link">查看我的賣場</a> <!-- 透過使用者編號前往賣家的賣場 -->
                                <a href="shop-detail.html" class="nav-item nav-link">檢視商品頁面</a> <!-- 透過商品編號前往買家商品頁面 -->
                                <div class="nav-item dropdown">
                                    <a href="#" class="nav-link dropdown-toggle active"
                                        data-bs-toggle="dropdown">Pages</a>
                                    <div class="dropdown-menu m-0 bg-secondary rounded-0">
                                        <a href="cart.html" class="dropdown-item">購物車</a> <!-- 透過使用者編號前往自己的購物車 -->
                                        <a href="chackout.html" class="dropdown-item active">商品修改</a>
                                        <a href="testimonial.html" class="dropdown-item">查詢我的商品</a>
                                        <a href="404.html" class="dropdown-item">新增商品</a> <!-- 上架商品 -->
                                    </div>
                                </div>
                                <a href="contact.html" class="nav-item nav-link">聯絡官方</a> <!-- 前往申訴頁面 -->
                            </div>
                            <div class="d-flex m-3 me-0">
                                <button
                                    class="btn-search btn border border-secondary btn-md-square rounded-circle bg-white me-4"
                                    data-bs-toggle="modal" data-bs-target="#searchModal"><i
                                        class="fas fa-search text-primary"></i></button>
                                <a href="#" class="position-relative me-4 my-auto">
                                    <i class="fa fa-shopping-bag fa-2x"></i>
                                    <span
                                        class="position-absolute bg-secondary rounded-circle d-flex align-items-center justify-content-center text-dark px-1"
                                        style="top: -5px; left: 15px; height: 20px; min-width: 20px;"
                                        id="usercartNumber">3</span>
                                    <!-- 透過ajax查詢該使用者的購物車內有幾個商品 -->
                                </a>
                                <a href="#" class="my-auto">
                                    <i class="fas fa-user fa-2x"></i>
                                </a>
                            </div>
                        </div>
                    </nav>
                </div>
            </div>
            <!-- Navbar End -->
            <!-- Modal Search Start -->
            <div class="modal fade" id="searchModal" tabindex="-1" aria-labelledby="exampleModalLabel"
                aria-hidden="true">
                <div class="modal-dialog modal-fullscreen">
                    <div class="modal-content rounded-0">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Search by keyword</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body d-flex align-items-center">
                            <div class="input-group w-75 mx-auto d-flex">
                                <input type="search" class="form-control p-3" placeholder="keywords"
                                    aria-describedby="search-icon-1">
                                <span id="search-icon-1" class="input-group-text p-3"><i
                                        class="fa fa-search"></i></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Modal Search End -->
            <!-- Single Page Header start -->
            <div class="container-fluid page-header py-5">
                <h1 class="text-center text-white display-6">我的商品</h1>
                <ol class="breadcrumb justify-content-center mb-0">
                    <li class="breadcrumb-item active text-white"><a href="#">我的商品</a></li>
                    <li class="breadcrumb-item"><a href="#">新增商品</a></li>
                </ol>
            </div>
            <!-- Single Page Header End -->
            <div id="layoutSidenav">

                <div id="layoutSidenav_content">
                    <main>
                        <div class="container-fluid px-4">

                            <div class="card mb-4">
                                <div class="card-header">
                                    <!-- <i class="fas fa-table me-1"></i> -->
                                    <button class="btn btn-sm btn-plus rounded-circle bg-light border"
                                        id="gotoInsertPage"> <!-- 前往新增商品葉面 -->
                                        <i class="fa fa-plus"></i>
                                    </button>
                                    <span>新增商品</span>
                                </div>
                                <div class="table-responsive"> <!-- 裡面放的是table標籤 -->
                                    <table id="datatablesSimple" class="table">
                                        <thead> <!-- 商品描述透過跳脫視窗呈現 -->
                                            <tr>
                                                <th scope="col">商品編號</th>
                                                <th scope="col">商品名稱</th>
                                                <th scope="col">封面照片</th>
                                                <th scope="col">商品種類</th>
                                                <th scope="col">上架日期</th>
                                                <th scope="col">品牌</th>
                                                <th scope="col">出發地</th>
                                                <th scope="col">賣家編號</th>
                                                <th scope="col">修改商品</th> <!-- 點擊後進入修改頁面 -->
                                            </tr>
                                        </thead>
                                        <tfoot>
                                            <tr>
                                                <th scope="col">商品編號</th>
                                                <th scope="col">商品名稱</th>
                                                <th scope="col">封面照片</th>
                                                <th scope="col">商品種類</th>
                                                <th scope="col">上架日期</th>
                                                <th scope="col">品牌</th>
                                                <th scope="col">出發地</th>
                                                <th scope="col">賣家編號</th>
                                                <th scope="col">修改商品</th> <!-- 點擊後進入修改頁面 -->
                                            </tr>
                                        </tfoot>
                                        <tbody id="GoodBasicData">

                                        </tbody>
                                    </table>
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
            <script src="https://cdn.ckeditor.com/ckeditor5/41.3.1/super-build/ckeditor.js"></script>
            <!-- JavaScript Libraries -->
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
            <!--  -->
            <!-- <script src="../../frontlib/easing/easing.min.js"></script> -->
            <script src="../../frontlib/easing/easing.min.js"></script>

            <!-- <script src="../../frontlib/waypoints/waypoints.min.js"></script> -->
            <script src="../../frontlib/waypoints/waypoints.min.js"></script>

            <!-- <script src="../../frontlib/lightbox/js/lightbox.min.js"></script> -->
            <script src="../../frontlib/lightbox/js/lightbox.min.js"></script>

            <script src="../../frontlib/owlcarousel/owl.carousel.min.js"></script>

            <script src="../../frontjs/main.js"></script>
            <script>
                $('#gotoInsertPage').click(function () { })

            </script>
        </body>

        </html>