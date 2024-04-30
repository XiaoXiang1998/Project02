
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<meta charset="UTF-8">
<title>賣家回覆區</title>
</head>
<body>
	 <header class="bg-dark py-3">
        <div class="container">
            <h1 class="text-white text-center">評價管理</h1>
        </div>
    </header>
    <nav class="bg-light py-3">
        <div class="container">
            <ul class="nav justify-content-center">
                <li class="nav-item">
                    <a class="nav-link" href="#">查看關於我的評論</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">查看所有買家的評論</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/sellerComments">查看我的回覆</a>
                </li>
                 <li class="nav-item">
                    <a class="nav-link" href="returnToControlUI">返回管理介面</a>
                </li>
                 <li class="nav-item">
                    <a class="nav-link" href="#">Welcome,${member.name}</a>
                </li>
            </ul>
        </div>
    </nav>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    	<%@ include file="index.jsp"%>
    
</body>
</html>