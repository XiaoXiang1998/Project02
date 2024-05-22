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
                <div id="layoutSidenav_nav">
                    <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                        <div class="sb-sidenav-menu">
                            <div class="nav">
                                <div class="sb-sidenav-menu-heading">Core</div>
                                <a class="nav-link" href="index.html">
                                    <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                                    Dashboard
                                </a>
                                <div class="sb-sidenav-menu-heading">Interface</div>
                                <a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
                                    data-bs-target="#collapseLayouts" aria-expanded="false"
                                    aria-controls="collapseLayouts">
                                    <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                                    Layouts
                                    <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                                </a>
                                <div class="collapse" id="collapseLayouts" aria-labelledby="headingOne"
                                    data-bs-parent="#sidenavAccordion">
                                    <nav class="sb-sidenav-menu-nested nav">
                                        <a class="nav-link" href="layout-static.html">Static Navigation</a>
                                        <a class="nav-link" href="layout-sidenav-light.html">Light Sidenav</a>
                                    </nav>
                                </div>
                                <a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
                                    data-bs-target="#collapsePages" aria-expanded="false" aria-controls="collapsePages">
                                    <div class="sb-nav-link-icon"><i class="fas fa-book-open"></i></div>
                                    Pages
                                    <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                                </a>
                                <div class="collapse" id="collapsePages" aria-labelledby="headingTwo"
                                    data-bs-parent="#sidenavAccordion">
                                    <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPages">
                                        <a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
                                            data-bs-target="#pagesCollapseAuth" aria-expanded="false"
                                            aria-controls="pagesCollapseAuth">
                                            Authentication
                                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i>
                                            </div>
                                        </a>
                                        <div class="collapse" id="pagesCollapseAuth" aria-labelledby="headingOne"
                                            data-bs-parent="#sidenavAccordionPages">
                                            <nav class="sb-sidenav-menu-nested nav">
                                                <a class="nav-link" href="login.html">Login</a>
                                                <a class="nav-link" href="register.html">Register</a>
                                                <a class="nav-link" href="password.html">Forgot Password</a>
                                            </nav>
                                        </div>
                                        <a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
                                            data-bs-target="#pagesCollapseError" aria-expanded="false"
                                            aria-controls="pagesCollapseError">
                                            Error
                                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i>
                                            </div>
                                        </a>
                                        <div class="collapse" id="pagesCollapseError" aria-labelledby="headingOne"
                                            data-bs-parent="#sidenavAccordionPages">
                                            <nav class="sb-sidenav-menu-nested nav">
                                                <a class="nav-link" href="401.html">401 Page</a>
                                                <a class="nav-link" href="404.html">404 Page</a>
                                                <a class="nav-link" href="500.html">500 Page</a>
                                            </nav>
                                        </div>
                                    </nav>
                                </div>
                                <div class="sb-sidenav-menu-heading">Addons</div>
                                <a class="nav-link" href="charts.html">
                                    <div class="sb-nav-link-icon"><i class="fas fa-chart-area"></i></div>
                                    Charts
                                </a>
                                <a class="nav-link" href="tables.html">
                                    <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                                    Tables
                                </a>
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
                            <h1 class="mt-4">Tables</h1>
                            <ol class="breadcrumb mb-4">
                                <li class="breadcrumb-item"><a href="index.html">Dashboard</a></li>
                                <li class="breadcrumb-item active">Tables</li>
                            </ol>

                            <div class="card mb-4">
                                <div class="card-header" id="goodstatus">
                                    <i class="fas fa-table me-1"></i>
                                    <span>全部商品</span>
                                </div>
                                <div class="card-body">
                                    <button class="btn btn-outline-primary goodstatuschoose" type="button">上架商品</button>
                                    <button class="btn btn-outline-primary goodstatuschoose" type="button">下架商品</button>
                                    <button class="btn btn-outline-primary goodstatuschoose" type="button">全部商品</button>
                                    <input type="text" name="SearchGood" class="ms-5" placeholder="搜尋商品"
                                        id="SearchGood">
                                    <button class="btn btn-outline-primary" id="SearchGoodBtn" type="button"><i
                                            class="fas fa-search"></i></button>
                                    <span id="errmsg" style="color: red;"></span>
                                    <p id="searchName"></p>
                                    <table id="mytable">

                                    </table>
                                </div>
                            </div>
                            <div id="PageList">

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
            <script src="js/datatables-simple-demo.js"></script>
            <script>

                var indexPage = 1;
                $('.goodstatuschoose').click(function () {//當點擊上下架分類時 直接觸發ajax
                    let status = $(this).prop("innerHTML");
                    $('#goodstatus').find('span').prop("innerHTML", status);
                    $('#searchName').prop("innerHTML", "");
                    $('#SearchGood').prop("value", "");
                    loadPage(1, status, "XXX");
                })
                $('#SearchGoodBtn').click(function () {
                    console.log("12313123");
                    let goodName = $('#SearchGood').val(); console.log(goodName);
                    let status = $('#goodstatus').find('span').prop('innerHTML');
                    console.log(status);
                    if (goodName == "") {
                        $('#errmsg').prop("innerHTML", "write something");
                    }
                    else {
                        $('#errmsg').prop("innerHTML", "");
                        $('#searchName').prop("innerHTML", `搜尋"` + goodName + `"的結果`);
                        loadPage(indexPage, status, goodName);
                    }
                })

                $(function () {//進來網頁時展示全部商品的內容
                    loadPage(indexPage, "全部商品", "XXX");
                })
                function change(page) {//點擊頁面按鈕時，觸發ajax
                    indexPage = page;
                    let status = $('#goodstatus').find('span').prop('innerHTML');
                    let goodNameTarget = $('#searchName').prop("innerHTML");
                    if (goodNameTarget == "") {
                        loadPage(indexPage, status, "XXX");
                    }
                    else {
                        let goodName = goodNameTarget.substring(3, goodNameTarget.length - 4);
                        loadPage(indexPage, status, goodName);
                    }
                }
                function loadPage(indexPage, status, goodName) {//全部基本商品資訊(包括狀態)
                    Basicinfo = [];
                    let hidden = indexPage + "_" + status + "_" + goodName;
                    console.log(hidden);
                    $.ajax({

                        type: 'get',

                        url: '/mangerqueryByPageStatus/' + hidden,

                        contentType: 'application/json',

                        success: function (inputdata1) {
                            var tabledata;
                            console.log($('#mytable').children().length);
                            let inputdata = inputdata1.good; console.log(inputdata);
                            if ($('#mytable').children().length == 0) {//new dataTable
                                tabledata = new simpleDatatables.DataTable('#mytable', {
                                    searchable: false,
                                    fixedHeight: true,
                                    lengthMenu: -1,
                                });
                                if (inputdata == null) {
                                    console.log("NO DATA");
                                    $('#mytable').prepend('<tr><td>No Result</td></tr>');//將table內的資料清空
                                }
                                else {

                                    $.each(inputdata, function (i, n) {
                                        Basicinfo[i] = [n.goodsID, n.goodsName, `<img src="` + n.titleImage + `" alt="" class="w-100 img-fluid" style="width: 150px;height: 100px;">`, n.goodsDirection, n.goodsType, n.launchDate, n.brand, n.shipmentPlace, n.goodsSellerID.sid, `<button type="button" class="btn btn-outline-primary">DetailGood</button>`,
                                        `<div class="form-check">
                                            <input class="form-check-input" type="radio" name="flexRadioDefault`+ i + `" checked>
                                            <label class="form-check-label">
                                                上架
                                            </label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="flexRadioDefault`+ i + `">
                                            <label class="form-check-label">
                                                下架
                                            </label>
                                        </div>`];
                                    });

                                    console.log(Basicinfo);
                                    let newData = {
                                        headings: ["GoodsID", "goodsName", "titleImage", "goodsDirection", "goodsType", "launchDate", "brand", "shipmentPlace", "goodsSellerID", "GoodDetail", "GoodStatus"],
                                        data: Basicinfo,
                                    };
                                    // let columns = tabledata.columns; console.log(columns);
                                    tabledata.insert(newData);
                                    //插入頁數按鈕
                                    let pageNumber = inputdata1.page;//取得總頁數
                                    // <button class="btn btn-outline-primary" type="button" onclick="change(${i})">${i}</button>
                                    for (let j = 1; pageNumber >= j; j++) {
                                        let btn = document.createElement("button"); btn.classList.add("btn"); btn.classList.add("btn-outline-primary");
                                        btn.setAttribute("type", "button"); btn.setAttribute("onclick", `change("` + (j) + `")`);
                                        btn.innerHTML = j;
                                        $('#PageList').append(btn);
                                    }
                                }
                            }
                            else { //如果有資料需要將table淨空
                                // tabledata = document.querySelector(".datatable-wrapper");
                                tabledata = $(".datatable-wrapper");
                                console.log(tabledata[0]);//取得整個dataTable的outterHTML
                                let target = tabledata.find('#mytable>tbody>tr');
                                let arrtarget = [...target];
                                $.each(arrtarget, function (i, n) {
                                    arrtarget[i].innerHTML = "";
                                })
                                $.each(inputdata, function (i, n) {
                                    let insertcontent = `<td>` + n.goodsID + `</td><td>` + n.goodsName + `</td><td>` + `<img src="` + n.titleImage + `" alt="" class="w-100 img-fluid" style="width: 150px;height: 100px;">` +
                                        `</td><td>` + n.goodsDirection + `</td><td>` + n.goodsType + `</td><td>` + n.launchDate + `</td><td>` + n.brand +
                                        `</td><td>` + n.shipmentPlace + `</td><td>` + n.goodsSellerID.sid + `</td><td>` + `<button type="button" class="btn btn-outline-primary">DetailGood</button></td>`;
                                    insertcontent = insertcontent + `<td><div class="form-check">
                                            <input class="form-check-input" type="radio" name="flexRadioDefault`+ i + `" checked>
                                            <label class="form-check-label">
                                                上架
                                            </label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="flexRadioDefault`+ i + `">
                                            <label class="form-check-label">
                                                下架
                                            </label>
                                        </div></td>`;
                                    arrtarget[i].innerHTML = insertcontent;
                                });
                                let pageNumber = inputdata1.page;//取得總頁數
                                // <button class="btn btn-outline-primary" type="button" onclick="change(${i})">${i}</button>
                                $('#PageList').empty();
                                for (let j = 1; pageNumber >= j; j++) {
                                    let btn = document.createElement("button"); btn.classList.add("btn"); btn.classList.add("btn-outline-primary");
                                    btn.setAttribute("type", "button"); btn.setAttribute("onclick", `change("` + (j) + `")`);
                                    btn.innerHTML = j;
                                    $('#PageList').append(btn);
                                }
                            }
                        }
                    })

                }

                $(document).on('click', '#mytable>tbody>tr>td:not(:last-child)', function () {
                    let form = document.createElement("form"); form.setAttribute("method", "get"); form.setAttribute("action", "goodDetailReviewByManger.controller");
                    form.setAttribute("enctype", "multipart/form-data");
                    // let formdata = new FormData();
                    let goodID = $(this).closest('tr').children()[0].innerHTML.trim(); console.log("goodID = " + goodID);
                    let input1 = document.createElement("input"); input1.setAttribute("type", "text"); input1.setAttribute("name", "GoodID"); input1.setAttribute("value", goodID);
                    form.append(input1);
                    $(document.body).append(form);
                    // formdata.append("goodID", goodID);

                    // console.log(formdata.get("goodID"));
                    // console.log(formdata);
                    form.submit();
                })
                $(document).on('change', '.form-check-input', function () {//觸發ajax改變商品上下架狀態
                    console.log("你點到我了");

                })


            </script>
        </body>

        </html>