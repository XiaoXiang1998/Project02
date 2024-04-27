<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Appeals</title>
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

form {
    max-width: 400px;
    margin: 20px auto;
    padding: 20px;
    border: 1px solid #ccc;
    border-radius: 5px;
    background-color: #f9f9f9;
}

input[type="text"], input[type="number"], input[type="date"] {
    width: 100%;
    padding: 10px;
    margin: 5px 0;
    border: 1px solid #ccc;
    border-radius: 5px;
    box-sizing: border-box;
}

input[type="submit"] {
    width: 100%;
    padding: 10px;
    margin-top: 10px;
    border: none;
    border-radius: 5px;
    background-color: #4CAF50;
    color: white;
    cursor: pointer;
    transition: background-color 0.3s;
}

input[type="submit"]:hover {
    background-color: #45a049;
}

label {
    font-weight: bold;
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
    display: inline-block;
    margin-top: 20px;
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

.text-center {
    text-align: center;
}
</style>
</head>
<body>

	<h2>新增申訴</h2>
	<form action="/insert" method="post">

<!-- 		<label for="Appeals_id">申訴編號:</label> <input type="text" -->
<!-- 			id="Appeals_id" name="Appeals_id" required><br>  -->
			
			<label for="Appeals_name">申訴人:</label> <input type="text"
			id="Appeals_name" name="Appeals_name" required><br>
		
		
			<label for="Appeals_content">申訴對象:</label>
		<input type="text" id="Appeals_content"
			name="Appeals_content" required><br> 
		
		
			<label for="Appeals_other">相關證據:</label>
		<input type="text" id="Appeals_other"
			name="Appeals_other" required><br> 
			
		
			
			<label for="Appeals_reason">申訴原因:</label>
		<input type="text" id="Appeals_reason"
			name="Appeals_reason" required><br> 
			
			
			

		




		<button type="submit" value="send">確定</button>

	</form>
	<div align="center">
		<p>
			<a class="btn" href="/getAll">查詢所有申訴</a>
		</p>
	</div>

	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	

</body>
</html>
