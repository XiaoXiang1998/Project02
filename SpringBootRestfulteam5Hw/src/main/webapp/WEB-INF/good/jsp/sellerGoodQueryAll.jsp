<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Insert title here</title>
            <!-- Google Web Fonts -->
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
            <script src="https://kit.fontawesome.com/92a295a0cf.js" crossorigin="anonymous"></script>
            <link
                href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
                rel="stylesheet">
            <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
            <!-- Icon Font Stylesheet -->
            <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
            <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

            <!-- Libraries Stylesheet -->
            <!-- <link href="frontlib/lightbox/css/lightbox.min.css" rel="stylesheet"> -->
            <link href="../../frontlib/lightbox/css/lightbox.min.css" rel="stylesheet">

            <!-- <link href="frontlib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet"> -->
            <link href="../../frontlib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


            <!-- <link href="frontcss/bootstrap.min.css" rel="stylesheet"> -->

            <link href="../../frontcss/bootstrap.min.css" rel="stylesheet">

            <!-- Template Stylesheet -->
            <!-- <link href="frontcss/style.css" rel="stylesheet"> -->

            <link href="../../frontcss/style.css" rel="stylesheet">
            <link href="css/styles.css" rel="stylesheet" />
            <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>

            <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
        </head>

        <body>
            <%@ include file="../../FrontDeskNav.jsp" %>

                <div class="container-fluid">
                    <span id="sellerID" hidden>${sellerID}</span>
                </div>
                <!-- Cart Page Start -->

                <!-- <div class="table-responsive">
                <div id="goodstatus">
                    <i class="fas fa-table me-1"></i>
                    <span>全部商品</span>
                </div>
                <button class="btn btn-outline-primary goodstatuschoose" type="button">上架商品</button>
                <button class="btn btn-outline-primary goodstatuschoose" type="button">下架商品</button>
                <button class="btn btn-outline-primary goodstatuschoose" type="button">全部商品</button>
                <input type="text" name="SearchGood" class="ms-5" placeholder="搜尋商品" id="SearchGood">
                <button class="btn btn-outline-primary" id="SearchGoodBtn" type="button"><i
                        class="fas fa-search"></i></button>
                <span id="errmsg" style="color: red;"></span>
                <p id="searchName"></p>
                <table id="mytable">

                </table>
                <div id="PageList">

                </div>
            </div> -->
                <!--  -->
                <div class="mt-5">

                    <div class="container-fluid px-4 mt-5">
                        <h1 class="mt-4"></h1>
                        <ol class="breadcrumb mb-4">

                        </ol>

                        <div class="card mb-4">
                            <div class="card-header" id="goodstatus">
                                <i class="fas fa-table me-1"></i>
                                <span>全部商品</span>
                                <button type="button" class="btn btn-sm btn-plus rounded-circle bg-light border"
                                    id="insertGood"><i class="fa fa-plus"></i></button>
                                <span>新增商品</span>
                            </div>
                            <div class="card-body">
                                <button class="btn btn-outline-primary goodstatuschoose" type="button">上架商品</button>
                                <button class="btn btn-outline-primary goodstatuschoose" type="button">下架商品</button>
                                <button class="btn btn-outline-primary goodstatuschoose" type="button">全部商品</button>
                                <input type="text" name="SearchGood" class="ms-5" placeholder="搜尋商品" id="SearchGood">
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

                <!--  -->
                <!-- Cart Page End -->

                <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
                    crossorigin="anonymous"></script>
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                <!--  -->
                <script src="../../frontlib/easing/easing.min.js"></script>

                <script src="../../frontlib/waypoints/waypoints.min.js"></script>

                <script src="../../frontlib/lightbox/js/lightbox.min.js"></script>

                <script src="../../frontlib/owlcarousel/owl.carousel.min.js"></script>

                <script src="../../frontjs/main.js"></script>
                <script>
                    var indexPage = 1;
                    //當點擊上下架分類時 直接觸發ajax
                    $('.goodstatuschoose').click(function () {
                        let status = $(this).prop("innerHTML");
                        $('#goodstatus').find('span').prop("innerHTML", status);
                        $('#searchName').prop("innerHTML", "");
                        $('#SearchGood').prop("value", "");
                        //取得sellerID
                        let sellerID = $('#sellerID').prop("innerHTML");
                        loadPage(1, status, "XXX", sellerID);
                    })
                    //在賣家底下搜尋商品
                    $('#SearchGoodBtn').click(function () {
                        console.log("12313123");
                        let goodName = $('#SearchGood').val(); console.log(goodName);
                        let status = $('#goodstatus').find('span').prop('innerHTML');
                        console.log(status);
                        let sellerID = $('#sellerID').prop("innerHTML");
                        if (goodName == "") {
                            $('#errmsg').prop("innerHTML", "write something");
                        }
                        else {
                            $('#errmsg').prop("innerHTML", "");
                            $('#searchName').prop("innerHTML", `搜尋"` + goodName + `"的結果`);
                            // loadPage(indexPage, status, goodName, sellerID);
                            loadPage(1, status, goodName, sellerID);
                        }
                    })
                    //進來網頁時展示全部商品的內容
                    $(function () {
                        let sellerID = $('#sellerID').prop("innerHTML");
                        loadPage(indexPage, "全部商品", "XXX", sellerID);
                    })
                    //點擊頁面按鈕時，觸發ajax
                    function change(page) {
                        indexPage = page;
                        let status = $('#goodstatus').find('span').prop('innerHTML');
                        let sellerID = $('#sellerID').prop("innerHTML");
                        let goodName = $('#searchName').prop("innerHTML");
                        loadPage(indexPage, status, goodName, sellerID);

                    }

                    function loadPage(indexPage, status, goodName, sellerID) {//找尋賣家的所有商品
                        Basicinfo = [];
                        let hidden = indexPage + "_" + status + "_" + goodName + "_" + sellerID;
                        console.log(hidden);
                        $.ajax({

                            type: 'get',

                            url: '/sellerqueryByPageStatus/' + hidden,

                            contentType: 'application/json',

                            success: function (inputdata1) {
                                var tabledata;
                                console.log($('#mytable').children().length);
                                console.log(inputdata1);
                                let inputdata = inputdata1.good; console.log(inputdata);
                                if ($('#mytable').children().length == 0) {//new dataTable
                                    tabledata = new simpleDatatables.DataTable('#mytable', {
                                        searchable: false,
                                        fixedHeight: true,
                                        lengthMenu: -1,
                                    });
                                    $('.datatable-dropdown').prop("outerHTML", "");
                                    if (inputdata == null) {
                                        console.log("NO DATA");
                                        $('#mytable').prepend('<tr><td>No Result</td></tr>');//將table內的資料清空
                                    }
                                    else {

                                        $.each(inputdata, function (i, n) {
                                            var statuscontent;
                                            if(n.status == 0){
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
                                                        </div>`;
                                            }
                                            else{
                                                if(n.status == 1){
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
                                                        </div>`;
                                                }
                                                else{
                                                    console.log("n.status = "+n.status);
                                                }
                                            }
                                            Basicinfo[i] = [n.goodsID, n.goodsName, `<img src="` + n.titleImage + `" alt="" class="w-100 img-fluid" style="width: 150px;height: 100px;">`, n.goodsType, n.launchDate, n.brand, n.shipmentPlace,
                                            statuscontent,
                                                `<button type="button" class="btn btn-md rounded-circle bg-light border modifyGood"><i class="fa-solid fa-wrench"></i></button>`,
                                                `<button type="button" class="btn btn-md rounded-circle bg-light border deleteGood"><i class="fa fa-times text-danger"></i></button>`];
                                        });

                                        console.log(Basicinfo);
                                        let newData = {
                                            headings: ["商品編號", "商品名稱", "封面照", "商品種類", "上架日期", "品牌", "出發地", "上下架狀態", "修改商品", "刪除"],
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
                                        var statuscontent;
                                            if(n.status == 0){
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
                                                        </div></td>`;
                                            }
                                            else{
                                                if(n.status == 1){
                                                    statuscontent = `<td><div class="form-check">
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
                                                        </div></td>`;
                                                }
                                                else{
                                                    console.log("n.status = "+n.status);
                                                }
                                            }
                                        //
                                        let insertcontent = `<td>` + n.goodsID + `</td><td>` + n.goodsName + `</td><td>` + `<img src="` + n.titleImage + `" alt="" class="w-100 img-fluid" style="width: 150px;height: 100px;">` +
                                            `</td><td>` + n.goodsType + `</td><td>` + n.launchDate + `</td><td>` + n.brand + `</td><td>` + n.shipmentPlace +
                                            `</td>`;
                                        insertcontent = insertcontent + statuscontent +
                                            `<td>` +
                                            `<button type="button" class="btn btn-md rounded-circle bg-light border modifyGood"><i class="fa-solid fa-wrench"></i></button>` +
                                            `</td><td>` +
                                            `<button type="button" class="btn btn-md rounded-circle bg-light border deleteGood"><i class="fa fa-times text-danger"></i></button></td>`;
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
                    //檢閱商品詳細資訊
                    $(document).on('click', '#mytable>tbody>tr>td:nth-child(1),#mytable>tbody>tr>td:nth-child(2),#mytable>tbody>tr>td:nth-child(3),#mytable>tbody>tr>td:nth-child(4),#mytable>tbody>tr>td:nth-child(5),#mytable>tbody>tr>td:nth-child(6),#mytable>tbody>tr>td:nth-child(7)', function () {
                        let form = document.createElement("form"); form.setAttribute("method", "get"); form.setAttribute("action", "goodDetailReviewBySeller.controller"); form.setAttribute("hidden", true);
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
                    //賣家修改商品上下架狀態
                    $(document).on('change', '.form-check-input', function () {//觸發ajax改變商品上下架狀態
                        let targettd = $(this).closest('tr').find('td');
                        let goodIDResult = [...targettd][0].innerHTML.trim();
                        let statusResult = $(this).val(); console.log(statusResult);
                        var params = { status: statusResult, GoodID: goodIDResult };
                        $.ajax({
                            type: "get",
                            url: "modifyGoodStatus",
                            dataType: "json",
                            contentType: "application/json",
                            data: params,
                            success: function (data) {
                                console.log("更改成功");
                            }
                        })
                    })
                    //賣家新增商品
                    $('#insertGood').click(function () {
                        let form = document.createElement("form"); form.setAttribute("action", "InsertGood.controller");
                        form.setAttribute("method", "get");
                        $(document.body).append(form);
                        form.submit();
                    })
                    //賣家修改商品
                    $(document).on('click', '.modifyGood', function () {
                        let targettd = $(this).closest('tr').find('td');
                        let goodID = [...targettd][0].innerHTML.trim();
                        let form = document.createElement("form"); form.setAttribute("method", "get"); form.setAttribute("action", "goodMidifyPage.controller");
                        let input1 = document.createElement("input"); input1.setAttribute("type", "text"); input1.setAttribute("name", "GoodID"); input1.setAttribute("value", goodID);
                        form.append(input1);
                        $(document.body).append(form);
                        form.submit();
                        console.log("你點到編輯了");
                    })
                    //賣家刪除商品
                    $(document).on('click', '.deleteGood', function () {
                        let targettd = $(this).closest('tr').find('td');
                        let goodID = [...targettd][0].innerHTML.trim();
                        let form = document.createElement("form"); form.setAttribute("method", "get"); form.setAttribute("action", "goodDelete");
                        let input1 = document.createElement("input"); input1.setAttribute("type", "text"); input1.setAttribute("name", "GoodID"); input1.setAttribute("value", goodID);
                        form.append(input1);
                        $(document.body).append(form);
                        form.submit();
                        console.log("你點到刪除了");
                    })
                   //搜尋商品
                    $('#GoToSearchGood').click(function () {
							let searchGoodInput = $(this).closest('form').find('input');
							console.log(searchGoodInput.prop('value'));
							if (searchGoodInput.prop('value') == null) {
								console.log(searchGoodInput);
							}
							else {
								let form = $(this).closest('form');
								form.attr("action", "/searchGood");
								form.attr("method", "get");
								// console.log(form.prop("innerHTML"));
								form.submit();
							}
						})
                </script>
        </body>

        </html>