<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="BIG5">
            <title>Insert title here</title>
            <meta charset="BIG5">
            <title>Insert title here</title>
            <!-- Google Web Fonts -->
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>


            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet"
                integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU"
                crossorigin="anonymous">
            <!-- Icon Font Stylesheet -->
            <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
            <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

            <link href="../../frontlib/lightbox/css/lightbox.min.css" rel="stylesheet">
            <link href="../../frontlib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
            <link href="../../frontcss/bootstrap.min.css" rel="stylesheet">
            <link href="../../frontcss/style.css" rel="stylesheet">
            <!--  -->
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.css">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick-theme.css">
        </head>

        <body>

            <%@ include file="../../FrontDeskNav.jsp" %>

                <div class="container-fluid">
                    <div class="container">
                        <div class="row g-4 mt-5">
                            <div class="col-lg-12 col-xl-12">
                                <div class="row g-4">
                                    <div class="col-lg-6">
                                        <!-- 圖片輪播功能 -->
                                        <div class="your-class">
                                            <div>
                                                <img class="img-fluid w-100" src="${Good.titleImage}"
                                                    alt="${Good.titleImage}" style="height: 400px;">
                                            </div>
                                            <c:forEach var="j" begin="0" end="${GoodImageNumber}" step="1"
                                                items="${GoodImage}" varStatus="loop">
                                                <div>
                                                    <img class="img-fluid w-100" src="${j.imagePath}"
                                                        alt="${j.imagePath}" style="height: 400px;">
                                                </div>
                                            </c:forEach>
                                            <c:forEach var="j" begin="0" end="${GoodFormatImagePathNumber}" step="1"
                                                items="${GoodFormatImagePath}" varStatus="loop">
                                                <div>
                                                    <img class="img-fluid w-100" src="${j.goodImagePath}"
                                                        alt="${j.goodImagePath}" style="height: 400px;">
                                                </div>
                                            </c:forEach>
                                        </div>
                                        <!-- 商品規格(呈現該商品編號下對應的所有規格) -->
                                    </div>
                                    <div class="col-lg-6">
                                        <h4 class="fw-bold mb-3" id="GoodName">
                                            ${GoodBasicInfo.goodName}</h4> <!-- 商品名稱 -->
                                        <div class="d-flex mb-4" id="GoodRate">
                                            <!-- 平均分數 EX(3.5/5) -->
                                            <c:forEach var="j" begin="1" end="5" step="1" varStatus="loop">
                                                <c:if test="${GoodBasicInfo.goodAVG>=loop.index}">
                                                    <i class="fa fa-star text-secondary py-1"></i>
                                                </c:if>
                                                <c:if test="${loop.index>GoodBasicInfo.goodAVG}">
                                                    <i class="fa fa-star py-1"></i>
                                                </c:if>
                                            </c:forEach>
                                            <p class="mx-3 mb-1" id="GoodSold">已售出:
                                                ${GoodBasicInfo.goodsold}</p>
                                            <!-- 商品售出量 -->
                                        </div>
                                        <p class="mb-3" id="GoodType">Category:
                                            ${GoodBasicInfo.goodType}</p> <!-- 商品種類 -->
                                        <h5 class="fw-bold mb-3" id="GoodPriceRange">
                                            ${GoodBasicInfo.minprice}-${GoodBasicInfo.maxprice}$
                                        </h5> <!-- 商品價格(以範圍表示) -->
                                        <div class="row row-cols-2">
                                            <c:forEach var="j" begin="0" end="${GoodFormatNumber}" step="1"
                                                items="${GoodFormat}" varStatus="loop">
                                                <div class="col">
                                                    <button
                                                        class="btn btn-outline-primary round-pill CategoryItem w-100 mb-1">
                                                        <img src="${j.goodImagePath}" alt="${j.goodImagePath}"
                                                            style="width: 20px;height: 20px;">
                                                        <span>${j.goodSize}</span>
                                                        <span hidden class="CategoryPrice">${j.goodPrice}</span>
                                                        <span hidden class="CategoryNumber">${j.goodsStock}</span>
                                                        <span hidden class="formatID">${j.good.goodsID}</span>
                                                    </button>
                                                </div>
                                            </c:forEach>
                                        </div>
                                        <div id="formatpriceremaining" hidden>
                                            <h3>數量:<span id="price"></span></h3>
                                            <h3>價格:<span id="remaining"></span></h3>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-12">
                                    <!-- 裡面放入商品描述 -->
                                    <h1>商品使用說明:</h1>
                                    <h4>${GoodBasicInfo.goodDirection}</h4>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 商品圖片(用輪播呈現) -->
                </div>
                </div>
                </div>
                <!-- 透過商品種類去查詢商品基本資料表 -->


                <!-- Single Product End -->


                <!-- Footer Start -->
                <div class="container-fluid bg-dark text-white-50 footer pt-5 mt-5">
                    <div class="container py-5">
                        <div class="pb-4 mb-4" style="border-bottom: 1px solid rgba(226, 175, 24, 0.5);">
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
                                        <a class="btn  btn-outline-secondary me-2 btn-md-square rounded-circle"
                                            href=""><i class="fab fa-twitter"></i></a> <a
                                            class="btn btn-outline-secondary me-2 btn-md-square rounded-circle"
                                            href=""><i class="fab fa-facebook-f"></i></a> <a
                                            class="btn btn-outline-secondary me-2 btn-md-square rounded-circle"
                                            href=""><i class="fab fa-youtube"></i></a> <a
                                            class="btn btn-outline-secondary btn-md-square rounded-circle" href=""><i
                                                class="fab fa-linkedin-in"></i></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row g-5">
                            <div class="col-lg-3 col-md-6">
                                <div class="footer-item">
                                    <h4 class="text-light mb-3">Why People Like us!</h4>
                                    <p class="mb-4">typesetting, remaining essentially
                                        unchanged.
                                        It was popularised in the 1960s with the like Aldus
                                        PageMaker
                                        including of Lorem Ipsum.</p>
                                    <a href="" class="btn border-secondary py-2 px-4 rounded-pill text-primary">Read
                                        More</a>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-6">
                                <div class="d-flex flex-column text-start footer-item">
                                    <h4 class="text-light mb-3">Shop Info</h4>
                                    <a class="btn-link" href="">About Us</a> <a class="btn-link" href="">Contact Us</a>
                                    <a class="btn-link" href="">Privacy
                                        Policy</a> <a class="btn-link" href="">Terms &
                                        Condition</a> <a class="btn-link" href="">Return
                                        Policy</a> <a class="btn-link" href="">FAQs & Help</a>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-6">
                                <div class="d-flex flex-column text-start footer-item">
                                    <h4 class="text-light mb-3">Account</h4>
                                    <a class="btn-link" href="">My Account</a> <a class="btn-link" href="">Shop
                                        details</a>
                                    <a class="btn-link" href="">Shopping
                                        Cart</a> <a class="btn-link" href="">Wishlist</a> <a class="btn-link"
                                        href="">Order
                                        History</a> <a class="btn-link" href="">International
                                        Orders</a>
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
                                <span class="text-light"><a href="#"><i
                                            class="fas fa-copyright text-light me-2"></i>Your
                                        Site Name</a>, All
                                    right reserved.</span>
                            </div>
                            <div class="col-md-6 my-auto text-center text-md-end text-white">
                                <!--/*** This template is free as long as you keep the below author’s credit link/attribution link/backlink. ***/-->
                                <!--/*** If you'd like to use the template without the below author’s credit link/attribution link/backlink, ***/-->
                                <!--/*** you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". ***/-->
                                Designed By <a class="border-bottom" href="https://htmlcodex.com">HTML
                                    Codex</a> Distributed By <a class="border-bottom"
                                    href="https://themewagon.com">ThemeWagon</a>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Copyright End -->

                <!-- Back to Top -->
                <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i
                        class="fa fa-arrow-up"></i></a>

                <!-- JavaScript Libraries -->
                <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.js"></script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.js"></script>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"
                    integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ"
                    crossorigin="anonymous"></script>
                <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script> -->

                <script src="../../frontlib/easing/easing.js"></script>
                <script src="../../frontlib/waypoints/waypoints.min.js"></script>
                <script src="../../frontlib/lightbox/js/lightbox.min.js"></script>
                <script src="../../frontlib/owlcarousel/owl.carousel.min.js"></script>
                <script src="../../frontjs/main.js"></script>
                <script>
                    $('.your-class').slick();

                    $('.CategoryItem').click(function () {//取得對應規格編號
                        if ($('#formatpriceremaining').prop("hidden", true)) {
                            $('#formatpriceremaining').prop("hidden", false)
                        }
                        else {

                        }
                        let goodstock = $(this).find('span[class="CategoryNumber"]').prop("innerHTML");
                        let formatprice = $(this).find('span[class="CategoryPrice"]').prop("innerHTML");

                        $('#price').prop("innerHTML", formatprice);
                        $('#remaining').prop("innerHTML", goodstock);

                    })



                </script>
        </body>

        </html>