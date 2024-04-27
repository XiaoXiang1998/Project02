<%@page import="java.util.ArrayList"%>
<%@page import="com.member.model.MemberBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%!@SuppressWarnings("unchecked")%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>所有會員資料</title>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
/* 全局樣式 */
* {
    box-sizing: border-box;
}

body {
    font-family: 'Oswald', sans-serif;
    margin: 0;
    padding: 0;
}

.wrap {
    overflow-x: auto; /* 水平滾動 */
    border-radius: 10px;
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.35);
    margin: 20px;
}

table {
    width: 100%;
    border-collapse: collapse;
}

th, td {
    padding: 10px;
    text-align: center;
}

th {
    background-color: #009879;
    color: #ffffff;
}

td {
    background-color: #ffffff;
    border-bottom: 1px solid #dddddd;
    border: 3px solid #f3f3f3;
}

tr:last-of-type td {
    border-bottom: 2px solid #009879;
}

tr:nth-child(even) td {
    background-color: #f3f3f3;
}

.button {
    background-color: #009879;
    color: #fff;
    border: none;
    border-radius: 10px;
    padding: 7px; /* 調整按鈕內部內距 */
    min-height: 15px;
    min-width: 30px;
    font-size: 14px; /* 調整字體大小 */
}

.button:hover {
    outline-color: transparent;
    outline-style: solid;
    box-shadow: 0 0 0 2px blue; /* 調整 hover 效果 */
    transition: 0.3s;
}
.button-cell td {
    border: none; /* 移除按钮单元格的边框 */
}
</style>
</head>
<body>
    <div align="center">
        <h2>會員資料</h2>
        <div class="wrap">
            <table>
                <thead>
                    <tr>
                        <th>會員編號</th>
                        <th>帳號</th>
                        <th>密碼</th>
                        <th>電子信箱</th>
                        <th>手機號碼</th>
                        <th>姓名</th>
                        <th>性別</th>
                        <th>地址</th>
                        <th>大頭貼</th>
                        <th>賣家身分</th>
                        <th>管理者身分</th>
                        <th>總評分數</th>
                        <th>被評次數</th>
                        <th>累計金額</th>
                        <th>刪除</th>
                        <th>更新</th>
                    </tr>
                </thead>
                <tbody>
                    <% List<MemberBean> members = (ArrayList<MemberBean>) request.getAttribute("members"); %>
                    <% for (MemberBean member : members) { %>
                    <tr>
                        <td><%=member.getSid()%></td>
                        <td><%=member.getAccount()%></td>
                        <td><%=member.getPassword()%></td>
                        <td><%=member.getEmail()%></td>
                        <td><%=member.getPhone()%></td>
                        <td><%=member.getName()%></td>
                        <td><%=member.getGender()%></td>
                        <td><%=member.getAddress()%></td>
                        <td>
                            <div style="width: 50px; height: 50px; border-radius: 50%; overflow: hidden;">
                                <img src="/<%=member.getPhotoSticker()%>" alt="沒有頭貼" style="width: 100%; height: 100%; object-fit: cover; object-position: center;">
                            </div>
                        </td>
                        <td><%=member.isSeller()%></td>
                        <td><%=member.isAdmin()%></td>
                        <td><%=member.getReviewCount()%></td>
                        <td><%=member.getCumulativeScore()%></td>
                        <td><%=member.getTotalSalesAmount()%></td>
                        <td class="button-cell">
                            <form id="delete<%=member.getSid()%>" method="post" action="DeleteMember?SID=<%=member.getSid()%>">
                                <input class="button" type="button" value="刪除" onclick="giveChance('<%=member.getSid()%>')" />
                            </form>
                        </td>
                        <td class="button-cell">
                            <button class="button" onclick="showEditForm('<%=member.getSid()%>', '<%=member.getAccount()%>', '<%=member.getPassword()%>', '<%=member.getEmail()%>', '<%=member.getPhone()%>', '<%=member.getName()%>', '<%=member.getGender()%>', '<%=member.getAddress()%>', '<%=member.getPhotoSticker()%>', '<%=member.isSeller()%>', '<%=member.isAdmin()%>','<%=member.getReviewCount()%>','<%=member.getCumulativeScore()%>','<%=member.getTotalSalesAmount()%>')">修改</button>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
        <div>
            <form method="post" action="backToAdminUI">
                <button type="submit">返回頁面</button>
            </form>
        </div>
        <h3>共<%=members.size()%>筆會員資料</h3>
    </div>
	<script>
		function giveChance(SID) {
		    Swal.fire({
		        title: "是否確認刪除?",
		        text: "執行後無法復原!",
		        icon: "warning",
		        showCancelButton: true,
		        confirmButtonColor: "#3085d6",
		        cancelButtonColor: "#d33",
		        confirmButtonText: "Yes"
		    }).then((result) => {
		        if(result.isConfirmed){
		            fetch("/DeleteMember/" + SID, {
		                method:'DELETE',
		                headers:{
		                    'Content-Type':'application/json'
		                }
		            }).then(() => {
		                console.log('Member deleted successfully');
		                window.location.href = "showAllMember";
		            });
		        }
		    });
		}
    
    function showEditForm(SID,Account,Password,Email,Phone,Name,Gender,Address,Photo_Sticker,Seller,Administrator,reviewCount,cumulativeScore,totalSalesAmount) {
        console.log("SID:", SID); 
        console.log("Account:", Account); 
        console.log("Password:", Password); 
        console.log("Email:", Email); 
        console.log("Phone:", Phone); 
        console.log("Name:", Name); 
        console.log("Gender:", Gender); 
        console.log("Address:", Address); 
        console.log("Photo_Sticker:", Photo_Sticker); 
        console.log("Seller:", Seller); 
        console.log("Administrator:", Administrator); 
        console.log("reviewCount:", reviewCount); 
        console.log("cumulativeScore:", cumulativeScore); 
        console.log("totalSalesAmount:", totalSalesAmount); 

        var newURL = ''; // 定義外部變數
            var html = 
            	'<form id="uploadForm" method="post" enctype="multipart/form-data">' +
                '<table>' +
                '<input type="hidden" name="_method" value="PUT">'+
                '<input id="SID" class="swal2-input" name="SID" value="' + SID + '" style="display: none;">' + 
                '<tr><td style="text-align: right; min-width: 110px;"><label for="Account">帳號：</label></td><td><input id="Account" class="swal2-input" name="Account" value="' + Account + '"></td></tr>' +
                '<tr><td style="text-align: right; min-width: 110px;"><label for="Password">密碼：</label></td><td><input id="Password" class="swal2-input" name="Password" value="' + Password + '"></td></tr>' +
                '<tr><td style="text-align: right; min-width: 110px;"><label for="Email">Email：</label></td><td><input id="Email" class="swal2-input" name="Email" value="' + Email + '"></td></tr>' +
                '<tr><td style="text-align: right; min-width: 110px;"><label for="Phone">電話號碼：</label></td><td><input id="Phone" class="swal2-input" name="Phone" value="' + Phone + '"></td></tr>' +
                '<tr><td style="text-align: right; min-width: 110px;"><label for="Name">姓名：</label></td><td><input id="Name" class="swal2-input" name="Name" value="' + Name + '"></td></tr>' +
                '<tr><td style="text-align: right; min-width: 110px;"><label>性別：</label></td>' +
                '<td><input type="radio" name="Gender" value="male"' + (Gender === "male" ? ' checked' : '') + '> 男' +
                '<input type="radio" name="Gender" value="female"' + (Gender === "female" ? ' checked' : '') + '> 女</td></tr>' +
                '<tr><td style="text-align: right; min-width: 110px;"><label for="Address">住址：</label></td><td><input id="Address" class="swal2-input" name="Address" value="' + Address + '"></td></tr>' +
                '<tr><td style="text-align: right; min-width: 110px;"><label for="Photo_Sticker">大頭貼：</label></td><td><input type="file" id="Photo_Sticker" class="swal2-input" name="Photo_Sticker"></td></tr>' +
                '<tr><td style="text-align: right; min-width: 110px;"><label>賣家身分：</label></td>' +
                '<td><input type="radio" name="Seller" value="true"' + (Seller === "true" ? ' checked' : '') + '> 是' +
                '<input type="radio" name="Seller" value="false"' + (Seller === "false" ? ' checked' : '') + '> 否</td></tr>' +
                '<tr><td style="text-align: right; min-width: 110px;"><label>管理者身分：</label></td>' +
                '<td><input type="radio" name="Administrator" value="true"' + (Administrator === "true" ? ' checked' : '') + '> 是' +
                '<input type="radio" name="Administrator" value="false"' + (Administrator === "false" ? ' checked' : '') + '> 否</td></tr>' +
                '<input id="oldPath" class="swal2-input" name="oldPath" value="' + Photo_Sticker + '" style="display: none;">' + 
                '<input id="reviewCount" class="swal2-input" name="reviewCount" value="' + reviewCount + '" style="display: none;">' + 
                '<input id="cumulativeScore" class="swal2-input" name="cumulativeScore" value="' + cumulativeScore + '" style="display: none;">' + 
                '<input id="totalSalesAmount" class="swal2-input" name="totalSalesAmount" value="' + totalSalesAmount + '" style="display: none;">' + 
                '</table>' +
                '</form>';
        
                  

        Swal.fire({
            title: '修改會員資料',
            width: '700px',
            html: html,
            focusConfirm: false,
            showCancelButton: true,
            confirmButtonText: '儲存',
            cancelButtonText: '取消'
        }).then((result) => {
            if (result.isConfirmed) {
                let form = document.getElementById('uploadForm');
                let formData = new FormData(form);

                fetch('UpdateMember', {
                    method: 'PUT',
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
    }

</script>
</body>
</html>