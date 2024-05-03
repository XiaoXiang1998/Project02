<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chat Room</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
/* Bootstrap 样式 */
.gradient-custom {
	background: #fccb90;
	background: -webkit-linear-gradient(to bottom right, rgba(252, 203, 144, 1),
		rgba(213, 126, 235, 1));
	background: linear-gradient(to bottom right, rgba(252, 203, 144, 1),
		rgba(213, 126, 235, 1));
}

.mask-custom {
	background: rgba(24, 24, 16, .2);
	border-radius: 2em;
	backdrop-filter: blur(15px);
	border: 2px solid rgba(255, 255, 255, 0.05);
	background-clip: padding-box;
	box-shadow: 10px 10px 10px rgba(46, 54, 68, 0.03);
}

.message-container {
	height: 300px;
	 display: flex;
    flex-direction: column;
}

.message {
    padding: 10px;
    margin-bottom: 10px;
    border-radius: 10px;
    word-wrap: break-word; 
}


.selected-user {
    background-color: #f0f0f0; 
}


.right-float {
            align-self: flex-end;
            color: #fff;
            text-align: right;
}

 .left-float {
     align-self: flex-start;
     color: #fff;
     text-align: left;
 }
</style>
</head>
<body class="gradient-custom">
	<div class="container py-5">
		<div class="row">
		<input type="hidden" id="username" value="${username}">
			<div class="col-md-6 col-lg-5 col-xl-5 mb-4 mb-md-0">
				<h5 class="font-weight-bold mb-3 text-center text-white">Member</h5>
				<div class="card mask-custom">
					<div class="card-body">
						<ul id="onlineUsersList" class="list-unstyled mb-0">
						</ul>
					</div>
				</div>
			</div>
			<div class="col-md-6 col-lg-7 col-xl-7">
				<div id="chat-box" class="card mb-3 mask-custom">
					<div id="chat-content" class="card-body message-container">
						<div id="content"></div>
					</div>
				</div>
				<ul class="list-unstyled text-white">
					<li class="mb-3">
						<div data-mdb-input-init class="form-outline form-white">
							<textarea class="form-control" id="message" rows="3"></textarea>
							<label class="form-label" for="message">Message</label>
						</div>
					</li>
					<li>
						<button id="toSend" type="button" data-mdb-button-init
							data-mdb-ripple-init class="btn btn-info btn-rounded float-end">Send</button>
					</li>
				</ul>
			</div>
		</div>
	</div>

	<script>
	
	
	
	
	
		$(function() {
			var ws;
			if ("WebSocket" in window) {
				var baseUrl = 'ws://localhost:8081/websocket/';
				var username = $('#username').val();
				ws = new WebSocket(baseUrl + username);

				ws.onopen = function() {
					console.log("建立 websocket 连接......");
					
					ws.send(username);

				};

				ws.onmessage = function(event) {
				    var data = JSON.parse(event.data);
				    console.log("Received message:", data);

				    if (data.onlineUsers !== undefined) {
				        handleOnlineUsersUpdate(data.onlineUsers);
				    } else {
				        
				        var $content = $('#content');
				        var messageClass = data.sender === $('#username').val() ? 'right-float' : 'left-float';
				        var messageDiv = '<div class="message ' + messageClass + '">' + data.sender + ': ' + data.content + '</div>';
				        $content.append(messageDiv); 
				    }
				};

				ws.onclose = function() {
					$('#content').append('[' + username + ']已離線');
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
				
				
				function handleOnlineUsersUpdate(onlineUsers) {
				    var onlineUsersList = document.getElementById("onlineUsersList");
				    onlineUsersList.innerHTML = ""; 

				    onlineUsers.forEach(function(user) {
				        if (user !== $('#username').val()) { 
				            var listItem = document.createElement("li");
				            listItem.textContent = user;
				            listItem.classList.add("user"); 
				            onlineUsersList.appendChild(listItem);
				        }
				    });

				    onlineUsersList.querySelectorAll(".user").forEach(function(userElement) {
				        userElement.addEventListener("click", function() {
				            var receiver = userElement.textContent;

				            onlineUsersList.querySelectorAll(".user").forEach(function(element) {
				                element.classList.remove("selected-user");
				            });

				            userElement.classList.add("selected-user");

				            window.selectedReceiver = receiver;
				        });
				    });
				}
				function sendMsg(receiver) {
				    var message = $('#message').val();
				    var username = $('#username').val();
		            var receiver = window.selectedReceiver;

				    var msgObj = {
				        "sender" : username,
				        "receiver" : receiver,
				        "content" : message,
				    };
				    var jsonString = JSON.stringify(msgObj);
				    var $content = $('#content');
				    $content.append('<div class="message right-float">' + "我" + ': ' + message + '</div>');

				    $('#message').val("");

				    ws.send(jsonString);
				}

				$('#toExit').click(function() {
					if (ws) {
						ws.close();
					}
				});
			} else {
				alert("很抱歉，您的瀏覽器不支持 WebSocket！！！");
			}
		});
	</script>
</body>
</html>