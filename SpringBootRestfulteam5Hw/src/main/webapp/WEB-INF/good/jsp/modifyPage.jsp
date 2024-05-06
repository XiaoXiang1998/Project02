<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="BIG5">
        <title>Insert title here</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
            integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
            crossorigin="anonymous" />
        <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
        <style>
            img {
                width: 150px;
                height: 150px;
            }

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
    </head>

    <body>
        <div id="GoodsID">${goodID}</div> <!-- 裡面放的是商品編號 -->
        <form id="GoodData" action="goodModify.controller" method="post" enctype="multipart/form-data">
            <!-- 假資料 -->
            <input type="checkbox" name="GoodDelete" class="form-check-input" checked value="-1">
            <input type="text" name="DeleteFormatDataById" class="form-control" value="-1">
            <!--  -->
            <input type="text" class="form-control" value="" name="GoodsID" id="GoodsIDFromController">
            <fieldset class="border p-2 mb-3">
                <legend class="float-none w-auto">商品圖片</legend>
                <div class="form-group" id="GoodPhoto">
                    <button type="button" class="btn btn-primary" id="insertPhoto">新增圖片</button>
                    <div id="photoData">
                    </div>
                    <div id="photoPreviewList">
                        <!-- 新的coding -->
                        <div class="row row-cols-4" id="photoPreviewListChildren">

                        </div>
                        <!-- 新的coding -->
                    </div>
                    <div id="hiddenGoodImageData">
                        <!--  -->
                        <input type="text" class="form-control" value="-1" name="GoodDelete" hidden>
                        <!--  -->
                    </div>
                </div>
            </fieldset>
            <fieldset class="border p-2 mb-3">
                <legend class="float-none w-auto">商品基本資訊</legend>
                <div class="form-group" id="GoodBasic">
                    <div class="form-floating mb-3">
                        <input type="text" name="GoodsName" class="form-control" id="GoodsName" value="">
                        <label for="GoodsName">商品名稱</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="text" name="GoodsType" class="form-control" id="GoodsType" value="">
                        <label for=" GoodsType">商品種類</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="date" name="LaunchDate" class="form-control" id="LaunchDate" value="">
                        <label for="LaunchDate">上架日期</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="text" name="Brand" class="form-control" id="Brand" value="">
                        <label for="Brand">品牌</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="text" name="ShipmentPlace" class="form-control" id="ShipmentPlace" value="">
                        <label for="ShipmentPlace">出貨地</label>
                    </div>
                    <div class="form-floating mb-3">
                        <img src="" alt="" data-name="titleImagetarget" id="TitleImageTarget">
                        <input type="file" name="TitleImage" class="form-control" id="TitleImage" value="">
                        <label for=" TitleImage">商品封面</label>
                    </div>
                    <div id="container" class="form-floating mb-3">
                        <div id="editor">
                            <p>HI sharkitty</p>
                        </div>
                    </div>
                    <input type="text" name="GoodDirection" class="form-control" id="GoodDirection" value="" hidden>
                </div>
            </fieldset>
            <fieldset class="border p-2">
                <legend class="float-none w-auto">商品規格表</legend>
                <div class="form-group" id="GoodFormat">
                    <button type="button" class="btn btn-primary mb-3" id="insertFormatImage">新增規格圖片</button>
                    <!-- <input type="file">放在這邊 -->
                    <div class="row row-col-2" id="tranferToFormatTable">
                        <!-- 裡面放圖片 -->
                    </div>
                    <table class="table table-bordered mt-3" id="FormatTable">
                        <thead>
                            <th>規格圖片</th>
                            <th>商品大小</th>
                            <th>商品價格</th>
                            <th>商品庫存數</th>
                            <th>刪除規格</th>
                            <th>新增規格</th>
                            <th>隱藏資料</th>
                        </thead>
                        <tbody id="formatdata">

                        </tbody>
                    </table>
                    <div class="row" id="DeleteFormatDataTransfer"> <!-- 當有規格資料被刪除時 規格表編號會被丟進這裡 -->
                    </div>
                </div>
            </fieldset>

            <button type="button" class="btn btn-primary" id="outputGoodData">Submit</button>
        </form>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
        <script src="https://cdn.ckeditor.com/ckeditor5/41.3.1/super-build/ckeditor.js"></script>
        <script>
            let editor;
            CKEDITOR.ClassicEditor.create(document.getElementById("editor"), {
                // https://ckeditor.com/docs/ckeditor5/latest/features/toolbar/toolbar.html#extended-toolbar-configuration-format
                toolbar: {
                    items: [
                        'exportPDF', 'exportWord', '|',
                        'findAndReplace', 'selectAll', '|',
                        'heading', '|',
                        'bold', 'italic', 'strikethrough', 'underline', 'code', 'subscript', 'superscript', 'removeFormat', '|',
                        'bulletedList', 'numberedList', 'todoList', '|',
                        'outdent', 'indent', '|',
                        'undo', 'redo',
                        '-',
                        'fontSize', 'fontFamily', 'fontColor', 'fontBackgroundColor', 'highlight', '|',
                        'alignment', '|',
                        'link', 'uploadImage', 'blockQuote', 'insertTable', 'mediaEmbed', 'codeBlock', 'htmlEmbed', '|',
                        'specialCharacters', 'horizontalLine', 'pageBreak', '|',
                        'textPartLanguage', '|',
                        'sourceEditing'
                    ],
                    shouldNotGroupWhenFull: true
                },
                // Changing the language of the interface requires loading the language file using the <script> tag.
                // language: 'es',
                list: {
                    properties: {
                        styles: true,
                        startIndex: true,
                        reversed: true
                    }
                },
                // https://ckeditor.com/docs/ckeditor5/latest/features/headings.html#configuration
                heading: {
                    options: [
                        { model: 'paragraph', title: 'Paragraph', class: 'ck-heading_paragraph' },
                        { model: 'heading1', view: 'h1', title: 'Heading 1', class: 'ck-heading_heading1' },
                        { model: 'heading2', view: 'h2', title: 'Heading 2', class: 'ck-heading_heading2' },
                        { model: 'heading3', view: 'h3', title: 'Heading 3', class: 'ck-heading_heading3' },
                        { model: 'heading4', view: 'h4', title: 'Heading 4', class: 'ck-heading_heading4' },
                        { model: 'heading5', view: 'h5', title: 'Heading 5', class: 'ck-heading_heading5' },
                        { model: 'heading6', view: 'h6', title: 'Heading 6', class: 'ck-heading_heading6' }
                    ]
                },
                // https://ckeditor.com/docs/ckeditor5/latest/features/editor-placeholder.html#using-the-editor-configuration
                placeholder: '請輸入商品描述',
                // https://ckeditor.com/docs/ckeditor5/latest/features/font.html#configuring-the-font-family-feature
                fontFamily: {
                    options: [
                        'default',
                        'Arial, Helvetica, sans-serif',
                        'Courier New, Courier, monospace',
                        'Georgia, serif',
                        'Lucida Sans Unicode, Lucida Grande, sans-serif',
                        'Tahoma, Geneva, sans-serif',
                        'Times New Roman, Times, serif',
                        'Trebuchet MS, Helvetica, sans-serif',
                        'Verdana, Geneva, sans-serif'
                    ],
                    supportAllValues: true
                },
                // https://ckeditor.com/docs/ckeditor5/latest/features/font.html#configuring-the-font-size-feature
                fontSize: {
                    options: [10, 12, 14, 'default', 18, 20, 22],
                    supportAllValues: true
                },
                // Be careful with the setting below. It instructs CKEditor to accept ALL HTML markup.
                // https://ckeditor.com/docs/ckeditor5/latest/features/general-html-support.html#enabling-all-html-features
                htmlSupport: {
                    allow: [
                        {
                            name: /.*/,
                            attributes: true,
                            classes: true,
                            styles: true
                        }
                    ]
                },
                // Be careful with enabling previews
                // https://ckeditor.com/docs/ckeditor5/latest/features/html-embed.html#content-previews
                htmlEmbed: {
                    showPreviews: true
                },
                // https://ckeditor.com/docs/ckeditor5/latest/features/link.html#custom-link-attributes-decorators
                link: {
                    decorators: {
                        addTargetToExternalLinks: true,
                        defaultProtocol: 'https://',
                        toggleDownloadable: {
                            mode: 'manual',
                            label: 'Downloadable',
                            attributes: {
                                download: 'file'
                            }
                        }
                    }
                },
                // https://ckeditor.com/docs/ckeditor5/latest/features/mentions.html#configuration
                mention: {
                    feeds: [
                        {
                            marker: '@',
                            feed: [
                                '@apple', '@bears', '@brownie', '@cake', '@cake', '@candy', '@canes', '@chocolate', '@cookie', '@cotton', '@cream',
                                '@cupcake', '@danish', '@donut', '@dragée', '@fruitcake', '@gingerbread', '@gummi', '@ice', '@jelly-o',
                                '@liquorice', '@macaroon', '@marzipan', '@oat', '@pie', '@plum', '@pudding', '@sesame', '@snaps', '@soufflé',
                                '@sugar', '@sweet', '@topping', '@wafer'
                            ],
                            minimumCharacters: 1
                        }
                    ]
                },
                // The "superbuild" contains more premium features that require additional configuration, disable them below.
                // Do not turn them on unless you read the documentation and know how to configure them and setup the editor.
                removePlugins: [
                    // These two are commercial, but you can try them out without registering to a trial.
                    // 'ExportPdf',
                    // 'ExportWord',
                    'AIAssistant',
                    'CKBox',
                    'CKFinder',
                    'EasyImage',
                    // This sample uses the Base64UploadAdapter to handle image uploads as it requires no configuration.
                    // https://ckeditor.com/docs/ckeditor5/latest/features/images/image-upload/base64-upload-adapter.html
                    // Storing images as Base64 is usually a very bad idea.
                    // Replace it on production website with other solutions:
                    // https://ckeditor.com/docs/ckeditor5/latest/features/images/image-upload/image-upload.html
                    // 'Base64UploadAdapter',
                    'MultiLevelList',
                    'RealTimeCollaborativeComments',
                    'RealTimeCollaborativeTrackChanges',
                    'RealTimeCollaborativeRevisionHistory',
                    'PresenceList',
                    'Comments',
                    'TrackChanges',
                    'TrackChangesData',
                    'RevisionHistory',
                    'Pagination',
                    'WProofreader',
                    // Careful, with the Mathtype plugin CKEditor will not load when loading this sample
                    // from a local file system (file://) - load this site via HTTP server if you enable MathType.
                    'MathType',
                    // The following features are part of the Productivity Pack and require additional license.
                    'SlashCommand',
                    'Template',
                    'DocumentOutline',
                    'FormatPainter',
                    'TableOfContents',
                    'PasteFromOfficeEnhanced',
                    'CaseChange'
                ]

            }).then(newEditor => {
                editor = newEditor;
            }).catch(error => {
                console.error(error);
            });

            //////////////////////////////////////////////////////////////////////////////////////
            let GoodID = $('#GoodsID').html().trim();
            $('#GoodsIDFromController').prop("value", GoodID);

            $.ajax({
                type: "get",
                url: "/goodImage/" + GoodID,//透過商品編號取得所有圖片
                contentType: 'application/json',
                success: function (data) {
                    $.each(data, function (i, n) {//將所有input標籤塞入
                        let nameField = "GoodImages" + i;
                        let hiddenName = "GoodImageshidden" + i;
                        let content = `<input type="file" name="` + nameField + `" class="form-control" value="">`;//input標籤置入
                        let previewContent = `<img src="` + n.imagePath + `" alt="` + n.imagePath + `" data-index="` + i + `">`;//img標籤置入
                        let hiddenVal = `<input type="text" name="` + hiddenName + `" class="form-control" value="` + n.goodImageID + `">`;//將商品圖片編號置入
                        $('#photoData').append(content);
                        // 新的coding
                        let divcol = document.createElement("div"); divcol.classList.add("col");
                        let divformcheck = document.createElement("div"); divformcheck.classList.add("form-check");
                        let inputformcheck = document.createElement("input"); inputformcheck.classList.add("form-check-input"); inputformcheck.setAttribute("type", "checkbox"); inputformcheck.setAttribute("value", n.goodImageID); inputformcheck.setAttribute("name", "GoodDelete");
                        divcol.append(divformcheck); divformcheck.append(inputformcheck);
                        divformcheck.innerHTML = divformcheck.innerHTML + previewContent;
                        $('#photoPreviewListChildren').append(divcol);
                        // $('#photoPreviewList').append(previewContent);
                        $('#hiddenGoodImageData').append(hiddenVal);
                    })
                }
            })
            $.ajax({
                type: "get",
                url: "/good/" + GoodID,//透過商品編號取得商品基本資訊
                contentType: 'application/json',
                success: function (data) {
                    console.log(data.goodsName);
                    let GoodName = data.goodsName; $('#GoodsName').prop("value", GoodName);
                    let GoodsType = data.goodsType; $('#GoodsType').prop("value", GoodsType);
                    let LaunchDate = data.launchDate; $('#LaunchDate').prop("value", LaunchDate)
                    let Brand = data.brand; $('#Brand').prop("value", Brand);
                    let ShipmentPlace = data.shipmentPlace; $('#ShipmentPlace').prop("value", ShipmentPlace);
                    let TitleImage = data.titleImage; $('#TitleImageTarget').prop("src", TitleImage); $('#TitleImage').prop("alt", TitleImage);
                    let GoodDirection = data.goodsDirection;

                    $('#editor').append(GoodDirection);
                    // console.log($('#editor').html());
                }
            })
            $.ajax({
                type: "get",
                url: "/goodformatHI/" + GoodID,//透過商品編號取得商品規格表
                contentType: 'application/json',
                success: function (data) {
                    //處理規格表資訊
                    var check = "";
                    var index = 1; record = {};
                    var NumFormat = 0;
                    var boundLengthData = data.length;
                    $.each(data, function (i, n) {
                        let pos = n.goodImagePath.lastIndexOf("/");
                        let imagePathalt = n.goodImagePath.substring(pos + 1);
                        if (check != imagePathalt) {//處理規格表內的資料
                            if (i == 1) {//第一筆資料需要做BC處理
                                let content = `<tr>
                                                <td rowspan="1"><img src="`+ n.goodImagePath + `" alt="` + n.goodImagePath + `" data-index="` + (index - 1) + `" data-imgname="` + imagePathalt + `">
                                                <td><input type="text" name="GoodSize" value="`+ n.goodSize + `" class="form-control"></td>
                                                <td><input type="text" name="GoodPrice" value="`+ n.goodPrice + `" class="form-control"></td>
                                                <td><input type="text" name="GoodsStock" value="`+ n.goodsStock + `" class="form-control"></td>
                                                <td><button type="button" class="btn btn-primary deleteformatbtn">刪除</button></td>
                                                <td rowspan="1"><button type="button" class="btn btn-primary insertformatbtn">新增</button></td>
                                                <td><input type="text" name="hiddenValue" value="NO" class="form-control hiddenData"></td>
                                                <td><input type="text" name="formatID" value="`+ n.formatID + `" class="form-control"></td>
                                            </tr>`;
                                NumFormat++;
                                check = imagePathalt;
                                record[index - 1] = { imageName: check, Num: "" };
                                $('#formatdata').append(content);

                                let inputcontent = `<div class="col-6"><input type="file" name="GoodFormatImages` + (index - 1) + `" class="form-control InsertPhotoData"></div>`;
                                $('#tranferToFormatTable').append(inputcontent);
                            }
                            else {//當圖片從aaa.jpg變成bbb.jpg時 紀錄該圖片有幾筆規格
                                index++;//當圖片更改時 圖片索引值+1
                                let content = `<tr>` +
                                    `<td rowspan="1"><img src="` + n.goodImagePath + `" alt="` + n.goodImagePath + `" data-index="` + (index - 1) + `" data-imgname="` + imagePathalt + `"></td>` +
                                    `<td><input type="text" name="GoodSize" value="` + n.goodSize + `" class="form-control"></td>` +
                                    `<td><input type="text" name="GoodPrice" value="` + n.goodPrice + `" class="form-control"></td>` +
                                    `<td><input type="text" name="GoodsStock" value="` + n.goodsStock + `" class="form-control"></td>` +
                                    `<td><button type="button" class="btn btn-primary deleteformatbtn">刪除</button></td>` +
                                    `<td rowspan="1"><button type="button" class="btn btn-primary insertformatbtn">新增</button></td>` +
                                    `<td><input type="text" name="hiddenValue" value="NO" class="form-control hiddenData"></td>` +
                                    `<td><input type="text" name="formatID" value="` + n.formatID + `" class="form-control"></td>` +
                                    `</tr>`;
                                $('#formatdata').append(content);
                                record[index - 2] = { imageName: check, Num: NumFormat };//紀錄aaa.jpg對應的規格數量
                                NumFormat = 1;//bbb.jpg至少有一張圖片
                                check = imagePathalt;
                                //input標籤插入 $('#tranferToFormatTable')
                                let inputcontent = `<div class="col-6"><input type="file" name="GoodFormatImages` + (index - 1) + `" class="form-control InsertPhotoData"></div>`;
                                $('#tranferToFormatTable').append(inputcontent);
                            }
                        }
                        else {//當得到的圖片和上一張一樣時
                            let content = `<tr>` +
                                // `<td><img src="` + n.goodImagePath + `" alt="` + n.goodImagePath + `" data-index="` + index + `">` +
                                `<td><input type="text" name="GoodSize" value="` + n.goodSize + `" class="form-control"></td>` +
                                `<td><input type="text" name="GoodPrice" value="` + n.goodPrice + `" class="form-control"></td>` +
                                `<td><input type="text" name="GoodsStock" value="` + n.goodsStock + `" class="form-control"></td>` +
                                `<td><button type="button" class="btn btn-primary deleteformatbtn">刪除</button></td>` +
                                // `<td><button type="button" class="btn btn-primary insertformatbtn">新增</button></td>` +
                                `<td><input type="text" name="hiddenValue" value="NO" class="form-control hiddenData"></td>` +
                                `<td><input type="text" name="formatID" value="` + n.formatID + `" class="form-control"></td>` +
                                `</tr>`;
                            $('#formatdata').append(content);
                            console.log("boundLengthData = " + boundLengthData);
                            console.log("i=" + i);
                            if (i == boundLengthData - 1) {//當i = boundLengthData-1;代表取完所有資料 假若ddd.jpg是最後一張圖片 記錄下其對應的規格數量
                                NumFormat++;
                                record[index - 1] = { imageName: check, Num: NumFormat };//紀錄ddd.jpg對應的規格數量
                            }
                            else {//數量+1
                                NumFormat++;
                            }
                        }
                    })
                    //找到img標籤以上的td標籤
                    console.log(record);
                    let targetimg = $(document).find('img[data-imgname]');
                    console.log(targetimg);
                    let arrtargetimg = [...targetimg];
                    arrtargetimg.forEach(function (elem, index) {//elem是img標籤
                        let check = elem.getAttribute("data-imgname");
                        console.log("check = " + check);
                        for (item in record) {
                            if (record[item].imageName == check) {
                                console.log("record[item].imageName = " + record[item].imageName);
                                let targetTd = elem.closest('td');
                                let targetTdFunc = targetTd.closest('tr').children[5];
                                // console.log(targetTdFunc);
                                targetTdFunc.setAttribute("rowspan", record[item].Num);
                                targetTd.setAttribute("rowspan", record[item].Num);
                                break;
                            }
                        }
                    })
                }
            })
            //
            $(document).on('click', '.deleteformatbtn', function () {
                let formatdata = $(this).closest('tr');//該列的資料
                //尋找該列的規格表編號
                if ([...formatdata.children()].length == 6) {
                    console.log([...[...formatdata.children()][5].children][0].getAttribute("value"));//取得表格編號
                    let formatID = [...[...formatdata.children()][5].children][0].getAttribute("value");
                    // console.log(formatdata);
                    // formatdata.prop("innerHTML", "");
                    if (formatID == null) {

                    }
                    else {
                        let divformat = document.createElement('div');
                        divformat.classList.add('col');
                        let inputformatID = document.createElement('input');
                        inputformatID.setAttribute("type", "text"); inputformatID.setAttribute("name", "DeleteFormatDataById"); inputformatID.setAttribute("value", formatID);
                        inputformatID.classList.add("form-control");
                        divformat.append(inputformatID);
                        $('#DeleteFormatDataTransfer').append(divformat);
                    }
                }
                else {
                    if ([...formatdata.children()].length == 8) {
                        console.log([...[...formatdata.children()][7].children][0].getAttribute("value"));
                        let formatID = [...[...formatdata.children()][7].children][0].getAttribute("value");
                        // let nexttr = $(this).closest('tr').next();
                        // let arrnexttd = [...nexttr.children()];
                        // let reserveSize = arrnexttd[0].getAttribute("value");
                        // let reservePrice = arrnexttd[1].getAttribute("value");
                        // let reserveStock = arrnexttd[2].getAttribute("value");
                        // let reserveHidden = arrnexttd[4].getAttribute("value");
                        // let reserveGoodID = arrnexttd[5].getAttribute("value");
                        // [...[...formatdata.children()][1].children][0].setAttribute("value", reserveSize);
                        // [...[...formatdata.children()][2].children][0].setAttribute("value", reservePrice);
                        // [...[...formatdata.children()][3].children][0].setAttribute("value", reserveStock);
                        // [...[...formatdata.children()][6].children][0].setAttribute("value", reserveHidden);
                        // [...[...formatdata.children()][7].children][0].setAttribute("value", reserveGoodID);
                        if (formatID == null) {

                        } else {
                            let divformat = document.createElement('div');
                            divformat.classList.add('col');
                            let inputformatID = document.createElement('input');
                            inputformatID.setAttribute("type", "text"); inputformatID.setAttribute("name", "DeleteFormatDataById"); inputformatID.setAttribute("value", formatID);
                            inputformatID.classList.add("form-control");
                            divformat.append(inputformatID);
                            $('#DeleteFormatDataTransfer').append(divformat);
                        }
                    }
                }

                //
                [...formatdata.children()][0].getAttribute("rowspan");
                //處理該規格只有一項的案例 在點擊一次直接刪除(並且存放在id = "tranferToFormatTable" 的對應input標籤要刪除)
                if (formatdata.children().length == 8) {
                    if ([...formatdata.children()][0].getAttribute("rowspan") == 1 || [...formatdata.children()][0].getAttribute("rowspan") == null) {//點擊有8個td的資料列 並且 該圖片只有一筆資料
                        let previewformdata = formatdata;
                        let arrFormTd = [...previewformdata.children()];//得到td
                        console.log([...arrFormTd[0].children][0]);
                        //讀取img標籤中的自訂義index屬性後 將該筆資料刪除
                        let index = [...arrFormTd[0].children][0].getAttribute("data-index");
                        let idenifier = "GoodFormatImages" + index;
                        formatdata.prop("outerHTML", "");
                        //假若table裡面沒有任何資料 將table全部刪掉
                        console.log($('#formatdata').find('tr').length);
                        if ($('#formatdata').find('tr').length == 0) {
                            $('#FormatTable').prop("outerHTML", "");
                            let target = $('#tranferToFormatTable').find('input[name="' + idenifier + '"]');
                            let div0 = target.closest('div');
                            console.log(div0);
                            div0.prop("outerHTML", "");
                        }
                        else {
                            //找出存放在id = "tranferToFormatTable"(div標籤)中所對應的input標籤
                            console.log('input[name="' + idenifier + '"]');
                            let target = $('#tranferToFormatTable').find('input[name="' + idenifier + '"]');
                            let div0 = target.closest('div');
                            console.log(div0);
                            div0.prop("outerHTML", "");
                            console.log(target);
                        }
                    }
                    else {//假若仍有超過一筆資料
                        let nextdata = $(this).closest('tr').next();
                        let arrnextdata = [...nextdata.children()];
                        console.log([...arrnextdata[0].children][0].getAttribute("value"));
                        //取得下一個tr標籤的屬性
                        let size = [...arrnextdata[0].children][0].getAttribute("value"); console.log(size);
                        let price = [...arrnextdata[1].children][0].getAttribute("value"); console.log(price);
                        let stock = [...arrnextdata[2].children][0].getAttribute("value"); console.log(stock);
                        let hiddenValue = [...arrnextdata[4].children][0].getAttribute("value"); console.log(hiddenValue);
                        let formatID = [...arrnextdata[5].children][0].getAttribute("value"); console.log(formatID);

                        //將取得的屬性值填入第一列
                        let arrtargettd = [...formatdata.children()];//裡面是td標籤
                        let input1 = arrtargettd[1].children[0];
                        console.log(input1);
                        arrtargettd[1].children[0].setAttribute("value", size);
                        arrtargettd[2].children[0].setAttribute("value", price);
                        arrtargettd[3].children[0].setAttribute("value", stock);
                        arrtargettd[6].children[0].setAttribute("value", hiddenValue);
                        arrtargettd[7].children[0].setAttribute("value", formatID);

                        let rowspanNum = arrtargettd[0].getAttribute("rowspan");
                        console.log(rowspanNum);
                        //將
                        nextdata.prop("outerHTML", "");//將第二列的資料刪除
                        arrtargettd[0].setAttribute("rowspan", rowspanNum - 1);
                        arrtargettd[5].setAttribute("rowspan", rowspanNum - 1);
                    }
                }
                else {
                    let previewformdata = formatdata.prev();
                    while (previewformdata.children().length == 6) {//
                        previewformdata = previewformdata.prev();
                    }
                    formatdata.prop("outerHTML", "");
                    let arrFormTd = [...previewformdata.children()];//得到td
                    let rowspanNum = arrFormTd[0].getAttribute("rowspan");
                    arrFormTd[0].setAttribute("rowspan", rowspanNum - 1);
                    arrFormTd[5].setAttribute("rowspan", rowspanNum - 1);
                }
            })
            //
            $(document).on('click', '.insertformatbtn', function () {
                let tr = document.createElement('tr');
                let td1 = document.createElement('td');
                let td2 = document.createElement('td');
                let td3 = document.createElement('td');
                let td4 = document.createElement('td');
                let td5 = document.createElement('td');//隱藏標籤
                let td6 = document.createElement('td');//規格表編號
                //
                let previewformdata;
                let formatdata = $(this).closest('tr');//該列的資料
                if (formatdata.children().length == 8) {
                    previewformdata = formatdata;
                } else {
                    previewformdata = formatdata.prev();
                    while (previewformdata.children().length == 6) {//
                        previewformdata = previewformdata.prev();
                    }
                }
                //

                let arrFormTd = [...previewformdata.children()];//得到td
                console.log(arrFormTd);
                let rowspanNum = arrFormTd[0].getAttribute("rowspan");
                if (rowspanNum == null) {
                    rowspanNum++;
                }
                else {//將字串轉數字
                    rowspanNum = Number.parseInt(rowspanNum);
                }
                arrFormTd[0].setAttribute("rowspan", rowspanNum + 1);
                arrFormTd[5].setAttribute("rowspan", rowspanNum + 1);
                //建立input標籤 和 button標籤
                let input1 = document.createElement('input'); input1.setAttribute("type", "text"); input1.setAttribute("required", true); input1.setAttribute("name", "GoodSize"); input1.setAttribute("value", ""); input1.classList.add("form-control");
                let input2 = document.createElement('input'); input2.setAttribute("type", "text"); input2.setAttribute("required", true); input2.setAttribute("name", "GoodPrice"); input2.setAttribute("value", ""); input2.classList.add("form-control");
                let input3 = document.createElement('input'); input3.setAttribute("type", "text"); input3.setAttribute("required", true); input3.setAttribute("name", "GoodsStock"); input3.setAttribute("value", ""); input3.classList.add("form-control");
                let btnDelete = document.createElement('button'); btnDelete.setAttribute("type", "button"); btnDelete.innerHTML = "刪除"; btnDelete.classList.add("btn"); btnDelete.classList.add("btn-primary"); btnDelete.classList.add("deleteformatbtn");
                //隱藏標籤
                let input4 = document.createElement('input'); input4.setAttribute("type", "text"); input4.setAttribute("required", true); input4.setAttribute("name", "hiddenValue"); input4.classList.add("form-control"); input4.classList.add("hiddenData");
                //規格編號
                let input5 = document.createElement('input'); input5.setAttribute("type", "text"); input5.setAttribute("name", "formatID"); input5.classList.add("form-control");

                console.log();
                let check = [...arrFormTd[0].children][0].getAttribute("src")
                if (check == null) {//假若圖片不存在 value給定為0
                    input4.setAttribute("value", "");
                } else {
                    //將圖片名稱放入隱藏資料表欄位
                    let uploadNameHI = [...arrFormTd[0].children][0].getAttribute("data-imgname");
                    // let pos = uploadNameHI.lastIndexOf("/");
                    // input4.setAttribute("value", uploadNameHI.substring(pos + 1));
                    input4.setAttribute("value", uploadNameHI);
                }
                //將input標籤和button標籤插入td標籤 將td標籤插入tr標籤
                td1.append(input1); td2.append(input2); td3.append(input3); td4.append(btnDelete); td5.append(input4); td6.append(input5);
                tr.append(td1); tr.append(td2); tr.append(td3); tr.append(td4); tr.append(td5); tr.append(td6);
                formatdata.after(tr);
                // $('#formatdata').append(tr);
            })

            //
            $('#insertFormatImage').click(function () {
                console.log($('#FormatTable').length);
                if ($('#FormatTable').length == 0) {//一開始建立規格表時沒有table
                    //確認圖片數量
                    let photoNumber = $('#tranferToFormatTable').find("div").length;//代表圖片數量
                    //建立放入id="tranferToFormatTable" 的div標籤 和 input標籤
                    let div0 = document.createElement('div');
                    div0.classList.add("col-6");
                    let input0 = document.createElement('input');
                    let input0attrName = "GoodFormatImages";
                    input0.setAttribute("type", "file");
                    input0.setAttribute("required", true);
                    input0.setAttribute("name", input0attrName + "" + (photoNumber + 1));
                    input0.classList.add("form-control"); input0.classList.add("InsertPhotoData");
                    //建立table標籤 thead標籤 tbody標籤
                    let table = document.createElement('table');
                    table.setAttribute("id", "FormatTable");
                    table.classList.add("table");
                    table.classList.add("table-bordered");
                    table.classList.add("mt-3");
                    let thead = document.createElement('thead');
                    let tbody = document.createElement('tbody');
                    tbody.setAttribute("id", "formatdata");
                    //建立th標籤
                    let th1 = document.createElement('th'); th1.innerHTML = "規格圖片";
                    let th2 = document.createElement('th'); th2.innerHTML = "商品大小";
                    let th3 = document.createElement('th'); th3.innerHTML = "商品價格";
                    let th4 = document.createElement('th'); th4.innerHTML = "商品庫存數";
                    let th5 = document.createElement('th'); th5.innerHTML = "刪除規格";
                    let th6 = document.createElement('th'); th6.innerHTML = "新增規格";
                    let th7 = document.createElement('th'); th7.innerHTML = "隱藏資料"; //th7.setAttribute("hidden", true);
                    let th8 = document.createElement('th'); th8.innerHTML = "規格表編號";
                    console.log(th8);
                    //建立tr 和 td標籤
                    let tr = document.createElement('tr');
                    let td1 = document.createElement('td'); let td2 = document.createElement('td'); let td3 = document.createElement('td');
                    let td4 = document.createElement('td'); let td5 = document.createElement('td'); let td6 = document.createElement('td');
                    let td7 = document.createElement('td'); let td8 = document.createElement('td');
                    // input0插入在<div class="row row-col-2">
                    div0.append(input0);
                    $('#tranferToFormatTable').append(div0);
                    //建立input標籤和button標籤
                    let input2 = document.createElement('input'); input2.setAttribute("type", "text"); input2.setAttribute("required", true); input2.setAttribute("name", "GoodSize"); input2.setAttribute("value", "");
                    input2.classList.add("form-control");
                    let input3 = document.createElement('input'); input3.setAttribute("type", "text"); input3.setAttribute("required", true); input3.setAttribute("name", "GoodPrice"); input3.setAttribute("value", "");
                    input3.classList.add("form-control");
                    let input4 = document.createElement('input'); input4.setAttribute("type", "text"); input4.setAttribute("required", true); input4.setAttribute("name", "GoodsStock"); input4.setAttribute("value", "");
                    input4.classList.add("form-control");
                    let btnDelete = document.createElement('button'); btnDelete.setAttribute("type", "button"); btnDelete.innerHTML = "刪除"; btnDelete.classList.add("btn"); btnDelete.classList.add("btn-primary"); btnDelete.classList.add("deleteformatbtn");
                    let btnInsert = document.createElement('button'); btnInsert.setAttribute("type", "button"); btnInsert.innerHTML = "新增"; btnInsert.classList.add("btn"); btnInsert.classList.add("btn-primary"); btnInsert.classList.add("insertformatbtn");
                    //隱藏欄位
                    let input7 = document.createElement('input'); input7.setAttribute("type", "text"); input7.setAttribute("required", true); input7.setAttribute("name", "hiddenValue"); input7.classList.add("form-control"); input7.classList.add("hiddenData");
                    //規格表編號
                    let input8 = document.createElement('input'); input8.setAttribute("type", "text"); input8.setAttribute("name", "formatID"); input8.setAttribute("readonly", true); input8.classList.add("form-control");

                    //剩下的插入在table標籤內
                    table.append(thead);
                    thead.append(th1); thead.append(th2); thead.append(th3); thead.append(th4); thead.append(th5); thead.append(th6); thead.append(th7); thead.append(th8);
                    table.append(tbody);
                    tbody.append(tr);
                    tr.append(td1); tr.append(td2); tr.append(td3); tr.append(td4); tr.append(td5); tr.append(td6); tr.append(td7); tr.append(td8);
                    // 需要加入img標籤(預覽圖片用的) 
                    td2.append(input2); td3.append(input3); td4.append(input4); td5.append(btnDelete); td6.append(btnInsert); td7.append(input7); td8.append(input8);
                    $('#GoodFormat').append(table);
                    //建立img標籤並且自訂義屬性(data-index) 目標是對應放入id="tranferToFormatTable" 的div標籤
                    // td1插入圖片
                    let pattern = document.createElement("img");
                    pattern.setAttribute("style", "height: 100px;width: 100px;");
                    pattern.setAttribute("src", "");
                    pattern.setAttribute("alt", "");
                    pattern.setAttribute("data-index", (photoNumber + 1) + "");
                    //<img src="../../goodImages/20240428232110542.jpg" alt="">
                    td1.append(pattern);
                    //處理圖片預覽
                }
                else {
                    let tbody = $('#formatdata');
                    //查詢該表的編號屬性最大值是多少
                    let photoNumber = $('#tranferToFormatTable').find("div").length;//代表圖片數量
                    //
                    let div0 = document.createElement('div');
                    div0.classList.add("col-6");
                    let input0 = document.createElement('input');
                    let input0attrName = "GoodFormatImages";//
                    input0.setAttribute("type", "file");
                    input0.setAttribute("required", true);
                    input0.setAttribute("name", input0attrName + "" + (photoNumber + 1));
                    input0.classList.add("form-control"); input0.classList.add("InsertPhotoData");
                    //建立tr 和 td標籤
                    let tr = document.createElement('tr');
                    let td1 = document.createElement('td'); let td2 = document.createElement('td'); let td3 = document.createElement('td');
                    let td4 = document.createElement('td'); let td5 = document.createElement('td'); let td6 = document.createElement('td');
                    let td7 = document.createElement('td'); let td8 = document.createElement('td');
                    // input0插入在<div class="row row-col-2">
                    div0.append(input0);
                    $('#tranferToFormatTable').append(div0);
                    //建立input標籤和button標籤
                    let input2 = document.createElement('input'); input2.setAttribute("type", "text"); input2.setAttribute("required", true); input2.setAttribute("name", "GoodSize"); input2.setAttribute("value", "");
                    input2.classList.add("form-control");
                    let input3 = document.createElement('input'); input3.setAttribute("type", "text"); input3.setAttribute("required", true); input3.setAttribute("name", "GoodPrice"); input3.setAttribute("value", "");
                    input3.classList.add("form-control");
                    let input4 = document.createElement('input'); input4.setAttribute("type", "text"); input4.setAttribute("required", true); input4.setAttribute("name", "GoodsStock"); input4.setAttribute("value", "");
                    input4.classList.add("form-control");
                    let btnDelete = document.createElement('button'); btnDelete.setAttribute("type", "button"); btnDelete.innerHTML = "刪除"; btnDelete.classList.add("btn"); btnDelete.classList.add("btn-primary"); btnDelete.classList.add("deleteformatbtn");
                    let btnInsert = document.createElement('button'); btnInsert.setAttribute("type", "button"); btnInsert.innerHTML = "新增"; btnInsert.classList.add("btn"); btnInsert.classList.add("btn-primary"); btnInsert.classList.add("insertformatbtn");
                    //隱藏欄位
                    let input7 = document.createElement('input'); input7.setAttribute("type", "text"); input7.setAttribute("required", true); input7.setAttribute("name", "hiddenValue"); input7.classList.add("form-control"); input7.classList.add("hiddenData");
                    //規格表編號
                    let input8 = document.createElement('input'); input8.setAttribute("type", "text"); input8.setAttribute("name", "formatID"); input8.setAttribute("readonly", true); input8.classList.add("form-control");
                    //
                    tbody.append(tr);
                    tr.append(td1); tr.append(td2); tr.append(td3); tr.append(td4); tr.append(td5); tr.append(td6); tr.append(td7); tr.append(td8);
                    td2.append(input2); td3.append(input3); td4.append(input4); td5.append(btnDelete); td6.append(btnInsert); td7.append(input7); td8.append(input8);
                    //建立img標籤並且自訂義屬性(data-index) 目標是對應放入id="tranferToFormatTable" 的div標籤
                    // td1 插入圖片
                    let pattern = document.createElement("img");
                    pattern.setAttribute("style", "height: 100px;width: 100px;");
                    pattern.setAttribute("src", "");
                    pattern.setAttribute("alt", "");
                    pattern.setAttribute("data-index", (photoNumber + 1) + "");
                    //<img src="../../goodImages/20240428232110542.jpg" alt="">
                    td1.append(pattern);
                }
            })
            //新增 規格表圖片增加的事件
            $(document).on('change', '.InsertPhotoData', function () {
                //取得上傳檔案的檔案名稱
                //將檔案名稱移入隱藏input標籤中
                let UploadRootFileName = $(this).prop("value");//取得絕對路徑
                let ps = UploadRootFileName.lastIndexOf('\\');
                let filename = UploadRootFileName.substring(ps + 1, UploadRootFileName.length);
                console.log(filename);
                //
                let fieldName = $(this).prop("name");//取得input標籤的name屬性
                let index = $(this).prop("name").substring(16);//ex:GoodFormatImages1 取得 1
                let formattr = $('#formatdata').children();//$('#formatdata')指的是tbody標籤 formattr裡面都是tr標籤
                let count = 0;
                let arrformattr = [...formattr];
                var i = 0;
                //
                let check = -1;
                console.log(index);
                console.log(arrformattr);
                while (check != index) {//去尋找img標籤的自訂義index屬性 找到與index變數相同的img標籤
                    // console.log(arrformattr[i].children[0].children[0]);
                    check = arrformattr[i].children[0].children[0].getAttribute("data-index");
                    console.log(check);
                    // console.log(arrformattr[i].children[0].children[0].getAttribute("data-index"));
                    i++;
                }
                i--;
                console.log(i);
                //取得對應的資料列
                let connectdata = arrformattr[i];
                console.log(connectdata);
                let preview = connectdata.children[0].children[0]//取得img標籤
                //取得隱藏的input標籤 並且將檔案名稱丟入input標籤中(假若隱藏欄的數量在2以上)
                i++; let boundLength = arrformattr.length;
                console.log(boundLength);
                connectdata.children[6].children[0].setAttribute("value", filename);
                let uploadFilenameInputImg = connectdata.children[6].children[0].getAttribute("value", filename);
                if (boundLength == i) {//上船圖片的欄位只有一個
                }
                else {//如果上傳圖片時隱藏欄位不只一個
                    while (arrformattr[i].children.length != 8 && (i <= boundLength)) {
                        console.log("arrformattr[i].children.length = " + arrformattr[i].children.length);
                        // check = arrformattr[i].children[0].children[0].getAttribute("data-index");
                        check = arrformattr[i].children[0].children[0];
                        arrformattr[i].children[4].children[0].setAttribute("value", filename); console.log("i = " + i);
                        console.log(arrformattr[i].children[4].children[0]);
                        // arrformattr[i].children[4].children[0].setAttribute("value", filename);
                        i++;
                        if (i == boundLength) {
                            break;
                        }
                    }
                }
                // let preview = $(this).closest('td').prev().children(0);//預覽圖片欄位
                console.log(preview);
                const reader = new FileReader();
                let file = $(this).prop("files");//取得input[type="file"]的files屬性
                console.log(file);
                if (file) {
                    reader.readAsDataURL(file[0]);
                }
                reader.addEventListener('load', function () {
                    preview.setAttribute('src', reader.result);
                    preview.setAttribute('data-imgname', uploadFilenameInputImg);
                })
            })
            //新增照片
            $('#insertPhoto').click(function () {//處理GoodImages資料表
                //需要檢視有幾張照片
                let imgSelector = $('#photoPreviewList').find('img');
                //
                let nameField = "GoodImages" + (imgSelector.length);
                let input = document.createElement("input");
                input.setAttribute("type", "file");
                input.setAttribute("name", nameField);
                input.classList.add("form-control");
                input.classList.add("GoodImageInsert");
                $('#photoData').append(input);
            })

            $(document).on('change', '.GoodImageInsert', function () {
                let inputName = $(this).prop("name");//GoodImages3
                let index = inputName.substring(10);
                //建立div標籤 把img標籤插進來
                let divcol = document.createElement("div"); divcol.classList.add("col");
                $('#photoPreviewListChildren').append(divcol);
                //建立img標籤 需要用來預覽
                let preview = document.createElement('img'); preview.setAttribute("src", ""); preview.setAttribute("alt", ""); preview.setAttribute("data-index", index);
                divcol.append(preview);
                $('#photoPreviewListChildren').append(divcol);
                //圖片需要預覽
                const reader = new FileReader();
                let file = $(this).prop("files");//取得input[type="file"]的files屬性
                console.log(file);
                if (file) {
                    reader.readAsDataURL(file[0]);
                }
                reader.addEventListener('load', function () {
                    preview.setAttribute('src', reader.result);
                })
            })
            //處理input[class="NO"]
            //有圖片需要預覽的案例()
            //處理商品圖片表的案例
            $(document).on('change', 'input[class="form-control"][type="file"][name^="GoodImages"]', function () {
                //取得上傳檔案的名稱
                let uplaodrootname = $(this).prop("value");
                let ps = uplaodrootname.lastIndexOf("\\");
                let filename = uplaodrootname.substring(ps + 1);
                // $(this).removeClass("NO");
                // $(this).addClass("form-control");
                //尋找對應的img標籤
                let propName = $(this).prop("name");//得到 GoodImages1 
                let indexVal = propName.substring(10);//取得索引值
                let preview = $('#photoPreviewList').find('img[data-index="' + indexVal + '"]');//找到相對應的img標籤
                console.log(preview);
                //找到img旁邊type屬性是checkbox的input標籤
                let checkboxtarget = preview.prev();
                [...checkboxtarget][0].setAttribute("disabled", true);
                //尋找對應的input標籤(hiddenVal)
                let targetInput = $(this).closest('#GoodPhoto').find('input[name^="GoodImageshidden"]');
                // let arrtargetInput = [...targetInput];
                $.each(targetInput, function (i, n) {
                    let check = n.getAttribute("name");
                    let checkVal = check.substring(16);
                    console.log(check);
                    if (checkVal == indexVal) {//找到對應標籤了
                        //避免重複修改的問題
                        let hiddenVal = n.getAttribute("value");
                        let ps = hiddenVal.lastIndexOf("/");
                        // console.log(hiddenVal.lastIndexOf("/"));
                        if (ps == -1) {//圖片尚未上傳
                            hiddenVal = hiddenVal + "/" + filename;
                        }
                        else {//因為上船錯圖片重新上傳
                            hiddenVal = hiddenVal.substring(0, ps + 1) + filename;
                        }
                        n.setAttribute("value", hiddenVal);
                    }
                })
                console.log(targetInput.length);
                //預覽圖片
                const reader = new FileReader();
                let file = $(this).prop("files");//取得input[type="file"]的files屬性
                console.log(file);
                if (file) {
                    reader.readAsDataURL(file[0]);
                }
                reader.addEventListener('load', function () {
                    preview.attr('src', reader.result);
                })
            })
            //處理商品基本資訊表的封面照案例

            $(document).on('change', 'input[id="TitleImage"]', function () {
                //尋找對應的img標籤(在input標籤的旁邊)
                let preview = $(this).prev();
                console.log(preview);
                //預覽圖片
                const reader = new FileReader();
                let file = $(this).prop("files");//取得input[type="file"]的files屬性
                console.log(file);
                if (file) {
                    reader.readAsDataURL(file[0]);
                }
                reader.addEventListener('load', function () {
                    preview.attr('src', reader.result);
                })
            })

            //
            $(document).on('change', 'input[type="text"]', function () {
                // console.log();
                $(this).attr("value", $(this).prop("value"))
            })
            //
            $(document).on('click', '#outputGoodData', function (e) {
                //將input標籤中的name屬性統一(規格表部分)
                let target = $('#tranferToFormatTable').find('input');
                let arrtarget = [...target];
                arrtarget.forEach(function (elem, index) {
                    elem.setAttribute("name", "GoodFormatImages");
                })
                //將input標籤中的name屬性統一(商品圖片表部分)[新增+修改]
                let targetImages = $('#photoData').find('input');
                let arrtargetImages = [...targetImages];
                console.log(arrtargetImages);
                arrtargetImages.forEach(function (elem, index) {
                    elem.setAttribute("name", "GoodImages");
                    console.log(elem);
                })
                //將input標籤中的name屬性統一(商品圖片表部分)[修改]
                let targethiddenImages = $('#hiddenGoodImageData').find('input');
                let arrtargethiddenImages = [...targethiddenImages];
                console.log(arrtargethiddenImages);
                arrtargethiddenImages.forEach(function (elem, index) {
                    elem.setAttribute("name", "GoodImageshidden");
                    console.log(elem);
                })

                //將CKeditor的內容填入 input標籤
                let editorData = editor.getData();
                $('#GoodDirection').attr("value", editorData);
                // 將隱藏欄位填入單一規格資料的(商品大小、商品價格、商品庫存、上傳圖片名稱、規格表編號)
                let hiddentarget = $('.hiddenData');
                console.log(hiddentarget);
                [...hiddentarget].forEach(function (elem, index) {
                    let tr = elem.closest('tr');
                    if (tr.children.length == 8) {
                        let size = tr.children[1].children; let sizedata = [...size][0].getAttribute("value"); console.log(sizedata);
                        let price = tr.children[2].children; let pricedata = [...price][0].getAttribute("value"); console.log(pricedata);
                        let stock = tr.children[3].children; let stockdata = [...stock][0].getAttribute("value"); console.log(stockdata);
                        let hiddenVal = tr.children[6].children; let hiddenValdata = [...hiddenVal][0].getAttribute("value"); console.log(hiddenValdata);
                        let formatID = tr.children[7].children; let formatIDdata = [...formatID][0].getAttribute("value"); console.log(formatIDdata);

                        if (formatIDdata == null) {
                            let keydata = sizedata + "/" + pricedata + "/" + stockdata + "/" + hiddenValdata;
                            console.log(keydata);
                            [...hiddenVal][0].setAttribute("value", keydata);
                        }
                        else {
                            let keydata = formatIDdata + "/" + sizedata + "/" + pricedata + "/" + stockdata + "/" + hiddenValdata;
                            console.log(keydata);
                            [...hiddenVal][0].setAttribute("value", keydata);
                        }
                    }
                    else {
                        if (tr.children.length == 6) {
                            let size = tr.children[0].children; let sizedata = [...size][0].getAttribute("value"); console.log(sizedata);
                            let price = tr.children[1].children; let pricedata = [...price][0].getAttribute("value"); console.log(pricedata);
                            let stock = tr.children[2].children; let stockdata = [...stock][0].getAttribute("value"); console.log(stockdata);
                            let hiddenVal = tr.children[4].children; let hiddenValdata = [...hiddenVal][0].getAttribute("value"); console.log(hiddenValdata);
                            let formatID = tr.children[5].children; let formatIDdata = [...formatID][0].getAttribute("value"); console.log(formatIDdata);
                            if (formatIDdata == null) {
                                let keydata = sizedata + "/" + pricedata + "/" + stockdata + "/" + hiddenValdata;
                                console.log(keydata);
                                [...hiddenVal][0].setAttribute("value", keydata);
                            }
                            else {
                                let keydata = formatIDdata + "/" + sizedata + "/" + pricedata + "/" + stockdata + "/" + hiddenValdata;
                                console.log(keydata);
                                [...hiddenVal][0].setAttribute("value", keydata);
                            }
                        }
                    }
                })
                //用form傳即可
                let form = document.getElementById("GoodData");
                form.submit();
                // e.preventDefault();
            })

            $(document).on('change', 'input[type="text"][name="GoodSize"]', function () {
                //找到隱藏欄位 把value屬性從NO改成Yes
                let currentLength = $(this).closest('tr').children().length;
                //尋找對應的img標籤
                let previewformdata;
                let formatdata = $(this).closest('tr');//該列的資料
                if (formatdata.children().length == 8) {
                    previewformdata = formatdata;
                } else {
                    previewformdata = formatdata.prev();
                    while (previewformdata.children().length == 6) {//
                        previewformdata = previewformdata.prev();
                    }
                }
                //
                let arrFormTd = [...previewformdata.children()];//得到td
                let checkimg = [...arrFormTd[0].children][0].getAttribute("data-imgname");
                console.log(checkimg);
                //如果有圖片
                if (checkimg == null) {//img標籤是空值

                }
                else {//img標籤不是空值
                    if (currentLength == 8) {//長度為8 
                        let target = [...$(this).closest('tr').children()][6].children;
                        let check = [...target][0].getAttribute("value");
                        if (check != "NO") {//有圖片上傳 其對應的值為 xxx.jpg
                            //啥事不幹
                        }
                        else {//沒有圖片上傳 其對應的值為NO
                            [...target][0].setAttribute("value", "YES");
                        }
                        console.log(target);
                    } else {
                        if (currentLength == 6) {
                            let target = [...$(this).closest('tr').children()][4].children;
                            let check = [...target][0].getAttribute("value");
                            if (check != "NO") {//有圖片上傳 其對應的值為 xxx.jpg
                                //啥事不幹
                            }
                            else {//沒有圖片上傳 其對應的值為NO
                                [...target][0].setAttribute("value", "YES");
                            }
                        }
                    }
                }

            })

            $(document).on('change', 'input[type="text"][name="GoodPrice"]', function () {
                //找到隱藏欄位 把value屬性從NO改成Yes
                let currentLength = $(this).closest('tr').children().length;
                //尋找對應的img標籤
                let previewformdata;
                let formatdata = $(this).closest('tr');//該列的資料
                if (formatdata.children().length == 8) {
                    previewformdata = formatdata;
                } else {
                    previewformdata = formatdata.prev();
                    while (previewformdata.children().length == 6) {//
                        previewformdata = previewformdata.prev();
                    }
                }
                //
                let arrFormTd = [...previewformdata.children()];//得到td
                let checkimg = [...arrFormTd[0].children][0].getAttribute("data-imgname");
                console.log(checkimg);
                //如果有圖片
                if (checkimg == null) {//img標籤是空值

                }
                else {//img標籤不是空值
                    if (currentLength == 8) {//長度為8 
                        let target = [...$(this).closest('tr').children()][6].children;
                        let check = [...target][0].getAttribute("value");
                        if (check != "NO") {//有圖片上傳 其對應的值為 xxx.jpg
                            //啥事不幹
                        }
                        else {//沒有圖片上傳 其對應的值為NO
                            [...target][0].setAttribute("value", "YES");
                        }
                        console.log(target);
                    } else {
                        if (currentLength == 6) {
                            let target = [...$(this).closest('tr').children()][4].children;
                            let check = [...target][0].getAttribute("value");
                            if (check != "NO") {//有圖片上傳 其對應的值為 xxx.jpg
                                //啥事不幹
                            }
                            else {//沒有圖片上傳 其對應的值為NO
                                [...target][0].setAttribute("value", "YES");
                            }
                        }
                    }
                }
            })

            $(document).on('change', 'input[type="text"][name="GoodsStock"]', function () {
                //找到隱藏欄位 把value屬性從NO改成Yes
                let currentLength = $(this).closest('tr').children().length;
                //尋找對應的img標籤
                let previewformdata;
                let formatdata = $(this).closest('tr');//該列的資料
                if (formatdata.children().length == 8) {
                    previewformdata = formatdata;
                } else {
                    previewformdata = formatdata.prev();
                    while (previewformdata.children().length == 6) {//
                        previewformdata = previewformdata.prev();
                    }
                }
                //
                let arrFormTd = [...previewformdata.children()];//得到td
                let checkimg = [...arrFormTd[0].children][0].getAttribute("data-imgname");
                console.log(checkimg);
                //如果有圖片
                if (checkimg == null) {//img標籤是空值

                }
                else {//img標籤不是空值
                    if (currentLength == 8) {//長度為8 
                        let target = [...$(this).closest('tr').children()][6].children;
                        let check = [...target][0].getAttribute("value");
                        if (check != "NO") {//有圖片上傳 其對應的值為 xxx.jpg
                            //啥事不幹
                        }
                        else {//沒有圖片上傳 其對應的值為NO
                            [...target][0].setAttribute("value", "YES");
                        }
                        console.log(target);
                    } else {
                        if (currentLength == 6) {
                            let target = [...$(this).closest('tr').children()][4].children;
                            let check = [...target][0].getAttribute("value");
                            if (check != "NO") {//有圖片上傳 其對應的值為 xxx.jpg
                                //啥事不幹
                            }
                            else {//沒有圖片上傳 其對應的值為NO
                                [...target][0].setAttribute("value", "YES");
                            }
                        }
                    }
                }
            })

            $(document).on('change', 'input[type="checkbox"][name="GoodDelete"]', function () {

            })
        </script>
    </body>

    </html>