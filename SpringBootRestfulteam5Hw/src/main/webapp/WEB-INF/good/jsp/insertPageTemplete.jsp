<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
            <div class="container px-0">
                <nav class="navbar navbar-light bg-white navbar-expand-xl">
                    <a href="index.html" class="navbar-brand">
                        <h1 class="text-primary display-6">首頁</h1>
                    </a>
                    <button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse"
                        data-bs-target="#navbarCollapse">
                        <span class="fa fa-bars text-primary"></span>
                    </button>
                    <div class="collapse navbar-collapse bg-white" id="navbarCollapse">
                        <div class="navbar-nav mx-auto">
                            <a href="index.html" class="nav-item nav-link">首頁</a>
                            <a href="shop.html" class="nav-item nav-link">賣家賣場</a>
                            <a href="shop-detail.html" class="nav-item nav-link">商品介紹</a>
                            <div class="nav-item dropdown">
                                <a href="#" class="nav-link dropdown-toggle active" data-bs-toggle="dropdown">Pages</a>
                                <div class="dropdown-menu m-0 bg-secondary rounded-0">
                                    <a href="cart.html" class="dropdown-item">Cart</a>
                                    <a href="chackout.html" class="dropdown-item active">Chackout</a>
                                    <a href="testimonial.html" class="dropdown-item">Testimonial</a>
                                    <a href="404.html" class="dropdown-item">404 Page</a>
                                </div>
                            </div>
                            <a href="contact.html" class="nav-item nav-link">聯絡賣家</a>
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
                                    style="top: -5px; left: 15px; height: 20px; min-width: 20px;">3</span>
                                <!-- 透過使用者編號查看購物車內有幾筆商品 -->
                            </a>
                            <a href="#" class="my-auto">
                                <i class="fas fa-user fa-2x"></i> <!-- 返回我的個人頁面 -->
                            </a>
                        </div>
                    </div>
                </nav>
            </div>
        </div>
        <!-- Navbar End -->


        <!-- Modal Search Start -->
        <div class="modal fade" id="searchModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
                            <span id="search-icon-1" class="input-group-text p-3"><i class="fa fa-search"></i></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal Search End -->


        <!-- Single Page Header start -->
        <div class="container-fluid page-header py-5">
            <h1 class="text-center text-white display-6">新增商品</h1>
            <ol class="breadcrumb justify-content-center mb-0">
                <li class="breadcrumb-item"><a href="#">檢視我的商品</a></li>
                <li class="breadcrumb-item active text-white">新增商品</li>
                <!-- <li class="breadcrumb-item"><a href="#">修改商品</a></li> -->
            </ol>
        </div>
        <!-- Single Page Header End -->


        <!-- Checkout Page Start -->
        <div class="container-fluid py-5">
            <div class="container py-5">
                <h1 class="mb-4">Billing details</h1>
                <form id="GoodData" action="InsertPage.controller" method="post" enctype="multipart/form-data">
                    <div class="row g-5">
                        <!-- <div class="col-md-12 col-lg-6 col-xl-7"> -->
                        <div class="col-12">

                            <fieldset class="border p-2 mb-3">
                                <legend class="float-none w-auto">商品圖片</legend>
                                <div class="form-item w-100" id="GoodPhoto">
                                    <button type="button" class="btn btn-primary" id="insertPhoto">新增圖片</button>
                                    <div id="photoData">
                                    </div>
                                </div>
                            </fieldset>
                            <!--  -->
                            <!-- <div class="col-md-12 col-lg-6">
                                    <div class="form-item w-100">
                                        <label class="form-label my-3">First Name<sup>*</sup></label>
                                        <input type="text" class="form-control">
                                    </div>
                                </div>
                                <div class="col-md-12 col-lg-6">
                                    <div class="form-item w-100">
                                        <label class="form-label my-3">Last Name<sup>*</sup></label>
                                        <input type="text" class="form-control">
                                    </div>
                                </div> -->

                            <fieldset class="border p-2 mb-3">
                                <legend class="float-none w-auto">商品基本資訊</legend>
                                <div class="form-group" id="GoodBasic">
                                    <div class="form-floating mb-3">
                                        <input type="text" name="GoodsName" class="form-control" id="GoodsName">
                                        <label for="GoodsName">商品名稱</label>
                                    </div>
                                    <div class="form-floating mb-3">
                                        <input type="text" name="GoodsType" class="form-control" id="GoodsType">
                                        <label for="GoodsType">商品種類</label>
                                    </div>
                                    <div class="form-floating mb-3">
                                        <input type="date" name="LaunchDate" class="form-control" id="LaunchDate">
                                        <label for="LaunchDate">上架日期</label>
                                    </div>
                                    <div class="form-floating mb-3">
                                        <input type="text" name="Brand" class="form-control" id="Brand">
                                        <label for="Brand">品牌</label>
                                    </div>
                                    <div class="form-floating mb-3">
                                        <input type="text" name="ShipmentPlace" class="form-control" id="ShipmentPlace">
                                        <label for="ShipmentPlace">出貨地</label>
                                    </div>
                                    <div class="form-floating mb-3">
                                        <input type="file" name="TitleImage" class="form-control" id="TitleImage">
                                        <label for="TitleImage">商品封面</label>
                                    </div>
                                    <div id="container" class="form-floating mb-3">
                                        <div id="editor">
                                        </div>
                                    </div>
                                    <input type="text" name="GoodDirection" class="form-control" id="GoodDirection"
                                        value="" hidden>
                                </div>
                            </fieldset>
                            <fieldset class="border p-2">
                                <legend class="float-none w-auto">商品規格表</legend>
                                <div class="form-group" id="GoodFormat">
                                    <button type="button" class="btn btn-primary mb-3"
                                        id="insertFormatImage">新增規格圖片</button>
                                    <!-- <input type="file">放在這邊 -->
                                    <div class="row row-col-2" id="tranferToFormatTable">
                                        <!-- 裡面放圖片 -->
                                    </div>
                                </div>
                            </fieldset>
                            <button type="button" class="btn btn-primary" id="outputGoodData">Submit</button>
                        </div>

                    </div>
                </form>
            </div>
        </div>
        <!-- Checkout Page End -->


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
                            <a href="" class="btn border-secondary py-2 px-4 rounded-pill text-primary">Read More</a>
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
                        <span class="text-light"><a href="#"><i class="fas fa-copyright text-light me-2"></i>Your Site
                                Name</a>, All right reserved.</span>
                    </div>
                    <div class="col-md-6 my-auto text-center text-md-end text-white">
                        <!--/*** This template is free as long as you keep the below author’s credit link/attribution link/backlink. ***/-->
                        <!--/*** If you'd like to use the template without the below author’s credit link/attribution link/backlink, ***/-->
                        <!--/*** you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". ***/-->
                        Designed By <a class="border-bottom" href="https://htmlcodex.com">HTML Codex</a> Distributed By
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
        <script src="../../frontjs/main.js"></script>
        <script src="https://cdn.ckeditor.com/ckeditor5/41.3.1/super-build/ckeditor.js"></script>

        <script>
            // ckeditor
            let editor;
            CKEDITOR.ClassicEditor.create(document.getElementById("editor"), {
                // https://ckeditor.com/docs/ckeditor5/latest/features/toolbar/toolbar.html#extended-toolbar-configuration-format
                toolbar: {
                    items: [
                        'exportPDF', 'exportWord', '|',
                        'findAndReplace', 'selectAll', '|',
                        'heading', '|',
                        'bold', 'italic', 'strikethrough', 'underline', 'code', 'subscript', 'superscript', 'removeFormat', '|',
                        'bulletedList', 'numberedList', 'todoList', '|',
                        'outdent', 'indent', '|',
                        'undo', 'redo',
                        '-',
                        'fontSize', 'fontFamily', 'fontColor', 'fontBackgroundColor', 'highlight', '|',
                        'alignment', '|',
                        'link', 'uploadImage', 'blockQuote', 'insertTable', 'mediaEmbed', 'codeBlock', 'htmlEmbed', '|',
                        'specialCharacters', 'horizontalLine', 'pageBreak', '|',
                        'textPartLanguage', '|',
                        'sourceEditing'
                    ],
                    shouldNotGroupWhenFull: true
                },
                // Changing the language of the interface requires loading the language file using the <script> tag.
                // language: 'es',
                list: {
                    properties: {
                        styles: true,
                        startIndex: true,
                        reversed: true
                    }
                },
                // https://ckeditor.com/docs/ckeditor5/latest/features/headings.html#configuration
                heading: {
                    options: [
                        { model: 'paragraph', title: 'Paragraph', class: 'ck-heading_paragraph' },
                        { model: 'heading1', view: 'h1', title: 'Heading 1', class: 'ck-heading_heading1' },
                        { model: 'heading2', view: 'h2', title: 'Heading 2', class: 'ck-heading_heading2' },
                        { model: 'heading3', view: 'h3', title: 'Heading 3', class: 'ck-heading_heading3' },
                        { model: 'heading4', view: 'h4', title: 'Heading 4', class: 'ck-heading_heading4' },
                        { model: 'heading5', view: 'h5', title: 'Heading 5', class: 'ck-heading_heading5' },
                        { model: 'heading6', view: 'h6', title: 'Heading 6', class: 'ck-heading_heading6' }
                    ]
                },
                // https://ckeditor.com/docs/ckeditor5/latest/features/editor-placeholder.html#using-the-editor-configuration
                placeholder: '請輸入商品描述',
                // https://ckeditor.com/docs/ckeditor5/latest/features/font.html#configuring-the-font-family-feature
                fontFamily: {
                    options: [
                        'default',
                        'Arial, Helvetica, sans-serif',
                        'Courier New, Courier, monospace',
                        'Georgia, serif',
                        'Lucida Sans Unicode, Lucida Grande, sans-serif',
                        'Tahoma, Geneva, sans-serif',
                        'Times New Roman, Times, serif',
                        'Trebuchet MS, Helvetica, sans-serif',
                        'Verdana, Geneva, sans-serif'
                    ],
                    supportAllValues: true
                },
                // https://ckeditor.com/docs/ckeditor5/latest/features/font.html#configuring-the-font-size-feature
                fontSize: {
                    options: [10, 12, 14, 'default', 18, 20, 22],
                    supportAllValues: true
                },
                // Be careful with the setting below. It instructs CKEditor to accept ALL HTML markup.
                // https://ckeditor.com/docs/ckeditor5/latest/features/general-html-support.html#enabling-all-html-features
                htmlSupport: {
                    allow: [
                        {
                            name: /.*/,
                            attributes: true,
                            classes: true,
                            styles: true
                        }
                    ]
                },
                // Be careful with enabling previews
                // https://ckeditor.com/docs/ckeditor5/latest/features/html-embed.html#content-previews
                htmlEmbed: {
                    showPreviews: true
                },
                // https://ckeditor.com/docs/ckeditor5/latest/features/link.html#custom-link-attributes-decorators
                link: {
                    decorators: {
                        addTargetToExternalLinks: true,
                        defaultProtocol: 'https://',
                        toggleDownloadable: {
                            mode: 'manual',
                            label: 'Downloadable',
                            attributes: {
                                download: 'file'
                            }
                        }
                    }
                },
                // https://ckeditor.com/docs/ckeditor5/latest/features/mentions.html#configuration
                mention: {
                    feeds: [
                        {
                            marker: '@',
                            feed: [
                                '@apple', '@bears', '@brownie', '@cake', '@cake', '@candy', '@canes', '@chocolate', '@cookie', '@cotton', '@cream',
                                '@cupcake', '@danish', '@donut', '@dragée', '@fruitcake', '@gingerbread', '@gummi', '@ice', '@jelly-o',
                                '@liquorice', '@macaroon', '@marzipan', '@oat', '@pie', '@plum', '@pudding', '@sesame', '@snaps', '@soufflé',
                                '@sugar', '@sweet', '@topping', '@wafer'
                            ],
                            minimumCharacters: 1
                        }
                    ]
                },
                // The "superbuild" contains more premium features that require additional configuration, disable them below.
                // Do not turn them on unless you read the documentation and know how to configure them and setup the editor.
                removePlugins: [
                    // These two are commercial, but you can try them out without registering to a trial.
                    // 'ExportPdf',
                    // 'ExportWord',
                    'AIAssistant',
                    'CKBox',
                    'CKFinder',
                    'EasyImage',
                    // This sample uses the Base64UploadAdapter to handle image uploads as it requires no configuration.
                    // https://ckeditor.com/docs/ckeditor5/latest/features/images/image-upload/base64-upload-adapter.html
                    // Storing images as Base64 is usually a very bad idea.
                    // Replace it on production website with other solutions:
                    // https://ckeditor.com/docs/ckeditor5/latest/features/images/image-upload/image-upload.html
                    // 'Base64UploadAdapter',
                    'MultiLevelList',
                    'RealTimeCollaborativeComments',
                    'RealTimeCollaborativeTrackChanges',
                    'RealTimeCollaborativeRevisionHistory',
                    'PresenceList',
                    'Comments',
                    'TrackChanges',
                    'TrackChangesData',
                    'RevisionHistory',
                    'Pagination',
                    'WProofreader',
                    // Careful, with the Mathtype plugin CKEditor will not load when loading this sample
                    // from a local file system (file://) - load this site via HTTP server if you enable MathType.
                    'MathType',
                    // The following features are part of the Productivity Pack and require additional license.
                    'SlashCommand',
                    'Template',
                    'DocumentOutline',
                    'FormatPainter',
                    'TableOfContents',
                    'PasteFromOfficeEnhanced',
                    'CaseChange'
                ]

            }).then(newEditor => {
                editor = newEditor;
            }).catch(error => {
                console.error(error);
            });

            $('#insertPhoto').click(function () {//處理GoodImages資料表
                let nameField = "GoodImages";
                let input = document.createElement("input");
                input.setAttribute("type", "file");
                input.setAttribute("name", nameField);
                input.classList.add("form-control");
                $('#photoData').append(input);
            })

            $('#insertFormatImage').click(function () {
                console.log($('#FormatTable').length);
                if ($('#FormatTable').length == 0) {//一開始建立規格表時沒有table
                    //確認圖片數量
                    let photoNumber = $('#tranferToFormatTable').find("div").length;//代表圖片數量
                    //建立放入id="tranferToFormatTable" 的div標籤 和 input標籤
                    let div0 = document.createElement('div');
                    div0.classList.add("col-6");
                    let input0 = document.createElement('input');
                    let input0attrName = "GoodFormatImages";
                    input0.setAttribute("type", "file");
                    input0.setAttribute("required", true);
                    input0.setAttribute("name", input0attrName + "" + (photoNumber + 1));
                    input0.classList.add("form-control"); input0.classList.add("InsertPhotoData");
                    //建立table標籤 thead標籤 tbody標籤
                    let table = document.createElement('table');
                    table.setAttribute("id", "FormatTable");
                    table.classList.add("table");
                    table.classList.add("table-bordered");
                    table.classList.add("mt-3");
                    let thead = document.createElement('thead');
                    let tbody = document.createElement('tbody');
                    tbody.setAttribute("id", "formatdata");
                    //建立th標籤
                    let th1 = document.createElement('th'); th1.innerHTML = "規格圖片";
                    let th2 = document.createElement('th'); th2.innerHTML = "商品大小";
                    let th3 = document.createElement('th'); th3.innerHTML = "商品價格";
                    let th4 = document.createElement('th'); th4.innerHTML = "商品庫存數";
                    let th5 = document.createElement('th'); th5.innerHTML = "刪除規格";
                    let th6 = document.createElement('th'); th6.innerHTML = "新增規格";
                    let th7 = document.createElement('th'); th7.innerHTML = "隱藏資料"; //th7.setAttribute("hidden", true);
                    //建立tr 和 td標籤
                    let tr = document.createElement('tr');
                    let td1 = document.createElement('td'); let td2 = document.createElement('td'); let td3 = document.createElement('td');
                    let td4 = document.createElement('td'); let td5 = document.createElement('td'); let td6 = document.createElement('td');
                    let td7 = document.createElement('td');
                    // input0插入在<div class="row row-col-2">
                    div0.append(input0);
                    $('#tranferToFormatTable').append(div0);
                    //建立input標籤和button標籤
                    let input2 = document.createElement('input'); input2.setAttribute("type", "text"); input2.setAttribute("required", true); input2.setAttribute("name", "GoodSize"); input2.setAttribute("value", "");
                    input2.classList.add("form-control");
                    let input3 = document.createElement('input'); input3.setAttribute("type", "text"); input3.setAttribute("required", true); input3.setAttribute("name", "GoodPrice"); input3.setAttribute("value", "");
                    input3.classList.add("form-control");
                    let input4 = document.createElement('input'); input4.setAttribute("type", "text"); input4.setAttribute("required", true); input4.setAttribute("name", "GoodsStock"); input4.setAttribute("value", "");
                    input4.classList.add("form-control");
                    let btnDelete = document.createElement('button'); btnDelete.setAttribute("type", "button"); btnDelete.innerHTML = "刪除"; btnDelete.classList.add("btn"); btnDelete.classList.add("btn-primary"); btnDelete.classList.add("deleteformatbtn");
                    let btnInsert = document.createElement('button'); btnInsert.setAttribute("type", "button"); btnInsert.innerHTML = "新增"; btnInsert.classList.add("btn"); btnInsert.classList.add("btn-primary"); btnInsert.classList.add("insertformatbtn");
                    //隱藏欄位
                    let input7 = document.createElement('input'); input7.setAttribute("type", "text"); input7.setAttribute("required", true); input7.setAttribute("name", "hiddenValue"); input7.classList.add("form-control"); input7.classList.add("hiddenData");
                    //剩下的插入在table標籤內
                    table.append(thead);
                    thead.append(th1); thead.append(th2); thead.append(th3); thead.append(th4); thead.append(th5); thead.append(th6); thead.append(th7);
                    table.append(tbody);
                    tbody.append(tr);
                    tr.append(td1); tr.append(td2); tr.append(td3); tr.append(td4); tr.append(td5); tr.append(td6); tr.append(td7);
                    // 需要加入img標籤(預覽圖片用的) 
                    td2.append(input2); td3.append(input3); td4.append(input4); td5.append(btnDelete); td6.append(btnInsert); td7.append(input7);
                    $('#GoodFormat').append(table);
                    //建立img標籤並且自訂義屬性(data-index) 目標是對應放入id="tranferToFormatTable" 的div標籤
                    // td1插入圖片
                    let pattern = document.createElement("img");
                    pattern.setAttribute("style", "height: 100px;width: 100px;");
                    pattern.setAttribute("src", "");
                    pattern.setAttribute("alt", "");
                    pattern.setAttribute("data-index", (photoNumber + 1) + "");
                    //<img src="../../goodImages/20240428232110542.jpg" alt="">
                    td1.append(pattern);
                    //處理圖片預覽
                }
                else {
                    let tbody = $('#formatdata');
                    //查詢該表的編號屬性最大值是多少
                    let photoNumber = $('#tranferToFormatTable').find("div").length;//代表圖片數量
                    //
                    let div0 = document.createElement('div');
                    div0.classList.add("col-6");
                    let input0 = document.createElement('input');
                    let input0attrName = "GoodFormatImages";//
                    input0.setAttribute("type", "file");
                    input0.setAttribute("required", true);
                    input0.setAttribute("name", input0attrName + "" + (photoNumber + 1));
                    input0.classList.add("form-control"); input0.classList.add("InsertPhotoData");
                    //建立tr 和 td標籤
                    let tr = document.createElement('tr');
                    let td1 = document.createElement('td'); let td2 = document.createElement('td'); let td3 = document.createElement('td');
                    let td4 = document.createElement('td'); let td5 = document.createElement('td'); let td6 = document.createElement('td');
                    let td7 = document.createElement('td');
                    // input0插入在<div class="row row-col-2">
                    div0.append(input0);
                    $('#tranferToFormatTable').append(div0);
                    //建立input標籤和button標籤
                    let input2 = document.createElement('input'); input2.setAttribute("type", "text"); input2.setAttribute("required", true); input2.setAttribute("name", "GoodSize"); input2.setAttribute("value", "");
                    input2.classList.add("form-control");
                    let input3 = document.createElement('input'); input3.setAttribute("type", "text"); input3.setAttribute("required", true); input3.setAttribute("name", "GoodPrice"); input3.setAttribute("value", "");
                    input3.classList.add("form-control");
                    let input4 = document.createElement('input'); input4.setAttribute("type", "text"); input4.setAttribute("required", true); input4.setAttribute("name", "GoodsStock"); input4.setAttribute("value", "");
                    input4.classList.add("form-control");
                    let btnDelete = document.createElement('button'); btnDelete.setAttribute("type", "button"); btnDelete.innerHTML = "刪除"; btnDelete.classList.add("btn"); btnDelete.classList.add("btn-primary"); btnDelete.classList.add("deleteformatbtn");
                    let btnInsert = document.createElement('button'); btnInsert.setAttribute("type", "button"); btnInsert.innerHTML = "新增"; btnInsert.classList.add("btn"); btnInsert.classList.add("btn-primary"); btnInsert.classList.add("insertformatbtn");
                    //隱藏欄位
                    let input7 = document.createElement('input'); input7.setAttribute("type", "text"); input7.setAttribute("required", true); input7.setAttribute("name", "hiddenValue"); input7.classList.add("form-control"); input7.classList.add("hiddenData");
                    //
                    tbody.append(tr);
                    tr.append(td1); tr.append(td2); tr.append(td3); tr.append(td4); tr.append(td5); tr.append(td6); tr.append(td7);
                    td2.append(input2); td3.append(input3); td4.append(input4); td5.append(btnDelete); td6.append(btnInsert); td7.append(input7);
                    //建立img標籤並且自訂義屬性(data-index) 目標是對應放入id="tranferToFormatTable" 的div標籤
                    // td1 插入圖片
                    let pattern = document.createElement("img");
                    pattern.setAttribute("style", "height: 100px;width: 100px;");
                    pattern.setAttribute("src", "");
                    pattern.setAttribute("alt", "");
                    pattern.setAttribute("data-index", (photoNumber + 1) + "");
                    //<img src="../../goodImages/20240428232110542.jpg" alt="">
                    td1.append(pattern);
                }
            })

            $(document).on('click', '.deleteformatbtn', function () {
                let formatdata = $(this).closest('tr');//該列的資料
                // console.log([...formatdata.children()][0]);
                // console.log([...formatdata.children()][0].getAttribute("rowspan"));
                [...formatdata.children()][0].getAttribute("rowspan");
                //處理該規格只有一項的案例 在點擊一次直接刪除(並且存放在id = "tranferToFormatTable" 的對應input標籤要刪除)
                if (formatdata.children().length == 7) {
                    if ([...formatdata.children()][0].getAttribute("rowspan") == 1 || [...formatdata.children()][0].getAttribute("rowspan") == null) {//點擊有7個td的資料列 並且 該圖片只有一筆資料
                        let previewformdata = formatdata;
                        let arrFormTd = [...previewformdata.children()];//得到td
                        console.log([...arrFormTd[0].children][0]);
                        //讀取img標籤中的自訂義index屬性後 將該筆資料刪除
                        let index = [...arrFormTd[0].children][0].getAttribute("data-index");
                        let idenifier = "GoodFormatImages" + index;
                        formatdata.prop("outerHTML", "");
                        //假若table裡面沒有任何資料 將table全部刪掉
                        console.log($('#formatdata').find('tr').length);
                        if ($('#formatdata').find('tr').length == 0) {
                            $('#FormatTable').prop("outerHTML", "");
                            let target = $('#tranferToFormatTable').find('input[name="' + idenifier + '"]');
                            let div0 = target.closest('div');
                            console.log(div0);
                            div0.prop("outerHTML", "");
                        }
                        else {
                            //找出存放在id = "tranferToFormatTable"(div標籤)中所對應的input標籤
                            console.log('input[name="' + idenifier + '"]');
                            let target = $('#tranferToFormatTable').find('input[name="' + idenifier + '"]');
                            let div0 = target.closest('div');
                            console.log(div0);
                            div0.prop("outerHTML", "");
                            console.log(target);
                        }
                    }
                    else {//假若仍有超過一筆資料
                        let nextdata = $(this).closest('tr').next();
                        let arrnextdata = [...nextdata.children()];
                        console.log(arrnextdata);
                        //取得下一個tr標籤的屬性
                        let size = arrnextdata[0].getAttribute("value"); console.log(size);
                        let price = arrnextdata[1].getAttribute("value"); console.log(price);
                        let stock = arrnextdata[2].getAttribute("value"); console.log(stock);
                        let hiddenValue = arrnextdata[4].getAttribute("value"); console.log(hiddenValue);
                        //將取得的屬性值填入第一列
                        let arrtargettd = [...formatdata.children()];//裡面是td標籤
                        let input1 = arrtargettd[1].children[0];
                        console.log(input1);
                        arrtargettd[1].children[0].setAttribute("value", size);
                        arrtargettd[2].children[0].setAttribute("value", price);
                        arrtargettd[3].children[0].setAttribute("value", stock);
                        arrtargettd[6].children[0].setAttribute("value", hiddenValue);
                        let rowspanNum = arrtargettd[0].getAttribute("rowspan");
                        console.log(rowspanNum);
                        //將
                        nextdata.prop("outerHTML", "");//將第二列的資料刪除
                        arrtargettd[0].setAttribute("rowspan", rowspanNum - 1);
                        arrtargettd[5].setAttribute("rowspan", rowspanNum - 1);
                    }
                }
                else {
                    let previewformdata = formatdata.prev();
                    while (previewformdata.children().length == 5) {//
                        previewformdata = previewformdata.prev();
                    }
                    formatdata.prop("outerHTML", "");
                    let arrFormTd = [...previewformdata.children()];//得到td
                    let rowspanNum = arrFormTd[0].getAttribute("rowspan");
                    arrFormTd[0].setAttribute("rowspan", rowspanNum - 1);
                    arrFormTd[5].setAttribute("rowspan", rowspanNum - 1);
                }
            })

            $(document).on('click', '.insertformatbtn', function () {
                let tr = document.createElement('tr');
                let td1 = document.createElement('td');
                let td2 = document.createElement('td');
                let td3 = document.createElement('td');
                let td4 = document.createElement('td');
                let td5 = document.createElement('td');//隱藏標籤
                //
                let previewformdata;
                let formatdata = $(this).closest('tr');//該列的資料
                if (formatdata.children().length == 7) {
                    previewformdata = formatdata;
                } else {
                    previewformdata = formatdata.prev();
                    while (previewformdata.children().length == 5) {//
                        previewformdata = previewformdata.prev();
                    }
                }
                //

                let arrFormTd = [...previewformdata.children()];//得到td
                let rowspanNum = arrFormTd[0].getAttribute("rowspan");
                if (rowspanNum == null) {
                    rowspanNum++;
                }
                else {//將字串轉數字
                    rowspanNum = Number.parseInt(rowspanNum);
                }
                arrFormTd[0].setAttribute("rowspan", rowspanNum + 1);
                arrFormTd[5].setAttribute("rowspan", rowspanNum + 1);
                //建立input標籤 和 button標籤
                let input1 = document.createElement('input'); input1.setAttribute("type", "text"); input1.setAttribute("required", true); input1.setAttribute("name", "GoodSize"); input1.setAttribute("value", ""); input1.classList.add("form-control");
                let input2 = document.createElement('input'); input2.setAttribute("type", "text"); input2.setAttribute("required", true); input2.setAttribute("name", "GoodPrice"); input2.setAttribute("value", ""); input2.classList.add("form-control");
                let input3 = document.createElement('input'); input3.setAttribute("type", "text"); input3.setAttribute("required", true); input3.setAttribute("name", "GoodsStock"); input3.setAttribute("value", ""); input3.classList.add("form-control");
                let btnDelete = document.createElement('button'); btnDelete.setAttribute("type", "button"); btnDelete.innerHTML = "刪除"; btnDelete.classList.add("btn"); btnDelete.classList.add("btn-primary"); btnDelete.classList.add("deleteformatbtn");
                //隱藏標籤
                let input4 = document.createElement('input'); input4.setAttribute("type", "text"); input4.setAttribute("required", true); input4.setAttribute("name", "hiddenValue"); input4.classList.add("form-control"); input4.classList.add("hiddenData");
                console.log();
                let check = [...arrFormTd[0].children][0].getAttribute("src")
                if (check == null) {//假若圖片不存在 value給定為0
                    input4.setAttribute("value", "");
                } else {

                }

                //將input標籤和button標籤插入td標籤 將td標籤插入tr標籤
                td1.append(input1); td2.append(input2); td3.append(input3); td4.append(btnDelete); td5.append(input4);
                tr.append(td1); tr.append(td2); tr.append(td3); tr.append(td4); tr.append(td5);
                formatdata.after(tr);
                // $('#formatdata').append(tr);
            })

            $(document).on('change', '.InsertPhotoData', function () {
                //取得上傳檔案的檔案名稱
                //將檔案名稱移入隱藏input標籤中
                let UploadRootFileName = $(this).prop("value");//取得絕對路徑
                let ps = UploadRootFileName.lastIndexOf('\\');
                let filename = UploadRootFileName.substring(ps + 1, UploadRootFileName.length);
                console.log(filename);
                //
                let fieldName = $(this).prop("name");//取得input標籤的name屬性
                let index = $(this).prop("name").substring(16);//ex:GoodFormatImages1 取得 1
                let formattr = $('#formatdata').children();//$('#formatdata')指的是tbody標籤 formattr裡面都是tr標籤
                let count = 0;
                let arrformattr = [...formattr];
                var i = 0;
                //
                let check = -1;
                console.log(index);
                console.log(arrformattr);
                while (check != index) {//去尋找img標籤的自訂義index屬性 找到與index變數相同的img標籤
                    // console.log(arrformattr[i].children[0].children[0]);
                    check = arrformattr[i].children[0].children[0].getAttribute("data-index");
                    // console.log(arrformattr[i].children[0].children[0].getAttribute("data-index"));
                    i++;
                }
                i--;
                console.log(i);
                //取得對應的資料列
                let connectdata = arrformattr[i];
                console.log(connectdata);
                let preview = connectdata.children[0].children[0]//取得img標籤
                //取得隱藏的input標籤 並且將檔案名稱丟入input標籤中(假若隱藏欄的數量在2以上)
                i++; let boundLength = arrformattr.length;
                console.log(boundLength);
                connectdata.children[6].children[0].setAttribute("value", filename);
                if (boundLength == i) {//上船圖片的欄位只有一個
                }
                else {//如果上傳圖片時隱藏欄位不只一個
                    while (arrformattr[i].children.length != 7 && (i <= boundLength)) {
                        console.log(arrformattr[i].children[4].children[0]);
                        arrformattr[i].children[4].children[0].setAttribute("value", filename);
                        // arrformattr[i].children[4].children[0].setAttribute("value", filename);
                        i++;
                        if (i == boundLength) {
                            break;
                        }
                    }
                }
                // let preview = $(this).closest('td').prev().children(0);//預覽圖片欄位
                console.log(preview);
                const reader = new FileReader();
                let file = $(this).prop("files");//取得input[type="file"]的files屬性
                console.log(file);
                if (file) {
                    reader.readAsDataURL(file[0]);
                }
                reader.addEventListener('load', function () {
                    preview.setAttribute('src', reader.result);
                })
            })
            //input標籤抓不到資料
            $(document).on('change', 'input[type="text"]', function () {
                // console.log();
                $(this).attr("value", $(this).prop("value"))
            })
            // 處理資料提交後的問題
            $(document).on('click', '#outputGoodData', function () {
                //將input標籤中的name屬性統一
                let target = $('#tranferToFormatTable').find('input');
                let arrtarget = [...target];
                arrtarget.forEach(function (elem, index) {
                    elem.setAttribute("name", "GoodFormatImages");
                })
                //將CKeditor的內容填入 input標籤
                let editorData = editor.getData();
                $('#GoodDirection').attr("value", editorData);
                // 將隱藏欄位填入單一規格資料的(商品大小、商品價格、商品庫存、上傳圖片名稱)
                let hiddentarget = $('.hiddenData');

                [...hiddentarget].forEach(function (elem, index) {
                    let tr = elem.closest('tr');
                    if (tr.children.length == 7) {
                        let size = tr.children[1].children; let sizedata = [...size][0].getAttribute("value"); console.log(sizedata);
                        let price = tr.children[2].children; let pricedata = [...price][0].getAttribute("value"); console.log(pricedata);
                        let stock = tr.children[3].children; let stockdata = [...stock][0].getAttribute("value"); console.log(stockdata);
                        let hiddenVal = tr.children[6].children; let hiddenValdata = [...hiddenVal][0].getAttribute("value"); console.log(hiddenValdata);
                        let keydata = sizedata + "/" + pricedata + "/" + stockdata + "/" + hiddenValdata; console.log(keydata);
                        [...hiddenVal][0].setAttribute("value", keydata);
                    }
                    else {
                        if (tr.children.length == 5) {
                            let size = tr.children[0].children; let sizedata = [...size][0].getAttribute("value"); console.log(sizedata);
                            let price = tr.children[1].children; let pricedata = [...price][0].getAttribute("value"); console.log(pricedata);
                            let stock = tr.children[2].children; let stockdata = [...stock][0].getAttribute("value"); console.log(stockdata);
                            let hiddenVal = tr.children[4].children; let hiddenValdata = [...hiddenVal][0].getAttribute("value"); console.log(hiddenValdata);
                            let keydata = sizedata + "/" + pricedata + "/" + stockdata + "/" + hiddenValdata; console.log(keydata);
                            [...hiddenVal][0].setAttribute("value", keydata);
                        }
                    }
                })
                // console.log(form);
                //用form傳即可
                let form = document.getElementById("GoodData");
                form.submit();
                // let formData = new FormData(form);
            })


        </script>
    </body>

    </html>