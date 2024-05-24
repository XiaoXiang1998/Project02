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
                <%@ include file="../../AllNav.jsp" %>
                    <div id="layoutSidenav_content">
                        <main>
                            <div class="container-fluid px-4">
                                <h1 class="mt-4">商品資料庫</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item"><a href="index.html">Dashboard</a></li>
                                    <li class="breadcrumb-item active">Tables</li>
                                </ol>
                                <!-- table標籤 -->
                                <div class="card mb-4">
                                    <div class="card-header" id="goodstatus">
                                        <i class="fas fa-table me-1"></i>
                                        <span>全部商品</span>
                                    </div>
                                    <div class="card-body">
                                        <button class="btn btn-outline-primary goodstatuschoose"
                                            type="button">上架商品</button>
                                        <button class="btn btn-outline-primary goodstatuschoose"
                                            type="button">下架商品</button>
                                        <button class="btn btn-outline-primary goodstatuschoose"
                                            type="button">違規商品</button>
                                        <button class="btn btn-outline-primary goodstatuschoose"
                                            type="button">全部商品</button>
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
                                $('.datatable-dropdown').prop("hidden", true);
                                if (inputdata == null) {
                                    console.log("NO DATA");
                                    $('#mytable').prepend('<tr><td>No Result</td></tr>');//將table內的資料清空
                                }
                                else {

                                    $.each(inputdata, function (i, n) {
                                        var statuscontent;
                                        console.log(n.status);
                                        // 
                                        switch (n.status) {
                                                case 0:
                                                statuscontent = `<div class="form-check">
                                                                    <input class="form-check-input" type="radio" name="flexRadioDefault`+ i + `" value="YES">
                                                                    <label class="form-check-label">
                                                                        上架
                                                                    </label>
                                                                </div>
                                                                <div class="form-check">
                                                                    <input class="form-check-input" type="radio" name="flexRadioDefault`+ i + `" value="NO" checked>
                                                                    <label class="form-check-label">
                                                                        下架
                                                                    </label>
                                                                </div>
                                                                <div class="form-check">
                                                                    <input class="form-check-input" type="radio" name="flexRadioDefault`+ i + `" value="BAD">
                                                                    <label class="form-check-label">
                                                                        違禁
                                                                    </label>
                                                                </div>`;
                                                    break;
                                                case 1:
                                                statuscontent = `<div class="form-check">
                                                                    <input class="form-check-input" type="radio" name="flexRadioDefault`+ i + `" value="YES" checked>
                                                                    <label class="form-check-label">
                                                                        上架
                                                                    </label>
                                                                </div>
                                                                <div class="form-check">
                                                                    <input class="form-check-input" type="radio" name="flexRadioDefault`+ i + `" value="NO">
                                                                    <label class="form-check-label">
                                                                        下架
                                                                    </label>
                                                                </div>
                                                                <div class="form-check">
                                                                    <input class="form-check-input" type="radio" name="flexRadioDefault`+ i + `" value="BAD">
                                                                    <label class="form-check-label">
                                                                        違禁
                                                                    </label>
                                                                </div>`;
                                                    break;
                                                case -1:
                                                statuscontent = `<div class="form-check"> 
                                                            <input class="form-check-input" type="radio" name="flexRadioDefault`+ i + `" value="YES" >
                                                            <label class="form-check-label">
                                                                上架
                                                            </label>
                                                        </div>
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="radio" name="flexRadioDefault`+ i + `" value="NO" >
                                                            <label class="form-check-label">
                                                                下架
                                                            </label>
                                                        </div><div class="form-check">
                                                            <input class="form-check-input" type="radio" name="flexRadioDefault`+ i + `" value="BAD" checked >
                                                            <label class="form-check-label">
                                                                違禁
                                                            </label>
                                                        </div>`;
                                                    break;
                                                default:
                                                    console.log("n.status = "+n.status);
                                            }
                                        // 
                                        Basicinfo[i] = [n.goodsID, n.goodsName, `<img src="` + n.titleImage + `" alt="" class="w-100 img-fluid" style="width: 150px;height: 100px;">`, n.goodsType, n.launchDate, n.brand, n.shipmentPlace, n.goodsSellerID.sid, statuscontent
                                        ];
                                    });

                                    console.log(Basicinfo);
                                    let newData = {
                                        headings: ["GoodsID", "goodsName", "titleImage", "goodsType", "launchDate", "brand", "shipmentPlace", "goodsSellerID", "GoodStatus"],
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
                                        `</td><td>` + n.goodsType + `</td><td>` + n.launchDate + `</td><td>` + n.brand +
                                        `</td><td>` + n.shipmentPlace + `</td><td>` + n.goodsSellerID.sid + `</td>`;
                                    // 
                                    switch (n.status) {
                                                case 0:
                                                statuscontent = `<td><div class="form-check">
                                                            <input class="form-check-input" type="radio" name="flexRadioDefault`+ i + `" value="YES">
                                                            <label class="form-check-label">
                                                                上架
                                                            </label>
                                                        </div>
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="radio" name="flexRadioDefault`+ i + `" value="NO" checked>
                                                            <label class="form-check-label">
                                                                下架
                                                            </label>
                                                        </div>
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="radio" name="flexRadioDefault`+ i + `" value="BAD" >
                                                            <label class="form-check-label">
                                                                違禁
                                                            </label>
                                                        </div></td>`;
                                                        insertcontent = insertcontent+statuscontent;
                                                    break;
                                                case 1:
                                                statuscontent = `<td><div class="form-check">
                                                                    <input class="form-check-input" type="radio" name="flexRadioDefault`+ i + `" value="YES" checked>
                                                                    <label class="form-check-label">上架</label>
                                                                </div>
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="radio" name="flexRadioDefault`+ i + `" value="NO">
                                                            <label class="form-check-label">下架</label>
                                                        </div>
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="radio" name="flexRadioDefault`+ i + `" value="BAD" >
                                                            <label class="form-check-label">違禁</label>
                                                        </div></td>`;
                                                        insertcontent = insertcontent+statuscontent;
                                                    break;
                                                case -1:
                                                statuscontent = `<td><div class="form-check">
                                                            <input class="form-check-input" type="radio" name="flexRadioDefault`+ i + `" value="YES" >
                                                            <label class="form-check-label">
                                                                上架
                                                            </label>
                                                        </div>
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="radio" name="flexRadioDefault`+ i + `" value="NO" >
                                                            <label class="form-check-label">
                                                                下架
                                                            </label>
                                                        </div><div class="form-check">
                                                            <input class="form-check-input" type="radio" name="flexRadioDefault`+ i + `" value="BAD" checked >
                                                            <label class="form-check-label">
                                                                違禁
                                                            </label>
                                                        </div></td>`;
                                                        insertcontent = insertcontent+statuscontent;
                                                    break;
                                                default:
                                                    console.log("n.status = "+n.status);
                                            }
                                    // 
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
                //檢閱詳細商品資訊
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
                //改變上下架、違禁狀態
                $(document).on('change', '.form-check-input', function () {//觸發ajax改變商品上下架狀態
                    let targettd = $(this).closest('tr').find('td');
                    let goodIDResult = [...targettd][0].innerHTML.trim();
                    let statusResult = $(this).prop("value"); console.log(statusResult);
                    var params = { status: statusResult, GoodID: goodIDResult };
                    console.log(params);
                    $.ajax({
                        type: "get",
                        url: "modifyGoodStatus",
                        dataType: "json",
                        contentType: "application/json",
                        data: params,
                        success: function (data) {//假若點擊上架 出現上架分類；反之則出現下架分類
                            console.log("更改成功");
                            // if (statusResult == "YES") { //上架商品
                            //     console.log($('#goodstatus').find('span[id="goodstatusmsg"]'));
                            //     $('#goodstatus').find('span[id="goodstatusmsg"]').prop("innerHTML", "上架商品");
                            //     let sellerID = $('#sellerID').prop("innerHTML");
                            //     loadPage(1, "上架商品", "XXX", sellerID);
                            // }
                            // else {
                            //     if (statusResult == "NO") {//下架商品
                            //         $('#goodstatus').find('span[id="goodstatusmsg"]').prop("innerHTML", "下架商品");
                            //         let sellerID = $('#sellerID').prop("innerHTML");
                            //         loadPage(1, "下架商品", "XXX", sellerID);
                            //     } else {
                            //         console.log(statusResult);
                            //     }
                            // }
                        }
                    })

                })


            </script>
        </body>

        </html>