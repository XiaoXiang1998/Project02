<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
        <meta charset="utf-8">
        <title>EZ Buy</title>
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
    <link href="/css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="/frontcss/style1.css" rel="stylesheet">
    </head>
<body>
<%@ include file="../FrontDeskNav.jsp" %>
<div class="container-fluid py-5">
    <div class="container py-5">
        <h1 class="mb-4">申訴資料</h1>

       <form action="updateAppeal" method="post">
              <div class="row g-5">
                    <div class="col-md-12 col-lg-6 col-xl-7">
                        <div class="row">
                         <div class="form-item">
                                    <label for="name" class="form-label my-3">申訴編號</label>
                                    <input type="text" id="id" name="id" class="form-control" value="${appeal.appeals_id}" readonly>
                                </div>
                            <div class="form-item">
                                    <label for="name" class="form-label my-3">申訴人</label>
                                    <input type="text" id="name" name="name" class="form-control" value="${appeal.appeals_name}" required>
                                </div>
                                <div class="form-item">
                                    <label for="content" class="form-label my-3">申訴對象</label>
                                    <input type="text"  class="form-control id="content" name="content" value="${appeal.appeals_content}" required>
                                </div>
                                <div class="form-item">
                                    <label for="reason" class="form-label my-3">申訴原因</label>
                                    <input type="text"  class="form-control id="reason" name="reason" value="${appeal.appeals_reason}" required>
                                </div>
                                <div class="form-item">
                                    <label for="order" class="form-label my-3">訂單編號</label>
                                    <input type="text"  class="form-control id="order" name="order" value="${appeal.appeals_order}" required>
                                </div>
                                <div class="form-item">
                                    <label for="date" class="form-label my-3">申訴日期</label>
                                    <input type="text" class="form-control id="date" name="date" value="${appeal.appeals_date}" required>
                                </div>
                                <div class="form-item">
                                    <label for="other" class="form-label my-3">其他資訊</label>
                                    <input type="text" class="form-control id="other" name="other" value="${appeal.appeals_other}" required>
                                </div>
                                <div class="form-item">
                                    <label for="state" class="form-label my-3">申訴狀態</label>
                                    <input type="text" class="form-control id="state" name="state" value="${appeal.appeals_state}" readonly>
                                </div>
                                <div class="row g-4 text-center align-items-center justify-content-center pt-4">
                                <!-- 更新按钮 -->
                                <button type="submit" class="btn border-secondary py-3 px-4 text-uppercase w-100 text-primary">更新</button>
                                <a class="btn border-secondary py-3 px-4 text-uppercase w-100 text-primary" href="/Crudindex">返回申訴首頁</a>
                            </div>
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
<%@ include file="../FrontDeskFooter.jsp" %>
<!-- Back to Top -->
<a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i class="fa fa-arrow-up"></i></a>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/frontlib/easing/easing.min.js"></script>
    <script src="/frontlib/waypoints/waypoints.min.js"></script>
    <script src="/frontlib/lightbox/js/lightbox.min.js"></script>
    <script src="/frontlib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Template Javascript -->
    <script src="/frontjs/main.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
</body>
</html>
