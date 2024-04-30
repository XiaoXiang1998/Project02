<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="websocket.js"></script>

</head>
<body style="margin: 45px">
    <h4>${username}在線聊天室</h4>
    <div class="form-group">
        <label for="content"></label>
        <textarea id="content" readonly="readonly" cols="80" rows="15"></textarea>
    </div>
    <div class="form-group" style="margin-top: 8px">
        <textarea id="message" cols="80" rows="5" placeholder="请输入消息"></textarea>
        <div style="margin-top: 10px">
            <button id="toSend" class="btn btn-info">發送</button>
            <button id="toExit" class="btn btn-danger">離線</button>
            <input id="username" value="${username}" style="display: none">
        </div>
    </div>
 
    
</body>
</html>