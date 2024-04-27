<%@page import="com.appeals.model.Appeals"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html>

<head>
<meta charset="UTF-8">
<title>申訴資料</title>
<style>
body {
    font-family: Arial, sans-serif;
    background-color: #fdf5e6;
    margin: 0;
    padding: 20px;
}

a, a:visited {
    text-decoration: none;
    color: blue;
    margin-right: 20px;
}

h2 {
    text-align: center;
    color: #333;
}

table {
    width: 50%;
    margin: 20px auto;
    border-collapse: collapse;
}

table td {
    padding: 10px;
    border: 1px solid #ccc;
}

table td:first-child {
    font-weight: bold;
    background-color: #f9f9f9;
}

button {
    padding: 10px 20px;
    background-color: #4CAF50;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.3s;
    margin-top: 20px;
}

button:hover {
    background-color: #45a049;
}

</style>
</head>

<body style="background-color: #fdf5e6">
    <div align="center">
        <h2>申訴資料</h2>
        <c:out var="appeals" scope="request" value="${appeals}" />
        <table>

       
<tr>
    <td>申訴編號:</td>
    <td><input type="text" readonly
        value="${appeal.appeals_id}"></td>
</tr>
<tr>
    <td>申訴人:</td>
    <td><input type="text" readonly
        value="${appeal.appeals_name}"></td>
</tr>
<tr>
    <td>申訴對象:</td>
    <td><input type="text" readonly
        value="${appeal.appeals_content}"></td>
</tr>
<tr>
    <td>相關證據:</td>
    <td><input type="text" readonly
        value="${appeal.appeals_other}"></td>
</tr>
<tr>
    <td>申訴原因:</td>
    <td><input type="text" readonly
        value="${appeal.appeals_reason}"></td>
</tr>
           
        </table>
        <p>
             <button id="queryButton">查詢所有申訴</button>
             
    </div>
     <script>
    document.getElementById("queryButton").onclick = function() {
        window.location.href = "/getAll";
    }; 
</script>
</body>

</html>
