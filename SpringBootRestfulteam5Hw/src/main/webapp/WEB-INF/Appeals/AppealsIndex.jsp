<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>申訴</title>

<style>
body {
    font-family: Arial, sans-serif;
    background-color: lightgray; 
}

button {
    width: 200px;
    padding: 10px;
    background-color: lightgreen; 
    color: black; 
    border: none;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.3s ease;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

button:hover {
    background-color: #8bc34a;
}

.container {
    margin-bottom: 20px;
}

.container:last-child {
    margin-bottom: 0;
}

h2 {
    color: #007bff;
}

</style>
</head>


<div align="center">
<h2>申訴管理介面</h2>
<br><br>
<form method="get" action="insert">
<button class="container">新增</button>
</form>
<br>
<form method="post" action="update">
<button class="container">修改</button>
</form>
<br>
<form method="get" action="getAll">
<button class="container">查詢全部</button>
</form>
<br>
<form method="get" action="selectOne">
<button class="container">查詢單筆</button>
</form>

</div>
<a href="appealcontrolUI">返回前台</a>
</body>
</html>