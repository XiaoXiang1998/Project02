<%@page import="java.sql.Time"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.*, com.comment.model.Comment,java.text.SimpleDateFormat"%>

<%! @SuppressWarnings("unchecked") public String formatDate(java.sql.Timestamp timestamp) {
    // 将 java.sql.Timestamp 转换为 Date 对象
    Date dateTime = new Date(timestamp.getTime());
    
    // 使用 SimpleDateFormat 格式化 Date 对象
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
    return sdf.format(dateTime);
} %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>評論資料</title>
<style>
.list {
	min-width: 400px;
	max-width: 800px;
	display: flex;
}

.list .item {
	width: 100%;
	display: flex;
}

.list .item .info {
	flex: 1;
	border-bottom: 3px solid  #e4e4e4;
	padding-bottom: 10px;
}

.list .item p {
	margin-bottom: 20;
}

.list .item .name {
	color: #FB7299;
	font-size: 14px;
	font-weight: bold;
}

.list .item .text {
	color: #333;
	padding: 10px 0;
}

.list .item .time {
	color: #999;
	font-size: 12px;
}
</style>
</head>
<body>

	<% List<Comment> coms=(ArrayList<Comment>)request.getAttribute("coms"); 
	for(Comment com:coms){	%>
	<div class="list ">
		<div class="item">
			<i class="avatar"></i>
			<div class="info">
				<p class="name"><%=com.getUserName()%></p>
				<p><%
					int rate = com.getRate(); // 获取评分值
					for (int i = 0; i < rate; i++) {
					%> <img src="images/output.png" alt="star" width="20" height="20">
					<% } %></p>
				<p class="time"><%=formatDate((com.getCommentTime())) %></p>
				<p class="text"><%=com.getCommentContent() %></p>
			</div>
		</div>
	</div>

	<% } %>


</body>
</html>