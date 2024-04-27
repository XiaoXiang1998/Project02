<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <!DOCTYPE html>
  <html>

  <head>
    <meta charset="UTF-8">
    <title>首頁</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        table {
            width: 50%;
            margin: 50px auto;
            border-collapse: collapse;
        }

        td {
            text-align: center;
            padding: 10px;
        }

        button {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            text-decoration: none;
            display: inline-block;
            transition: background-color 0.3s;
        }

        button a {
            color: white;
            text-decoration: none;
        }

        button:hover {
            background-color: #45a049;
        }
    </style>
  </head>

  <body>
	<table>
		<tr>
			<td><button><a href="goodqueryallpage.controller">查詢全部</a></button></td>
		</tr>
		<tr>
			<td><button><a href="goodinsert.controller">新增單筆</a></button></td>
		</tr>
	</table>
	<a href="returncontrolUI">回到管理介面</a>    
  </body>

  </html>