<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>申訴成功</title>
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

    <!-- Customized Bootstrap Stylesheet -->
    <link href="/frontcss/bootstrap.min.css" rel="stylesheet">

    <!-- Custom Stylesheet -->
    <link href="/frontcss/style1.css" rel="stylesheet">
</head>
<body>
<%@ include file="../FrontDeskNav.jsp" %>
<form>
    <div class="container-fluid py-5">
        <div class="container py-5">
            <div class="row justify-content-center">
                <div class="col-lg-6">
                    <div class="bg-white p-5 rounded shadow text-center">
                        <h2 class="mb-4 text-success">提交成功</h2>
                        <p class="mb-4">您的申訴已成功提交，申訴編號為: <strong>${appealsId}</strong></p>
                        <a href="/Crudindex" class="btn btn-primary">返回首頁</a>
                    
                    </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
<%@ include file="../FrontDeskFooter.jsp" %>
    <!-- JavaScript Libraries -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/frontlib/easing/easing.min.js"></script>
    <script src="/frontlib/waypoints/waypoints.min.js"></script>
    <script src="/frontlib/lightbox/js/lightbox.min.js"></script>
    <script src="/frontlib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Template Javascript -->
    <script src="/frontjs/main.js"></script>
</body>
</html>
