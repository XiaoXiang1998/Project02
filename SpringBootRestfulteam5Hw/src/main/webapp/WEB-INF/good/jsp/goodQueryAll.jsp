<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Product Query All</title>
            <link rel="stylesheet" href="../css/ordersystem.css">
            <style>
                body {

                    font-family: Arial, sans-serif;

                    background-color: #f7f7f7;

                    margin: 0;

                    padding: 0;

                }



                #productListTitle {

                    font-size: 24px;

                    font-weight: bold;

                    margin-bottom: 20px;

                }



                table {

                    width: 100%;

                    border-collapse: collapse;

                    margin-bottom: 20px;

                }



                th,
                td {

                    padding: 10px;

                    text-align: center;

                    border: 1px solid #ddd;

                }



                th {

                    background-color: #f2f2f2;

                }



                .product-image {

                    max-width: 200px;

                    max-height: 200px;

                }



                .modify-btn,
                .delete-btn {

                    padding: 5px 10px;

                    background-color: #007bff;

                    color: #fff;

                    border: none;

                    cursor: pointer;

                    border-radius: 5px;

                }



                .modify-btn:hover,
                .delete-btn:hover {

                    background-color: #0056b3;

                }



                #showpage {

                    text-align: center;

                }



                #showpage button {

                    margin: 0 5px;

                    padding: 5px 10px;

                    background-color: #007bff;

                    color: #fff;

                    border: none;

                    cursor: pointer;

                    border-radius: 5px;

                }



                #showpage button:hover {

                    background-color: #0056b3;

                }
            </style>
            <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
            <script>
                var indexPage = 1;
                $(function () {
                    loadPage(indexPage);
                })
                function change(page) {
                    indexPage = page;
                    loadPage(indexPage);
                }
                function loadPage(indexPage) {
                    $.ajax({
                        type: 'get',
                        url: '/good/queryByPage/' + indexPage,
                        contentType: 'application/json',
                        success: function (data) {
                            $('#showproduct').empty("");

                            if (data == null) {
                                $('table').prepend('<tr><td>No Result</td></tr>');
                            }
                            else {
                                var table = $('#showproduct');
                                table.append("<thead id='ptitle'>" + "<tr>" +
                                    "<th>GoodsID</th><th>GoodsName</th>" +
                                    "<th>GoodsImg</th>" +
                                    "<th>GoodsPrice</th>" +
                                    "<th>GoodsStock</th>" +
                                    "<th>GoodsDirection</th>" +
                                    "<th>GoodsType</th>" +
                                    "<th>LaunchDate</th>" +
                                    "<th>Brand</th>" +
                                    "<th>ShipmentPlace</th>" +
                                    "<th>GoodsSellerID</th>" +
                                    "<th>修改</th>" +
                                    "<th>刪除</th>" +
                                    "</thead>" +
                                    "<tbody>");

                                $.each(data, function (i, n) {
                                    var tr = "<tr><td>" + n.goodsID + "</td><td>" + n.goodsName + "</td><td><img src=\"" + n.goodsImg + "\" alt=\"" + n.goodsImg + "\" height=\"200px\" width=\"200px\">" + "</td><td>" + n.goodsPrice + "</td><td>" + n.goodsStock + "</td><td>" + n.goodsDirection + "</td><td>" + n.goodsType + "</td><td>" + n.launchDate + "</td><td>" + n.brand + "</td><td>" + n.shipmentPlace + "</td><td>" + n.goodsSellerID + "</td><td>" + "<button onclick=\"Modify(" + n.goodsID + ")\" id=\"Modify" + n.goodsID + "\" class=\"modify-btn\"> 修改</button> " +
                                        "</td><td>" +
                                        "<button onclick=\"Delete(" + n.goodsID + ")\" id=\"Delete" + n.goodsID + "\" class=\"delete-btn\">刪除</button>" +
                                        "</td></tr>";
                                    table.append(tr);
                                });
                                table.append("</tbody>");
                            }
                        }
                    })
                }
                function getValModify(tr) {
                    let td = tr.children;
                    let arrtd = [...td];
                    let arrVal = new Array(arrtd.length - 2);
                    for (let i = 0; i < arrtd.length - 2; i++) {
                        if (i == 2) {//取得圖片路徑
                            let pattern = arrtd[i].children[0];
                            let path = pattern.getAttribute("src");
                            arrVal[i] = path;
                        }
                        else {
                            arrVal[i] = arrtd[i].innerHTML.trim();
                        }
                    }
                    return arrVal;
                }
                function Modify(ID) {
                    let identify = "Modify" + ID;
                    let target = document.getElementById(identify);
                    console.log(target);
                    let tr = target.closest("tr");
                    let arrVal = getValModify(tr);
                    let [goodsID, goodsName, goodsImg, goodsPrice, goodsStock, goodsDirection, goodsType, launchDate, brand, shipmentPlace, goodsSellerID] = arrVal;
                    Swal.fire({
                        title: "編輯資料",
                        html: '<form method="post" action="goodmodify.controller" enctype="multipart/form-data" id="field">' +
                            '<table border="1">' +
                            '<thead>' +
                            '<th colspan="2">商品基本資訊</th>' +
                            '</thead>' +
                            '<tbody>' +
                            '<tr>' +
                            '<td>商品編號</td>' +
                            '<td><input type="text" name="GoodsID" form="field" value="' + goodsID + '" readonly/></td>' +
                            '</tr>' +
                            '<tr>' +
                            '<td>輸入商品名字</td>' +
                            '<td><input type="text" name="GoodsName" form="field" value="' + goodsName + '"/></td>' +
                            '</tr>' +
                            '<tr>' +
                            '<td>上傳商品圖片</td>' +
                            '<td><input type="file" name="GoodsImg" form="field" value="' + goodsImg + '"/></td>' +
                            '</tr>' +
                            '<tr>' +
                            '<td>輸入商品單價</td>' +
                            '<td><input type="text" name="GoodsPrice" form="field" value="' + goodsPrice + '"/></td>' +
                            '</tr>' +
                            '<tr>' +
                            '<td>輸入商品庫存</td>' +
                            '<td><input type="text" name="GoodsStock" form="field" value="' + goodsStock + '"/></td>' +
                            '<tr>' +
                            '<td>書寫使用說明</td>' +
                            '<td><input type="text" name="GoodsDirection" form="field" value="' + goodsDirection + '"/></td>' +
                            '</tr>' +
                            '<tr>' +
                            '<td>商品種類 </td>' +
                            '<td><input type="text" name="GoodsType" form="field" value="' + goodsType + '"/></td>' +
                            '</tr>' +
                            '<tr>' +
                            '<td>上架日期 </td>' +
                            '<td><input type="date" name="LaunchDate" form="field" value="' + launchDate + '"/></td>' +
                            '</tr>' +
                            '<tr>' +
                            '<td>商品品牌</td>' +
                            '<td><input type="text" name="Brand" form="field" value="' + brand + '"/></td>' +
                            '</tr>' +
                            '<tr>' +
                            '<td>出發地 </td>' +
                            '<td><select name="ShipmentPlace" id="" form="field">' +
                            '<option value="台北市">台北市</option>' +
                            '<option value="新北市">新北市</option>' +
                            '<option value="桃園市">桃園市</option>' +
                            '<option value="台南市">台南市</option>' +
                            '<option value="高雄市">高雄市</option>' +
                            '<option value="基隆市">基隆市</option>' +
                            '<option value="新竹市">新竹市</option>' +
                            '<option value="嘉義市">嘉義市</option>' +
                            '<option value="新竹縣">新竹縣</option>' +
                            '<option value="苗栗縣">苗栗縣</option>' +
                            '<option value="彰化縣">彰化縣</option>' +
                            '<option value="南投縣">南投縣</option>' +
                            '<option value="雲林縣">雲林縣</option>' +
                            '<option value="嘉義縣">嘉義縣</option>' +
                            '<option value="屏東縣">屏東縣</option>' +
                            '<option value="宜蘭縣">宜蘭縣</option>' +
                            '<option value="花蓮縣">花蓮縣</option>' +
                            '<option value="台東縣">台東縣</option>' +
                            '<option value="澎湖縣">澎湖縣</option>' +
                            '</select>' +
                            '</td>' +
                            '</tr>' +
                            '<tr>' +
                            '<td>賣家編號</td>' +
                            '<td><input type="text" name="GoodSellerID" form="field" value="' + goodsSellerID + '"/></td>' +
                            '</tr>' +
                            '</tbody>' +
                            '</table>' +
                            '</form>'
                        ,
                        icon: "info",
                        showCancelButton: true,
                        showConfirmButton: true
                    }).then(function (result) {
                        if (result.isConfirmed) {
                            let form = document.getElementById("field");
                            let formData = new FormData(form);

                            fetch('goodupdate.controller', {
                                method: 'PUT',
                                body: formData,
                            }).then(function (response) {
                                if (response.status != 200) {
                                    console.log('response status:' + response.status);
                                    location.reload();
                                    return;
                                }
                                console.log('response status:' + response.status);
                            })

                            console.log("選擇編輯");
                        }
                        else {
                            Swal.fire("您選擇了Cancel");
                        }
                    })
                }
                function getValDelete(tr) {
                    let td = tr.children;
                    let arrtd = [...td];
                    let arrVal = new Array(2);
                    arrVal[0] = arrtd[0].innerHTML.trim();
                    let pattern = arrtd[2].children[0];
                    let path = pattern.getAttribute("src");
                    arrVal[1] = path;
                    return arrVal;
                }
                function Delete(ID) {
                    let identify = "Delete" + ID;
                    let target = document.getElementById(identify);
                    let tr = target.closest("tr");
                    let arrVal = getValDelete(tr);
                    let [goodsID, goodsImg] = arrVal;
                    Swal.fire({
                        title: "刪除資料",
                        html: '<form method="post" action="goodmodify.controller" enctype="multipart/form-data" id="field">' +
                            '<table border="1">' +
                            '<thead>' +
                            '<th colspan="2">商品基本資訊</th>' +
                            '</thead>' +
                            '<tbody>' +
                            '<tr>' +
                            '<td>商品編號</td>' +
                            '<td><input type="text" name="GoodsID" form="field" value="' + goodsID + '" readonly/></td>' +
                            '</tr>' +
                            '<tr>' +
                            '<td>上傳商品圖片</td>' +
                            '<td><img src="' + goodsImg + '" alt="' + goodsImg + '" style="height: 150px;width: 150px;"></td>' +
                            //             '<td><input type="image" name="GoodsImg" form="field" src="' + goodsImg + '" value="' + goodsImg + '"/></td>' +
                            '</tr>' +
                            '<input type="text" name="GoodsImg" form="field" value="' + goodsImg + '" hidden/>' +
                            '</tbody>' +
                            '</table>' +
                            '</form>'
                        ,
                        icon: "info",
                        showCancelButton: true,
                        showConfirmButton: true
                    }).then(function (result) {
                        if (result.isConfirmed) {
                            let form = document.getElementById("field");
                            let formData = new FormData(form);
                            fetch('gooddelete.controller', {
                                method: 'DELETE',
                                body: formData,
                            }).then(function (response) {
                                if (response.status != 200) {
                                    console.log('response status:' + response.status);
                                    location.reload();
                                    //                                    return;
                                }
                                console.log('response status:' + response.status);
                            })
                            console.log("選擇刪除");
                        }
                        else {
                            Swal.fire("您選擇了Cancel");
                        }
                    })
                }
            </script>
        </head>

        <body>
            <button id="Insert">新增</button>
            <div id="productListTitle">Product Query All</div>
            <table id="showproduct" border="1"></table>
            <table id="showpage">
                <tr>
                    <td>Total Pages: ${totalPages} totalRecords: ${totalElements}</td>
                    <td colspan="3" align="right">Previous

                        <c:forEach var="i" begin="1" end="${totalPages}" step="1">
                            <button id="myPage" type="button" onclick="change(${i})">${i}</button>
                        </c:forEach>Next
                    </td>
                </tr>
            </table>
            <a href="goodindex.controller">商品首頁</a>
        </body>
        <script>
            let insert = document.getElementById("Insert");
            // let mod = document.getElementById("Modify3");
            insert.onclick = function () {
                // console.log('123123');
                Swal.fire({
                    title: "新增資料",
                    html: '<form method="post" action="goodmodify.controller" enctype="multipart/form-data" id="field">' +
                        '<table border="1">' +
                        '<thead>' +
                        '<th colspan="2">商品基本資訊</th>' +
                        '</thead>' +
                        '<tbody>' +
                        '<tr>' +
                        '<td>輸入商品名字</td>' +
                        '<td><input type="text" name="GoodsName" form="field"/></td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td>上傳商品圖片</td>' +
                        '<td><input type="file" name="GoodsImg" form="field"/></td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td>輸入商品單價</td>' +
                        '<td><input type="text" name="GoodsPrice" form="field"/></td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td>輸入商品庫存</td>' +
                        '<td><input type="text" name="GoodsStock" form="field"/></td>' +
                        '<tr>' +
                        '<td>書寫使用說明</td>' +
                        '<td><input type="text" name="GoodsDirection" form="field"/></td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td>商品種類 </td>' +
                        '<td><input type="text" name="GoodsType" form="field"/></td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td>上架日期 </td>' +
                        '<td><input type="date" name="LaunchDate" form="field"/></td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td>商品品牌</td>' +
                        '<td><input type="text" name="Brand" form="field"/></td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td>出發地 </td>' +
                        '<td><select name="ShipmentPlace" id="" form="field">' +
                        '<option value="台北市">台北市</option>' +
                        '<option value="新北市">新北市</option>' +
                        '<option value="桃園市">桃園市</option>' +
                        '<option value="台南市">台南市</option>' +
                        '<option value="高雄市">高雄市</option>' +
                        '<option value="基隆市">基隆市</option>' +
                        '<option value="新竹市">新竹市</option>' +
                        '<option value="嘉義市">嘉義市</option>' +
                        '<option value="新竹縣">新竹縣</option>' +
                        '<option value="苗栗縣">苗栗縣</option>' +
                        '<option value="彰化縣">彰化縣</option>' +
                        '<option value="南投縣">南投縣</option>' +
                        '<option value="雲林縣">雲林縣</option>' +
                        '<option value="嘉義縣">嘉義縣</option>' +
                        '<option value="屏東縣">屏東縣</option>' +
                        '<option value="宜蘭縣">宜蘭縣</option>' +
                        '<option value="花蓮縣">花蓮縣</option>' +
                        '<option value="台東縣">台東縣</option>' +
                        '<option value="澎湖縣">澎湖縣</option>' +
                        '</select>' +
                        '</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td>賣家編號</td>' +
                        '<td><input type="text" name="GoodSellerID" form="field"/></td>' +
                        '</tr>' +
                        '</tbody>' +
                        '</table>' +
                        '</form>'
                    ,
                    icon: "info",
                    showCancelButton: true,
                    showConfirmButton: true,
                }).then(function (result) {
                    if (result.isConfirmed) {
                        let form = document.getElementById("field");
                        let formData = new FormData(form);
                        fetch('goodinsert2.controller', {
                            method: 'POST',
                            body: formData,
                        }).then(function (response) {
                            if (response.status != 200) {
                                console.log('response status:' + response.status);
                                return;
                            }
                            console.log('response status:' + response.status);
                            console.log('response url:' + response.url);
                            location.reload();
                        })
                        //
                        console.log("選擇新增");
                    }
                    else {
                        Swal.fire("您選擇了Cancel");
                    }
                })
            }

        </script>

        </html>