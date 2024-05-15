<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="BIG5">
            <title>Insert title here</title>
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
                            $('#returnGoodResult').prop("innerHTML", "");
                            $.each(data, function (i, n) {

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
                                div0.append(div1);
                                $('#returnGoodResult').append(div0);
                            })
                            // console.log($('#returnGoodResult'));
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
                    <!--  -->
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
                    <!--  -->
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
            <!-- Navbar End -->


            <!-- Fruits Shop Start-->
            <div class="container-fluid fruite py-5">
                <div class="container py-5">
                    <div class="row mt-5">
                        <div class="col mt-5">
                            <h1 class="mb-4 mt-2" id="GoodNameResult">搜尋"${goodsName}"的結果</h1>
                        </div>
                        <div class="col-xl-3 mt-5">
                            <div class="bg-light ps-3 py-3 rounded d-flex justify-content-between mb-4">
                                <form action="" id="GoodOrderByItem">
                                    <label for="fruits">Default Sorting:</label>
                                    <select id="fruits" name="fruitlist" class="border-0 form-select-sm bg-light me-3"
                                        form="fruitform">
                                        <option value="NO">Nothing</option>
                                        <option value="price">價格</option>
                                        <option value="score">評價</option>
                                        <option value="ID">商品編號</option>
                                    </select>
                                </form>
                            </div>
                        </div>
                    </div>
                    <!-- <h1 class="mb-4 mt-5">搜尋"${goodsName}"的結果</h1> -->
                    <div class="row g-4">
                        <div class="col-lg-12">
                            <div class="row g-4">
                                <!-- <div class="col-xl-3">
                                    <div class="input-group w-100 mx-auto d-flex">
                                        <input type="search" class="form-control p-3" placeholder="keywords"
                                            aria-describedby="search-icon-1">
                                        <span id="search-icon-1" class="input-group-text p-3"><i
                                                class="fa fa-search"></i></span>
                                    </div>
                                </div> -->
                                <div class="col-6"></div>
                                <!-- <div class="col-xl-3">
                                    <div class="bg-light ps-3 py-3 rounded d-flex justify-content-between mb-4">
                                        <form action="" id="GoodOrderByItem">
                                            <label for="fruits">Default Sorting:</label>
                                            <select id="fruits" name="fruitlist"
                                                class="border-0 form-select-sm bg-light me-3" form="fruitform">
                                                <option value="volvo">Nothing</option>
                                                <option value="saab">價格</option>
                                                <option value="opel">評價</option>
                                                <option value="audi">商品編號</option>
                                            </select>
                                        </form>
                                    </div>
                                </div> -->
                            </div>
                            <div class="row g-4">
                                <div class="col-lg-3">
                                    <div class="row g-4">
                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <h4>種類</h4>
                                                <ul class="list-unstyled fruite-categorie" id="CategoriesList">
                                                    <c:forEach var="j" begin="0" end="${CategoryNumber}" step="1"
                                                        items="${CategoryNumberList}">
                                                        <li>
                                                            <div
                                                                class="form-check d-flex justify-content-between fruite-name CategotyClick">
                                                                <form action="">
                                                                    <input class="form-check-input" type="checkbox"
                                                                        value="${j.goodsType}" name="Category">
                                                                    <input type="text" class="form-control"
                                                                        name="GoodName" value="${goodsName}" hidden>
                                                                    <input type="text" class="form-control"
                                                                        name="GoodType" value="${{j.goodsType}}" hidden>
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
                                                <output id="amount" name="amount" min-velue="0" max-value="50000"
                                                    for="rangeInput">0</output>
                                            </div>
                                        </div>
                                        <div class="col-lg-12">
                                            <h4 class="mb-3">Featured products</h4>
                                            <div class="d-flex align-items-center justify-content-start">
                                                <div class="rounded me-4" style="width: 100px; height: 100px;">
                                                    <img src="img/featur-1.jpg" class="img-fluid rounded" alt="">
                                                </div>
                                                <div>
                                                    <h6 class="mb-2">Big Banana</h6>
                                                    <div class="d-flex mb-2">
                                                        <i class="fa fa-star text-secondary"></i>
                                                        <i class="fa fa-star text-secondary"></i>
                                                        <i class="fa fa-star text-secondary"></i>
                                                        <i class="fa fa-star text-secondary"></i>
                                                        <i class="fa fa-star"></i>
                                                    </div>
                                                    <div class="d-flex mb-2">
                                                        <h5 class="fw-bold me-2">2.99 $</h5>
                                                        <h5 class="text-danger text-decoration-line-through">4.11 $</h5>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="d-flex align-items-center justify-content-start">
                                                <div class="rounded me-4" style="width: 100px; height: 100px;">
                                                    <img src="img/featur-2.jpg" class="img-fluid rounded" alt="">
                                                </div>
                                                <div>
                                                    <h6 class="mb-2">Big Banana</h6>
                                                    <div class="d-flex mb-2">
                                                        <i class="fa fa-star text-secondary"></i>
                                                        <i class="fa fa-star text-secondary"></i>
                                                        <i class="fa fa-star text-secondary"></i>
                                                        <i class="fa fa-star text-secondary"></i>
                                                        <i class="fa fa-star"></i>
                                                    </div>
                                                    <div class="d-flex mb-2">
                                                        <h5 class="fw-bold me-2">2.99 $</h5>
                                                        <h5 class="text-danger text-decoration-line-through">4.11 $</h5>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="d-flex align-items-center justify-content-start">
                                                <div class="rounded me-4" style="width: 100px; height: 100px;">
                                                    <img src="img/featur-3.jpg" class="img-fluid rounded" alt="">
                                                </div>
                                                <div>
                                                    <h6 class="mb-2">Big Banana</h6>
                                                    <div class="d-flex mb-2">
                                                        <i class="fa fa-star text-secondary"></i>
                                                        <i class="fa fa-star text-secondary"></i>
                                                        <i class="fa fa-star text-secondary"></i>
                                                        <i class="fa fa-star text-secondary"></i>
                                                        <i class="fa fa-star"></i>
                                                    </div>
                                                    <div class="d-flex mb-2">
                                                        <h5 class="fw-bold me-2">2.99 $</h5>
                                                        <h5 class="text-danger text-decoration-line-through">4.11 $</h5>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="d-flex justify-content-center my-4">

                                                <a href="#"
                                                    class="btn border border-secondary px-4 py-3 rounded-pill text-primary w-100">Vew
                                                    More</a>
                                            </div>
                                        </div>
                                        <div class="col-lg-12">
                                            <div class="position-relative">
                                                <img src="img/banner-fruits.jpg" class="img-fluid w-100 rounded" alt="">
                                                <div class="position-absolute"
                                                    style="top: 50%; right: 10px; transform: translateY(-50%);">
                                                    <h3 class="text-secondary fw-bold">Fresh <br> Fruits <br> Banner
                                                    </h3>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-9">
                                    <div class="row g-4 " id="returnGoodResult"> <!-- justify-content-center -->
                                        <!-- 
                                        <div class="col-md-6 col-lg-6 col-xl-4">
                                            <div class="rounded position-relative fruite-item">
                                                <div class="fruite-img">
                                                    <img src="img/fruite-item-5.jpg" class="img-fluid w-100 rounded-top"
                                                        alt="">
                                                </div>
                                                <div class="text-white bg-secondary px-3 py-1 rounded position-absolute"
                                                    style="top: 10px; left: 10px;">Fruits</div>
                                                <div class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                    <h4>Grapes</h4>
                                                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do
                                                        eiusmod te incididunt</p>
                                                    <div class="d-flex justify-content-between flex-lg-wrap">
                                                        <p class="text-dark fs-5 fw-bold mb-0">$4.99 / kg</p>
                                                        <a href="#"
                                                            class="btn border border-secondary rounded-pill px-3 text-primary"><i
                                                                class="fa fa-shopping-bag me-2 text-primary"></i> Add to
                                                            cart</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-6 col-xl-4">
                                            <div class="rounded position-relative fruite-item">
                                                <div class="fruite-img">
                                                    <img src="img/fruite-item-5.jpg" class="img-fluid w-100 rounded-top"
                                                        alt="">
                                                </div>
                                                <div class="text-white bg-secondary px-3 py-1 rounded position-absolute"
                                                    style="top: 10px; left: 10px;">Fruits</div>
                                                <div class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                    <h4>Grapes</h4>
                                                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do
                                                        eiusmod te incididunt</p>
                                                    <div class="d-flex justify-content-between flex-lg-wrap">
                                                        <p class="text-dark fs-5 fw-bold mb-0">$4.99 / kg</p>
                                                        <a href="#"
                                                            class="btn border border-secondary rounded-pill px-3 text-primary"><i
                                                                class="fa fa-shopping-bag me-2 text-primary"></i> Add to
                                                            cart</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-6 col-xl-4">
                                            <div class="rounded position-relative fruite-item">
                                                <div class="fruite-img">
                                                    <img src="img/fruite-item-2.jpg" class="img-fluid w-100 rounded-top"
                                                        alt="">
                                                </div>
                                                <div class="text-white bg-secondary px-3 py-1 rounded position-absolute"
                                                    style="top: 10px; left: 10px;">Fruits</div>
                                                <div class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                    <h4>Raspberries</h4>
                                                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do
                                                        eiusmod te incididunt</p>
                                                    <div class="d-flex justify-content-between flex-lg-wrap">
                                                        <p class="text-dark fs-5 fw-bold mb-0">$4.99 / kg</p>
                                                        <a href="#"
                                                            class="btn border border-secondary rounded-pill px-3 text-primary"><i
                                                                class="fa fa-shopping-bag me-2 text-primary"></i> Add to
                                                            cart</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-6 col-xl-4">
                                            <div class="rounded position-relative fruite-item">
                                                <div class="fruite-img">
                                                    <img src="img/fruite-item-4.jpg" class="img-fluid w-100 rounded-top"
                                                        alt="">
                                                </div>
                                                <div class="text-white bg-secondary px-3 py-1 rounded position-absolute"
                                                    style="top: 10px; left: 10px;">Fruits</div>
                                                <div class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                    <h4>Apricots</h4>
                                                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do
                                                        eiusmod te incididunt</p>
                                                    <div class="d-flex justify-content-between flex-lg-wrap">
                                                        <p class="text-dark fs-5 fw-bold mb-0">$4.99 / kg</p>
                                                        <a href="#"
                                                            class="btn border border-secondary rounded-pill px-3 text-primary"><i
                                                                class="fa fa-shopping-bag me-2 text-primary"></i> Add to
                                                            cart</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-6 col-xl-4">
                                            <div class="rounded position-relative fruite-item">
                                                <div class="fruite-img">
                                                    <img src="img/fruite-item-3.jpg" class="img-fluid w-100 rounded-top"
                                                        alt="">
                                                </div>
                                                <div class="text-white bg-secondary px-3 py-1 rounded position-absolute"
                                                    style="top: 10px; left: 10px;">Fruits</div>
                                                <div class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                    <h4>Banana</h4>
                                                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do
                                                        eiusmod te incididunt</p>
                                                    <div class="d-flex justify-content-between flex-lg-wrap">
                                                        <p class="text-dark fs-5 fw-bold mb-0">$4.99 / kg</p>
                                                        <a href="#"
                                                            class="btn border border-secondary rounded-pill px-3 text-primary"><i
                                                                class="fa fa-shopping-bag me-2 text-primary"></i> Add to
                                                            cart</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-6 col-xl-4">
                                            <div class="rounded position-relative fruite-item">
                                                <div class="fruite-img">
                                                    <img src="img/fruite-item-1.jpg" class="img-fluid w-100 rounded-top"
                                                        alt="">
                                                </div>
                                                <div class="text-white bg-secondary px-3 py-1 rounded position-absolute"
                                                    style="top: 10px; left: 10px;">Fruits</div>
                                                <div class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                    <h4>Oranges</h4>
                                                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do
                                                        eiusmod te incididunt</p>
                                                    <div class="d-flex justify-content-between flex-lg-wrap">
                                                        <p class="text-dark fs-5 fw-bold mb-0">$4.99 / kg</p>
                                                        <a href="#"
                                                            class="btn border border-secondary rounded-pill px-3 text-primary"><i
                                                                class="fa fa-shopping-bag me-2 text-primary"></i> Add to
                                                            cart</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-6 col-xl-4">
                                            <div class="rounded position-relative fruite-item">
                                                <div class="fruite-img">
                                                    <img src="img/fruite-item-2.jpg" class="img-fluid w-100 rounded-top"
                                                        alt="">
                                                </div>
                                                <div class="text-white bg-secondary px-3 py-1 rounded position-absolute"
                                                    style="top: 10px; left: 10px;">Fruits</div>
                                                <div class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                    <h4>Raspberries</h4>
                                                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do
                                                        eiusmod te incididunt</p>
                                                    <div class="d-flex justify-content-between flex-lg-wrap">
                                                        <p class="text-dark fs-5 fw-bold mb-0">$4.99 / kg</p>
                                                        <a href="#"
                                                            class="btn border border-secondary rounded-pill px-3 text-primary"><i
                                                                class="fa fa-shopping-bag me-2 text-primary"></i> Add to
                                                            cart</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-6 col-xl-4">
                                            <div class="rounded position-relative fruite-item">
                                                <div class="fruite-img">
                                                    <img src="img/fruite-item-5.jpg" class="img-fluid w-100 rounded-top"
                                                        alt="">
                                                </div>
                                                <div class="text-white bg-secondary px-3 py-1 rounded position-absolute"
                                                    style="top: 10px; left: 10px;">Fruits</div>
                                                <div class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                    <h4>Grapes</h4>
                                                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do
                                                        eiusmod te incididunt</p>
                                                    <div class="d-flex justify-content-between flex-lg-wrap">
                                                        <p class="text-dark fs-5 fw-bold mb-0">$4.99 / kg</p>
                                                        <a href="#"
                                                            class="btn border border-secondary rounded-pill px-3 text-primary"><i
                                                                class="fa fa-shopping-bag me-2 text-primary"></i> Add to
                                                            cart</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-6 col-xl-4">
                                            <div class="rounded position-relative fruite-item">
                                                <div class="fruite-img">
                                                    <img src="img/fruite-item-1.jpg" class="img-fluid w-100 rounded-top"
                                                        alt="">
                                                </div>
                                                <div class="text-white bg-secondary px-3 py-1 rounded position-absolute"
                                                    style="top: 10px; left: 10px;">Fruits</div>
                                                <div class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                    <h4>Oranges</h4>
                                                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do
                                                        eiusmod te incididunt</p>
                                                    <div class="d-flex justify-content-between flex-lg-wrap">
                                                        <p class="text-dark fs-5 fw-bold mb-0">$4.99 / kg</p>
                                                        <a href="#"
                                                            class="btn border border-secondary rounded-pill px-3 text-primary"><i
                                                                class="fa fa-shopping-bag me-2 text-primary"></i> Add to
                                                            cart</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                         -->
                                    </div>
                                    <div class="col-12">
                                        <div class="pagination d-flex justify-content-center mt-5">
                                            <!-- <a href="#" class="rounded">&laquo;</a> -->
                                            Previous
                                            <c:forEach var="i" begin="0" end="${totalPages+1}" step="1">
                                                <button id="myPage" type="button"
                                                    onclick="change(${i}+1)">${i+1}</button>
                                            </c:forEach>
                                            Next
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
                            <!--/*** This template is free as long as you keep the below authors credit link/attribution link/backlink. ***/-->
                            <!--/*** If you'd like to use the template without the below authors credit link/attribution link/backlink, ***/-->
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

            <script src="../../frontlib/easing/easing.min.js"></script>
            <script src="../../frontlib/waypoints/waypoints.min.js"></script>
            <script src="../../frontlib/lightbox/js/lightbox.min.js"></script>
            <script src="../../frontlib/owlcarousel/owl.carousel.min.js"></script>
            <!-- Template Javascript -->
            <script src="../../frontjs/main.js"></script>
            <script>
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
            </script>
        </body>

        </html>