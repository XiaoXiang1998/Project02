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
						 <input id="username" value="${username}" style="display: none">
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
                var username=$('#username').val();
				ws = new WebSocket(baseUrl + username);

				// 建立连接之后，触发事件
				ws.onopen = function() {
					console.log("建立 websocket 连接......");
				};

				ws.onmessage = function(event) {
					  var message = event.data;
					    console.log("Received message:", message); // 输出收到的消息到控制台

					    // 直接将消息追加到 textarea 的值中
					    var textarea = $('#content');
					    textarea.val(textarea.val() + message + '\n');
					
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

				function sendMsg() {
				    var receiver = $('#receiver').val(); // 获取接收者名称
				    var message = $('#message').val(); // 获取消息内容
				    var username = $('#username').val(); // 获取消息内容

				    var msgObj = {
				    	"sender": username,
				        "receiver": receiver,
				        "content": message
				    };
				    var jsonString = JSON.stringify(msgObj); // 将消息对象转换为 JSON 字符串
				    ws.send(jsonString); // 发送 JSON 字符串
				    
				 // 将发送的消息也追加到自己的聊天框中
    			$('#content').append('<p><strong>' + username + ':</strong> ' + message + '</p>');
					    
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