<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<body style="margin: 45px">
	<div class="container">
		<div class="row">
			<div class="col-md-8 offset-md-2 col-lg-6 offset-lg-3">
				<h4 class="text-center">${username}在線聊天室</h4>
				<div id="chat-box" class="card mb-3">
					<div id="chat-content" class="card-body">
						<label for="content">聊天内容：</label>
						<textarea id="content" readonly="readonly" class="form-control"
							rows="15"></textarea>
					</div>
				</div>
				<div class="input-group mt-3">
					<input type="text" id="receiver" class="form-control"
						placeholder="輸入接收者">
					<textarea id="message" class="form-control" rows="3"
						placeholder="請輸入消息"></textarea>
					<div class="input-group-append">
						<button id="toSend" class="btn btn-info">發送</button>
						<button id="toExit" class="btn btn-danger">離開</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
		$(function() {
			var ws;
			// 如果浏览器支持 WebSocket
			if ("WebSocket" in window) {
				var baseUrl = 'ws://localhost:8081/websocket/';
				var username = $('#username').val();
				ws = new WebSocket(baseUrl + username);

				// 建立连接之后，触发事件
				ws.onopen = function() {
					console.log("建立 websocket 连接......");
				};

				ws.onmessage = function(event) {
					var message = event.data;
					var currentUser = $('#username').val();

					// 直接使用消息内容作为接收到的消息
					var content = message;

					// 输出日志，用于调试
					console.log("接收到服务端发送的消息：" + message);

					// 在聊天框中显示消息内容
					$('#content').append('<p>' + content + '</p>');

				};

				// 连接关闭时，触发事件
				ws.onclose = function() {
					$('#content').append('[' + username + ']已离线');
					console.log("关闭 websocket 连接......");
				};

				// 发生错误时，触发事件
				ws.onerror = function(event) {
					console.log("websocket 发生错误......" + event + '\n');
				};

				// 发送按钮触发的行为，客户端发送消息到服务器
				$('#toSend').click(function() {
					sendMsg();
				});

				// 支持回车键发送消息
				$(document).keyup(function(event) {
					if (event.keyCode == 13) {
						sendMsg();
					}
				});

				// 发送消息的函数
				function sendMsg() {
					var message = $('#message').val(); // 消息内容
					ws.send(message); // 直接发送消息内容

					$('#message').val(""); // 清空消息输入框
				}

				// 离线按钮触发的行为
				$('#toExit').click(function() {
					if (ws) {
						ws.close();
					}
				});
			} else { // 如果浏览器不支持 WebSocket
				alert("很抱歉，您的浏览器不支持 WebSocket！！！");
			}
		});
	</script>

</body>
</html>