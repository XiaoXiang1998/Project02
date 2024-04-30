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
