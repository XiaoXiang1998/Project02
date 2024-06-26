<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@page import="com.member.model.MemberBean" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <title>Insert title here</title>
                <link rel="preconnect" href="https://fonts.googleapis.com">

                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                <link
                    href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
                    rel="stylesheet">

                <!-- Icon Font Stylesheet -->
                <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
                <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
                    rel="stylesheet">

                <!-- Libraries Stylesheet -->
                <link href="../../frontlib/lightbox/css/lightbox.min.css" rel="stylesheet">

                <link href="../../frontlib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

                <!-- Customized Bootstrap Stylesheet -->
                <link href="../../frontcss/bootstrap.min.css" rel="stylesheet">

                <!-- Template Stylesheet -->
                <link href="../../frontcss/style.css" rel="stylesheet">
                <style>
                    .CategotyClick {
                        cursor: pointer;
                    }
                </style>
                <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
                <script>
                    var indexPage = 1;
                    $(function () {
                        let target = $('#CategoriesList').find('input[type="checkbox"][name="Category"]:checked');
                        let Category;
                        if (target.length == 0) {
                            Category = "XXX";
                        }
                        else {
                            Category = target.val();
                        }
                        let price;
                        if ($('#rangeInput').val() == 0) {
                            price = "XXX";
                        }
                        else {
                            price = $('#rangeInput').val();
                        }
                        let orderItem;
                        if ($('#fruits').val() == "NO") {
                            orderItem = "XXX";
                        }
                        else {
                            orderItem = $('#fruits').val();
                        }
                        let goodNameLength = $('#GoodNameResult').prop("innerHTML").length;

                        let goodName = $('#GoodNameResult').prop("innerHTML").substring(3, goodNameLength - 4);

                        let hiddenContent = goodName + "_" + Category + "_" + price + "_" + orderItem;
                        //
                        loadPage(indexPage, hiddenContent);//還需檢查額外條件
                    })
                    function change(page) {
                        let target = $('#CategoriesList').find('input[type="checkbox"][name="Category"]:checked');
                        let Category;
                        if (target.length == 0) {
                            Category = "XXX";
                        }
                        else {
                            Category = target.val();
                        }
                        let price;
                        if ($('#rangeInput').val() == 0) {
                            price = "XXX";
                        }
                        else {
                            price = $('#rangeInput').val();
                        }
                        let orderItem;
                        if ($('#fruits').val() == "NO") {
                            orderItem = "XXX";
                        }
                        else {
                            orderItem = $('#fruits').val();
                        }
                        let goodNameLength = $('#GoodNameResult').prop("innerHTML").length;

                        let goodName = $('#GoodNameResult').prop("innerHTML").substring(3, goodNameLength - 4);

                        let hiddenContent = goodName + "_" + Category + "_" + price + "_" + orderItem;
                        //
                        indexPage = page;
                        loadPage(indexPage, hiddenContent);
                    }
                    function loadPage(indexPage, hiddenContent) {
                        $.ajax({
                            type: 'get',
                            url: '/searchGoodResult/' + indexPage + "/" + hiddenContent,
                            contentType: 'application/json',
                            success: function (data) {
                                //	private Integer page;
                                //	private List<GoodPriceDTO> goodPriceDtoList;
                                let data1 = data.goodPriceDtoList;
                                $('#returnGoodResult').prop("innerHTML", "");
                                $.each(data1, function (i, n) {
                                    //form標籤包在div[class="col-md-6 col-lg-6 col-xl-4"]裡面
                                    //div[class="col-md-6 col-lg-6 col-xl-4"]
                                    let form = document.createElement('form');
                                    let inputID = document.createElement('input'); inputID.setAttribute("type", "text"); inputID.setAttribute("name", "GoodID"); inputID.classList.add('form-control'); inputID.setAttribute("value", n.goodsID); inputID.setAttribute("hidden", true);
                                    //
                                    let div0 = document.createElement("div"); div0.classList.add("col-md-6"); div0.classList.add("col-lg-6"); div0.classList.add("col-xl-4");
                                    let div1 = document.createElement("div"); div1.classList.add("rounded"); div1.classList.add("position-relative"); div1.classList.add("fruite-item");
                                    let div2 = document.createElement("div"); div2.classList.add("fruite-img");
                                    let img0 = document.createElement("img"); img0.classList.add("img-fluid"); img0.classList.add("w-100"); img0.classList.add("rounded-top"); img0.setAttribute("src", n.titleImage); img0.setAttribute("alt", n.titleImage); div2.append(img0); img0.setAttribute("style", "width: 150px;height: 250px;");
                                    let div3 = document.createElement("div"); div3.classList.add("text-white"); div3.classList.add("bg-secondary"); div3.classList.add("px-3"); div3.classList.add("py-1"); div3.classList.add("rounded"); div3.classList.add("position-absolute");
                                    div3.setAttribute("style", "top: 10px; left: 10px;"); div3.innerHTML = n.goodType;
                                    let div4 = document.createElement("div"); div4.classList.add("p-4"); div4.classList.add("border"); div4.classList.add("border-secondary"); div4.classList.add("border-top-0"); div4.classList.add("rounded-bottom");
                                    let contenth4 = document.createElement("h4"); contenth4.innerHTML = n.goodName;
                                    // <div class="d-flex my-3">
                                    //      <i class="fas fa-star text-primary"></i>
                                    //      <i class="fas fa-star text-primary"></i>
                                    //      <i class="fas fa-star text-primary"></i>
                                    //      <i class="fas fa-star text-primary"></i>
                                    //      <i class="fas fa-star"></i>
                                    // </div>
                                    let div5 = document.createElement("div"); div5.classList.add("d-flex"); div5.classList.add("my-3");
                                    let score = n.goodAVG;
                                    for (let i = 1; i <= 5; i++) {
                                        if (score >= i) {
                                            let fontawesomei = document.createElement("i"); fontawesomei.classList.add("fas"); fontawesomei.classList.add("fa-star"); fontawesomei.classList.add("text-primary");
                                            div5.append(fontawesomei);
                                        }
                                        else {
                                            let fontawesomei = document.createElement("i"); fontawesomei.classList.add("fas"); fontawesomei.classList.add("fa-star");
                                            div5.append(fontawesomei);
                                        }
                                    }
                                    let div6 = document.createElement("div"); div6.classList.add("d-flex"); div6.classList.add("justify-content-between");
                                    div6.classList.add("flex-lg-wrap");
                                    //                 <p class="text-dark fs-5 fw-bold mb-0">$4.99 / kg</p>
                                    let p1 = document.createElement("p"); p1.classList.add("text-dark"); p1.classList.add("fs-5"); p1.classList.add("fw-bold");
                                    p1.classList.add("mb-0");
                                    let content = n.minprice + "-" + n.maxprice + "$";
                                    p1.innerHTML = content;
                                    div6.append(p1);
                                    div4.append(contenth4); div4.append(div5); div4.append(div6);
                                    div1.append(div2); div1.append(div3); div1.append(div4);
                                    form.append(div1);

                                    div0.append(form); form.append(inputID)
                                    $('#returnGoodResult').append(div0);
                                })

                                changePaheNumber(data.page);


                            }
                        })
                    }
                </script>
            </head>

            <body>
                <%@ include file="../../FrontDeskNav.jsp" %>
                    <% HttpSession MemberSession=request.getSession(); MemberBean member=(MemberBean)
                        MemberSession.getAttribute("member"); %>
                        <!-- Fruits Shop Start-->
                        <div class="container-fluid fruite">
                            <div class="container">
                                <div class="row mt-5">
                                    <div class="col mt-5">
                                        <h1 class="mb-4 mt-2" id="GoodNameResult">搜尋"${goodsName}"的結果</h1>
                                    </div>
                                    <div class="col-xl-3 mt-5">
                                        <div class="bg-light ps-3 py-3 rounded d-flex justify-content-between mb-4">
                                            <form action="" id="GoodOrderByItem">
                                                <label for="fruits">Default Sorting:</label>
                                                <select id="fruits" name="fruitlist"
                                                    class="border-0 form-select-sm bg-light me-3" form="fruitform">
                                                    <option value="NO">Nothing</option>
                                                    <option value="price">價格</option>
                                                    <option value="score">評價</option>
                                                    <option value="ID">近期熱銷</option>
                                                </select>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                                <h1 class="mb-4 mt-5" id="test">${totalPages}</h1>
                                <h1 class="mb-4 mt-5" id="test1">
                                </h1>
                                <div class="row g-4">
                                    <div class="col-lg-12">
                                        <div class="row g-4">

                                            <div class="col-6"></div>

                                        </div>
                                        <div class="row g-4">
                                            <div class="col-lg-3">
                                                <div class="row g-4">
                                                    <div class="col-lg-12">
                                                        <div class="mb-3">
                                                            <h4>種類</h4>
                                                            <ul class="list-unstyled fruite-categorie"
                                                                id="CategoriesList">
                                                                <c:forEach var="j" begin="0" end="${CategoryNumber}"
                                                                    step="1" items="${CategoryNumberList}">
                                                                    <li>
                                                                        <div
                                                                            class="form-check d-flex justify-content-between fruite-name CategotyClick">
                                                                            <form action="">
                                                                                <input class="form-check-input"
                                                                                    type="checkbox"
                                                                                    value="${j.goodsType}"
                                                                                    name="Category">
                                                                                <input type="text" class="form-control"
                                                                                    name="GoodName" value="${goodsName}"
                                                                                    hidden>
                                                                                <input type="text" class="form-control"
                                                                                    name="GoodType"
                                                                                    value="${{j.goodsType}}" hidden>
                                                                                <span>${j.goodsType}</span>
                                                                                <span>(${j.goodsTypeNumber})</span>
                                                                            </form>
                                                                        </div>
                                                                    </li>
                                                                </c:forEach>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-12">
                                                        <div class="mb-3">
                                                            <h4 class="mb-2">Price</h4>
                                                            <input type="range" class="form-range w-100" id="rangeInput"
                                                                name="rangeInput" min="0" max="50000" value="0"
                                                                oninput="amount.value=rangeInput.value">
                                                            <output id="amount" name="amount" min-velue="0"
                                                                max-value="50000" for="rangeInput">0</output>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-12" id="popularGoodList">
                                                        <h4 class="mb-3">暢銷商品</h4>
                                                        <!-- PopularGoodBasicInfo -->
                                                        <div id="popularGoodList1">
                                                            <c:forEach var="j" begin="0" step="1"
                                                                items="${PopularGoodBasicInfo}">
                                                                <form action="" class="popularGoodListForm">
                                                                    <div
                                                                        class="d-flex align-items-center justify-content-start mb-3">
                                                                        <div class="rounded me-4"
                                                                            style="width: 100px; height: 100px;">
                                                                            <img src="${j.titleImage}"
                                                                                class="img-fluid rounded w-100 h-100"
                                                                                alt=""
                                                                                style="width: 50px;height: 50px;">
                                                                        </div>
                                                                        <input type="text" name="GoodID"
                                                                            value="${j.goodsID}" hidden>
                                                                        <div>
                                                                            <h6 class="mb-2">${j.goodName}</h6>
                                                                            <div class="d-flex mb-2">
                                                                                <c:forEach var="i" begin="1" end="5"
                                                                                    step="1" varStatus="loop">
                                                                                    <c:if
                                                                                        test="${j.goodAVG>=loop.index}">
                                                                                        <i
                                                                                            class="fa fa-star text-secondary"></i>
                                                                                    </c:if>
                                                                                    <c:if
                                                                                        test="${loop.index>j.goodAVG}">
                                                                                        <i class="fa fa-star"></i>
                                                                                    </c:if>
                                                                                </c:forEach>
                                                                            </div>
                                                                            <div class="d-flex mb-2">
                                                                                <h5 class="fw-bold me-2">
                                                                                    ${j.minprice}-${j.maxprice}
                                                                                    $
                                                                                </h5>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </form>
                                                            </c:forEach>
                                                        </div>

                                                        <div class="d-flex justify-content-start my-4" id="borderLine">
                                                            <!-- 點擊View More -->
                                                            <button class="btn btn-primary" type="button"
                                                                id="ViewMore">View
                                                                More</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-9">
                                                <div class="row g-4 " id="returnGoodResult">
                                                    <!-- justify-content-center -->

                                                </div>
                                                <div class="col-12">
                                                    <div class="pagination d-flex justify-content-center mt-5">
                                                        <!-- <a href="#" class="rounded">&laquo;</a> -->
                                                        <!-- Previous -->
                                                        <!-- <c:forEach var="i" begin="0" end="${totalPages+1}" step="1">
                                                <button id="myPage" type="button"
                                                    onclick="change(${i}+1)">${i+1}</button>
                                            </c:forEach> -->
                                                        <div class="row" id="PageList">

                                                        </div>
                                                        <!-- Next -->
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Fruits Shop End-->


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
                                                <input class="form-control border-0 w-100 py-3 px-4 rounded-pill"
                                                    type="number" placeholder="Your Email">
                                                <button type="submit"
                                                    class="btn btn-primary border-0 border-secondary py-3 px-4 position-absolute rounded-pill text-white"
                                                    style="top: 0; right: 0;">Subscribe Now</button>
                                            </div>
                                        </div>
                                        <div class="col-lg-3">
                                            <div class="d-flex justify-content-end pt-3">
                                                <a class="btn  btn-outline-secondary me-2 btn-md-square rounded-circle"
                                                    href=""><i class="fab fa-twitter"></i></a>
                                                <a class="btn btn-outline-secondary me-2 btn-md-square rounded-circle"
                                                    href=""><i class="fab fa-facebook-f"></i></a>
                                                <a class="btn btn-outline-secondary me-2 btn-md-square rounded-circle"
                                                    href=""><i class="fab fa-youtube"></i></a>
                                                <a class="btn btn-outline-secondary btn-md-square rounded-circle"
                                                    href=""><i class="fab fa-linkedin-in"></i></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row g-5">
                                    <div class="col-lg-3 col-md-6">
                                        <div class="footer-item">
                                            <h4 class="text-light mb-3">Why People Like us!</h4>
                                            <p class="mb-4">typesetting, remaining essentially unchanged. It was
                                                popularised in the 1960s with the like Aldus PageMaker including of
                                                Lorem
                                                Ipsum.
                                            </p>
                                            <a href=""
                                                class="btn border-secondary py-2 px-4 rounded-pill text-primary">Read
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
                                        <span class="text-light"><a href="#"><i
                                                    class="fas fa-copyright text-light me-2"></i>Your
                                                Site
                                                Name</a>, All right reserved.</span>
                                    </div>
                                    <div class="col-md-6 my-auto text-center text-md-end text-white">
                                        <!--/*** This template is free as long as you keep the below authors credit link/attribution link/backlink. ***/-->
                                        <!--/*** If you'd like to use the template without the below authors credit link/attribution link/backlink, ***/-->
                                        <!--/*** you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". ***/-->
                                        Designed By <a class="border-bottom" href="https://htmlcodex.com">HTML Codex</a>
                                        Distributed
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
                        <script
                            src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>

                        <script src="../../frontlib/easing/easing.min.js"></script>
                        <script src="../../frontlib/waypoints/waypoints.min.js"></script>
                        <script src="../../frontlib/lightbox/js/lightbox.min.js"></script>
                        <script src="../../frontlib/owlcarousel/owl.carousel.min.js"></script>
                        <!-- Template Javascript -->
                        <script src="../../frontjs/main.js"></script>
                        <script>
                            //點擊種類checkbox 觸發ajax並保有分頁查詢
                            $('input[type="checkbox"][name="Category"]').click(function () {//仍須滿足分頁查詢的功能
                                let goodNameLength = $('#GoodNameResult').prop("innerHTML").length;
                                let goodName = $('#GoodNameResult').prop("innerHTML").substring(3, goodNameLength - 4);
                                // console.log("123123123123123");
                                // console.log($(this).closest('form').find("span").prop("innerHTML")); //種類
                                // console.log($('#rangeInput').val()); //價格
                                // console.log($('#fruits').val()); //用甚麼方式排序
                                let Category;
                                if ($(this).prop("checked") == true) {
                                    Category = $(this).closest('form').find("span").prop("innerHTML");
                                }
                                else {
                                    Category = "XXX";
                                }
                                let price;
                                if ($('#rangeInput').val() == 0) {
                                    price = "XXX";
                                }
                                else {
                                    price = $('#rangeInput').val();
                                }
                                let orderItem;
                                if ($('#fruits').val() == "NO") {
                                    orderItem = "XXX";
                                }
                                else {
                                    orderItem = $('#fruits').val();
                                }
                                let hiddenContent = goodName + "_" + Category + "_" + price + "_" + orderItem;
                                console.log("hiddenContent = " + hiddenContent);
                                loadPage(1, hiddenContent);
                            })
                            //調整價格大小 觸發ajax並保有分頁查詢
                            $('#rangeInput').change(function () {
                                let goodNameLength = $('#GoodNameResult').prop("innerHTML").length;

                                let target = $('#CategoriesList').find('input[type="checkbox"][name="Category"]:checked');
                                let goodName = $('#GoodNameResult').prop("innerHTML").substring(3, goodNameLength - 4);

                                let Category;
                                if (target.length == 0) {
                                    Category = "XXX";
                                }
                                else {
                                    Category = target.val();
                                }
                                let price;
                                if ($(this).val() == 0) {
                                    price = "XXX";
                                }
                                else {
                                    price = $(this).val();
                                }

                                let orderItem;
                                if ($('#fruits').val() == "NO") {
                                    orderItem = "XXX";
                                }
                                else {
                                    orderItem = $('#fruits').val();
                                }
                                let hiddenContent = goodName + "_" + Category + "_" + price + "_" + orderItem;
                                console.log("hiddenContent = " + hiddenContent);
                                loadPage(1, hiddenContent);
                            })
                            //指定排序方式 觸發ajax並保有分頁查詢
                            $('#fruits').change(function () {
                                let goodNameLength = $('#GoodNameResult').prop("innerHTML").length;

                                let goodName = $('#GoodNameResult').prop("innerHTML").substring(3, goodNameLength - 4);

                                let orderItem;
                                if ($(this).val() == "NO") {
                                    orderItem = "XXX";
                                }
                                else {
                                    orderItem = $(this).val();
                                }

                                let target = $('#CategoriesList').find('input[type="checkbox"][name="Category"]:checked');
                                let Category;
                                if (target.length == 0) {
                                    Category = "XXX";
                                }
                                else {
                                    Category = target.val();
                                }
                                let price;
                                if ($('#rangeInput').val() == 0) {
                                    price = "XXX";
                                }
                                else {
                                    price = $('#rangeInput').val();
                                }
                                let hiddenContent = goodName + "_" + Category + "_" + price + "_" + orderItem;
                                console.log("hiddenContent = " + hiddenContent);
                                loadPage(1, hiddenContent);
                            })
                            //查詢新的商品名稱 頁面跳轉
                            $('#GoToSearchGood').click(function () {
                                let searchGoodInput = $(this).closest('form').find('input');
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
                            // 當觸發ajax後，根據得到的結果數量改變點擊按鈕的數量 $('#PageList')放入頁面的地方
                            function changePaheNumber(pageNumber) {//pageNumber = ${ totalPages+ 1}
                                console.log("pageNumber = " + pageNumber);

                                $('#PageList').prop("innerHTML", "");

                                // $('#PageList').prop("innerHTML", "");
                                for (let i = 1; i <= pageNumber; i++) {
                                    let btn1 = document.createElement("button");
                                    btn1.setAttribute("type", "button");
                                    btn1.innerHTML = i;
                                    btn1.setAttribute("onclick", "change(" + (i) + ")");
                                    btn1.classList.add("col");
                                    console.log("i = " + i);
                                    $('#PageList').append(btn1);
                                }
                                $('#PageList').prop("innerHTML")
                                // $('#test').prop("innerHTML", pageNumber + 1);
                            }
                            //檢閱詳細商品資訊
                            $(document).on('click', 'div[class="col-md-6 col-lg-6 col-xl-4"]', function () {//前往詳細商品頁面
                                console.log("你點到我了");
                                let form = $(this).find('form');
                                console.log(form);
                                form.prop("method", "get");
                                form.prop("action", "goodDetail.controller");
                                form.submit();
                            })
                            //想看更多熱銷商品 觸發ajax
                            $('#ViewMore').click(function () {
                                // let showstatus = ;
                                let showstatusString = $(this).prop("innerHTML").replace(/\s*/g, "");
                                console.log("你點到" + showstatusString);

                                let target = $('#popularGoodList').find(`div[class="d-flex align-items-center justify-content-start mb-3"]`);
                                console.log(target);
                                let arrtarget = [...target];
                                for (let i = 0; i < arrtarget.length; i++) {
                                    arrtarget[i].outerHTML = "";
                                }
                                let targetpopular = $('#GoodNameResult').prop("innerHTML");
                                let targetString = targetpopular.substring(3, targetpopular.length - 4);
                                let form = document.createElement("form");
                                let formdata = new FormData(form);
                                formdata.append("GoodName", targetString);
                                let params = { GoodName: targetString, showstatus: showstatusString };
                                console.log(params);
                                $.ajax({
                                    type: "get",
                                    url: "/viewMoreGood",
                                    dataType: "json",
                                    contentType: "application/json",
                                    data: params,
                                    success: function (data) {
                                        $.each(data, function (i, n) {
                                            // let div0 = document.createElement("div");
                                            // div0.classList.add("d-flex"); div0.classList.add("align-items-center");
                                            // div0.classList.add("justify-content-start"); div0.classList.add("mb-3");
                                            let content = `<div class="d-flex align-items-center justify-content-start mb-3">
                                 <div class="rounded me-4" style="width: 100px; height: 100px;">
                                                        <img src=`+ n.titleImage + ` class="img-fluid rounded w-100 h-100"
                                                            alt="" style="width: 50px;height: 50px;">
                                                    </div>
                                                    <div>
                                                        <h6 class="mb-2">`+ n.goodName + `</h6>
                                                        <div class="d-flex mb-2">`;
                                            for (let j = 1; j <= 5; j++) {
                                                if (n.goodAVG >= j) {
                                                    content = content + `<i class="fa fa-star text-secondary"></i>`;
                                                }
                                                else {
                                                    content = content + `<i class="fa fa-star"></i>`;
                                                }
                                            }
                                            content = content + `</div>
                                                        <div class="d-flex mb-2">
                                                            <h5 class="fw-bold me-2">`+ n.minprice + `-` + n.maxprice + `$</h5>
                                                        </div>
                                                    </div>
                                                </div>`;
                                            // div0.append(content);
                                            $('#popularGoodList1').append(content);
                                        })
                                    }
                                })
                                console.log($(this).prop("innerHTML").replace(/\s*/g, "") == "ViewMore");
                                if ($(this).prop("innerHTML").replace(/\s*/g, "") == "ViewMore") {
                                    $(this).prop("innerHTML", "View Less");
                                }
                                else {
                                    if ($(this).prop("innerHTML").replace(/\s*/g, "") == "ViewLess") {
                                        $(this).prop("innerHTML", "View More");
                                    }
                                }
                            })
                            //檢閱熱銷商品的詳細資訊
                            $('.popularGoodListForm').click(function () {
                                let form = $(this).closest("form");
                                form.prop("action", "goodDetail.controller");
                                form.prop("method", "get");
                                form.submit();
                            })
                        </script>
            </body>

            </html>