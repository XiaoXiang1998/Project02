<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="BIG5">
            <title>Insert title here</title>
            <!-- Google Web Fonts -->
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
            <link
                href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
                rel="stylesheet">

            <!-- Icon Font Stylesheet -->
            <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
            <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

            <!-- Libraries Stylesheet -->
            <link href="../../frontlib/lightbox/css/lightbox.min.css" rel="stylesheet">

            <link href="../../frontlib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


            <link href="../../frontcss/bootstrap.min.css" rel="stylesheet">

            <!-- Template Stylesheet -->
            <link href="../../frontcss/style.css" rel="stylesheet">
            <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
            <script>
                // 透過ajax檢查該使用者購物車內有幾筆商品
                $.ajax({
                    type: 'get',
                    url: "...(要加入使用者編號)",
                    contentType: 'application/json',
                    success: function (data) {
                        if (data.length == 0) {

                        }
                        else {
                            $('#numberGoodInCart').html(data.length)
                        }
                    }
                })
                // $.ajax({//透過上架日期取得商品基本資訊
                //     type: 'get',
                //     url: "indexgoodByLaunchDate",
                //     contentType: 'application/json',
                //     success: function (data) {

                //         //<div class="container-fluid vesitable py-5">
                //         let divcontainer0 = document.createElement("div"); divcontainer0.classList.add("container-fluid"); divcontainer0.classList.add("vesitable"); divcontainer0.classList.add("py-5");
                //         //<div class="container py-5">
                //         let divcontainer1 = document.createElement("div"); divcontainer1.classList.add("container"); divcontainer1.classList.add("py-5");
                //         //     <h1 class="mb-0">Fresh Organic Vegetables</h1>
                //         let h1container1 = document.createElement("h1"); h1container1.classList.add("mb-0"); h1container1.innerHTML = "近期商品";
                //         //     <div class="owl-carousel vegetable-carousel justify-content-center owl-loaded owl-drag">
                //         let divcontainer2 = document.createElement("div"); divcontainer2.classList.add("owl-carousel"); divcontainer2.classList.add("vegetable-carousel"); divcontainer2.classList.add("justify-content-center"); divcontainer2.classList.add("owl-loaded");
                //         divcontainer2.classList.add("owl-drag");
                //         //<div class="owl-stage-outer">
                //         let divcontainer3 = document.createElement("div"); divcontainer3.classList.add("owl-stage-outer");
                //         //             <div class="owl-stage" style="transform: translate3d(-1442px, 0px, 0px); transition: all 0s ease 0s; width: 5768px;">
                //         let divcontainer4 = document.createElement("div"); divcontainer3.classList.add("owl-stage"); divcontainer3.setAttribute("style", "transform: translate3d(-1442px, 0px, 0px); transition: all 0s ease 0s; width: 5768px;")
                //         //         /*上面是前置作業*/

                //         let backdiv1 = document.createElement("div"); backdiv1.classList.add("owl-carousel"); backdiv1.classList.add("vegetable-carousel"); backdiv1.classList.add("justify-content-center");
                //         $.each(data, function (i, n) {
                //             let form = document.createElement("form");
                //             // <div class="border border-primary rounded position-relative vesitable-item">
                //             let div0 = document.createElement("div"); div0.classList.add("border"); div0.classList.add("border-primary"); div0.classList.add("rounded"); div0.classList.add("position-relative"); div0.classList.add("vesitable-item");
                //             //<div class="vesitable-img">
                //             let div1 = document.createElement("div"); div1.classList.add("vesitable-img");
                //             //<img src="../../frontimg/vegetable-item-1.jpg" class="img-fluid w-100 rounded-top" alt="">

                //             let img0 = document.createElement("img"); img0.setAttribute("src", n.titleImage); img0.classList.add("img-fluid");
                //             img0.classList.add("w-100"); img0.classList.add("rounded-top"); img0.setAttribute("alt", n.titleImage); div1.append(img0);
                //             // <div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; right: 10px;">Vegetable</div>
                //             let div2 = document.createElement("div"); div2.classList.add("text-white"); div2.classList.add("bg-primary");
                //             div2.classList.add("px-3"); div2.classList.add("py-1"); div2.classList.add("rounded"); div2.classList.add("position-absolute");
                //             div2.setAttribute("style", "top: 10px; right: 10px;"); div2.innerHTML = n.goodsType;
                //             //     <div class="p-4 rounded-bottom">
                //             let div3 = document.createElement("div"); div3.classList.add("p-4"); div3.classList.add("rounded-bottom");
                //             //         <h4>Parsely</h4>
                //             let h4 = document.createElement("h4"); h4.innerHTML = n.goodsName;
                //             //評分
                //             // <div class="d-flex my-3">
                //             //     <i class="fas fa-star text-primary"></i>
                //             //     <i class="fas fa-star text-primary"></i>
                //             //     <i class="fas fa-star text-primary"></i>
                //             //     <i class="fas fa-star text-primary"></i>
                //             //     <i class="fas fa-star"></i>
                //             // </div>
                //             let div4 = document.createElement("div"); div4.classList.add("d-flex"); div4.classList.add("my-3");
                //             console.log(n.numberRatings);
                //             if (n.numberRatings == 0 || n.numberRatings == null) {//沒人評分
                //                 for (let i = 0; i < 5; i++) {
                //                     let star = document.createElement("i"); star.classList.add("fas"); star.classList.add("fa-star");
                //                     div4.append(star);
                //                 }
                //                 console.log(div4);
                //             }
                //             else {
                //                 let score = Math.round(n.rating / n.numberRatings);
                //                 for (let i = 0; i < 5; i++) {
                //                     if (i < score) {
                //                         let star = document.createElement("i"); star.classList.add("fas"); star.classList.add("fa-star"); star.classList.add("text-primary");
                //                         div4.append(star);
                //                     }
                //                     else {
                //                         let star = document.createElement("i"); star.classList.add("fas"); star.classList.add("fa-star");
                //                         div4.append(star);
                //                     }
                //                 }
                //             }
                //             //         <div class="d-flex justify-content-between flex-lg-wrap">
                //             let div5 = document.createElement("div"); div5.classList.add("d-flex"); div5.classList.add("justify-content-between"); div5.classList.add("flex-lg-wrap");
                //             let ID = n.goodsID;
                //             //取該編號的價格範圍
                //             //             <p class="text-dark fs-5 fw-bold mb-0">$4.99 / kg</p>
                //             $.ajax({
                //                 // [minprice,maxprice,goodsID]
                //                 type: "get",
                //                 // data: { GoodType: n[0] },
                //                 url: "/indexpopulargoodPrice/" + ID,
                //                 contentType: 'application/json',
                //                 success: function (data) {
                //                     console.log(data);
                //                     let content = data[0][0] + "-" + data[0][1] + "$";
                //                     let p = document.createElement('p'); p.classList.add("text-dark"); p.classList.add("fs-5"); p.classList.add("fw-bold");
                //                     p.classList.add("mb-0"); p.innerHTML = content;
                //                     div5.append(p);
                //                 }
                //             })
                //             //
                //             // <h1 class="mb-0">近期商品</h1 >
                //             //     <div class="owl-carousel vegetable-carousel justify-content-center">
                //             let goodinput = document.createElement("input"); goodinput.setAttribute("type", "text"); goodinput.setAttribute("class", "form-control"); goodinput.setAttribute("name", "GoodID"); goodinput.setAttribute("value", ID); goodinput.setAttribute("hidden", true);
                //             div3.append(h4); div3.append(div4); div3.append(div5);
                //             div0.append(div1); div0.append(div2); div0.append(div3); form.append(div0); form.append(goodinput);
                //             backdiv1.append(form);
                //         })
                //         let backh1 = document.createElement("h1"); backh1.classList.add("mb-0"); backh1.innerHTML = "近期商品";
                //         $('#testtarget').append(backh1); $('#testtarget').append(backdiv1);

                //     }
                // })
                /*間隔*/
                // 透過ajax取得活動資料(目前活動功能是未知數)
                $.ajax({
                    type: 'get',
                    url: "...(透過活動狀態取得活動資料)",
                    contentType: 'application/json',
                    success: function (data) {
                        if (data.length == 0) {
                            //沒有活動 敬請期待
                        }
                        else {
                            $.each(data, function (i, n) {
                                let content = `<div class="carousel-item rounded">
                                        <img src="`+ n.activityImage + `" class="img-fluid w-100 h-100 rounded"
                                            alt="Second slide"> 
                                            <form action="">
                                                <input type="text" value="`+ n.activityID + `" name="activityID">
                                            </form>
                                    </div>`
                            })
                        }
                    }
                })

                $.ajax({// 透過ajax取得商品基本資料表中所有種類商品(目前order資料表中沒有資料)
                    // select TOP 5 GoodType 
                    // from Orders o join GoodFormat gf on o.FK_FORMATGOODID = gf.goodFormatID
                    //               join Good g on gf.goodID = g.goodID
                    // group by g.goodType
                    // order by sum(o.quantity)
                    /**/
                    // select TOP 5 GoodType 
                    // from Good g 
                    // group by g.goodType

                    type: 'get',
                    url: "indexpopulargoodtype",
                    contentType: 'application/json',
                    success: function (data) {//取得五筆商品種類 還需要取得各種類中的前20名商品
                        if (data.length == 0) {
                            //沒有商品
                        }
                        else {
                            let check = 0;
                            $.each(data, function (i, n) { //將得到的種類插入置網頁內
                                let li = document.createElement('li'); li.classList.add("nav-item");
                                let a = document.createElement('a');
                                a.classList.add("d-flex"); a.classList.add("m-2"); a.classList.add("py-2"); a.classList.add("bg-light");
                                a.classList.add("rounded-pill");
                                if (check == 0) {
                                    a.classList.add("active");
                                    check++;
                                }
                                a.setAttribute("data-bs-toggle", "pill"); a.setAttribute("href", "#tab-" + (i + 1));
                                let span = document.createElement('span');
                                span.classList.add("text-dark"); span.setAttribute("style", "width: 130px"); span.setAttribute("data-typeName", n);
                                span.innerHTML = n;
                                a.append(span); li.append(a);
                                // let content = `<li class="nav-item">`+
                                //     `<a class="d-flex m-2 py-2 bg-light rounded-pill active" data-bs-toggle="pill" href="#tab-`+ (i+1) +`">`+
                                //         `<span class="text-dark" style="width: 130px;" data-index="`+ n +`">`+ n +`</span>`+
                                //     `</a>`+
                                // `</li>`;
                                $('#CategoryList').append(li);
                            })
                        }
                    }
                }).then(function (res) {// 還需要取得各種類中的前10名商品
                    // select GoodType 
                    // from Orders o join GoodFormat gf on o.FK_FORMATGOODID = gf.goodFormatID
                    //               join Good g on gf.goodID = g.goodID
                    // group by g.goodType
                    // where g.goodsType = ? 
                    // order by sum(o.quantity)
                    /*訂單內沒資料 所以只取商品種類中的所有商品*/
                    // select * 
                    // from Good g 
                    // where g.goodsType = ? 
                    $.each(res, function (i, n) { //透過商品種類名稱個別去取得10筆資料
                        // n是商品種類名稱
                        let GoodType = n;
                        GetGoodTypePopular(GoodType);
                    })
                })
                function GetGoodTypePopular(GoodType) {
                    console.log("GoodType in GetGoodTypePopular = " + GoodType);
                    let check = 0
                    $.ajax({
                        type: "get",
                        // data: { GoodType: n },
                        url: "indexpopulargood/" + GoodType,
                        contentType: 'application/json',
                        success: function (data) {//取得該種類中的10筆資料
                            let tabhref = $('span[data-typeName="' + GoodType + '"]').closest('a').attr("href");
                            let tabhrefID = tabhref.substring(5); console.log(tabhrefID);
                            let divcontain0 = document.createElement('div'); divcontain0.setAttribute("id", "tab-" + tabhrefID);
                            divcontain0.classList.add("tab-pane"); divcontain0.classList.add("fade"); divcontain0.classList.add("show");
                            divcontain0.classList.add("p-0");
                            if (check == 0 && tabhrefID == 1) {
                                divcontain0.classList.add("active");
                                check++;
                            }
                            //
                            let divcontain1 = document.createElement('div'); divcontain1.classList.add("row"); divcontain1.classList.add("g-4");
                            let divcontain2 = document.createElement('div'); divcontain2.classList.add("col-lg-12");
                            let divcontain3 = document.createElement('div'); divcontain3.classList.add("row"); divcontain3.classList.add("g-4");

                            divcontain0.append(divcontain1); divcontain1.append(divcontain2); divcontain2.append(divcontain3);

                            $.each(data, function (i, n) {
                                //n:[GoodsID,GoodsType,GoodsName,TitleImage](要不要加入販賣數量、評分數)
                                let div0 = document.createElement('div'); div0.classList.add("col-md-6"); div0.classList.add("col-lg-4"); div0.classList.add("col-xl-3");
                                let div1 = document.createElement('div'); div1.classList.add("rounded"); div1.classList.add("position-relative"); div1.classList.add("fruite-item");
                                let div2 = document.createElement('div'); div2.classList.add("fruite-img");
                                let img0 = document.createElement('img');//將圖片插入
                                img0.setAttribute("src", n[3]); img0.classList.add("img-fluid"); img0.classList.add("w-100");
                                img0.classList.add("rounded-top"); img0.setAttribute("alt", n[3]);//封面照片
                                div2.append(img0);
                                let div3 = document.createElement('div'); div3.classList.add("text-white"); div3.classList.add("bg-secondary"); div3.classList.add("px-3");
                                div3.classList.add("py-1"); div3.classList.add("rounded"); div3.classList.add("position-absolute");
                                div3.setAttribute("style", "top: 10px; left: 10px;"); div3.innerHTML = n[1];//商品種類
                                let div4 = document.createElement('div'); div4.classList.add("p-4"); div4.classList.add("border"); div4.classList.add("border-secondary"); div4.classList.add("border-top-0"); div4.classList.add("rounded-bottom");
                                let h4 = document.createElement("h4"); h4.innerHTML = n[2]//商品名稱
                                // <div class="d-flex justify-content-between flex-lg-wrap">
                                let div5 = document.createElement("div"); div5.classList.add("d-flex"); div5.classList.add("justify-content-between");
                                div5.classList.add("flex-lg-wrap");
                                // <p class="text-dark fs-5 fw-bold mb-0">$4.99 / kg</p> 商品價格(用ajax抓)
                                let ID = n[0];
                                $.ajax({
                                    // [minprice,maxprice,goodsID]
                                    type: "get",
                                    // data: { GoodType: n[0] },
                                    url: "/indexpopulargoodPrice/" + ID,
                                    contentType: 'application/json',
                                    success: function (data) {
                                        // console.log(data);
                                        let content = [...data][0][0] + "-" + [...data][0][1] + "$";
                                        let p = document.createElement('p'); p.classList.add("text-dark"); p.classList.add("fs-5"); p.classList.add("fw-bold");
                                        p.classList.add("mb-0"); p.innerHTML = content;
                                        div5.append(p);
                                    }
                                })
                                //
                                div4.append(h4); div4.append(div5); div1.append(div2); div1.append(div3); div1.append(div4); div0.append(div1);
                                divcontain3.append(div0);
                                // console.log($('#tabContentList'));
                                $('#tabContentList').append(divcontain0);
                            })
                        }
                    })
                }


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
            <div class="container-fluid fixed-top bg-info">
                <div class="container topbar bg-info d-none d-lg-block mb-3">
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
                <div class="container px-0 d-flex mb-5">
                    <a href="#" class="navbar-brand">
                        <h1 class="text-secondary display-6">EZBuy</h1>
                    </a>
                    <form class="form-inline d-flex">
                        <div class="form-group mx-sm-3 mb-2">
                            <input type="text" class="form-control border-2 border-secondary py-3 px-4 rounded-pill"
                                style="width: 1000px;height: 60px;" name="GoodName">
                        </div>
                        <button
                            class="btn btn-primary border-2 border-secondary py-3 px-4 rounded-pill position-relative"
                            style="left: -80px;height: 60px;" id="GoToSearchGood" type="button">
                            <i class="fas fa-search"></i>
                        </button>
                    </form>
                    <a href="#" class="position-relative me-4 my-auto ms-5">
                        <i class="fa fa-shopping-bag fa-2x text-secondary"></i>
                        <span
                            class="position-absolute bg-white rounded-circle d-flex align-items-center justify-content-center text-dark px-1"
                            style="top: -5px; left: 15px; height: 20px; min-width: 20px;">3</span>
                    </a>
                    <a href="#" class="my-auto">
                        <i class="fas fa-user fa-2x text-secondary"></i>
                    </a>
                    <!-- <nav class="navbar navbar-light bg-info navbar-expand-xl">
                        <a href="#" class="navbar-brand">
                            <h1 class="text-secondary display-6">EZBuy</h1>
                        </a>
                        <button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarCollapse">
                            <span class="fa fa-bars text-secondary"></span>
                        </button>
                        <div class="collapse navbar-collapse bg-info" id="navbarCollapse">
                            <div class="navbar-nav">
                                <a href="#" class="nav-item nav-link">購物車</a>
                                <a href="#" class="nav-item nav-link">訂單紀錄</a>
                                <a href="#" class="nav-item nav-link">官方申訴</a>
                            </div>
                            <div class="d-flex flex-row bd-highlight"> -->
                    <!--<div class="d-flex m-3 me-0">
                        <form class="form-inline d-flex">
                            <div class="form-group mx-sm-3 mb-2">
                                <input type="text" class="form-control border-2 border-secondary py-3 px-4 rounded-pill"
                                    style="width: 500px;height: 60px;">
                            </div>
                            <button
                                class="btn btn-primary border-2 border-secondary py-3 px-4 rounded-pill position-relative"
                                style="left: -80px;height: 60px;">
                                <i class="fas fa-search"></i>
                            </button>
                        </form>
                        <a href="#" class="position-relative me-4 my-auto ms-5">
                            <i class="fa fa-shopping-bag fa-2x text-secondary"></i>
                            <span
                                class="position-absolute bg-white rounded-circle d-flex align-items-center justify-content-center text-dark px-1"
                                style="top: -5px; left: 15px; height: 20px; min-width: 20px;">3</span>
                        </a>
                        <a href="#" class="my-auto">
                            <i class="fas fa-user fa-2x text-secondary"></i>
                        </a>
                    </div>
                </div>
                </nav> -->
                </div>
            </div>
            <!-- Navbar End -->

            <!-- Hero Start -->
            <div class="container-fluid py-5 mb-5 hero-header">
                <div class="container py-5">
                    <div class="row g-5 align-items-center">
                        <div class="col-md-12 col-lg-7">
                            <h4 class="mb-3 text-secondary">100% Organic Foods</h4>
                            <h1 class="mb-5 display-3 text-primary">Organic Veggies & Fruits Foods</h1>
                            <!-- <div class="position-relative mx-auto"> 
                                <form id="gotoSearchGoodForm">
                                    <input class="form-control border-2 border-secondary w-75 py-3 px-4 rounded-pill"
                                        type="number" placeholder="Search" id="SearchGood">
                                    <button type="button"
                                        class="btn btn-primary border-2 border-secondary py-3 px-4 position-absolute rounded-pill text-white h-100"
                                        style="top: 0; right: 25%;" id="gotoSearchGood"><i
                                            class="fas fa-search"></i></button>
                                </form>
                            </div> -->
                        </div>
                        <div class="col-md-12 col-lg-5">
                            <!-- 放置活動圖片(透過ajax取得近期活動圖片、活動內容) -->
                            <div id="carouselId" class="carousel slide position-relative" data-bs-ride="carousel">
                                <div class="carousel-inner" role="listbox">
                                    <div class="carousel-item active rounded">
                                        <img src="../../frontimg/hero-img-1.png"
                                            class="img-fluid w-100 h-100 bg-secondary rounded" alt="First slide">
                                        <a href="#" class="btn px-4 py-2 text-white rounded">Fruites</a>
                                    </div>
                                    <div class="carousel-item rounded">
                                        <img src="../../frontimg/hero-img-2.jpg" class="img-fluid w-100 h-100 rounded"
                                            alt="Second slide"> <!-- 活動圖片 -->
                                        <a href="#" class="btn px-4 py-2 text-white rounded">Vesitables</a>
                                        <!-- 透過點擊圖片檢閱活動內文[<a></a>拿掉] -->
                                    </div>
                                </div>
                                <button class="carousel-control-prev" type="button" data-bs-target="#carouselId"
                                    data-bs-slide="prev">
                                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                    <span class="visually-hidden">Previous</span>
                                </button>
                                <button class="carousel-control-next" type="button" data-bs-target="#carouselId"
                                    data-bs-slide="next">
                                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                    <span class="visually-hidden">Next</span>
                                </button>
                            </div>
                            <!-- 放置活動圖片 -->
                        </div>
                    </div>
                </div>
            </div>
            <!-- Hero End -->
            <!-- Fruits Shop Start-->
            <div class="container-fluid fruite py-5">
                <div class="container py-5">
                    <div class="tab-class text-center">
                        <div class="row g-4">
                            <div class="col-lg-4 text-start">
                                <h1>熱門商品</h1>
                            </div>
                            <div class="col-lg-8 text-end">
                                <ul class="nav nav-pills d-inline-flex text-center mb-5" id="CategoryList">

                                </ul>
                            </div>
                        </div>
                        <div class="tab-content" id="tabContentList">

                        </div>
                    </div>
                </div>
            </div>
            <!-- Fruits Shop End-->


            <!-- Featurs Start(加入商城特色 鼓勵大家過來購買 成為EZBuy的電商) -->

            <!-- Featurs End -->
            <!--Vesitable Shop Start-->
            <div class="container-fluid vesitable py-5">
                <div class="container py-5" id="testtarget">
                    <h1 class="mb-0">近期商品</h1>
                    <div class="owl-carousel vegetable-carousel justify-content-center">


                        <c:forEach var="i" begin="1" end="${GoodNumber}" step="1">
                            <c:forEach var="j" items="${findGoodPriceRange}">
                                <form action="">
                                    <div class="border border-primary rounded position-relative vesitable-item">
                                        <div class="vesitable-img">
                                            <img src="${j.titleImage}" class="img-fluid w-100 rounded-top" alt=""
                                                style="width: 150px;height: 250px;">
                                        </div>
                                        <div class="text-white bg-primary px-3 py-1 rounded position-absolute"
                                            style="top: 10px; right: 10px;">${j.goodType}</div>
                                        <div class="p-4 rounded-bottom">
                                            <h4>${j.goodName}</h4>
                                            <p>${j.minprice}-${j.maxprice}$</p>
                                            <div class="d-flex justify-content-between flex-lg-wrap">
                                                <div class="d-flex my-3">
                                                    <c:forEach var="k" begin="1" end="5" step="1">
                                                        <c:if test="${j.goodAVG>k}">
                                                            <i class="fas fa-star text-primary"></i>
                                                        </c:if>
                                                        <c:if test="${k>j.goodAVG}">
                                                            <i class="fas fa-star"></i>
                                                        </c:if>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </c:forEach>
                        </c:forEach>
                    </div>
                </div>
            </div>
            <!-- Vesitable Shop End -->


            <!-- Banner Section Start-->
            <!-- <div class="container-fluid banner bg-secondary my-5">
                <div class="container py-5">
                    <div class="row g-4 align-items-center">
                        <div class="col-lg-6">
                            <div class="py-4">
                                <h1 class="display-3 text-white">Fresh Exotic Fruits</h1>
                                <p class="fw-normal display-3 text-dark mb-4">in Our Store</p>
                                <p class="mb-4 text-dark">The generated Lorem Ipsum is therefore always free
                                    from repetition
                                    injected humour, or non-characteristic words etc.</p>
                                <a href="#"
                                    class="banner-btn btn border-2 border-white rounded-pill text-dark py-3 px-5">BUY</a>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="position-relative">
                                <img src="../../frontimg/baner-1.png" class="img-fluid w-100 rounded" alt="">
                                <div class="d-flex align-items-center justify-content-center bg-white rounded-circle position-absolute"
                                    style="width: 140px; height: 140px; top: 0; left: 0;">
                                    <h1 style="font-size: 100px;">1</h1>
                                    <div class="d-flex flex-column">
                                        <span class="h2 mb-0">50$</span>
                                        <span class="h4 text-muted mb-0">kg</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div> -->
            <!-- Banner Section End -->


            <!-- Bestsaler Product Start -->
            <!-- <div class="container-fluid py-5">
                <div class="container py-5">
                    <div class="text-center mx-auto mb-5" style="max-width: 700px;">
                        <h1 class="display-4">Bestseller Products</h1>
                        <p>Latin words, combined with a handful of model sentence structures, to generate Lorem
                            Ipsum which
                            looks reasonable.</p>
                    </div>
                    <div class="row g-4">
                        <div class="col-lg-6 col-xl-4">
                            <div class="p-4 rounded bg-light">
                                <div class="row align-items-center">
                                    <div class="col-6">
                                        <img src="../../frontimg/best-product-1.jpg"
                                            class="img-fluid rounded-circle w-100" alt="">
                                    </div>
                                    <div class="col-6">
                                        <a href="#" class="h5">Organic Tomato</a>
                                        <div class="d-flex my-3">
                                            <i class="fas fa-star text-primary"></i>
                                            <i class="fas fa-star text-primary"></i>
                                            <i class="fas fa-star text-primary"></i>
                                            <i class="fas fa-star text-primary"></i>
                                            <i class="fas fa-star"></i>
                                        </div>
                                        <h4 class="mb-3">3.12 $</h4>
                                        <a href="#"
                                            class="btn border border-secondary rounded-pill px-3 text-primary"><i
                                                class="fa fa-shopping-bag me-2 text-primary"></i> Add to
                                            cart</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6 col-xl-4">
                            <div class="p-4 rounded bg-light">
                                <div class="row align-items-center">
                                    <div class="col-6">
                                        <img src="../../frontimg/best-product-2.jpg"
                                            class="img-fluid rounded-circle w-100" alt="">
                                    </div>
                                    <div class="col-6">
                                        <a href="#" class="h5">Organic Tomato</a>
                                        <div class="d-flex my-3">
                                            <i class="fas fa-star text-primary"></i>
                                            <i class="fas fa-star text-primary"></i>
                                            <i class="fas fa-star text-primary"></i>
                                            <i class="fas fa-star text-primary"></i>
                                            <i class="fas fa-star"></i>
                                        </div>
                                        <h4 class="mb-3">3.12 $</h4>
                                        <a href="#"
                                            class="btn border border-secondary rounded-pill px-3 text-primary"><i
                                                class="fa fa-shopping-bag me-2 text-primary"></i> Add to
                                            cart</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6 col-xl-4">
                            <div class="p-4 rounded bg-light">
                                <div class="row align-items-center">
                                    <div class="col-6">
                                        <img src="../../frontimg/best-product-3.jpg"
                                            class="img-fluid rounded-circle w-100" alt="">
                                    </div>
                                    <div class="col-6">
                                        <a href="#" class="h5">Organic Tomato</a>
                                        <div class="d-flex my-3">
                                            <i class="fas fa-star text-primary"></i>
                                            <i class="fas fa-star text-primary"></i>
                                            <i class="fas fa-star text-primary"></i>
                                            <i class="fas fa-star text-primary"></i>
                                            <i class="fas fa-star"></i>
                                        </div>
                                        <h4 class="mb-3">3.12 $</h4>
                                        <a href="#"
                                            class="btn border border-secondary rounded-pill px-3 text-primary"><i
                                                class="fa fa-shopping-bag me-2 text-primary"></i> Add to
                                            cart</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6 col-xl-4">
                            <div class="p-4 rounded bg-light">
                                <div class="row align-items-center">
                                    <div class="col-6">
                                        <img src="../../frontimg/best-product-4.jpg"
                                            class="img-fluid rounded-circle w-100" alt="">
                                    </div>
                                    <div class="col-6">
                                        <a href="#" class="h5">Organic Tomato</a>
                                        <div class="d-flex my-3">
                                            <i class="fas fa-star text-primary"></i>
                                            <i class="fas fa-star text-primary"></i>
                                            <i class="fas fa-star text-primary"></i>
                                            <i class="fas fa-star text-primary"></i>
                                            <i class="fas fa-star"></i>
                                        </div>
                                        <h4 class="mb-3">3.12 $</h4>
                                        <a href="#"
                                            class="btn border border-secondary rounded-pill px-3 text-primary"><i
                                                class="fa fa-shopping-bag me-2 text-primary"></i> Add to
                                            cart</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6 col-xl-4">
                            <div class="p-4 rounded bg-light">
                                <div class="row align-items-center">
                                    <div class="col-6">
                                        <img src="../../frontimg/best-product-5.jpg"
                                            class="img-fluid rounded-circle w-100" alt="">
                                    </div>
                                    <div class="col-6">
                                        <a href="#" class="h5">Organic Tomato</a>
                                        <div class="d-flex my-3">
                                            <i class="fas fa-star text-primary"></i>
                                            <i class="fas fa-star text-primary"></i>
                                            <i class="fas fa-star text-primary"></i>
                                            <i class="fas fa-star text-primary"></i>
                                            <i class="fas fa-star"></i>
                                        </div>
                                        <h4 class="mb-3">3.12 $</h4>
                                        <a href="#"
                                            class="btn border border-secondary rounded-pill px-3 text-primary"><i
                                                class="fa fa-shopping-bag me-2 text-primary"></i> Add to
                                            cart</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6 col-xl-4">
                            <div class="p-4 rounded bg-light">
                                <div class="row align-items-center">
                                    <div class="col-6">
                                        <img src="../../frontimg/best-product-6.jpg"
                                            class="img-fluid rounded-circle w-100" alt="">
                                    </div>
                                    <div class="col-6">
                                        <a href="#" class="h5">Organic Tomato</a>
                                        <div class="d-flex my-3">
                                            <i class="fas fa-star text-primary"></i>
                                            <i class="fas fa-star text-primary"></i>
                                            <i class="fas fa-star text-primary"></i>
                                            <i class="fas fa-star text-primary"></i>
                                            <i class="fas fa-star"></i>
                                        </div>
                                        <h4 class="mb-3">3.12 $</h4>
                                        <a href="#"
                                            class="btn border border-secondary rounded-pill px-3 text-primary"><i
                                                class="fa fa-shopping-bag me-2 text-primary"></i> Add to
                                            cart</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6 col-xl-3">
                            <div class="text-center">
                                <img src="../../frontimg/fruite-item-1.jpg" class="img-fluid rounded" alt="">

                                <div class="py-4">
                                    <a href="#" class="h5">Organic Tomato</a>
                                    <div class="d-flex my-3 justify-content-center">
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star"></i>
                                    </div>
                                    <h4 class="mb-3">3.12 $</h4>
                                    <a href="#" class="btn border border-secondary rounded-pill px-3 text-primary"><i
                                            class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6 col-xl-3">
                            <div class="text-center">
                                <img src="../../frontimg/fruite-item-2.jpg" class="img-fluid rounded" alt="">

                                <div class="py-4">
                                    <a href="#" class="h5">Organic Tomato</a>
                                    <div class="d-flex my-3 justify-content-center">
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star"></i>
                                    </div>
                                    <h4 class="mb-3">3.12 $</h4>
                                    <a href="#" class="btn border border-secondary rounded-pill px-3 text-primary"><i
                                            class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6 col-xl-3">
                            <div class="text-center">
                                <img src="../../frontimg/fruite-item-3.jpg" class="img-fluid rounded" alt="">
                                <div class="py-4">
                                    <a href="#" class="h5">Organic Tomato</a>
                                    <div class="d-flex my-3 justify-content-center">
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star"></i>
                                    </div>
                                    <h4 class="mb-3">3.12 $</h4>
                                    <a href="#" class="btn border border-secondary rounded-pill px-3 text-primary"><i
                                            class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6 col-xl-3">
                            <div class="text-center">
                                <img src="../../frontimg/fruite-item-4.jpg" class="img-fluid rounded" alt="">

                                <div class="py-2">
                                    <a href="#" class="h5">Organic Tomato</a>
                                    <div class="d-flex my-3 justify-content-center">
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star"></i>
                                    </div>
                                    <h4 class="mb-3">3.12 $</h4>
                                    <a href="#" class="btn border border-secondary rounded-pill px-3 text-primary"><i
                                            class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div> -->
            <!-- Bestsaler Product End -->


            <!-- Fact Start -->
            <!-- <div class="container-fluid py-5">
                <div class="container">
                    <div class="bg-light p-5 rounded">
                        <div class="row g-4 justify-content-center">
                            <div class="col-md-6 col-lg-6 col-xl-3">
                                <div class="counter bg-white rounded p-5">
                                    <i class="fa fa-users text-secondary"></i>
                                    <h4>satisfied customers</h4>
                                    <h1>1963</h1>
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-6 col-xl-3">
                                <div class="counter bg-white rounded p-5">
                                    <i class="fa fa-users text-secondary"></i>
                                    <h4>quality of service</h4>
                                    <h1>99%</h1>
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-6 col-xl-3">
                                <div class="counter bg-white rounded p-5">
                                    <i class="fa fa-users text-secondary"></i>
                                    <h4>quality certificates</h4>
                                    <h1>33</h1>
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-6 col-xl-3">
                                <div class="counter bg-white rounded p-5">
                                    <i class="fa fa-users text-secondary"></i>
                                    <h4>Available Products</h4>
                                    <h1>789</h1>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div> -->
            <!-- Fact Start -->


            <!-- Tastimonial Start -->
            <!-- <div class="container-fluid testimonial py-5">
                <div class="container py-5">
                    <div class="testimonial-header text-center">
                        <h4 class="text-primary">Our Testimonial</h4>
                        <h1 class="display-5 mb-5 text-dark">Our Client Saying!</h1>
                    </div>
                    <div class="owl-carousel testimonial-carousel">
                        <div class="testimonial-item img-border-radius bg-light rounded p-4">
                            <div class="position-relative">
                                <i class="fa fa-quote-right fa-2x text-secondary position-absolute"
                                    style="bottom: 30px; right: 0;"></i>
                                <div class="mb-4 pb-4 border-bottom border-secondary">
                                    <p class="mb-0">Lorem Ipsum is simply dummy text of the printing Ipsum has
                                        been the
                                        industry's standard dummy text ever since the 1500s,
                                    </p>
                                </div>
                                <div class="d-flex align-items-center flex-nowrap">
                                    <div class="bg-secondary rounded">
                                        <img src="../../frontimg/testimonial-1.jpg" class="img-fluid rounded"
                                            style="width: 100px; height: 100px;" alt="">
                                    </div>
                                    <div class="ms-4 d-block">
                                        <h4 class="text-dark">Client Name</h4>
                                        <p class="m-0 pb-3">Profession</p>
                                        <div class="d-flex pe-5">
                                            <i class="fas fa-star text-primary"></i>
                                            <i class="fas fa-star text-primary"></i>
                                            <i class="fas fa-star text-primary"></i>
                                            <i class="fas fa-star text-primary"></i>
                                            <i class="fas fa-star"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="testimonial-item img-border-radius bg-light rounded p-4">
                            <div class="position-relative">
                                <i class="fa fa-quote-right fa-2x text-secondary position-absolute"
                                    style="bottom: 30px; right: 0;"></i>
                                <div class="mb-4 pb-4 border-bottom border-secondary">
                                    <p class="mb-0">Lorem Ipsum is simply dummy text of the printing Ipsum has
                                        been the
                                        industry's standard dummy text ever since the 1500s,
                                    </p>
                                </div>
                                <div class="d-flex align-items-center flex-nowrap">
                                    <div class="bg-secondary rounded">
                                        <img src="../../frontimg/testimonial-1.jpg" class="img-fluid rounded"
                                            style="width: 100px; height: 100px;" alt="">
                                    </div>
                                    <div class="ms-4 d-block">
                                        <h4 class="text-dark">Client Name</h4>
                                        <p class="m-0 pb-3">Profession</p>
                                        <div class="d-flex pe-5">
                                            <i class="fas fa-star text-primary"></i>
                                            <i class="fas fa-star text-primary"></i>
                                            <i class="fas fa-star text-primary"></i>
                                            <i class="fas fa-star text-primary"></i>
                                            <i class="fas fa-star text-primary"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="testimonial-item img-border-radius bg-light rounded p-4">
                            <div class="position-relative">
                                <i class="fa fa-quote-right fa-2x text-secondary position-absolute"
                                    style="bottom: 30px; right: 0;"></i>
                                <div class="mb-4 pb-4 border-bottom border-secondary">
                                    <p class="mb-0">Lorem Ipsum is simply dummy text of the printing Ipsum has
                                        been the
                                        industry's standard dummy text ever since the 1500s,
                                    </p>
                                </div>
                                <div class="d-flex align-items-center flex-nowrap">
                                    <div class="bg-secondary rounded">
                                        <img src="../../frontimg/testimonial-1.jpg" class="img-fluid rounded"
                                            style="width: 100px; height: 100px;" alt="">

                                    </div>
                                    <div class="ms-4 d-block">
                                        <h4 class="text-dark">Client Name</h4>
                                        <p class="m-0 pb-3">Profession</p>
                                        <div class="d-flex pe-5">
                                            <i class="fas fa-star text-primary"></i>
                                            <i class="fas fa-star text-primary"></i>
                                            <i class="fas fa-star text-primary"></i>
                                            <i class="fas fa-star text-primary"></i>
                                            <i class="fas fa-star text-primary"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div> -->
            <!-- Tastimonial End -->


            <!-- Footer Start -->
            <div class="container-fluid bg-dark text-white-50 footer pt-5 mt-5">
                <div class="container py-5">
                    <div class="pb-4 mb-4" style="border-bottom: 1px solid rgba(226, 175, 24, 0.5) ;">
                        <div class="row g-4">
                            <div class="col-lg-3">
                                <a href="#">
                                    <h1 class="text-primary mb-0">EZBuy</h1>
                                    <p class="text-secondary mb-0">品質保證</p>
                                </a>
                            </div>
                            <div class="col-lg-6">
                                <div class="position-relative mx-auto">
                                    <input class="form-control border-0 w-100 py-3 px-4 rounded-pill" type="number"
                                        placeholder="Your Email">
                                    <button type="submit"
                                        class="btn btn-primary border-0 border-secondary py-3 px-4 position-absolute rounded-pill text-white"
                                        style="top: 0; right: 0;">Subscribe Now</button>
                                </div>
                            </div>
                            <div class="col-lg-3">
                                <div class="d-flex justify-content-end pt-3">
                                    <a class="btn  btn-outline-secondary me-2 btn-md-square rounded-circle" href=""><i
                                            class="fab fa-twitter"></i></a>
                                    <a class="btn btn-outline-secondary me-2 btn-md-square rounded-circle" href=""><i
                                            class="fab fa-facebook-f"></i></a>
                                    <a class="btn btn-outline-secondary me-2 btn-md-square rounded-circle" href=""><i
                                            class="fab fa-youtube"></i></a>
                                    <a class="btn btn-outline-secondary btn-md-square rounded-circle" href=""><i
                                            class="fab fa-linkedin-in"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row g-5">
                        <div class="col-lg-3 col-md-6">
                            <div class="footer-item">
                                <h4 class="text-light mb-3">Why People Like us!</h4>
                                <p class="mb-4">因為我們保證7天內貨到付款，提供買家申訴管道，杜絕劣質賣家，定期提供免運活動讓買家減少支出，並且鼓勵大家在這裡成為電商</p>
                                <a href="" class="btn border-secondary py-2 px-4 rounded-pill text-primary">Read
                                    More</a>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="d-flex flex-column text-start footer-item">
                                <h4 class="text-light mb-3">Shop Info</h4>
                                <a class="btn-link" href="">About Us</a>
                                <a class="btn-link" href="">Contact Us</a>
                                <a class="btn-link" href="">Privacy Policy</a>
                                <a class="btn-link" href="">Terms & Condition</a>
                                <a class="btn-link" href="">Return Policy</a>
                                <a class="btn-link" href="">FAQs & Help</a>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="d-flex flex-column text-start footer-item">
                                <h4 class="text-light mb-3">Account</h4>
                                <a class="btn-link" href="">My Account</a>
                                <a class="btn-link" href="">Shop details</a>
                                <a class="btn-link" href="">Shopping Cart</a>
                                <a class="btn-link" href="">Wishlist</a>
                                <a class="btn-link" href="">Order History</a>
                                <a class="btn-link" href="">International Orders</a>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="footer-item">
                                <h4 class="text-light mb-3">Contact</h4>
                                <p>Address: 1429 Netus Rd, NY 48247</p>
                                <p>Email: Example@gmail.com</p>
                                <p>Phone: +0123 4567 8910</p>
                                <p>Payment Accepted</p>
                                <img src="../../frontimg/payment.png" class="img-fluid" alt="">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Footer End -->

            <!-- Copyright Start -->
            <div class="container-fluid copyright bg-dark py-4">
                <div class="container">
                    <div class="row">
                        <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
                            <span class="text-light"><a href="#"><i class="fas fa-copyright text-light me-2"></i>Your
                                    Site
                                    Name</a>, All right reserved.</span>
                        </div>
                        <div class="col-md-6 my-auto text-center text-md-end text-white">
                            <!--/*** This template is free as long as you keep the below author’s credit link/attribution link/backlink. ***/-->
                            <!--/*** If you'd like to use the template without the below author’s credit link/attribution link/backlink, ***/-->
                            <!--/*** you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". ***/-->
                            Designed By <a class="border-bottom" href="https://htmlcodex.com">HTML Codex</a>
                            Distributed By
                            <a class="border-bottom" href="https://themewagon.com">ThemeWagon</a>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Copyright End -->



            <!-- Back to Top -->
            <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i
                    class="fa fa-arrow-up"></i></a>


            <!-- JavaScript Libraries -->
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
            <!--  -->
            <script src="../../frontlib/easing/easing.min.js"></script>

            <script src="../../frontlib/waypoints/waypoints.min.js"></script>

            <script src="../../frontlib/lightbox/js/lightbox.min.js"></script>

            <script src="../../frontlib/owlcarousel/owl.carousel.min.js"></script>

            <script src="../../frontjs/main.js"></script>
            <script>
                $('#GoToSearchGood').click(function () {
                    let searchGoodInput = $(this).closest('form').find('input');
                    if (searchGoodInput.prop('value') == null) {
                        console.log(searchGoodInput);
                    }
                    else {
                        let form = $(this).closest('form');
                        form.attr("action", "/searchGood");
                        form.attr("method", "get");
                        form.submit();
                        console.log(form.prop("outerHTML"));
                    }
                })
                $(document).on('click', 'div[class="border border-primary rounded position-relative vesitable-item"]', function () {
                    console.log("123123123123123");

                    console.log($(this).find('input'));
                })
                // <form class="form-inline d-flex">
                //         <div class="form-group mx-sm-3 mb-2">
                //             <input type="text" class="form-control border-2 border-secondary py-3 px-4 rounded-pill"
                //                 style="width: 1000px;height: 60px;" name="GoodName">
                //         </div>
                //         <button
                //             class="btn btn-primary border-2 border-secondary py-3 px-4 rounded-pill position-relative"
                //             style="left: -80px;height: 60px;">
                //             <i class="fas fa-search"></i>
                //         </button>
                //     </form>
            </script>
        </body>

        </html>