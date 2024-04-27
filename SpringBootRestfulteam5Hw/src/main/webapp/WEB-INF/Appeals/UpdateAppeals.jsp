<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>修改申訴資料</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #fdf5e6; /* 淡黃色背景 */
            margin: 0;
            padding: 0;
        }

        div {
            text-align: center;
            margin-top: 50px;
        }

        h2 {
            color: #007bff; /* 深藍色標題 */
        }

        table {
            margin: auto;
            border-collapse: collapse;
            width: 80%;
            max-width: 600px;
        }

        th, td {
            padding: 10px;
            border-bottom: 1px solid #ddd; /* 灰色底框 */
        }

        input[type="text"] {
            width: calc(100% - 20px);
            padding: 5px;
            border: 1px solid #ccc; /* 淺灰色邊框 */
            border-radius: 4px;
            box-sizing: border-box;
        }

        button {
            padding: 10px 20px;
            background-color: #007bff; /* 深藍色背景 */
            color: white; /* 白色文字 */
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #0056b3; /* 深藍色懸停背景 */
        }

        button#queryButton {
            margin-top: 20px;
            background-color: #17a2b8; /* 淺藍色背景 */
        }

        button#queryButton:hover {
            background-color: #117a8b; /* 深藍色懸停背景 */
        }
    </style>
</head>

<body style="background-color: #fdf5e6">
    <div align="center">

        <h2>修改申訴資料</h2>
        <form method="post" action="/updatecontroller">
            <table>
                <tr>
                    <td>申訴編號</td>
                    <td><input type="text" name="appeals_id" readonly
                            value="${appeals.appeals_id}"></td>
                </tr>
                <tr>
                    <td>申訴人</td>
                    <td><input type="text" name="appeals_name"
                            value="${appeals.appeals_name}"></td>
                </tr>
                <tr>
                    <td>申訴對象</td>
                    <td><input type="text" name="appeals_content"
                            value="${appeals.appeals_content}"></td>
                </tr>
                <tr>
                    <td>相關證據</td>
                    <td><input type="text" name="appeals_other"
                            value="${appeals.appeals_other}"></td>
                </tr>
               
                <tr>
                    <td>申訴原因</td>
                    <td><input type="text" name="appeals_reason"
                            value="${appeals.appeals_reason}"></td>
                </tr>
                
            </table>

            <button type="submit">更新</button>
</form>
            <button id="queryButton">查詢所有申訴</button>
    </div>
    <script>
    document.getElementById("queryButton").onclick = function() {
        window.location.href = "/getAll";
    };
</script>
</body>

</html>
