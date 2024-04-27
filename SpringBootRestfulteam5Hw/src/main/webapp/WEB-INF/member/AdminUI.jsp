<%@page import="java.util.ArrayList"%>
<%@page import="com.member.model.MemberBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>使用者管理介面</title>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <style>
            html,
            body {
                text-align: center;
                height: 100%;
                /* 確保佔滿整個頁面高度 */
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                background-color: rgb(255, 231, 200);
            }

            a {
                text-decoration: none;
                color: black;
            }

            a:hover {
                color: red;
            }

            #choose {
                display: flex;
                margin: 0 auto;
                justify-content: center;
            }

            h4 {
                background-color: rgb(251, 230, 209);
                padding: 2px;
                border: 2px solid black;
                border-radius: 5px;
                margin: 5px;
            }

            legend {
                background-color: rgb(252, 122, 75);
                color: white;
                border-radius: 5px;
                width: 150px;
            }

            fieldset {
                border-color: rgb(255, 164, 84);
                border-radius: 20px;
            }

            input {
                border-radius: 3px;
            }

            button {
                margin-right: 10px
            }
        </style>
    </head>

    <body>
   		<% MemberBean member = (MemberBean)session.getAttribute("member");%>
        <div style="position: absolute; top: 10px; right: 10px;">
            <!-- 歡迎信息 -->
            <div id="welcomeMessage">
                <%= member.getAccount() %>，歡迎回來
            </div>
        </div>
        <fieldset>
            <legend>會員資料管理系統</legend>
            <div id="choose">
                <button id="showAllMembers">顯示所有資料</button>
                <button id="insertMember">新增會員資料</button>
                <button id="returnToControlUI">返回總管理列表</button>
            </div>
            <label for="search">搜尋: </label> <input type="text" id="search" name="search" placeholder="請輸入查詢資料...">
            <select name="selectMethod" id="selectMethod">
                <option value="">請指定選項</option>
                <option value="SelectByName">搜尋姓名</option>
                <option value="SelectLikeName">模糊搜尋(姓名)</option>
                <option value="SelectByAccount">搜尋會員帳號</option>
                <option value="SelectByPhone">搜尋會員手機號碼</option>
            </select><br>
            <button type="submit" style="margin-top: 10px;" id="selectSubmit">查詢</button>
        </fieldset>
        <script>
            document
                .getElementById("selectSubmit")
                .addEventListener(
                    "click",
                    function () {
                        // 获取输入框和选择框的值
                        let searchText = document.getElementById("search").value;
                        let selectMethod = document
                            .getElementById("selectMethod").value;
                        let URL = null;

                        switch (selectMethod) {
                            case "SelectByName":
                                URL = 'SelectFunction?selected=' + selectMethod + '&content=' + searchText;
                                window.location.href = URL;
                                break;
                            case "SelectLikeName":
                                URL = 'SelectFunction?selected=' + selectMethod + '&content=' + searchText;
                                window.location.href = URL;
                                break;
                            case "SelectByAccount":
                                URL = 'SelectFunction?selected=' + selectMethod + '&content=' + searchText;
                                window.location.href = URL;
                                break;
                            case "SelectByPhone":
                                URL = 'SelectFunction?selected=' + selectMethod + '&content=' + searchText;
                                window.location.href = URL;
                                break;
                        }
                    });

            document.getElementById("showAllMembers").addEventListener('click',
                function () {
                    URL = "showAllMember"
                    window.location.href = URL
                });

            document.getElementById("returnToControlUI").addEventListener('click',
                function () {
                    URL = "returnToControlUI"
                    window.location.href = URL
                });

            document.getElementById("insertMember").addEventListener('click', function () {

                var html = `
            	<form id="uploadForm" method="post" enctype="multipart/form-data">
                <table>
                    <tr>
                        <td style="text-align: right; min-width: 110px;">
                            <label for="Account">帳號：</label>
                        </td>
                        <td>
                            <input id="Account" class="swal2-input" name="Account" value="">
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right; min-width: 110px;">
                            <label for="Password">密碼：</label>
                        </td>
                        <td>
                            <input id="Password" class="swal2-input" name="Password" value="">
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right; min-width: 110px;">
                            <label for="Email">Email：</label>
                        </td>
                        <td>
                            <input id="Email" class="swal2-input" name="Email" value="">
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right; min-width: 110px;">
                            <label for="Phone">電話號碼：</label>
                        </td>
                        <td>
                            <input id="Phone" class="swal2-input" name="Phone" value="">
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right; min-width: 110px;">
                            <label for="Name">姓名：</label>
                        </td>
                        <td>
                            <input id="Name" class="swal2-input" name="Name" value="">
                        </td>
                    </tr>
                    <tr>
                    <td style="text-align: right; min-width: 110px;">
                    <label>性別:</label>
                </td>
                <td>
                    <input type="radio" name="Gender" id="male" value="male">
                    <label for="male">男</label>
                    <input type="radio" name="Gender" id="female" value="female">
                    <label for="female">女</label>
                </td>
                    </tr>
                    <tr>
                        <td style="text-align: right; min-width: 110px;">
                            <label for="Address">住址：</label>
                        </td>
                        <td>
                            <input id="Address" class="swal2-input" name="Address" value="">
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right; min-width: 110px;">
                            <label for="Photo_Sticker">大頭貼：</label>
                        </td>
                        <td>
                            <input type="file" id="Photo_Sticker" class="swal2-input" name="Photo_Sticker">
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right; min-width: 110px;">
                            <label>開啟賣家權限:</label>
                        </td>
                        <td>
                            <input type="radio" name="Seller" id="isSeller" value="true">
                            <label for="isSeller">是</label>
                            <input type="radio" name="Seller" id="notSeller" value="false">
                            <label for="notSeller">否</label>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right; min-width: 110px;">
                            <label>開啟管理者權限:</label>
                        </td>
                        <td>
                            <input type="radio" name="Administrator" id="isAdministrator" value="true">
                            <label for="isAdministrator">是</label>
                            <input type="radio" name="Administrator" id="notAdministrator" value="false">
                            <label for="notAdministrator">否</label>
                        </td>
                    </tr>
                </table>
            </form>
        `;
                Swal.fire({
                    title: '新增會員資料',
                    width: '700px',
                    html: html,
                    focusConfirm: false,
                    showCancelButton: true,
                    confirmButtonText: '儲存',
                    cancelButtonText: '取消',
                }).then((result) => {
                    if (result.isConfirmed) {
                        let form = document.getElementById('uploadForm');
                        let formData = new FormData(form);

                        fetch('InsertMember', {
                            method: 'POST',
                            body: formData
                        }).then(function(response) {
                            if (!response.ok) {
                                console.log('回應狀態碼: ' + response.status);
                                throw new Error(response.status);
                            }
                            console.log('成功');
                            window.location.href = "showAllMember";
                        }).catch(function(error) {
                            console.error('更新失敗:', error.message);
                            // 在這裡處理錯誤情況
                        });
                    }
                });
            });
        </script>
    </body>

    </html>