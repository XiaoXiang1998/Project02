<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<body style="margin: 45px">
  <h4>${member.name}在線聊天室</h4>
<div class="form-group">
    <label for="content">聊天内容：</label>
    <textarea id="content" readonly="readonly" class="form-control" rows="15"></textarea>
</div>
<div class="form-group">
    <label for="message">输入消息：</label>
    <textarea id="message" class="form-control" rows="5" placeholder="请输入消息"></textarea>
</div>
<div class="form-group" style="margin-top: 10px">
    <button id="toSend" class="btn btn-info">发送</button>
    <button id="toExit" class="btn btn-danger">离线</button>
    <input id="username" value="${member.name}" style="display: none">
</div>
 
    <script>
    $(function () {
        var ws;
        //如果浏览器支持WebSocket
        if ("WebSocket" in window) {
            var baseUrl='ws://localhost:8081/websocket/';
            var username=$('#username').val();
            ws=new WebSocket(baseUrl + username);

            //建立连接之后，触发事件
            ws.onopen=function () {
                console.log("建立 websocket 连接......");
            };

            //接收后台服务端的消息，触发事件
            ws.onmessage=function (event) {
                $('#content').append(event.data + '\n\n');
                console.log("接收到服务端发送的消息......" + event.data + '\n');
            };

            //连接关闭时，触发事件
            ws.onclose=function () {
                $('#content').append('[' + username + ']已离线');
                console.log("关闭 websocket 连接......");
            };

            //发生错误时，触发事件
            ws.onerror=function (event) {
                console.log("websocket发生错误......" + event + '\n');
            };
        } else { //如果浏览器不支持WebSocket
            alert("很抱歉，您的浏览器不支持WebSocket！！！");
        }

        //发送按钮触发的行为，客户端发送消息到服务器
        $('#toSend').click(function () {
            sendMsg();
        });
        //支持回车键发送消息
        $(document).keyup(function (event) {
            if (event.keyCode == 13) {
                sendMsg();
            }
        });

        //发送消息的函数
        function sendMsg() {
            ws.send($('#message').val());
            $('#message').val("");
        }

        //离线按钮触发的行为
        $('#toExit').click(function () {
            if (ws) {
                ws.close();
            }
        })
    })
	
    
    </script>
    
</body>
</html>