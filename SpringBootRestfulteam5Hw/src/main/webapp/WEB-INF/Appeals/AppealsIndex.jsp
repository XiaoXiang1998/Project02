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
    <link href="lib/lightbox/css/lightbox.min.css" rel="stylesheet">
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


    <!-- Customized Bootstrap Stylesheet -->
    <link href="/css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="/css/style1.css" rel="stylesheet">
     <style>
        .no-border-button {
            border: none;
            background-color: transparent; /* 可根據需要更改背景顏色 */
            cursor: pointer;
        }

        .no-border-button h5 {
            margin: 0;
        }
    </style>
</head>

    <body>
				<%@ include file="../FrontDeskNav.jsp" %>

        <!-- Featurs Section Start -->
        <div class="container-fluid featurs py-5" align="center" action="/appeals">
            <div class="container py-5">
                <div class="row g-4">
                
                
                
               
                    <div class="col-md-6 col-lg-3" >
                       <div class="featurs-item text-center rounded bg-light p-4">
                            <div class="featurs-icon btn-square rounded-circle bg-secondary mb-5 mx-auto">
                                <i class="fa-solid fa-pen  fa-3x text-white"></i>
                            </div>
                            <form method="get" action="insert">
                            <div class="featurs-content text-center">
                               <button class="no-border-button"><h5>新增申訴</h5></button>
                                </form>
                                
                            </div>
                        </div>
                    </div>
                   
                    
                    <br>
                    
<!--                     <form method="Get" action="update2"> -->
                    <div class="col-md-6 col-lg-3">
                        <div class="featurs-item text-center rounded bg-light p-4">
                            <div class="featurs-icon btn-square rounded-circle bg-secondary mb-5 mx-auto">
<!--                                 <i class="fas fa-car-side fa-3x text-white"></i> -->
                                   <i class="fa-regular fa-keyboard  fa-3x text-white"></i>
                            </div>
                            <form method="Get" action="update2">
                            <div class="featurs-content text-center">
                                <button class="no-border-button"><h5>查詢及修改</h5></button>
                                 </form>
                            </div>
                        </div>
                    </div>
<!--                     </form> -->
                    
                    <br>
<!--                     <form method="get" action="selectOne2"> -->
<!--                     <div class="col-md-6 col-lg-3"> -->
<!--                         <div class="featurs-item text-center rounded bg-light p-4"> -->
<!--                             <div class="featurs-icon btn-square rounded-circle bg-secondary mb-5 mx-auto"> -->
<!--                                 <i class="fa-regular fa-folder fa-3x text-white"></i> -->
<!--                             </div> -->
<!--                             <form method="get" action="selectOne2"> -->
<!--                             <div class="featurs-content text-center"> -->
<!--                                <button class="no-border-button"> <h5>查詢申訴</h5></button> -->
<!--                                 </form> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                     </div> -->
                    <div class="col-md-6 col-lg-3">
                        <div class="featurs-item text-center rounded bg-light p-4">
                            <div class="featurs-icon btn-square rounded-circle bg-secondary mb-5 mx-auto">
                               <i class="fa-solid fa-box-archive fa-3x text-white"></i>

                            </div>
                            <form method="get" action="delete">
                            <div class="featurs-content text-center">
                               <button class="no-border-button"> <h5>刪除申訴</h5></button>
                                </form>
                            </div>
                        </div>
                    </div>
                    
                    
                    
                    
                    
                    <div class="col-md-6 col-lg-3">
    <div class="featurs-item text-center rounded bg-light p-4">
        <div class="featurs-icon btn-square rounded-circle bg-secondary mb-5 mx-auto">
            <i class="fa-regular fa-folder fa-3x text-white"></i>
        </div>
        <div class="featurs-content text-center">
            <button class="no-border-button" onclick="navigateToContactUs()"><h5>聯絡我們</h5></button>
        </div>
    </div>
</div>
<!--                     </form> -->
                    
                    
                    
<!--                     <div class="col-md-6 col-lg-3"> -->
<!--                         <div class="featurs-item text-center rounded bg-light p-4"> -->
<!--                             <div class="featurs-icon btn-square rounded-circle bg-secondary mb-5 mx-auto"> -->
<!--                                 <i class="fas fa-exchange-alt fa-3x text-white"></i> -->
<!--                             </div> -->
<!--                             <div class="featurs-content text-center"> -->
<!--                                 <h5>刪除申訴</h5> -->
                                
<!--                             </div> -->
<!--                         </div> -->
<!--                     </div> -->
                    
                </div>
            </div>
        </div>
       				<%@ include file="../FrontDeskFooter.jsp" %>
       





        <!-- Back to Top -->
        <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i class="fa fa-arrow-up"></i></a>   

        
    <!-- JavaScript Libraries -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/lib/easing/easing.min.js"></script>
    <script src="/lib/waypoints/waypoints.min.js"></script>
    <script src="/lib/lightbox/js/lightbox.min.js"></script>
    <script src="/lib/owlcarousel/owl.carousel.min.js"></script>
<script src="https://kit.fontawesome.com/60e7a8ebe3.js"
    crossorigin="anonymous"></script>
    <!-- Template Javascript -->
    <script src="/js/main.js"></script>
    <script>
    function navigateToContactUs() {
        window.location.href = "/static/testmail.html"; // 将此路径替换为实际的testmail.html路径
    }
</script>
    </body>

</html>