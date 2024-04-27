<%@page import="com.appeals.model.Appeals"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html> 
 
<head>
<meta charset="UTF-8">
<title>所有申訴資料</title>
<style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f1f1f1;
             margin: 0;
            padding: 20px;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        th,
        td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
            background-color: #fff;
        }

        th {
            background-color: #4CAF50;
            color: white;
        }

        a {
            text-decoration: none;
            color: blue;
        }

        a:hover {
            color: darkblue;
        }

        .btn {
            padding: 8px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
            text-decoration: none;
        }

        .btn:hover {
            background-color: #45a049;
        }

        .btn-danger {
            background-color: #f44336;
        }

        .btn-danger:hover {
            background-color: #cc0000;
        }

        img {
            width: 12vw;
            height: 12vw;
        }
    </style>
</head>

<body>
	<div align="center">
		<h2>所有申訴資料</h2>
		<table>
			<tr>
				<th>申訴編號</th>
				<th>申訴原因</th>
				<th>申訴人</th>
				<th>申訴對象</th>				
				<th>相關證據</th>				
				<th>修改</th>
				<th>刪除</th>
				
			</tr>
			<%
                List<Appeals> appealsBeans = (ArrayList<Appeals>) request.getAttribute("appeals");
                for (Appeals appeals : appealsBeans) {
            %>

			<tr>
				<td><%=appeals.getAppeals_id()%></td>
				<td><a
					href="appeals/<%=appeals.getAppeals_id()%>"><%=appeals.getAppeals_name()%></a>
				</td>
				<td><%=appeals.getAppeals_content()%></td>
				<td><%=appeals.getAppeals_other()%></td>
				<td><%=appeals.getAppeals_reason()%></td>
				
				<td>
				<a class="btn" href="/update/<%=appeals.getAppeals_id()%>">修改</a>
				</td>
				
				<td>
				<a class="btn" href="/delete/<%=appeals.getAppeals_id()%>">刪除</a>
				</td>
				
			</tr>
			<%
			}
			%>
		</table>
		<h3>
			共<%=appealsBeans.size()%>筆申訴資料
		</h3>
		<p>
			<a class="btn" href="/insert">新增申訴</a>
			<a class="btn" href="/Crudindex">返回首頁</a>
		</p>
	</div>




	
</body>

</html>
