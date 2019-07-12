<%--
  Created by IntelliJ IDEA.
  User: 18545
  Date: 2019/6/18
  Time: 10:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
    <meta
            content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'
            name='viewport'/>
    <meta name="viewport" content="width=device-width"/>


    <!-- Bootstrap core CSS     -->
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css"
          rel="stylesheet"/>

    <!-- Animation library for notifications   -->
    <link href="${pageContext.request.contextPath}/css/animate.min.css"
          rel="stylesheet"/>

    <!--  Light Bootstrap Table core CSS    -->
    <link
            href="${pageContext.request.contextPath}/css/light-bootstrap-dashboard.css"
            rel="stylesheet"/>


    <!--  CSS for Demo Purpose, don't include it in your project     -->
    <link href="${pageContext.request.contextPath}/css/demo.css"
          rel="stylesheet"/>


    <!--     Fonts and icons     -->

    <link href="${pageContext.request.contextPath}/css/pe-icon-7-stroke.css"
          rel="stylesheet"/>
</head>
<body>
<div class="sidebar" data-color="grow" data-image="${pageContext.request.contextPath}/images/sidebar-5.jpg">
    <div class="sidebar-wrapper">
        <div class="logo">
            <a href="#" class="simple-text">
                <img src="${pageContext.request.contextPath}/images/logo.png">
            </a>
        </div>

        <ul class="nav">
            <li>
                <a href="${pageContext.request.contextPath}/user/main">
                    <i class="pe-7s-graph"></i>
                    <p>平台首页</p>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/product/products?pageNow=1">
                    <i class="pe-7s-user"></i>
                    <p>商品管理</p>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/product/addProduct.do?pid=0">
                    <i class="pe-7s-user"></i>
                    <p>添加商品</p>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/order/orders?pageNow=1">
                    <i class="pe-7s-news-paper"></i>
                    <p>订单管理</p>
                </a>
            </li>
        </ul>
    </div>
</div>
</body>
</html>
