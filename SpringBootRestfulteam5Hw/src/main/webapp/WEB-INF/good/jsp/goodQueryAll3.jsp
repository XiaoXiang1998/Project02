<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Product Query All</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
                integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
                crossorigin="anonymous" />
            <link rel="stylesheet" href="https://cdn.datatables.net/2.0.5/css/dataTables.dataTables.css">
            <style>
                #container {
                    width: 1000px;
                    margin: 20px auto;
                }

                .ck-editor__editable[role="textbox"] {
                    /* Editing area */
                    min-height: 200px;
                }

                .ck-content .image {
                    /* Block images */
                    max-width: 80%;
                    margin: 20px auto;
                }
            </style>
            <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
            <script src="https://cdn.datatables.net/2.0.5/js/dataTables.js"></script>
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
                function loadPage(indexPage) {//全部基本商品資訊
                    $.ajax({

                        type: 'get',

                        url: '/getallgood.controller',

                        contentType: 'application/json',

                        success: function (data) {

                            $('#showproduct').empty("");

                            if (data == null) {

                                $('table').prepend('<tr><td>No Result</td></tr>');

                            }

                            else {

                                //商品圖片、商品規格

                                var table = $('#showproduct');

                                table.append("<thead id='ptitle'>" + "<tr>" +

                                    "<th scope=\"col\">GoodsID</th><th>GoodsName</th>" +

                                    "<th scope=\"col\">TitleImage</th>" +

                                    "<th scope=\"col\">GoodsDirection</th>" +

                                    "<th scope=\"col\">GoodsType</th>" +

                                    "<th scope=\"col\">LaunchDate</th>" +

                                    "<th scope=\"col\">Brand</th>" +

                                    "<th scope=\"col\">ShipmentPlace</th>" +

                                    "<th scope=\"col\">GoodsSellerID</th>" +

                                    "<th scope=\"col\">修改基本商品資訊</th>" +

                                    "<th scope=\"col\">刪除這筆商品</th>" +

                                    "<th scope=\"col\">查看這筆商品的所有圖片</th>" +//裡面包含圖片的增刪改查

                                    "<th scope=\"col\">查看這筆商品的所有規格</th>" +//裡面包含規格的增刪改查

                                    "</thead>" +

                                    "<tbody>");

                                $.each(data, function (i, n) {
                                    // String(n.goodsName)
                                    // console.log("n.titleImage = "+n.titleImage);
                                    // console.log(typeof String(n.goodsName));
                                    var tr = "<tr><td>" + n.goodsID + "</td><td>" + n.goodsName + "</td><td><img src=" + n.titleImage + " alt=" + n.titleImage + "></td><td>" + n.goodsDirection + "</td><td>" + n.goodsType + "</td><td>" + n.launchDate + "</td><td>" + n.brand + "</td><td>" + n.shipmentPlace + "</td><td>" + n.goodsSellerID.sid + "</td><td>" +

                                        "<button onclick=\"Modify(" + n.goodsID + ")\" id=\"Modify" + n.goodsID + "\" class = \"btn btn-primary btn-block\">修改基本商品資訊</button> " +

                                        "</td><td>" +

                                        "<button onclick=\"Delete(" + n.goodsID + ")\" id=\"Delete" + n.goodsID + "\" class = \"btn btn-primary btn-block\">刪除這筆商品</button>" +

                                        "</td><td>" +

                                        "<button onclick=\"ImageCheck(" + n.goodsID + ")\" id=\"ImageCheck" + n.goodsID + "\" class = \"btn btn-primary btn-block\">查看這筆商品的所有圖片</button>" +

                                        "</td><td>" +

                                        "<button onclick=\"FormatCheck(" + n.goodsID + ")\" id=\"FormatCheck" + n.goodsID + "\" class = \"btn btn-primary btn-block\">查看這筆商品的所有規格</button>" +
                                        "</td></tr>";

                                    table.append(tr);

                                });

                                table.append("</tbody>");
                                new DataTable('#showproduct');
                            }

                        }

                    })

                }
            </script>
        <body>
            <button id="InsertGoodData">新增</button>
            <form action="InsertGood.controller" method="post">
                <button id="InsertGoodPPage">進入新增頁面</button>
            </form>
            
            <div id="productListTitle">Product Query All</div>
            <table id="showproduct" class="table table-bordered" style="width:100%"></table>
            <!-- <table id="showpage">
                <tr>
                    <td>Total Pages: ${totalPages} totalRecords: ${totalElements}</td>
                    <td colspan="3" align="right">Previous

                        <c:forEach var="i" begin="1" end="${totalPages}" step="1">
                            <button id="myPage" type="button" onclick="change(${i})">${i}</button>
                        </c:forEach>Next
                    </td>
                </tr>
            </table> -->
            <img src="../../goodImage/20240419135850997.jpg" alt="">
        </body>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
        <script>
            let insertPage = document.getElementById("InsertGoodPPage");
            insertPage.onclick = function(){
                // location.href = "http://localhost:8081/InsertGood.controller";
                location.href = "/InsertGood.controller";
            }
            let insert = document.getElementById("InsertGoodData");
            // let mod = document.getElementById("Modify3");
            insert.onclick = function () {
                console.log('123123');
                Swal.fire({
                    title: "新增資料",
                    html: '<button type="button" id="photoinsert">新增圖片欄位</button>' +
                        '<form method="post" action="goodinsert2.controller" enctype="multipart/form-data" id="field">' +
                        '<table border="1" id="table">' +
                        '<thead>' +
                        '<th colspan="2">商品基本資訊</th>' +
                        '</thead>' +
                        '<tbody>' +
                        '<tr>' +
                        '<td>輸入商品名字</td>' +
                        '<td><input type="text" name="GoodsName" form="field"/></td>' +
                        '</tr>' +
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
                        '<td><input type="text" name="Brand" form="field" id="editorcontent"/></td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td>出發地</td>' +
                        '<td><input type="text" name="ShipmentPlace" form="field"></td>' +
                        '</tr>' +
                        '</tbody>' +
                        '</table>' +
                        '</form>'
                    ,
                    icon: "info",
                    showCancelButton: true,
                    showConfirmButton: true,
                }).then(function (result) {//裡邊不需要ajax才對 
                    if (result.isConfirmed) {
                        let form = document.getElementById("field");
                        form.submit();
                        // let formData = new FormData(form);
                        // fetch('goodinsert2.controller', {
                        //     method: 'POST',
                        //     body: formData,
                        // }).then(function (response) {
                        //     if (response.status != 200) {
                        //         console.log('response status:' + response.status);
                        //         return;
                        //     }
                        //     console.log('response status:' + response.status);
                        //     console.log('response url:' + response.url);
                        //     location.reload();
                        // })
                        //
                        console.log("選擇新增");
                    }
                    else {
                        Swal.fire("您選擇了Cancel");
                    }
                })
                //
                let item = $('#field').find(`input[type="file"]`);
                console.log(item.length);
                if (item.length == 0) {//假如form標籤內沒有input標籤,將沒有圖片這段話顯示出來
                    let content = `<p id="msg">No Images here</p>`;
                    $('#photo').prepend(content);
                }

                $('#photoinsert').click(function () {
                    //td標籤塞入tr標籤中
                    let tr = document.createElement("tr");
                    let td = document.createElement("td");
                    //建立刪除圖片欄位的按鈕
                    let buttonDelete = document.createElement("button");
                    buttonDelete.innerHTML = "delete";
                    buttonDelete.setAttribute('class', 'btnDelete')
                    //建立上傳圖片的input標籤
                    let input = document.createElement("input");
                    let tdDelete = document.createElement("td");
                    let table = document.getElementById("table");
                    tdDelete.append(buttonDelete);
                    td.append(input);
                    tr.append(td);
                    tr.append(tdDelete);
                    table.append(tr);
                    let numbers = table.children.length;
                    let Name = "photo" + numbers;
                    input.setAttribute("type", "file");
                    input.setAttribute("name", Name);
                    input.setAttribute("required", true);
                    input.setAttribute("form", "field");
                    
                    //
                    let item = $('#field').find(`input[type="file"]`);
                    console.log(item.length);
                    if (item.length == 0) {//假如form標籤內沒有input標籤,將沒有圖片這段話顯示出來
                        let content = `<p id="msg">No Images here</p>`;
                        item.prepend(content);
                    }
                    else {
                        $("#msg").prop('outerHTML', "");//將此訊息刪除
                    }
                    $('.btnDelete').click(function () {
                        let tr = $(this).closest('tr');
                        tr.prop('outerHTML', "");
                    })
                })
                //
            }

        </script>

        </html>