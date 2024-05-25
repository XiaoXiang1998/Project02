<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="utf-8" />
            <meta http-equiv="X-UA-Compatible" content="IE=edge" />
            <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
            <meta name="description" content="" />
            <meta name="author" content="" />
            <title>Tables - SB Admin</title>
            <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
            <link href="css/styles.css" rel="stylesheet" />
            <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>

        </head>

        <body class="sb-nav-fixed">
            <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
                <!-- Navbar Brand-->
                <a class="navbar-brand ps-3" href="index.html">Start Bootstrap</a>
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
                <%@ include file="../../AllNav.jsp" %>

                    <div id="layoutSidenav_content">
                        <main>
                            <div class="container-fluid px-4">
                                <h1 class="mt-4 mb-4">商品圖表</h1>
                                

                                <div class="card mb-4">
                                    <div class="card-header">
                                        <i class="fas fa-chart-area me-1"></i>
                                        七天前每天商品的銷售量
                                    </div>
                                    <div class="card-body"><canvas id="myAreaChart" width="100%" height="30"></canvas>
                                    </div>
                                    <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-6">
                                        <div class="card mb-4">
                                            <div class="card-header">
                                                <i class="fas fa-chart-bar me-1"></i>
                                                七天前每天新增的數量
                                            </div>
                                            <div class="card-body"><canvas id="myBarChart" width="100%"
                                                    height="50"></canvas></div>
                                            <div class="card-footer small text-muted">Updated yesterday at 11:59 PM
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="card mb-4">
                                            <div class="card-header">
                                                <i class="fas fa-chart-pie me-1"></i>
                                                商城種類占比
                                            </div>
                                            <div class="card-body"><canvas id="myPieChart" width="100%"
                                                    height="50"></canvas></div>
                                            <div class="card-footer small text-muted">Updated yesterday at 11:59 PM
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
            <script src="https://code.jquery.com/jquery-3.7.1.min.js"
                integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                crossorigin="anonymous"></script>
            <script src="js/scripts.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
                crossorigin="anonymous"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
                crossorigin="anonymous"></script>
            <script src="https://cdn.jsdelivr.net/gh/google/palette.js@master/palette.js"></script>
            <script src="js/datatables-simple-demo.js"></script>
            <!-- <script src="assets/demo/chart-area-demo.js"></script>
            <script src="assets/demo/chart-bar-demo.js"></script>
            <script src="assets/demo/chart-pie-demo.js"></script> -->
            <script>
                Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
                Chart.defaults.global.defaultFontColor = '#292b2c';
                $.ajax({ //圓餅圖(商品資料庫內的商品組成)
                    type: "get",
                    url: "mangerGoodTypePie",//取種類對應的數量{"goodsTypeNumber":2,"goodsType":"寵物"}
                    success: function (inputdata) {
                        let labeldata = [];
                        let datas = [];
                        $.each(inputdata, function (i, n) {
                            labeldata[i] = n.goodsType;
                            datas[i] = n.goodsTypeNumber;
                        })

                        var ctxPie = document.getElementById("myPieChart");
                        var myPieChart = new Chart(ctxPie, {
                            type: 'pie',
                            data: {
                                labels: labeldata,
                                datasets: [{
                                    data: datas,
                                    backgroundColor: palette('tol', labeldata.length).map(function (hex) {
                                        return '#' + hex;
                                    })
                                }],
                            },
                        });
                    }
                })
                //每天商品新增的數量
                $.ajax({
                    type: "get",
                    url: "numberOfGoodInsert",//取種類對應的數量{"goodsNumber":2,"date":"2024-05-21"}
                    success: function (inputdata) {
                        let labeldata = [];
                        let datas = [];
                        $.each(inputdata, function (i, n) {
                            labeldata[i] = n.date;
                            datas[i] = n.goodsNumber;
                        })

                        var ctxBar = document.getElementById("myBarChart");
                        var myPieChart = new Chart(ctxBar, {
                            type: 'bar',
                            data: {
                                labels: labeldata,
                                datasets: [{
                                    label: "新增數量",
                                    backgroundColor: "rgba(2,117,216,1)",
                                    borderColor: "rgba(2,117,216,1)",
                                    data: datas,
                                }],
                            }
                        });
                    }
                })
                // 曲線圖
                $.ajax({
                    type: "get",
                    url: "numberOfGoodSold",//取種類對應的數量{"goodsNumber":2,"date":"2024-05-21"}
                    success: function (inputdata) {
                        //
                        labelsList = [];
                        datas = [];
                        $.each(inputdata, function (i, n) {
                            labelsList[i] = n.date;
                            datas[i] = n.goodsNumber;
                        })
                        var ctx = document.getElementById("myAreaChart");
                        var myLineChart = new Chart(ctx, {
                            type: 'line',
                            data: {
                                labels: labelsList,
                                datasets: [{
                                    label: "獲利",
                                    lineTension: 0.3,
                                    backgroundColor: "rgba(2,117,216,0.2)",
                                    borderColor: "rgba(2,117,216,1)",
                                    pointRadius: 5,
                                    pointBackgroundColor: "rgba(2,117,216,1)",
                                    pointBorderColor: "rgba(255,255,255,0.8)",
                                    pointHoverRadius: 5,
                                    pointHoverBackgroundColor: "rgba(2,117,216,1)",
                                    pointHitRadius: 50,
                                    pointBorderWidth: 2,
                                    data: datas,
                                }],
                            },
                            // options: {
                            //     scales: {
                            //         xAxes: [{
                            //             time: {
                            //                 unit: 'date'
                            //             },
                            //             gridLines: {
                            //                 display: false
                            //             },
                            //             ticks: {
                            //                 maxTicksLimit: 7
                            //             }
                            //         }],
                            //         yAxes: [{
                            //             ticks: {
                            //                 min: 0,
                            //                 max: 40000,
                            //                 maxTicksLimit: 5
                            //             },
                            //             gridLines: {
                            //                 color: "rgba(0, 0, 0, .125)",
                            //             }
                            //         }],
                            //     },
                            //     legend: {
                            //         display: false
                            //     }
                            // }
                        });
                        //
                    }
                })


            </script>
        </body>

        </html>