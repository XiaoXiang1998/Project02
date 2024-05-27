<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>新增申訴資料</title>
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
    

    <!-- Checkout Page Start -->
    
    <div class="container-fluid py-5">
        <div class="container py-5">
            <h1 class="mb-4">新增申訴</h1>
            <form action="insertcontroller" method="post">
            

                <div class="row g-5">
                    <div class="col-md-12 col-lg-6 col-xl-7">
                        <div class="row">
                            <div class="form-item">
                                <label class="form-label my-3">申訴人<sup>*</sup></label>
                                <input type="text" class="form-control" id="Appeals_name" name="Appeals_name" required>
                            </div>
                        </div>
                        
                        <div class="form-item">
                            <label class="form-label my-3">申訴對象<sup>*</sup></label>
                            <input type="text" class="form-control" id="Appeals_content" name="Appeals_content" required>
                        </div>
                        <div class="form-item">
                            <label class="form-label my-3">申訴原因<sup>*</sup></label>
                            <input type="text" class="form-control" id="Appeals_reason" name="Appeals_reason" required>
                        </div>
                        <div class="form-item">
                            <label class="form-label my-3">訂單編號<sup>*</sup></label>
                            <input type="text" class="form-control" id="Appeals_order" name="Appeals_order" required>
                        </div>
                        <div class="form-item">
                            <label class="form-label my-3">申訴日期<sup>*</sup></label>
                            <input type="date" class="form-control"  id="Appeals_date" name="Appeals_date"  required>
                        </div>
                        <div class="form-item">
                            <label class="form-label my-3">其他資訊<sup>*</sup></label>
                            <input type="text" class="form-control"  id="Appeals_other" name="Appeals_other" require>
                        </div>
                        
                        
                        <div class="row g-4 text-center align-items-center justify-content-center pt-4">
                            <button type="submit"
                                class="btn border-secondary py-3 px-4 text-uppercase w-100 text-primary"  value="send">提交申請</button>
                                <button type="button" class="btn border-secondary py-3 px-4 text-uppercase w-100 text-primary" onclick="fillFormWithDummyData()">輸入</button>
                               
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
        	document.getElementById("Appeals_name").value = "劉大錘";
            document.getElementById("Appeals_content").value = "王二狗";
            document.getElementById("Appeals_reason").value = "商品有瑕疵";
            document.getElementById("Appeals_order").value = "10";
            document.getElementById("Appeals_date").value = "2024-05-24";
            document.getElementById("Appeals_other").value = "商品品質差";
        }
    </script>

</body>
</html>
