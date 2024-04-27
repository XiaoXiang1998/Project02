<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <!DOCTYPE html>
  <html>

  <head>
    <meta charset="UTF-8">
    <title>首頁</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet"
      integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
  </head>

  <body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
      <div class="container-fluid">
        <div class="collapse navbar-collapse" id="navbarNav">
          <ul class="navbar-nav">
            <li class="nav-item">
              <a class="nav-link ${page eq 'index' ? 'active' : ''}" href="goindex.controller">首頁</a>
            </li>
            <li class="nav-item">
              <a class="nav-link ${page eq 'product' ? 'active' : ''}" href="product.controller">商品列表</a>
            </li>
            <li class="nav-item">
              <a class="nav-link ${page eq 'shopcar' ? 'active' : ''}" href="shopcar.controller">購物車</a>
            </li>
            <li class="nav-item">
              <a class="nav-link ${page eq 'query' ? 'active' : ''}" href="goquery.controller">訂單管理</a>
            </li>
            <li class="nav-item">
              <a class="nav-link ${page eq 'admin' ? 'active' : ''}" href="goui.controller">管理系統</a>
            </li>
          </ul>
        </div>
      </div>
    </nav>
  </body>

  </html>