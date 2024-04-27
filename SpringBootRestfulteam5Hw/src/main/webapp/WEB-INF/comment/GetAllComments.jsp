<%@page import="com.comment.model.Comment"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"
 import="java.util.*, com.comment.model.Comment,java.text.SimpleDateFormat,java.net.URLEncoder"%>
 
<%!@SuppressWarnings("unchecked")
 public String formatDate(java.sql.Timestamp timestamp) {
  Date dateTime = new Date(timestamp.getTime());

  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
  return sdf.format(dateTime);
 }%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>評論表多筆資料</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet"
 href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<style>
#backButton {
 display: block;
 margin: 0 auto;
 margin-bottom: 20px;
}

table {
 margin-top: 20px;
 border-collapse: collapse;
 width: 100%;
}

th, td {
 padding: 10px;
 text-align: center;
 border: 1px solid #ddd;
 max-width: 150px;
 overflow: hidden;
 white-space: normal;
}

th {
 background-color: #f2f2f2;
}

tr:hover {
 background-color: #f5f5f5;
}

.update, .delete {
 text-decoration: none;
 color: #333;
}

.update:hover, .delete:hover {
 color: red;
}

td img {
 vertical-align: middle;
}

#editFormContainer {
 display: none;
 position: absolute;
 top: 50%;
 left: 50%;
 transform: translate(-50%, -50%);
 background-color: #f9f9f9;
 padding: 20px;
 border: 1px solid #ccc;
 width: 80%; /* 設置寬度為容器的 80% */
 max-width: 600px; /* 最大寬度為 600 像素 */
}

#editFormContainer form {
 display: flex;
 flex-direction: column;
 align-items: center;
}

#editFormContainer input[type="text"], #editFormContainer textarea {
 width: 100%;
 padding: 10px;
 margin-bottom: 10px;
 border: 1px solid #ccc;
 border-radius: 5px;
 box-sizing: border-box;
}

#editFormContainer input[type="submit"] {
 width: auto;
 padding: 8px 20px;
 background-color: #007bff;
 color: white;
 border: none;
 cursor: pointer;
 border-radius: 5px;
}

#editFormContainer input[type="submit"]:hover {
 background-color: #0056b3;
}
</style>
</head>
<body>
 <button onclick="redirectToHomepage()" id="backButton">返回首頁</button>
 <div align="center">
  <h2>評論表資料</h2>
  <table id="table_id">
   <thead>
    <tr>
     <th>編號</th>
     <th>名字</th>
     <th>類型</th>
     <th>評論內容</th>
     <th>服務評價</th>
     <th>圖片</th>
     <th>評論建立時間</th>
     <th>評論修改時間</th>
     <th>刪除</th>
     <th>修改</th>
    </tr>
   </thead>
   <%
   List<Comment> coms = (ArrayList<Comment>) request.getAttribute("coms");
   for (Comment com : coms) {
   %>
   <tbody>
    <tr>
     <td><%=com.getCommentId()%></td>
     <td><%=com.getUserName()%></td>
     <td><%=com.getUserType()%></td>
     <td><%=com.getCommentContent()%></td>
     <td>
      <%
      int rate = com.getRate(); // 获取评分值
      %> <%
 for (int i = 0; i < rate; i++) {
 %> <img src="commentPicture/output.png" alt="star" width="20" height="20">
      <%
      }
      %>
     </td>
     <%
     String productPhoto = com.getProductPhoto();
     if (productPhoto != null && !productPhoto.isEmpty()) {
     %>
     <td><img
      src="/<%=com.getProductPhoto() %>"
      width="100" height="100" /></td>
     <%
     } else {
     %>
     <td></td>
     <%
     }
     %>
     <td><%=formatDate(com.getCommentTime())%></td>
     <td><%=formatDate(com.getLastModifiedTime())%></td>
     <td><form id="deleteForm" action="${pageContext.request.contextPath}/comment/<%=com.getCommentId()%>" method="post">
       <input type="hidden" name="_method" value="DELETE">
       <button class="delete" data-commentid="<%=com.getCommentId()%>">
        <i class="fa-solid fa-delete-left"></i>
       </button>
      </form></td>
     <td><a href="javascript:void(0)"
      onclick="showEditForm('<%=com.getCommentId()%>', '<%=com.getUserName()%>', '<%=com.getUserType()%>', '<%=URLEncoder.encode(com.getCommentContent())%>','<%=formatDate(com.getCommentTime())%>', '<%=formatDate(com.getLastModifiedTime())%>', '<%=com.getRate()%>')">
       <i class="fa-solid fa-pen"></i>
     </a></td>
    </tr>
    <%
    }
    %>
   </tbody>
  </table>
  <h3>
   共<%=coms.size()%>筆評論資料
  </h3>
 </div>
 <div id="editFormContainer">
  <span onclick="closeForm()">&times;</span>
  <form id="editForm" method="post">
   <input type="hidden" name="_method" value="PUT"> <input
    type="text" id="cid" name="cid" readonly> <input
    type="text" id="username" name="userName" readonly><br>
   <input type="text" id="userType" name="userType" readonly><br>
   <textarea id="commentContent" name="commentContent" rows="10"
    cols="30" maxlength="100" oninput="countCharacters()"></textarea>
   <br> <span id="charCount">0/100</span> <input type="text"
    id="commentTime" readonly><br> <input type="text"
    id="lastModifiedTime" readonly><br> <input
    type="hidden" id="rate" name="rate" readonly><br>
   <div id="starRating"></div>
   <br> <input type="submit" value="Submit">
  </form>
 </div>

 <script>
 function showEditForm(cid, username, userType, commentContent, commentTime, lastModifiedTime, rate) {
    var editForm = document.getElementById("editForm");
      var contextPath = '<%= request.getContextPath() %>';
      editForm.action = contextPath + "/comment/" + cid;
     $('#cid').val(cid);
     $('#username').val(username);
     $('#userType').val(userType);
     $('#commentContent').val(decodeURIComponent(commentContent));
     $('#commentTime').val(commentTime);
     $('#lastModifiedTime').val(lastModifiedTime);
     $('#rate').val(rate);
     
     $('#starRating').empty();
     
     for (var i = 0; i < rate; i++) {
         var starImg = $('<img>').attr({
             src:"${pageContext.request.contextPath}/commentPicture/output.png",
             alt: 'star',
             width: '20',
             height: '20'
         });
         $('#starRating').append(starImg);
     }
     
     
     $('#editFormContainer').css('display', 'block');
 }

 function closeForm() {
     $('#editFormContainer').css('display', 'none');
 }

 function countCharacters() {
     var text = $('#commentContent').val();
     var length = text.length;
     var maxLength = 100;
     $('#charCount').text(length + '/' + maxLength);
 }
   
 $('#editForm').submit(function(event) {
     event.preventDefault(); 

     Swal.fire({
         title: "你想要儲存這次編輯嗎?",
         showDenyButton: true,
         showCancelButton: true,
         confirmButtonText: "儲存",
         denyButtonText: "不保存"
     }).then((result) => {
         if (result.isConfirmed) {
             Swal.fire({
                 title: "修改成功",
                 allowOutsideClick: false,
                 onBeforeOpen: () => {
                     Swal.showLoading();
                 }
             });

             // 提交表单
             setTimeout(() => {
                 $('#editForm').off('submit').submit();
             }, 1000); 

         } else if (result.isDenied) {
             Swal.fire("更改未保存", "", "info");
         }
     });
 });
  
 $(".delete").on('click', function(e) {
     e.preventDefault();
     var commentid = $(this).data('commentid');
   //  $(this).closest('form').find('.cid').val(commentid);

     Swal.fire({
         title: "你確定要刪除使用者編號為 " + commentid + " 的資料嗎?",
         text: "您將無法恢復此狀態！",
         icon: "warning",
         showCancelButton: true,
         confirmButtonColor: "#3085d6",
         cancelButtonColor: "#d33",
         confirmButtonText: "刪除"
     }).then((result) => {
         if (result.isConfirmed) {
             Swal.fire({
                 title: "已刪除!",
                 text: "您的資料已刪除",
                 icon: "success",
                 confirmButtonText: "OK",
                 showConfirmButton: true,
                 showCloseButton: true 
             }).then(() => {
                 $(this).closest('form').submit();
             });
         }
     });
 });
  function redirectToHomepage() {
   window.location.href = 'index.controller';
  }  
</script>
</body>
</html>