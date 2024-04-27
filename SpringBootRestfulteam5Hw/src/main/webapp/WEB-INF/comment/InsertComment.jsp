<%@page
	import="java.util.*, com.comment.model.Comment,java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%!public String formatDate(java.sql.Timestamp timestamp) {
		// 将 java.sql.Timestamp 转换为 Date 对象
		Date dateTime = new Date(timestamp.getTime());

		// 使用 SimpleDateFormat 格式化 Date 对象
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		return sdf.format(dateTime);
	}%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>評論資料</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
button {
	margin-bottom: 20px;
	margin-top: 20px;
}

table {
	margin-top: 20px;
	border-collapse: collapse;
	width: 100%;
}

th, td {
	padding: 10px;
	text-align: center;
	border: 1px solid #ddd;
	max-width: 150px;
	overflow: hidden;
	white-space: normal;
}

th {
	background-color: #f2f2f2;
}

tr:hover {
	background-color: #f5f5f5;
}

.update, .delete {
	text-decoration: none;
	color: #333;
}

.update:hover, .delete:hover {
	color: red;
}

td img {
	vertical-align: middle;
}
</style>
<jsp:useBean id="com" scope="request" class="com.comment.model.Comment" />

</head>
<body style='background-color: fdf5e6'>
	<div align="center" style="margin-top: 20px;">
		<h2>成功新增資料</h2>
		<table border="1">
			<tr style="background-color: #a8fefa">
				<th>編號
				<th>名字
				<th>類型
				<th>評論內容
				<th>服務評價
				<th>圖片
				<th>評論建立時間
				<th>評論修改時間
			<tr>
				<td><%=com.getCommentId()%></td>
				<td><%=com.getUserName()%></td>
				<td><%=com.getUserType()%></td>
				<td><%=com.getCommentContent()%></td>
				<td>
					<%
					int rate = com.getRate(); // 获取评分值
					for (int i = 0; i < rate; i++) {
					%> <img src="${pageContext.request.contextPath}/commentPicture/output.png"
					alt="star" width="20" height="20"> <%
 }
 %>
				</td>

				<%
				String productPhoto = com.getProductPhoto();
				if (productPhoto != null && !productPhoto.isEmpty()) {
				%>
				<td><img
					src="/<%=com.getProductPhoto() %>"
					width="100" height="100" /></td>
				<%
				} else {
				%>
				<td></td>
				<%
				}
				%>

				<td><%=formatDate(com.getCommentTime())%></td>
				<td><%=formatDate(com.getLastModifiedTime())%></td>

			</tr>
		</table>
		<button onclick="redirectToHomepage()">返回首頁</button>
	</div>
	<script>
		function redirectToHomepage() {
			window.location.href = 'index.controller';
		}
	</script>
</body>
</html>