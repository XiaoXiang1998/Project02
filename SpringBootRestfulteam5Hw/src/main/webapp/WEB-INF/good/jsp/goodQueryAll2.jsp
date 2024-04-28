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
                                    var tr = "<tr><td>" + n.goodsID + "</td><td>" + n.goodsName + "</td><td><img src=\"" + n.titleImage + "\" alt=\"" + n.titleImage + "\"></td><td>" + n.goodsDirection + "</td><td>" + n.goodsType + "</td><td>" + n.launchDate + "</td><td>" + n.brand + "</td><td>" + n.shipmentPlace + "</td><td>" + n.goodsSellerID.sid + "</td><td>" +

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
                /*FormatCheck*/
                /*FormatCheck*/
                function ImageCheck(ID) {//透過ajax找到對應ID的所有圖片
                    // console.log(typeof ID);
                    $.ajax({

                        type: 'get',

                        url: '/goodImage/' + ID,//回傳取得所有圖片的路徑

                        contentType: 'application/json',

                        success: function (data) {
                            let contentfunction = `<table id="dataTable1" class="table table-bordered">` +
                                `<tr>` +
                                `<td><button id="Insertphoto" class="btn btn-primary btn-lg">新增</button></td>` +
                                `<td><button id="Modify" class="btn btn-primary btn-lg">修改</button></td>` +
                                `<td><button id="Delete" class="btn btn-primary btn-lg">刪除</button></td>` +
                                `</tr>`;
                            console.log(data);
                            if (data.length == 0) {//沒資料顯示No Images
                                //沒有資料的情況下無法修改和刪除
                                let content = contentfunction + `<p>No Images</p>`;
                                swal.fire({
                                    html: content,
                                })
                                let modifyBtnfunction = document.getElementById("Modify");
                                let deleteBtnfunction = document.getElementById("Delete");
                                modifyBtnfunction.setAttribute("disabled", true);
                                deleteBtnfunction.setAttribute("disabled", true);
                                // $('#Modify').attr("disabled", true);
                                // $('#Delete').attr("disabled", true);
                                $('#Insertphoto').click(function () {
                                    let content = '<button id="insert" class="btn btn-primary btn-lg">新增欄位</button>' +
                                        '<form action="" id="photo" enctype="multipart/form-data" method="post">' + //action裡面存的是將資料傳出去的路徑
                                        '<table id="dataTable1" class="table table-bordered">' +
                                        '<tbody id="table">' +
                                        '</tbody>' +
                                        '</table>' +
                                        '</form>';
                                    Swal.fire({
                                        html: content,
                                        showCancelButton: true,
                                        showConfirmButton: true,
                                    }).then(function (result) {
                                        // let form = $('#photo');
                                        if (result.isConfirmed) {//用AJAX提交資料
                                            let form = document.getElementById("photo");
                                            let formData = new FormData(form);
                                            fetch('goodImageinsert.controller', {
                                                method: 'POST',
                                                body: formData,
                                            }).then(function (response) {
                                                if (response.status != 200) {
                                                    console.log('response status:' + response.status);
                                                    return;
                                                }
                                                console.log('response status:' + response.status);
                                                // location.reload();
                                            })
                                        }
                                        else {
                                            console.log("NO");
                                        }
                                    })
                                    let item = $('#photo').find('input');
                                    console.log(item.length);
                                    if (item.length == 0) {//假如form標籤內沒有input標籤,將沒有圖片這段話顯示出來
                                        let content = `<p id="msg">No Images here</p>`;
                                        $('#photo').prepend(content);
                                    }
                                    //新增的案例
                                    $('#insert').click(function () {
                                        let input = document.createElement("input");
                                        let buttonDelete = document.createElement("button");
                                        buttonDelete.innerHTML = "delete";
                                        buttonDelete.setAttribute('class', 'btnDelete')
                                        let tr = document.createElement("tr");
                                        let td = document.createElement("td");
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
                                        input.setAttribute("form", "photo");
                                        //
                                        let item = $('#photo').find('input');
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
                                            //
                                            let item = $('#table').find('input');
                                            if (item.length == 0) {//假如form標籤內沒有input標籤,將沒有圖片這段話顯示出來
                                                console.log("NO PHOTO");
                                                let content = `<p id="msg">No Images here</p>`;
                                                $('#photo').prepend(content);
                                            }
                                        })
                                    })
                                    //
                                })
                            }
                            else {//如果data有資料的案例
                                let arrPath = new Array(data.length);//裡面存對應商品編號的所有圖片路徑
                                let content = contentfunction;

                                $.each(data, function (i, n) {
                                    content = content + `<tr><td colspan="3"><img src=\"` + n.imagePath + `\" alt=\"` + n.imagePath + `\" style="height: 250px;width: 500px;"></td></tr>`;
                                    console.log("path=" + n.imagePath);
                                })
                                content = content + `</table>`;
                                swal.fire({
                                    html: content,
                                })
                                //點擊任一功能 會展示所有圖片，不過只能使用一個功能
                                $('#Insertphoto').click(function () {
                                    console.log("我想要新增照片");
                                    //視窗內有'新增欄位'的按鈕 點擊後會出現input標籤可以上傳圖片 
                                    //傳遞出去的位址是 goodImageinsert.controller
                                    let content = '<button id="insert" type="button">新增欄位</button>' +
                                        '<form action="" id="photo" enctype="multipart/form-data" method="post">' + //action裡面存的是將資料傳出去的路徑
                                        '<table border="1">' +
                                        '<tbody id="table">';

                                    $.each(data, function (i, n) {
                                        content = content + `<tr><td colspan="3"><img src=\"` + n.imagePath + `\" alt=\"` + n.imagePath + `\" style="height: 250px;width: 500px;"></td></tr>`;
                                    })
                                  
                                    content = content + '<tr hidden><td><input type="text" name="GoodsID" form="photo" value="'+ ID +'"> </td></tr></tbody>' +
                                        '</table>' +
                                        '</form>';
                                    Swal.fire({
                                        html: content,
                                        showCancelButton: true,
                                        showConfirmButton: true,
                                    }).then(function (result) {
                                        //
                                        let form = document.getElementById('photo');
                                        console.log(form);
                                        let formData = new FormData(form);
                                        if (result.isConfirmed) {//用AJAX提交資料
                                            fetch('goodImageinsert.controller', {
                                                method: 'POST',
                                                body: formData,
                                            }).then(function (response) {
                                                if (response.status != 200) {
                                                    console.log('response status:' + response.status);
                                                    return;
                                                }
                                                console.log('response status:' + response.status);
                                                
                                                // location.reload();
                                            })
                                        }
                                        else {
                                            console.log("NO");
                                        }
                                    })
                                    //跳脫視窗中的JS
                                    let item = $('#photo').find('img');
                                    console.log(item.length);
                                    if (item.length == 0) {//假如form標籤內沒有input標籤,將沒有圖片這段話顯示出來
                                        let content = `<p id="msg">No Images here</p>`;
                                        $('#photo').prepend(content);
                                    }

                                    $('#insert').click(function () {
                                        let input = document.createElement("input");
                                        let buttonDelete = document.createElement("button");
                                        buttonDelete.innerHTML = "delete";
                                        buttonDelete.setAttribute('class', 'btnDelete')
                                        let tr = document.createElement("tr");
                                        let td = document.createElement("td");
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
                                        input.setAttribute('form', 'photo');
                                        //
                                        let item = $('#photo').find('input');
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
                                            let item = $('#photo').find('input');
                                            if (item.length == 0 && $('#photo').find('img').length == 0) {
                                                let content = `<p id="msg">No Images here</p>`;
                                                $('#photo').prepend(content);
                                            }
                                        })
                                    })
                                    //
                                })
                                $('#Modify').click(function () {//圖片點擊後會觸發事件 點擊後可以上傳想要的圖片
                                    //比較麻煩的地方是要存兩種資料
                                    //第一種是上傳上去的圖片資料(上傳後要改變圖片名稱)
                                    //第二種是要刪除的圖片路徑名稱(被更改的圖片需要被刪除)
                                    //將資料傳遞的位址是goodImagemodify.controller
                                    //傳遞出去的資料是商品編號、圖片資料
                                    //改變的瞬間透過ajax刪除資料
                                    let content = `<form method="" action="" enctype="multipart/form-data" id="ImageField">
                                                        <table>`;
                                    content = content + `<thead>
                                                            <th>圖片編號</th>
                                                            <th>預覽圖片</th>
                                                            <th>上傳按鈕</th>
                                                            <th hidden>傳給controller的資料</th>
                                                        </thead>`;
                                    //新的coding
                                    $.each(data, function (i, n) {
                                        content = content + `<tr>
                                                                <td>`+ n.goodImageID + `</td>
                                                                <td><img src=\"`+ n.imagePath + `\" alt="Image preview"
                                                                    style="height: 100px;width: 100px;" class="photo" /></td>
                                                                <td><input type="file" class="previewfile" name="photo`+ i +`" form="NO" /></td>
                                                                <td hidden><input type="text" name="ControllerData" value="" form="NO"></td>
                                                            </tr>`;
                                    })
                                    content = content + `</table>
                                                    </form>`;
                                    //新的coding
                                    Swal.fire({
                                        html: content,
                                        showCancelButton: true,
                                        showConfirmButton: true,
                                    }).then(function (result) {
                                        if (result.isConfirmed) {
                                            //裡邊用AJAX傳資料
                                            //需要"商品圖片編號","商品圖片資料"
                                            //傳遞位址是 goodImagedelete.controller
                                            //將另一個table內的數值取出來1.商品圖片編號2.商品圖片                                          
                                            let form = document.getElementById("ImageField");
                                            console.log(form);
                                            // let form = $('#ImageField');
                                            // let formDataID = produceJSON(formID);
                                            let formData = new FormData(form);
                                            fetch('goodImagemodify.controller', {
                                                method: 'POST',
                                                body: formData,
                                            }).then(function (response) {
                                                if (response.status != 200) {
                                                    console.log('response status:' + response.status);
                                                    return;
                                                }
                                                console.log('response status:' + response.status);
                                                // location.reload();
                                            })
                                        }
                                        else {
                                            console.log("NO");
                                        }
                                    })
                                    //跳脫視窗的JS
                                    $('.previewfile').change(function () {
                                        //處理圖片預覽
                                        let preview = $(this).closest('td').prev().children(0);//預覽圖片欄位
                                        console.log(preview);
                                        const reader = new FileReader();
                                        let file = $(this).prop("files");//取得input[type="file"]的files屬性
                                        console.log(file);
                                        if (file) {
                                            reader.readAsDataURL(file[0]);
                                        }
                                        reader.addEventListener('load', function () {
                                            preview.prop('src', reader.result);
                                        })
                                        //賦予form屬性
                                        $(this).attr('form', 'ImageField');//上傳圖片的欄位給予form屬性
                                        // $(this).closest('td').prev().prev().children(0).attr("form", 'ImageField');//圖片編號的欄位給予form屬性
                                        let imageID = $(this).closest('td').prev().prev().html().trim();
                                        rootname = $(this).prop('value');//因為在本地電腦上傳 路徑資料包含fakepath
                                        let ps = rootname.lastIndexOf('\\');
                                        let uplaodfilename = rootname.substring(ps + 1, rootname.length);//取得上傳檔案的名稱
                                        let imageDeleteControllerData = ID + "/" + imageID + "/" + uplaodfilename;//(goodID/goodImageID/uploadfilename)ex: 1/18/sharkitty.jpg
                                        $(this).closest('td').next().children(0).attr('value', imageDeleteControllerData)//賦予name屬性值為ControllerData的欄位
                                        $(this).closest('td').next().children(0).attr('form', 'ImageField');
                                    })
                                })
                                $('#Delete').click(function () {
                                    //圖片旁邊有input標籤 type屬性是checkbox 點擊你想刪除的圖片
                                    //將資料傳遞的位址是goodImagedelete.controller
                                    //傳遞出去資料有商品編號、圖片資料
                                    let content = `<form action="" id="ImageField" enctype="multipart/form-data" method="">
                                                    <table>`;
                                    //新的coding
                                    $.each(data, function (i, n) {
                                        content = content + `<tr>
                                                                <td><input type="checkbox" class="deleteMark"></td>
                                                                <td><img src="`+ n.imagePath + `" alt="` + n.imagePath + `" style="width: 150px;height: 150px;"></td>
                                                                <td hidden><input type="text" value="`+ n.goodImageID + `" form="NO" name="GoodImageID"></td>
                                                            </tr>`;
                                    })
                                    content = content + `<tr hidden><td colspan="3"><input type="text" value="` + ID + `" form="ImageField" name="GoodsID"></td></tr>` +
                                        `</table>`;
                                    Swal.fire({
                                        html: content,
                                        showCancelButton: true,
                                        showConfirmButton: true,
                                    }).then(function (result) {
                                        if (result.isConfirmed) {//裡邊用AJAX傳資料
                                            // let form = $('#ImageField');
                                            let form = document.getElementById("ImageField");
                                            let formData = new FormData(form);
                                            console.log(form);
                                            fetch('goodImagedelete.controller', {
                                                method: 'POST',
                                                body: formData,
                                            }).then(function (response) {
                                                if (response.status != 200) {
                                                    console.log('response status:' + response.status);
                                                    return;
                                                }
                                                console.log('response status:' + response.status);
                                            })
                                        }
                                        else {
                                            console.log("NO");
                                        }
                                    })
                                    //跳脫視窗的JS
                                    $('.deleteMark').click(function () {
                                        let imgs = $(this).closest('td').next().next().children();
                                        if ($(this).prop("checked")) {//有打勾的部分會被賦予form屬性
                                            console.log(imgs.prop("defaultValue"));
                                            imgs.attr("form", "ImageField");
                                        }
                                        else {//反之則拿掉form屬性
                                            console.log('false');
                                            imgs.attr("form", "NO");
                                        }
                                    })
                                })
                            }

                        }
                    })
                }
                /*處理規格表的部分*/

                /*處理規格表的部分*/
                function getValModify(tr) {
                    let td = tr.children;
                    let arrtd = [...td];
                    let arrVal = new Array(arrtd.length - 2);
                    for (let i = 0; i < arrtd.length - 4; i++) {//原本只有兩個功能，現在已經變成四個功能了
                        if(i==2){
                            let imagephotoselect = arrtd[i].children;
                            let arrimagephotoselect = [...imagephotoselect];
                            arrVal[i] = arrimagephotoselect[0].getAttribute("src");
                        }
                        else{
                            arrVal[i] = arrtd[i].innerHTML.trim();
                        }
                    }
                    return arrVal;
                }
                //編輯商品基本資訊
                function Modify(ID) {
                    let identify = "Modify" + ID;
                    let target = document.getElementById(identify);
                    console.log(target);
                    let tr = target.closest("tr");
                    let arrVal = getValModify(tr);
                    let [goodsID, goodsName, goodtitleImage, goodsDirection, goodsType, launchDate, brand, shipmentPlace, goodsSellerID] = arrVal;
                    console.log(goodtitleImage);
                    Swal.fire({
                        title: "編輯資料",
                        html: '<form method="" action="" enctype="multipart/form-data" id="field">' +
                            '<table border="1">' +
                            '<thead>' +
                            '<th colspan="2">商品基本資訊</th>' +
                            '</thead>' +
                            '<tbody>' +
                            '<tr>' +
                            '<td>商品編號</td>' +
                            '<td><input type="text" name="GoodsID" form="field" value="' + goodsID + '" readonly /></td>' +
                            '</tr>' +
                            '<tr>' +
                            '<td>輸入商品名字</td>' +
                            '<td><input type="text" name="GoodsName" form="field" value="' + goodsName + '" /></td>' +
                            '</tr>' +
                            '<tr>' +
                            `<td><img src=` + goodtitleImage + ` alt=` + goodtitleImage + ` class="img-fluid"></td>` +
                            '<td><input type="file" name="TitleImage" form="NO" id="goodtitleImages"></td>' +
                            '</tr>' +
                            '<tr>' +
                            '<td>書寫使用說明</td>' +
                            '<td><input type="text" name="GoodsDirection" form="field" value="' + goodsDirection + '" /></td>' +
                            '</tr>' +
                            '<tr>' +
                            '<td>商品種類 </td>' +
                            '<td><input type="text" name="GoodsType" form="field" value="' + goodsType + '" /></td>' +
                            '</tr>' +
                            '<tr>' +
                            '<td>上架日期 </td>' +
                            '<td><input type="date" name="LaunchDate" form="field" value="' + launchDate + '" /></td>' +
                            '</tr>' +
                            '<tr>' +
                            '<td>商品品牌</td>' +
                            '<td><input type="text" name="Brand" form="field" value="' + brand + '" /></td>' +
                            '</tr>' +
                            '<tr>' +
                            '<td>出發地</td>' +
                            '<td><input type="text" name="ShipmentPlace" form="field" value="' + shipmentPlace + '"/></td>' +
                            '</tr>' +
                            '</tbody>' +
                            '</table>' +
                            '</form>',
                        icon: "info",
                        showCancelButton: true,
                        showConfirmButton: true
                    }).then(function (result) {
                        if (result.isConfirmed) {
                            let form = document.getElementById("field");
                            let formData = new FormData(form);

                            fetch('goodupdate.controller', {
                                method: 'POST',
                                body: formData,
                            }).then(function (response) {
                                if (response.status != 200) {
                                    console.log('response status:' + response.status);
                                    return;
                                }
                                console.log('response status:' + response.status);
                                //location.reload();
                            })

                            console.log("選擇編輯");
                        }
                        else {
                            Swal.fire("您選擇了Cancel");
                        }
                    })
                    console.log($('#goodtitleImages'));
                    $('#goodtitleImages').change(function () {
                        //處理圖片預覽
                        let goodtitleImage = $(this).closest('td').prev().children(0);//預覽圖片欄位
                        console.log(goodtitleImage);
                        const reader = new FileReader();
                        let file = $(this).prop("files");//取得input[type="file"]的files屬性
                        console.log(file);
                        if (file) {
                            reader.readAsDataURL(file[0]);
                        }
                        reader.addEventListener('load', function () {
                            goodtitleImage.prop('src', reader.result);
                        })
                        //賦予form屬性
                        $(this).attr('form', 'field');//上傳圖片的欄位給予form屬性
                    })
                }
                //刪除時不只顯示商品編號 也要能看到對應商品編號的全部圖片
                //先透過ajax取得所有圖片
                function getValDelete(tr) {//當基本資料表的一筆資料被刪除時，連帶全部圖片都會被刪掉
                    let td = tr.children;
                    let arrtd = [...td];
                    let arrVal = new Array(arrtd.length - 2);
                    for (let i = 0; i < arrtd.length - 4; i++) {//原本只有兩個功能，現在已經變成四個功能了
                        arrVal[i] = arrtd[i].innerHTML.trim();
                    }
                    return arrVal;
                }
                function Delete(ID) {
                    let identify = "Delete" + ID;
                    let target = document.getElementById(identify);
                    let tr = target.closest("tr");
                    let arrVal = getValDelete(tr);
                    let [goodsID, goodsName, titleImage, goodsDirection, goodsType, launchDate, brand, shipmentPlace, goodsSellerID] = arrVal;
                    let contentroot = `<button id="photo">查看商品圖片</button>` +
                        '<form method="" action="" enctype="multipart/form-data" id="field">' +
                        '<table border="1">' +
                        '<thead>' +
                        '<th colspan="2">商品基本資訊</th>' +
                        '</thead>' +
                        '<tbody>' +
                        '<tr>' +
                        '<td>商品編號</td>' +
                        '<td><input type="text" name="GoodsID" form="field" value="' + goodsID + '" readonly /></td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td>商品名稱</td>' +
                        '<td>' + goodsName + '</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td>商品封面</td>' +
                        '<td><img src="'+ titleImage +'" alt="'+ titleImage +'"></td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td>商品說明</td>' +
                        '<td>' + goodsDirection + '</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td>商品種類</td>' +
                        '<td>' + goodsType + '</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td>上架日期</td>' +
                        '<td>' + launchDate + '</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td>商品品牌</td>' +
                        '<td>' + brand + '</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td>出貨地</td>' +
                        '<td>' + shipmentPlace + '</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td>賣家商品編號</td>' +
                        '<td>' + goodsSellerID + '</td>' +
                        '</tr>' +
                        '</tbody>' +
                        '</table>' +
                        '</form>' +
                        `<table>`;
                    //透過fetch取得圖片
                    $.ajax({

                        type: 'get',

                        url: '/good/goodImage/' + ID,//回傳取得所有圖片的路徑

                        contentType: 'application/json',

                        success: function (data) {
                            if (data == null) {//沒資料顯示No Images
                                //沒有資料的情況下無法修改和刪除
                                let content = contentroot + `<tr><td>No Images</td></tr>`;
                                Swal.fire({
                                    title: "刪除資料",
                                    html: content,
                                    icon: "info",
                                    showCancelButton: true,
                                    showConfirmButton: true,
                                }).then(function (result) {//只有將商品編號送出
                                    if (result.isConfirmed) {
                                        let form = document.getElementById("field");
                                        let formData = new FormData(form);
                                        fetch('gooddelete.controller', {
                                            method: 'POST',
                                            body: formData,
                                        }).then(function (response) {
                                            if (response.status != 200) {
                                                console.log('response status:' + response.status);
                                                return;
                                            }
                                            console.log('response status:' + response.status);
                                            location.reload();
                                        })
                                        console.log("選擇刪除");
                                    }
                                    else {
                                        Swal.fire("您選擇了Cancel");
                                    }
                                })
                            }
                            else {//有資料顯示所有圖片
                                let content = contentroot;
                                $.each(data, function (i, n) {
                                    content = content + `<tr><td><img src=` + n.imagePath + ` alt="` + n.imagePath + `" style="width: 150px;height: 150px;"></td></tr>`;
                                })
                                Swal.fire({
                                    title: "刪除資料",
                                    html: content,
                                    icon: "info",
                                    showCancelButton: true,
                                    showConfirmButton: true,
                                }).then(function (result) {//只有將商品編號送出
                                    if (result.isConfirmed) {
                                        let form = document.getElementById("field");
                                        let formData = new FormData(form);
                                        fetch('gooddelete.controller', {
                                            method: 'POST',
                                            body: formData,
                                        }).then(function (response) {
                                            if (response.status != 200) {
                                                console.log('response status:' + response.status);
                                                return;
                                            }
                                            console.log('response status:' + response.status);
                                            location.reload();
                                        })
                                        console.log("選擇刪除");
                                    }
                                    else {
                                        Swal.fire("您選擇了Cancel");
                                    }
                                })
                            }
                        }
                    })

                }
            </script>
        </head>

        <body>
            <button id="InsertGoodData">新增</button>
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