<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="utf-8">
        <title>聯絡我們</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">

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
        <link href="/frontlib/lightbox/css/lightbox.min.css" rel="stylesheet">
        <link href="/frontlib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


        <!-- Customized Bootstrap Stylesheet -->
        <link href="/frontcss/bootstrap.min.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="/frontcss/style1.css" rel="stylesheet">
    </head>

    <body>


        <%@ include file="../FrontDeskNav.jsp" %>

            <!-- Single Page Header End -->


            <!-- Checkout Page Start -->

            <div class="container-fluid py-5">
                <div class="container py-5">
                    <h1 class="mb-4">聯絡我們</h1>
                    <form method="GET" action="/sendEmailTest">


                        <div class="row g-5">
                            <div class="col-md-12 col-lg-6 col-xl-7">
                                <div class="row">
                                    <div class="form-item">
                                        <label class="form-label my-3"> 標題:</label>
                                        <input type="text" class="form-control" id="subject" name="subject" required>
                                    </div>
                                </div>

                                <div class="form-item">
                                    <label class="form-label my-3">描述:</label>
                                    <input type="text" class="form-control" id="body" name="body" required></textarea>
                                </div>
                                <div class="form-item">
                                    <label class="form-label my-3">訂單編號:</label>
                                    <input type="text" class="form-control" id="order" name="order">
                                </div>
                                <div class="form-item">
                                    <label class="form-label my-3">電話號碼:</label>
                                    <input type="text" class="form-control" id="phone" name="phone">
                                </div>
                                <div class="form-item">
                                    <label class="form-label my-3">附件 (選填):</label>
                                    <input type="text" class="form-control" id="other" name="other">
                                </div>


                                <hr>

                                <div class="row g-4 text-center align-items-center justify-content-center pt-4">
                                    <button type="submit"
                                        class="btn border-secondary py-3 px-4 text-uppercase w-100 text-primary"
                                        value="send">提交</button>
                                    <button type="button" onclick="fillFormWithDummyData()"
                                        class="btn border-secondary py-3 px-4 text-uppercase w-100 text-primary">產生</button>

                                </div>
                            </div>

                            <div class="col-md-12 col-lg-6 col-xl-5">
                                <div class="table-responsive">

                                    <table class="table">
                                        <div class="col-lg-5">


                                        </div>

                                        <tbody>

                                        </tbody>
                                    </table>
                                </div>



                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <!-- Checkout Page End -->


            <%@ include file="../FrontDeskFooter.jsp" %>



                <!-- Back to Top -->
                <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i
                        class="fa fa-arrow-up"></i></a>


                <!-- JavaScript Libraries -->
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                <script src="/frontlib/easing/easing.min.js"></script>
                <script src="/frontlib/waypoints/waypoints.min.js"></script>
                <script src="/frontlib/lightbox/js/lightbox.min.js"></script>
                <script src="/frontlib/owlcarousel/owl.carousel.min.js"></script>

                <!-- Template Javascript -->
                <script src="/frontjs/main.js"></script>

                <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
                <script>
                    function fillFormWithDummyData() {
                        // 填充固定描述
                        subject
                        document.getElementById('subject').value = "商品收到損壞，請求退款";
                        document.getElementById('body').value = "收到的包裝已被打開，耳機外殼有明顯的刮痕，且無法正常工作。我希望您能夠協助我處理這個問題，期待您的回覆。";

                        // 填充固定訂單編號和電話號碼
                        document.getElementById('order').value = "20240524001";
                        document.getElementById('phone').value = "0923-456-7890";

                        // 填充固定附件
                        document.getElementById('other').value = "照片1.jpg";
                    }
                </script>

    </body>

    </html>