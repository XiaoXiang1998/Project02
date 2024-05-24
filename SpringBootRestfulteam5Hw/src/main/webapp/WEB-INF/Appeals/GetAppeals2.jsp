
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
            <h1 class="mb-4">申訴資料</h1>
                                        <form>
                                        
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="inputEmail" type="text" readonly  value="${appeal.appeals_id}" />
                                                <label for="inputEmail">申訴編號</label>
                                            </div>
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="inputPassword" type="text" readonly  value="${appeal.appeals_name}" />
                                                <label for="inputPassword">申訴人</label>
                                            </div>
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="inputPassword" type="text" readonly  value="${appeal.appeals_content}" />
                                                <label for="inputPassword">申訴對象</label>
                                            </div>
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="inputPassword" type="text" readonly  value="${appeal.appeals_reason}" />
                                                <label for="inputPassword">申訴原因</label>
                                            </div>
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="inputPassword" type="text" readonly  value="${appeal.appeals_order}" />
                                                <label for="inputPassword">訂單編號</label>
                                            </div>
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="inputPassword" type="text" readonly  value="${appeal.appeals_date}" />
                                                <label for="inputPassword">申訴日期</label>
                                            </div>
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="inputPassword" type="text" readonly  value="${appeal.appeals_other}" />
                                                <label for="inputPassword">相關證據</label>
                                            </div>
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="inputPassword" type="text" readonly  value="${appeal.appeals_state}" />
                                                <label for="inputPassword">處理狀態</label>
                                            </div>
<!--                                             <div class="form-check mb-3"> -->
<!--                                                 <input class="form-check-input" id="inputRememberPassword" type="checkbox" value="" /> -->
<!--                                                 <label class="form-check-label" for="inputRememberPassword">Remember Password</label> -->
<!--                                             </div> -->
<!--                                             <div class="d-flex align-items-center justify-content-between mt-4 mb-0"> -->
<!--                                                 <a class="small" href="password.html">Forgot Password?</a> -->
<!--                                                 <a class="btn btn-primary" href="index.html">Login</a> -->
<!--                                             </div> -->
                                        </form>
                                        
              
                                   <div class="row g-4 text-center align-items-center justify-content-center pt-4">
                            <button id="queryButton" type="submit"
                                class="btn border-secondary py-3 px-4 text-uppercase w-100 text-primary"  value="send">返回首頁</button>
                                

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
	document.getElementById("queryButton").onclick = function() {
        window.location.href = "/Crudindex";
    }; 
	</script>

</body>
</html>
