<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>訂單管理</title>
</head>
<body>
<%@ include file="Index.jsp" %>
<div class="container">
    <div class="row justify-content-center mt-5">
        <div class="col-md-6">
            <div class="border p-4">
                <h3 class="text-center mb-3">訂單管理</h3>
                <form action="queryOrder.controller" method="get">
                    <div class="mb-3">
                        <label for="queryType" class="form-label">選擇查詢類型：</label>
                        <select name="queryType" id="queryType" class="form-select">
                            <option value="all">全部訂單</option>
                            <option value="byOrderId">按訂單編號查詢</option>
                            <option value="byDate">按日期範圍查詢</option>
                        </select>
                    </div>
                    <div id="orderIdInput" style="display: none;">
                        <label for="orderId" class="form-label">訂單編號：</label>
                        <input type="text" id="orderId" name="orderId" class="form-control">
                    </div>
                    <div id="dateRangeInput" style="display: none;">
                        <label for="startDate" class="form-label">開始日期：</label>
                        <input type="date" id="startDate" name="startDate" class="form-control">
                        <label for="endDate" class="form-label">結束日期：</label>
                        <input type="date" id="endDate" name="endDate" class="form-control">
                    </div>
                    <div class="text-center m-3">
                        <button type="submit" class="btn btn-primary">查詢</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

	<script>
	document.getElementById("queryType").addEventListener("change", function () {
	    let selectedValue = this.value;
	    let orderIdInput = document.getElementById("orderIdInput");
	    let dateRangeInput = document.getElementById("dateRangeInput");

	    if (selectedValue === "byOrderId") {
	        orderIdInput.style.display = "block";
	        orderIdInput.querySelector('input').required = true; 
	        dateRangeInput.style.display = "none";
	        dateRangeInput.querySelector('input').required = false; 
	    } else if (selectedValue === "byDate") {
	        orderIdInput.style.display = "none";
	        orderIdInput.querySelector('input').required = false; 
	        dateRangeInput.style.display = "block";
	        dateRangeInput.querySelector('input').required = true; 
	    } else {
	        orderIdInput.style.display = "none";
	        orderIdInput.querySelector('input').required = false; 
	        dateRangeInput.style.display = "none";
	        dateRangeInput.querySelector('input').required = false; 
	    }
	});
	</script>
</body>
</html>