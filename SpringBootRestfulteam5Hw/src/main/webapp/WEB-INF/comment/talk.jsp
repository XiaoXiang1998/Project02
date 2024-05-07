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

#chat-content {
    overflow-y: auto;
    max-height: 400px; 
}

.message-time {
    display: inline; 
}

.avatar-icon {
    width: 30px;
    height: 30px; 
    border-radius: 50%; 
    margin-right: 10px; 
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

	              loadChatHistory();
	              handleOnlineUsersUpdate([]);
			};

			ws.onmessage = function(event) {
			    var data = JSON.parse(event.data);
			    console.log("Received message:", data);

			    if (data.onlineUsers !== undefined) {
			        handleOnlineUsersUpdate(data.onlineUsers);
			    } else if (data.offlineUser !== undefined) { 
			        var offlineUser = data.offlineUser;
			        $('#content').append('[' + offlineUser + ']已離線');

			    } else if (data.onlineUser !== undefined ) { 
			        var onlineUser = data.onlineUser;
			        $('#content').append('[' + onlineUser + ']已進入聊天室');
	
			    } else {
			        var $content = $('#content');
			        var messageClass = data.sender === $('#username').val() ? 'right-float'
			                : 'left-float';
			        var currentTime = getCurrentTime(); 
			        var messageDiv = '<div class="message ' + messageClass + '">' +
                    '<img class="avatar" src="commentPicture/deafult-avatar.png" alt="Avatar">' +
                    data.sender + ': ' + data.content + 
                    '<span class="message-time">' + data.time + '</span>' +
                 '</div>';
			        $content.append(messageDiv);
			        
			        var scrollHeight = $('#chat-content')[0].scrollHeight;
			        $('#chat-content').scrollTop(scrollHeight);
			        
			        storeMessage(data);
			        
			        updateLastMessageForUser(data.sender, data.content, data.time);

			    }
			};

			ws.onclose = function() {
				console.log("關閉 websocket 連接......");
			};

			ws.onerror = function(event) {
				console.log("websocket 發生錯誤......" + event + '\n');
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
			            
			            listItem.setAttribute("data-username", user); 

			            
			            // 添加一个容器来显示最后一条消息的内容
			            var lastMessageContainer = document.createElement("div");
			            lastMessageContainer.classList.add("last-message");
			            listItem.appendChild(lastMessageContainer);
			            
			            // 获取用户的最后一条消息
			            var lastMessage = getLastMessageForUser(user);

			            if (lastMessage !== null) { // 检查是否存在最后一条消息
			                // 更新容器中的内容为最后一条消息的内容
			                lastMessageContainer.textContent = lastMessage ? lastMessage.content : "";
			            }

			            // 添加用户头像
			            var img = document.createElement("img");
			            img.src = "commentPicture/deafult-avatar.png"; 
			            img.alt = "Avatar";
			            img.classList.add("avatar");
			            listItem.prepend(img); 
			            
			            // 将用户列表项添加到用户列表中
			            onlineUsersList.appendChild(listItem);

			            // 添加点击事件监听器
			            listItem.addEventListener("click", function() {
			                var receiver = user;
			                onlineUsersList.querySelectorAll(".user").forEach(function(element) {
			                    element.classList.remove("selected-user");
			                });
			                listItem.classList.add("selected-user");
			                window.selectedReceiver = receiver;
			            });
			        }
			    });
			}
			
			

			
			
			function getLastMessageForUser(username) {
	            var chatHistory = localStorage.getItem('chatHistory');
	            if (chatHistory) {
	                var messages = JSON.parse(chatHistory);
	                var userMessages = messages.filter(function(message) {
	                    return message.sender === username;
	                });
	                if (userMessages.length > 0) {
	                    return userMessages[userMessages.length - 1];
	                }
	            }
	            return null;
	        }
			
			function updateLastMessageForUser(username, content, time) {
			    console.log("进步来是沙小");

			    var onlineUsersList = document.getElementById("onlineUsersList");
			    var userItems = onlineUsersList.querySelectorAll(".user");

			    userItems.forEach(function(userItem) {
			        // 使用自定义属性来获取用户名
			        var userItemUsername = userItem.getAttribute("data-username");
			        if (userItemUsername === username) { // 如果用户名匹配
			            var lastMessageContainer = userItem.querySelector(".last-message");
			            console.log(userItemUsername);
			            lastMessageContainer.textContent = content;
			            console.log(content);
			        }
			    });
			}

			
			function sendMsg(receiver) {
				var message = $('#message').val();
				var username = $('#username').val();
				var receiver = window.selectedReceiver;
				var sender=$('#message').val();
			    var currentTime = getCurrentTime(); 
	
				
				
				var msgObj = {
					"sender" : username,
					"receiver" : receiver,
					"content" : message,
			        "time": currentTime 
				};
				var jsonString = JSON.stringify(msgObj);
				var $content = $('#content');
				$content.append('<div class="message right-float">' +
		                '<img class="avatar" src="commentPicture/deafult-avatar.png" alt="Avatar">' +
		                "我" + ': ' + message + 
		                '<span class="message-time">' + currentTime + '</span>' +
		                '</div>');				
				
			    storeMessage(msgObj);

				$('#message').val("");

				ws.send(jsonString);
				
			    var scrollHeight = $('#chat-content')[0].scrollHeight;
			    $('#chat-content').scrollTop(scrollHeight);
			    

			}
			
			function getCurrentTime() {
			    var now = new Date();
			    var hours = now.getHours();
			    var minutes = now.getMinutes();

			    hours = hours < 10 ? '0' + hours : hours;
			    minutes = minutes < 10 ? '0' + minutes : minutes;

			    var period = hours >= 12 ? '下午' : '上午'; 
			    hours = hours > 12 ? hours - 12 : hours; 
			    return period + ' ' + hours + '點' + ' ' + minutes + '分';
			}

	        function storeMessage(message) {
	            var chatHistory = localStorage.getItem('chatHistory');
	            var messages = chatHistory ? JSON.parse(chatHistory) : [];
	            messages.push(message);
	            localStorage.setItem('chatHistory', JSON.stringify(messages));
	        }
	        
	        function loadChatHistory() {
	            var chatHistory = localStorage.getItem('chatHistory');
	            if (chatHistory) {
	                var messages = JSON.parse(chatHistory);
	                messages.forEach(function(message) {
	                    var messageClass = message.sender === $('#username').val() ? 'right-float' : 'left-float';
	                    var senderName = message.sender === $('#username').val() ? '我' : message.sender;
	                    var messageDiv = '<div class="message ' + messageClass + '">' +
                        '<img class="avatar" src="commentPicture/deafult-avatar.png" alt="Avatar">' +
                        senderName + ': ' + message.content +
                        '<span class="message-time">' + message.time + '</span>' +
                     '</div>';
	                    $('#content').append(messageDiv);
	                });

	                var scrollHeight = $('#chat-content')[0].scrollHeight;
	                $('#chat-content').scrollTop(scrollHeight);
	            }
	        }
	        
	        
	        
		} else {
			alert("很抱歉，您的瀏覽器不支持 WebSocket！！！");
		}
	});
	</script>
</body>
</html>