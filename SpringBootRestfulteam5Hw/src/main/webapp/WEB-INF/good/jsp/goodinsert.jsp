<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        #container {
            width: 50%;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 10px;
        }
        th {
            background-color: #f2f2f2;
            text-align: center;
        }
        td {
            text-align: left;
        }
        input[type="text"], input[type="file"], select, input[type="date"] {
            width: 100%;
            padding: 8px;
            margin: 4px 0;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type="submit"] {
            width: auto;
            padding: 10px 20px;
            margin-top: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
 <div id="container">
        <h1>商品資訊輸入表單</h1>
	<form method="post" action="goodinsert2.controller" enctype="multipart/form-data" id="field">
                          	<table border="1">
                            <thead>
                            <th colspan="2">商品基本資訊</th>
                            </thead>
                            <tbody>
                            <tr>
                            <td>輸入商品名字</td>
                            <td><input type="text" name="GoodsName" form="field" /></td>
                            </tr>
                            <tr>
                            <td>上傳商品圖片</td>
                            <td><input type="file" name="GoodsImg" form="field" /></td>
                            </tr>
                            <tr>
                            <td>輸入商品單價</td>
                            <td><input type="text" name="GoodsPrice" form="field" /></td>
                            </tr>
                            <tr>
                            <td>輸入商品庫存</td>
                            <td><input type="text" name="GoodsStock" form="field" /></td>
                            <tr>
                            <td>書寫使用說明</td>
                            <td><input type="text" name="GoodsDirection" form="field" /></td>
                            </tr>
                            <tr>
                            <td>商品種類 </td>
                            <td><input type="text" name="GoodsType" form="field" /></td>
                            </tr>
                            <tr>
                            <td>上架日期 </td>
                            <td><input type="date" name="LaunchDate" form="field" /></td>
                            </tr>
                            <tr>
                            <td>商品品牌</td>
                            <td><input type="text" name="Brand" form="field" /></td>
                            </tr>
                            <tr>
                            <td>出發地 </td>
                            <td><select name="ShipmentPlace" id="" form="field">                          
                            <option value="台北市">台北市</option>
                            <option value="新北市">新北市</option>
                            <option value="桃園市">桃園市</option>
                            <option value="台南市">台南市</option>
                            <option value="高雄市">高雄市</option>
                            <option value="基隆市">基隆市</option>
                            <option value="新竹市">新竹市</option>
                            <option value="嘉義市">嘉義市</option>
                            <option value="新竹縣">新竹縣</option>
                            <option value="苗栗縣">苗栗縣</option>
                            <option value="彰化縣">彰化縣</option>
                            <option value="南投縣">南投縣</option>
                            <option value="雲林縣">雲林縣</option>
                            <option value="嘉義縣">嘉義縣</option>
                            <option value="屏東縣">屏東縣</option>
                            <option value="宜蘭縣">宜蘭縣</option>
                            <option value="花蓮縣">花蓮縣</option>
                            <option value="台東縣">台東縣</option>
                            <option value="澎湖縣">澎湖縣</option>
                            </select>
                            </td>
                            </tr>
                            <tr>
                            <td>賣家編號</td>
                            <td><input type="text" name="GoodSellerID" form="field"/></td>
                            </tr>
                            <tr>
                            <td>提交</td>
                            <td><button>提交</button></td>
                            </tr>
                            
                            </tbody>
                            </table>
                            </form>
                            </div>
</body>
</html>