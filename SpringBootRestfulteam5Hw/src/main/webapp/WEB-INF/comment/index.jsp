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
<style>
.message {
    margin-bottom: 10px; /* 设置消息之间的间距 */
    overflow: auto; /* 自动滚动条 */
}

.right-float {
    float: right;
    clear: both; /* 清除浮动 */
    text-align: right; /* 消息右对齐 */
}

.left-float {
    float: left;
    clear: both; /* 清除浮动 */
    text-align: left; /* 消息左对齐 */
}
</style>
</head>
<body style="margin: 45px">
	<div class="container">
		<div class="row">
			<div class="col-md-8 offset-md-2 col-lg-6 offset-lg-3">
				<h4 class="text-center">${username}在線聊天室</h4>
				<div id="chat-box" class="card mb-3">
					<div id="chat-content" class="card-body">
						<label for="content">聊天内容：</label>
						 <div id="content" class="form-control" style="height: 200px; overflow-y: auto;"></div>
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
					    var data = JSON.parse(event.data);
						    console.log("Received message:", data); // 输出收到的消息到控制台

						    var $content = $('#content');
							
						    if (data.sender !== undefined) {
						        // 根据发送者确定消息的 CSS 类
						        messageClass = data.sender === $('#username').val() ? 'right-float' : 'left-float';
						    }

						        // 使用 <div> 包装每一条消息，并添加不同的 CSS 类
						        var messageDiv = '<div class="message ' + messageClass + '">' + data.sender + ': ' + data.content + '</div>';
						        $content.append(messageDiv); // 将消息追加到内容区域
						    
						
					};
				
				
				
				ws.onclose = function() {
					$('#content').append('[' + username + ']已离线');
					console.log("关闭 websocket 连接......");
				};

				ws.onerror = function(event) {
					console.log("websocket 发生错误......" + event + '\n');
				};

				$('#toSend').click(function() {
					sendMsg();
				});

				$(document).keyup(function(event) {
					if (event.keyCode == 13) {
						sendMsg();
					}
				});

				function sendMsg() {
				    var receiver = $('#receiver').val(); 
				    var message = $('#message').val(); 
				    var username = $('#username').val(); 

				    var msgObj = {
				    	"sender": username,
				        "receiver": receiver,
				        "content": message
				    };
				    var jsonString = JSON.stringify(msgObj); 
				    var $content = $('#content'); 
				    $content.append('<div class="message right-float">' + "我"+ ': ' + message + '</div>');

					    
				    $('#message').val(""); 
				    
				    ws.send(jsonString);
				}

				$('#toExit').click(function() {
					if (ws) {
						ws.close();
					}
				});
			} else { 
				alert("很抱歉，您的浏览器不支持 WebSocket！！！");
			}
		});
	</script>

</body>
</html>