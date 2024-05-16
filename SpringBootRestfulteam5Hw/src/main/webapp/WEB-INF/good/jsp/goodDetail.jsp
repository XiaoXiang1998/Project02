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
            <link href="../../frontlib/lightbox/css/lightbox.min.css" rel="stylesheet">

            <link href="../../frontlib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


            <link href="../../frontcss/bootstrap.min.css" rel="stylesheet">

            <link href="../../frontcss/style.css" rel="stylesheet">
            <script>
                $.ajax({ //會用到多次ajax去抓評論、訂單(透過檢查訂單是否完成來開放評論)
                    type: 'get',

                    url: '/good/' + ID,

                    contentType: 'application/json',

                    success: function (data) { //將基本商品資訊鑲嵌在本網頁上

                    }
                })
            </script>
        </head>
        <!-- 建立個人賣場太花時間 拿掉 -->
        <!-- 聯絡賣家需要寫聊天室API 拿掉 -->

        <body>

            <!-- Spinner Start -->
            <div id="spinner"
                class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
                <div class="spinner-grow text-primary" role="status"></div>
            </div>
            <!-- Spinner End -->


            <!-- Navbar start -->
            <div class="container-fluid fixed-top">

                <div class="container px-0">
                    <nav class="navbar navbar-light bg-white navbar-expand-xl">
                        <a href="index.html" class="navbar-brand">
                            <h1 class="text-primary display-6">EZBuy</h1> <!-- 前往商城首頁 -->
                        </a>
                        <button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarCollapse">
                            <span class="fa fa-bars text-primary"></span>
                        </button>
                        <div class="collapse navbar-collapse bg-white" id="navbarCollapse">
                            <!-- <div class="navbar-nav mx-auto"> -->
                            <!-- <a href="index.html" class="nav-item nav-link">首頁</a>  -->
                            <!-- 首頁 -->
                            <!-- <form action="" method="" id="SellerMarket1">  -->
                            <!-- 個人賣場(用賣家編號去找)JSP[頁面跳轉] -->
                            <!-- <input type="text" readonly class="form-control-plaintext" value="" name=""> -->
                            <!-- <span class="badge badge-primary" id="goToSellerMarket1">前往賣家賣場</span> -->
                            <!-- <a href="shop.html" class="nav-item nav-link">個人賣場</a>   -->
                            <!-- </form> -->
                            <!-- <a href="#" class="nav-item nav-link active">商品介紹</a> -->
                            <!-- <a href="contact.html" class="nav-item nav-link">聯絡賣家</a>  -->
                            <!-- 可以傳訊息給賣家[頁面跳轉] -->
                            <!-- </div> -->

                            <div class="d-flex m-3 me-0">
                                <button
                                    class="btn-search btn border border-secondary btn-md-square rounded-circle bg-white me-4"
                                    data-bs-toggle="modal" data-bs-target="#searchModal"><i
                                        class="fas fa-search text-primary"></i></button>
                                <!-- 搜尋該賣家的某一商品名稱[搜尋成功後頁面跳轉] -->
                                <form action="" method="get" id="MyCart"> <!-- 前往個人購物車(買家編號)[頁面跳轉] -->
                                    <i class="fa fa-shopping-bag fa-2x" id="MyCartMark"></i>
                                    <span
                                        class="position-absolute bg-secondary rounded-circle d-flex align-items-center justify-content-center text-dark px-1"
                                        style="top: -5px; left: 15px; height: 20px; min-width: 20px;"
                                        id="CartItemNumber">3</span> <!-- 透過ajax搜尋購物車內有幾種商品(買家編號) -->

                                    <input type="text" readonly class="form-control-plaintext" value="" name="">
                                    <!-- 買家編號 -->
                                </form>

                                <form action="" method="get"> <!-- 透過買家編號前往個人首頁[頁面跳轉] -->
                                    <input type="text" readonly class="form-control-plaintext" value="" name="">
                                    <!-- 買家編號 -->
                                    <i class="fas fa-user fa-2x" id="MyIndex"></i>
                                </form>
                            </div>
                        </div>
                    </nav>
                </div>
            </div>
            <!-- Navbar End -->

            <!-- Single Product Start -->
            <div class="container-fluid py-5 mt-5">
                <div class="container py-5">
                    <div class="row g-4 mb-5">
                        <div class="col-lg-8 col-xl-9">
                            <div class="row g-4">
                                <div class="col-lg-6">
                                    <div class="border rounded">
                                        <!-- 商品圖片(用輪播呈現) -->
                                        <div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
                                            <!-- 透過迴圈去寫[需要塞入所有圖片(封面照、圖片表、規格表圖片)] -->
                                            <div class="carousel-inner">
                                                <div class="carousel-item active">
                                                    <img class="d-block w-100" src="${Good}" alt="${Good.titleImage}">
                                                </div>
                                                <c:forEach var="j" begin="0" end="${GoodImageNumber}" step="1"
                                                    items="${GoodImage}" varStatus="loop">
                                                    <div class="carousel-item">
                                                        <img class="d-block w-100" src="${j.imagePath}"
                                                            alt="${j.imagePath}">
                                                    </div>
                                                </c:forEach>
                                                <!-- <div class="carousel-item active">
                                                    <img class="d-block w-100" src="..." alt="First slide">
                                                </div>
                                                <div class="carousel-item">
                                                    <img class="d-block w-100" src="..." alt="Second slide">
                                                </div>
                                                <div class="carousel-item">
                                                    <img class="d-block w-100" src="..." alt="Third slide">
                                                </div> -->
                                            </div>
                                            <!-- 透過迴圈去寫 -->
                                            <a class="carousel-control-prev" href="#carouselExampleControls"
                                                role="button" data-slide="prev">
                                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                                <span class="sr-only">Previous</span>
                                            </a>
                                            <a class="carousel-control-next" href="#carouselExampleControls"
                                                role="button" data-slide="next">
                                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                                <span class="sr-only">Next</span>
                                            </a>
                                        </div>
                                        <!-- 商品圖片(用輪播呈現) -->
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <h4 class="fw-bold mb-3" id="GoodName">${GoodBasicInfo.goodName}</h4> <!-- 商品名稱 -->
                                    <p class="mb-3" id="GoodType">Category: ${GoodBasicInfo.goodType}</p> <!-- 商品種類 -->
                                    <h5 class="fw-bold mb-3" id="GoodPriceRange">
                                        ${GoodBasicInfo.minprice}-${GoodBasicInfo.maxprice}$</h5> <!-- 商品價格(以範圍表示) -->
                                    <div class="d-flex mb-4" id="GoodRate"> <!-- 平均分數 EX(3.5/5) -->
                                        <c:forEach var="j" begin="1" end="5" step="1" items="${GoodBasicInfo.goodAVG}"
                                            varStatus="loop">
                                            <c:if test="${GoodBasicInfo.goodAVG>=loop.index}">
                                                <i class="fa fa-star text-secondary"></i>
                                            </c:if>
                                            <c:if test="${loop.index>GoodBasicInfo.goodAVG}">
                                                <i class="fa fa-star"></i>
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                    <!-- 商品規格(呈現該商品編號下對應的所有規格) -->
                                    <div class="row col-2">
                                        <c:forEach var="j" begin="0" end="${GoodFormatNumber}" step="1"
                                            items="${GoodFormat}" varStatus="loop">
                                            <div class="col-6">
                                                <button class="CategoryItem">
                                                    <img src="${j.goodImagePath}" alt="${j.goodImagePath}">
                                                    <span>${j.goodSize}</span>
                                                    <span hidden class="CategoryNumber">${j.goodsStock}</span>
                                                </button>
                                            </div>
                                        </c:forEach>
                                    </div>
                                    <!-- 當某一規格被點擊時 會出現剩餘的數量(輪播的部分呈現該張圖片) -->
                                    <div class="input-group quantity mb-5" style="width: 100px;" id="BuyItemNumber"
                                        hidden>
                                        <!--買入數量  -->
                                        <div class="input-group-btn">
                                            <button class="btn btn-sm btn-minus rounded-circle bg-light border">
                                                <i class="fa fa-minus"></i> <!-- 降低數量按鈕 -->
                                            </button>
                                        </div>
                                        <input type="text" class="form-control form-control-sm text-center border-0"
                                            value="1" id="BuyNumber"> <!-- 當點擊到庫存上限時 會出現紅字 -->
                                        <p id="errormsg"></p>
                                        <div class="input-group-btn">
                                            <button class="btn btn-sm btn-plus rounded-circle bg-light border">
                                                <i class="fa fa-plus"></i> <!-- 增加數量按鈕 -->
                                            </button>
                                        </div>
                                        <p id="remainingNumber"></p>
                                    </div>
                                    <!-- 一個是直接購買(直接進入訂單環節) 另一個是加入購物車(將購買的商品放入購物車內) -->
                                    <!-- 在購買之前需要選擇特定規格 -->
                                    <form action="" id="orderDetail"> <!-- 進入訂單環節(跳轉頁面) -->
                                        <!-- 下單後對應規格的庫存量會下降 -->
                                        <input type="text" class="form-control" id="orderNumber" name="orderNumber">
                                        <!-- 購買數量 -->
                                        <input type="text" class="form-control" id="formatID" name="formatID">
                                        <!-- 規格表編號 -->
                                        <input type="text" class="form-control" id="formatID" name="formatID">
                                        <!-- 買家編號 -->
                                        <button></button>
                                    </form>
                                    <form action="" id="cartDetail"> <!-- 進入購物車(透過ajax將值傳到後端) -->
                                        <input type="text"> <!-- 購買數量 -->
                                        <input type="text"> <!-- 規格表編號 -->
                                        <input type="text"> <!-- 買家編號 -->
                                        <button></button>
                                    </form>
                                    <!-- <a href="#"
                                    class="btn border border-secondary rounded-pill px-4 py-2 mb-4 text-primary"><i
                                        class="fa fa-shopping-bag me-2 text-primary"></i></a> -->
                                </div>
                                <div class="col-lg-12">
                                    <nav>
                                        <div class="nav nav-tabs mb-3">
                                            <button class="nav-link active border-white border-bottom-0" type="button"
                                                role="tab" id="nav-about-tab" data-bs-toggle="tab"
                                                data-bs-target="#nav-about" aria-controls="nav-about"
                                                aria-selected="true">商品使用說明</button>
                                            <button class="nav-link border-white border-bottom-0" type="button"
                                                role="tab" id="nav-mission-tab" data-bs-toggle="tab"
                                                data-bs-target="#nav-mission" aria-controls="nav-mission"
                                                aria-selected="false">評論</button>
                                        </div>
                                    </nav>
                                    <div class="tab-content mb-5">
                                        <div class="tab-pane active" id="nav-about" role="tabpanel"
                                            aria-labelledby="nav-about-tab">
                                            <div class="px-2">
                                                <div class="row g-4">
                                                    <div class="col-6" id="GoodDirectionContent">
                                                        <!-- 裡面放入商品描述 -->
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="tab-pane" id="nav-mission" role="tabpanel"
                                            aria-labelledby="nav-mission-tab"> <!-- 所有評論 -->
                                            <!-- 透過商品編號查詢有幾筆評論(使用迴圈寫) -->
                                            <!-- 將每一筆評論呈現出來 -->
                                            <div class="d-flex">
                                                <img src="img/avatar.jpg" class="img-fluid rounded-circle p-3"
                                                    style="width: 100px; height: 100px;" alt=""> <!-- 評論用戶的大頭貼 -->
                                                <div class="">
                                                    <p class="mb-2" style="font-size: 14px;">April 12, 2024</p>
                                                    <!-- 評論日期 -->
                                                    <div class="d-flex justify-content-between"> <!-- 評論用戶名 + 評論星數 -->
                                                        <h5>Jason Smith</h5> <!-- 評論用戶名 -->
                                                        <div class="d-flex mb-3"> <!-- 評論星數(星星數可用迴圈去寫) -->
                                                            <i class="fa fa-star text-secondary"></i>
                                                            <i class="fa fa-star text-secondary"></i>
                                                            <i class="fa fa-star text-secondary"></i>
                                                            <i class="fa fa-star text-secondary"></i>
                                                            <i class="fa fa-star"></i>
                                                        </div>
                                                    </div>
                                                    <p>The generated Lorem Ipsum is therefore always free from
                                                        repetition
                                                        injected humour, or non-characteristic
                                                        words etc. Susp endisse ultricies nisi vel quam suscipit </p>
                                                    <!-- 評論內容 -->
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <form action="#" method="post"> <!-- 評論(會先檢查該用戶所有已完成的訂單(如果有滿足該商品編號即可撰寫評論)) -->
                                    <h4 class="mb-5 fw-bold">Leave a Reply</h4>
                                    <div class="row g-4">
                                        <div class="col-lg-12"> <!-- 評論內容 -->
                                            <div class="border-bottom rounded my-4">
                                                <textarea name="" id="" class="form-control border-0" cols="30" rows="8"
                                                    placeholder="Your Review *" spellcheck="false"></textarea>
                                            </div>
                                        </div>
                                        <div class="col-lg-12"> <!-- 星星數(交給隊員處理) -->
                                            <div class="d-flex justify-content-between py-3 mb-5">
                                                <div class="d-flex align-items-center">
                                                    <p class="mb-0 me-3">Please rate:</p>
                                                    <div class="d-flex align-items-center" style="font-size: 12px;">
                                                        <i class="fa fa-star text-muted"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                    </div>
                                                </div>
                                                <button>送出評論</button>
                                                <!-- <a href="#"
                                                class="btn border border-secondary text-primary rounded-pill px-4 py-3">
                                                Post Comment</a> 送出評論 -->
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>

                    </div>
                    <h1 class="fw-bold mb-0">Related products</h1>
                    <!-- 透過商品種類去查詢商品基本資料表 -->
                    <div class="vesitable">
                        <div class="owl-carousel vegetable-carousel justify-content-center"> <!-- 透過迴圈去寫 -->
                            <form action="" method="">
                                <div class="border border-primary rounded position-relative vesitable-item">
                                    <div class="vesitable-img"> <!-- 商品封面圖片 -->
                                        <img src="img/vegetable-item-6.jpg" class="img-fluid w-100 rounded-top" alt="">
                                    </div>
                                    <div class="text-white bg-primary px-3 py-1 rounded position-absolute"
                                        style="top: 10px; right: 10px;">Vegetable
                                    </div><!-- 商品名稱 -->
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Single Product End -->


            <!-- Footer Start -->
            <div class="container-fluid bg-dark text-white-50 footer pt-5 mt-5">
                <div class="container py-5">
                    <div class="pb-4 mb-4" style="border-bottom: 1px solid rgba(226, 175, 24, 0.5) ;">
                        <div class="row g-4">
                            <div class="col-lg-3">
                                <a href="#">
                                    <h1 class="text-primary mb-0">Fruitables</h1>
                                    <p class="text-secondary mb-0">Fresh products</p>
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
                                <p class="mb-4">typesetting, remaining essentially unchanged. It was
                                    popularised in the 1960s with the like Aldus PageMaker including of Lorem Ipsum.</p>
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
                                <img src="img/payment.png" class="img-fluid" alt="">
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
                            Designed By <a class="border-bottom" href="https://htmlcodex.com">HTML Codex</a> Distributed
                            By
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
            <script src="../../frontlib/easing/easing.js"></script>
            <script src="../../frontlib/waypoints/waypoints.min.js"></script>

            <script src="../../frontlib/lightbox/js/lightbox.min.js"></script>

            <script src="../../frontlib/owlcarousel/owl.carousel.min.js"></script>

            <script src="../../frontjs/main.js"></script>
            <script>
                $('#search-icon-1').click(function () {//查詢賣家底下的商品
                    // action="" method="get" id="gotoSearchGoodForm"
                    let form = $(this).closest('form');
                    form.prop("action", "....");//目標網址
                    form.submit();
                })
                $('.CategoryItem').click(function () {
                    if ($('#BuyItemNumber').prop("hidden") == true) {//假若欄位被影藏
                        $('#BuyItemNumber').prop("hidden", false);//取消影藏
                    }
                    else {

                    }
                    let goodstock = $(this).find('span[class="CategoryNumber"]').prop("innerHTML");
                    $('#BuyItemNumber').find('p[id="remainingNumber"]').prop("innerHTML", "還剩" + goodstock + "個");
                })
                $('button[class="btn btn-sm btn-plus rounded-circle bg-light border"]').click(function () {
                    let InputNumber = $(this).closest('div').find('input[id="BuyNumber"]').prop("value");
                    let goodstockmsg = $('#BuyItemNumber').find('p[id="remainingNumber"]').prop("innerHTML");
                    let goodstock = goodstockmsg.substring(2, goodstockmsg.length - 1);
                    if (ItemNumber > Number(goodstock)) {
                        $('#errormsg').prop("innerHTML", "操作不當");//最多只能購買剩餘的數量
                    }
                    $(this).closest('div').find('input[id="BuyNumber"]').prop("value", Number(goodstock));//不讓數字增加
                })
                $('button[class="btn btn-sm btn-minus rounded-circle bg-light border"]').click(function () {
                    let InputNumber = $(this).closest('div').find('input[id="BuyNumber"]').prop("value");
                    let goodstockmsg = $('#BuyItemNumber').find('p[id="remainingNumber"]').prop("innerHTML");//
                    let goodstock = goodstockmsg.substring(2, goodstockmsg.length - 1);//取得剩餘數量
                    if (ItemNumber <= Number(goodstock)) {
                        $('#errormsg').prop("innerHTML", "");//將錯誤訊息抹消
                    }
                    if (ItemNumber <= 1) {
                        $(this).closest('div').find('input[id="BuyNumber"]').prop("value", 1);//最少購買一筆
                    }
                })
            </script>
        </body>

        </html>