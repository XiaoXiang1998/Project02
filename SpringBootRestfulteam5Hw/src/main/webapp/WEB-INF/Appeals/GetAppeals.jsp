<%@page import="com.appeals.model.Appeals"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html>

<head>
<meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
<title>申訴資料</title>
<link href="/css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
<style>
        #queryButton {
            background-color: #007BFF; /* 按鈕的主色調 */
            color: white; /* 按鈕文字顏色 */
            border: none; /* 移除預設邊框 */
            padding: 10px 20px; /* 內邊距 */
            font-size: 16px; /* 字體大小 */
            border-radius: 5px; /* 邊框圓角 */
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* 陰影效果 */
            cursor: pointer; /* 鼠標指針變成手狀 */
            transition: background-color 0.3s, box-shadow 0.3s; /* 添加過渡效果 */
        }

        #queryButton:hover {
            background-color: #0056b3; /* 懸停時的背景色 */
            box-shadow: 0 6px 8px rgba(0, 0, 0, 0.15); /* 懸停時的陰影效果 */
        }

        #queryButton:active {
            background-color: #004085; /* 點擊時的背景色 */
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2); /* 點擊時的陰影效果 */
        }
    </style>
</head>

<body class="bg-primary">
        <div id="layoutAuthentication">
            <div id="layoutAuthentication_content">
                <main>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-5">
                                <div class="card shadow-lg border-0 rounded-lg mt-5">
                                    <div class="card-header"><h2 class="text-center font-weight-light my-4">查詢單筆資料</h2></div>
                                    <div class="card-body">
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
                                    </div>
                                    <div class="card-footer text-center py-3">
                                        <button id="queryButton">查詢所有申訴</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
            <div id="layoutAuthentication_footer">
                <footer class="py-4 bg-light mt-auto">
                    <div class="container-fluid px-4">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted">Copyright &copy; Your Website 2023</div>
                            <div>
                                <a href="#">Privacy Policy</a>
                                &middot;
                                <a href="#">Terms &amp; Conditions</a>
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
        </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="/js/scripts.js"></script>
     <script>
    document.getElementById("queryButton").onclick = function() {
        window.location.href = "/appeals/getAll";
    }; 
</script>
</body>

</html>
