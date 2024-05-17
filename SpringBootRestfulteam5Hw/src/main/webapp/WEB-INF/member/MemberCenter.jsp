<%@page import="com.member.model.MemberBean" %>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>會員中心</title>
            <script src="https://kit.fontawesome.com/92a295a0cf.js" crossorigin="anonymous"></script>
            <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
            <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
            <!-- Libraries Stylesheet -->
            <link href="/frontlib/lightbox/css/lightbox.min.css" rel="stylesheet">
            <link href="/frontlib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
            <link href="/frontcss/bootstrap.min.css" rel="stylesheet">
            <link href="frontcss/style.css" rel="stylesheet">
            <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
            <style>
                .list-group {
                    border-radius: 10px;
                    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1), 0 6px 20px rgba(0, 0, 0, 0.1);
                    /* 陰影效果 */
                    background-color: #fff;
                    /* 背景顏色 */
                }

                .bordered-pane {
                    border: 1px solid #ccc;
                    /* 邊框樣式 */
                    padding: 15px;
                    /* 內部間隔 */
                    overflow-y: auto;
                    /* 若內容超過高度，自動顯示滾動條 */
                    max-height: 850px;
                    /* 最大高度，避免整體內容過高 */
                    border-radius: 10px;
                    /* 邊框圓角 */
                    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1), 0 6px 20px rgba(0, 0, 0, 0.1);
                    /* 陰影效果 */
                    background-color: #fff;
                    /* 背景顏色 */
                }

                .error-message {
                    color: red;
                    margin-top: 10px;
                }
            </style>
        </head>

        <body>
            <%@ include file="../FrontDeskNav.jsp" %>
                <% HttpSession MemberSession=request.getSession(); MemberBean member=(MemberBean)
                    MemberSession.getAttribute("member"); %>
                    <div class="container mt-5">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="list-group" id="list-tab" role="tablist">
                                    <a class="list-group-item list-group-item-action active" id="list-info-list"
                                        data-bs-toggle="list" href="#list-info" role="tab" aria-controls="info">個人資訊</a>
                                    <a class="list-group-item list-group-item-action" id="list-account-list"
                                        data-bs-toggle="list" href="#list-account" role="tab"
                                        aria-controls="account">帳號詳情</a>
                                    <a class="list-group-item list-group-item-action" id="list-password-list"
                                        data-bs-toggle="list" href="#list-password" role="tab"
                                        aria-controls="password">修改密碼</a>
                                    <a class="list-group-item list-group-item-action" id="list-orders-list"
                                        data-bs-toggle="list" href="#list-orders" role="tab"
                                        aria-controls="orders">歷史訂單</a>
                                    <a class="list-group-item list-group-item-action" id="list-coupons-list"
                                        data-bs-toggle="list" href="#list-coupons" role="tab"
                                        aria-controls="coupons">我的優惠券</a>
                                </div>
                            </div>
                            <div class="col-md-9">
                                <div class="tab-content" id="nav-tabContent">
                                    <!-- 個人資訊 -->
                                    <div class="tab-pane fade show active bordered-pane" id="list-info" role="tabpanel"
                                        aria-labelledby="list-info-list">
                                        <h3>個人資訊</h3>
                                        <div class="d-flex justify-content-center mt-3 w-100">
                                            <div
                                                style="width: 100px; height: 100px; border-radius: 50%; overflow: hidden;">
                                                <img src="<%= member.getPhotoSticker() %>" alt="沒有頭貼"
                                                    style="width: 100%; height: 100%; object-fit: cover; object-position: center;">
                                            </div>
                                        </div>
                                        <form action="#" class="mt-3" id="#editForm">
                                            <div class="form-floating mb-3">
                                                <input type="text" class="form-control" id="floatingUsername"
                                                    placeholder="帳號名稱" name="account" readonly>
                                                <label for="floatingUsername">帳號名稱</label>
                                            </div>
                                            <div class="form-floating mb-3">
                                                <input type="email" class="form-control" id="floatingEmail"
                                                    placeholder="電子信箱" name="email" readonly>
                                                <label for="floatingEmail">電子信箱</label>
                                            </div>
                                            <div class="form-floating mb-3">
                                                <input type="text" class="form-control" id="floatingPhone"
                                                    placeholder="手機號碼" name="phone" readonly>
                                                <label for="floatingPhone">手機號碼</label>
                                            </div>
                                            <div class="form-floating mb-3">
                                                <input type="text" class="form-control" id="floatingName"
                                                    placeholder="會員姓名" name="name" readonly>
                                                <label for="floatingName">會員姓名</label>
                                            </div>
                                            <div class="form-floating mb-3">
                                                <select class="form-select" id="floatingGender" aria-label="會員性別"
                                                    name="gender" disabled>
                                                    <option selected>選擇性別</option>
                                                    <option value="male">男</option>
                                                    <option value="female">女</option>
                                                </select>
                                                <label for="floatingGender">會員性別</label>
                                            </div>
                                            <div class="form-floating mb-3">
                                                <input type="text" class="form-control" id="floatingAddress"
                                                    placeholder="會員住址" name="address" readonly>
                                                <label for="floatingAddress">會員住址</label>
                                            </div>
                                            <div class="d-flex justify-content-center">
                                                <button type="button" class="btn btn-primary"
                                                    id="editButton">修改會員資料</button>
                                            </div>
                                            <!-- 新增送出和取消按鈕，預設隱藏 -->
                                            <div class="d-flex justify-content-center mt-2" id="actionButtons"
                                                style="display: none;">
                                                <button type="submit" class="btn btn-success mx-2 controlButton"
                                                    style="display: none;" id="updateButton">送出</button>
                                                <button type="button" class="btn btn-danger mx-2 controlButton"
                                                    style="display: none;" id="cancelButton">取消</button>
                                            </div>
                                        </form>
                                    </div>
                                    <!-- 帳號詳情 -->
                                    <div class="tab-pane fade bordered-pane" id="list-account" role="tabpanel"
                                        aria-labelledby="list-account-list">
                                        <h3>帳號詳情</h3>
                                        <div class="form-floating mb-3 mt-5">
                                            <input type="text" class="form-control" id="isSeller" placeholder="是否具有賣家身分"
                                                readonly>
                                            <label for="isSeller">是否具有賣家身分</label>
                                        </div>
                                        <div class="form-floating mb-3 mt-3">
                                            <input type="text" class="form-control" id="reviewCount" placeholder="被評論總數"
                                                readonly>
                                            <label for="reviewCount">被評論總數</label>
                                        </div>
                                        <div class="form-floating mb-3 mt-3">
                                            <input type="text" class="form-control" id="cumulativeScore"
                                                placeholder="當前平均評分數" readonly>
                                            <label for="cumulativeScore">當前平均評分數</label>
                                        </div>
                                        <div class="form-floating mb-3 mt-3">
                                            <input type="text" class="form-control" id="totalSalesAmount"
                                                placeholder="當前累計消費金額" readonly>
                                            <label for="totalSalesAmount">當前累計消費金額</label>
                                        </div>
                                        <div class="form-floating mb-3 mt-3">
                                            <input type="text" class="form-control" id="third_party_provider"
                                                placeholder="登入方式" readonly>
                                            <label for="third_party_provider">登入方式</label>
                                        </div>
                                        <div class="form-floating mb-3 mt-3">
                                            <input type="text" class="form-control" id="registrationTime"
                                                placeholder="註冊時間" readonly>
                                            <label for="registrationTime">註冊時間</label>
                                        </div>
                                    </div>
                                    <!-- 修改密碼 -->
                                    <div class="tab-pane fade bordered-pane" id="list-password" role="tabpanel"
                                        aria-labelledby="list-password-list">
                                        <h3>修改密碼</h3>
                                        <form action="" method="post" onsubmit="return validateForm()">
                                            <div class="form-floating mb-3 mt-5">
                                                <input type="password" class="form-control" id="floatingPassword"
                                                    placeholder="請輸入密碼">
                                                <label for="floatingPassword">請輸入密碼</label>
                                            </div>
                                            <div class="form-floating mb-3 mt-3">
                                                <input type="password" class="form-control" id="floatingCheckPassword"
                                                    placeholder="請再確認密碼">
                                                <label for="floatingCheckPassword">請再確認密碼</label>
                                            </div>
                                            <div id="error-message" class="error-message"></div>
                                            <div class="d-flex justify-content-center">
                                                <button type="submit" class="btn btn-primary mt-3"
                                                    id="changePassword">送出</button>
                                            </div>
                                        </form>
                                    </div>
                                    <!-- 歷史訂單 -->
                                    <div class="tab-pane fade" id="list-orders" role="tabpanel"
                                        aria-labelledby="list-orders-list">
                                        <h3>歷史訂單</h3>
                                        <p>這裡顯示用戶的歷史訂單。</p>
                                    </div>
                                    <!-- 優惠卷 -->
                                    <div class="tab-pane fade" id="list-coupons" role="tabpanel"
                                        aria-labelledby="list-coupons-list">
                                        <h3>我的優惠券</h3>
                                        <p>這裡顯示用戶的優惠券。</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"
                        integrity="sha384-p34f1UUtsS3wqzfto5wAAmdvj+osOnFyQFpp4Ua3gs/ZVWx6oOypYoCJhGGScy+8"
                        crossorigin="anonymous"></script>
                    <script>
                        var userData = {};
                        var imgElement = document.querySelector('img');

                        // 檢查圖片的 src 是否為空
                        if (imgElement.src === '') {
                            // 如果是空，則將 src 屬性設置為預設的 icon 圖片
                            imgElement.src = '預設icon的路徑';
                        }

                        $('#editButton').click(function () {
                            userData.username = $('#floatingUsername').val();
                            userData.email = $('#floatingEmail').val();
                            userData.phone = $('#floatingPhone').val();
                            userData.name = $('#floatingName').val();
                            userData.address = $('#floatingAddress').val();
                            userData.gender = $('#floatingGender').val();

                            // 創建一個新的檔案上傳輸入框
                            var fileInput = $('<div class="mb-3" id="fileUpload"><label for="photoSticker" class="form-label">上傳頭貼:</label> <input type="file"id="photoSticker" name="photoSticker" class="form-control"></div>');

                            // 將檔案上傳輸入框添加到表單中
                            $('#actionButtons').before(fileInput);
                            // 顯示送出和取消按鈕
                            $('.controlButton').show();
                            // 隱藏編輯按鈕
                            $(this).hide();
                            // 將所有具有 readonly 屬性的 input 元素變為可編輯
                            $('input').prop('readonly', false);
                            // 將會員性別下拉菜單的 disabled 屬性移除
                            $('#floatingGender').prop('disabled', false);
                        });

                        $('#editForm').on('submit', function (event) {
                            event.preventDefault(); // 阻止表单的默认提交行为
                        });

                        $('#updateButton').click(function () {
                            let form = $('#editForm')[0];
                            let formData = new FormData(form);
                            for (let [key, value] of formData.entries()) {
                                console.log(key, value);
                            }
                            fetch('UpdateMember', {
                                method: 'PUT',
                                body: formData
                            })
                                .then(response => {
                                    if (response.ok) {
                                        return response.json(); // 假设服务器返回JSON
                                    } else {
                                        throw new Error('网络响应失败');
                                    }
                                })
                                .then(data => {
                                    console.log('成功:', data);
                                    // 可以在这里处理成功的响应，例如显示提示信息
                                })
                                .catch(error => {
                                    console.error('错误:', error);
                                    // 可以在这里处理错误，例如显示错误信息
                                });
                        });

                        $('#cancelButton').click(function () {
                            $('#fileUpload').remove();
                            $('.controlButton').hide();
                            $('#editButton').show();
                            $('input').prop('readonly', true);
                            $('#floatingGender').prop('disabled', true);

                            $('#floatingUsername').val(userData.username);
                            $('#floatingEmail').val(userData.email);
                            $('#floatingPhone').val(userData.phone);
                            $('#floatingName').val(userData.name);
                            $('#floatingAddress').val(userData.address);
                            $('#floatingGender').val(userData.gender);
                        })

                        $('#changePassword').click(function () {
                            var password = document.getElementById("floatingPassword").value;
                            var confirmPassword = document.getElementById("floatingCheckPassword").value;
                            var errorMessage = document.getElementById("error-message");
                            if (password !== confirmPassword) {
                                errorMessage.innerText = "兩次密碼不一致，請重新輸入。";
                                return false;
                            }
                            return true;
                        })

                        //初始化給值
                        $(document).ready(function () {
                            // 從JSP獲取UserBean資料
                            var user = {
                                username: '<%= member.getAccount() %>',
                                email: '<%= member.getEmail() %>',
                                phone: '<%= member.getPhone() %>',
                                name: '<%= member.getName() %>',
                                gender: '<%= member.getGender() %>',
                                address: '<%= member.getAddress() %>',
                                photoSticker: '<%= member.getPhotoSticker() %>',
                                seller: '<%= member.isSeller() %>',
                                reviewCount: '<%= member.getReviewCount() %>',
                                cumulativeScore: '<%= member.getCumulativeScore() %>',
                                totalSalesAmount: '<%= member.getTotalSalesAmount() %>',
                                level: '<%= member.getLevel() %>',
                                third_party_provider: '<%= member.getThirdPartyProvider() %>',
                                registrationTime: '<%= member.getRegistrationTime() %>'
                            };

                            // 設置表單元素的預設值
                            $('#floatingUsername').val(user.username);
                            $('#floatingEmail').val(user.email);
                            $('#floatingPhone').val(user.phone);
                            $('#floatingName').val(user.name);
                            $('#floatingGender').val(user.gender);
                            $('#floatingAddress').val(user.address);
                            $('#isSeller').val(user.seller ? "是" : "否");
                            $('#reviewCount').val(user.reviewCount);
                            $('#cumulativeScore').val(user.cumulativeScore);
                            $('#totalSalesAmount').val(user.totalSalesAmount);
                            $('#third_party_provider').val(user.third_party_provider);
                            $('#registrationTime').val(user.registrationTime);

                            // 設定性別選項
                            $('#floatingGender option').each(function () {
                                if ($(this).val() === user.gender) {
                                    $(this).prop('selected', true);
                                }
                            });
                        });
                    </script>
                    <%@ include file="../FrontDeskFooter.jsp" %>
        </body>

        </html>