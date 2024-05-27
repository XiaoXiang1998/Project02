<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>申訴資料</title>
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
    
    
    <div class="container-fluid py-5">
        <div class="container py-5">
            <div class="row justify-content-center">
                <div class="col-lg-6">
                    <div class="text-center mb-4">
                        <h1>輸入申訴編號</h1>
                    </div>
                    <form action="/searchById?id=${id}" method="get" class="bg-light p-4 rounded">
                        <div class="mb-3">
                            <label for="id" class="form-label"></label>
                            <input type="text" id="id" name="id" class="form-control" required>
                        </div>
                        <div class="text-center">
                            <button type="submit" class="btn btn-primary">刪除</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    
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
	

</body>
</html>
