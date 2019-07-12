<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <link rel="icon" type="image/png"
          href="img/favicon.ico">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>

    <title>管理页面</title>

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
    <script src="${pageContext.request.contextPath}/js/jquery-1.10.2.js"></script>
    <script>
        $(function () {
            var cid = $("#cid").val();
            $.ajax({
                url: "${pageContext.request.contextPath}/product/addProductJson2?cid=" + cid,
                dataType: 'json',
                success: function (data) {
                    if (data != "no") {
                        $("#csid").empty();
                        for (var i = 0; i < data.length; i++) {
                            var sele = "";
                            if (data[i].csid == "${pageBean.csid}") {
                                sele = "selected";
                            }
                            $('#csid').append("<option  " + sele + " value='" + data[i].csid + "'>" + data[i].csname + "</option>")
                        }
                    } else {
                        $("#csid").empty();
                        $('#csid').append("<option value='0'>请选择二级类目</option>")
                    }
                }
            })

            $("#cid").change(function () {
                var cid = $("#cid").val();
                $.ajax({
                    url: "${pageContext.request.contextPath}/product/addProductJson2?cid=" + cid,
                    dataType: 'json',
                    success: function (data) {
                        if (data != "no") {
                            $("#csid").empty();
                            for (var i = 0; i < data.length; i++) {
                                $('#csid').append("<option  value='" + data[i].csid + "'>" + data[i].csname + "</option>")
                            }
                        } else {
                            $("#csid").empty();
                            $('#csid').append("<option value='0'>请选择二级类目</option>")
                        }
                    }
                })
            })
        })

        function del(pid) {
            $.ajax({
                url: '${pageContext.request.contextPath}/product/doDelete?pid=' + pid,
                success: function (data) {
                    if (data == "ok") {
                        alert("删除成功！")
                        location.reload();
                    } else {
                        alert("该商品已被订单锁定，删除失败")
                    }
                }
            })
        }
    </script>
</head>
<body>

<div class="wrapper">


    <%@include file="left.jsp" %>


    <div class="main-panel">

        <%@include file="head.jsp" %>


        <div class="content">
            <div class="container-fluid">
                <div class="row">

                    <div class="col-md-12">
                        <div class="card">
                            <div class="header">
                                <h4 class="title">商品管理</h4>
                                <p class="category">Here is a subtitle for this table</p>
                                <form action="${pageContext.request.contextPath}/product/products" method="get">
                                    <div style="float:left;  width: 130px;">
                                        <input type="hidden" name="pageNow" value="1">
                                        <select id="cid" name="cid" class="form-control" style="width: 160px;">
                                            <option value="0">请选择一类目</option>
                                            <c:forEach var="category" items="${category}">
                                                <option ${category.cid==pageBean.cid?"selected":''}
                                                        value="${category.cid}">${category.cname}</option>
                                            </c:forEach>
                                        </select>

                                    </div>
                                    <div style="float:left;  width: 160px;">
                                        <select id="csid" name="csid" class="form-control"
                                                style="width: 160px;margin-left: 40px">
                                            <option value="0">请选择二级类目</option>
                                        </select>
                                    </div>
                                    <div style="float:left; margin:0 2px; width: 130px;margin-left: 50px">
                                        <input type="text" class="form-control" placeholder="查询" size=8 name="pname"
                                               value="${pageBean.pname}">
                                    </div>
                                    <div style="float:left; margin:0 2px; width: 65px;">
                                        <button type="submit" class="btn btn-info btn-fill pull-right">查询</button>
                                    </div>
                                </form>

                            </div>
                            <div class="content table-responsive table-full-width">
                                <table class="table table-hover table-striped">
                                    <thead>
                                    <th>ID</th>
                                    <th>商品图片</th>
                                    <th>商品名</th>
                                    <th>商品描述</th>
                                    <th>商城价格</th>
                                    <th>市场价格</th>
                                    <th>是否热门</th>
                                    <th>上架时间</th>
                                    <th>所属二级类目</th>
                                    <th>剩余库存</th>
                                    <th>操作</th>
                                    <th>操作</th>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="p" items="${pageBean.products}">
                                        <tr height="35px">
                                            <td>${p.pid}</td>
                                            <td><img width="30" height="30"
                                                     src="${pageContext.request.contextPath}/${p.image}"></td>
                                            <td>${p.pname}</td>
                                            <td>
                                                <p style="overflow : hidden;text-overflow:ellipsis;white-space: nowrap;width:100px;">${p.pdesc}</p>
                                            </td>
                                            <td>${p.shop_price}</td>
                                            <td>${p.market_price}</td>
                                            <td>${p.is_hot==1?'是':'否'}</td>
                                            <td>${p.pdate}</td>
                                            <td>${categorySecond[p.csid].csname}</td>
                                            <td>${p.stock}</td>
                                            <td style="font-size: 12px"><a
                                                    href="${pageContext.request.contextPath}/product/addProduct.do?pid=${p.pid}">修改</a>
                                            </td>
                                            <td style="font-size: 12px"><a
                                                    href="javaScript:onclick=del(${p.pid});">删除</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>

                            </div>
                            <div style=" margin: 0 0 0px 50px;padding:0 0 20px 0; width: 70%;">
                                <c:if test="${!empty pageBean.products}">
                                    <c:if test="${pageBean.pageNow>1}">
                                        <a href="${pageContext.request.contextPath}/product/products?pageNow=1&pname=${pageBean.pname}&cid=${pageBean.cid}">
                                            【首页】 </a>
                                        <a href="${pageContext.request.contextPath}/product/products?pageNow=${pageBean.pageNow-1}&pname=${pageBean.pname}&cid=${pageBean.cid}">
                                            【上一页】 </a>
                                    </c:if>
                                    <c:if test="${pageBean.pageCount>5}">
                                        <c:choose>
                                            <c:when test="${pageBean.pageNow >= 4 && pageBean.pageNow <= pageBean.pageCount - 2}">
                                                <c:set var="pageStart" value="${pageBean.pageNow-2}"></c:set>
                                                <c:set var="pageEnd" value="${pageBean.pageNow+2}"></c:set>
                                            </c:when>
                                            <c:when test="${pageBean.pageNow>pageBean.pageCount-2}">
                                                <c:set var="pageStart" value="${pageBean.pageCount-4}"></c:set>
                                                <c:set var="pageEnd" value="${pageBean.pageCount}"></c:set>
                                            </c:when>
                                            <c:otherwise>
                                                <c:set var="pageStart" value="1"></c:set>
                                                <c:set var="pageEnd" value="5"></c:set>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:if>
                                    <c:if test="${pageBean.pageCount<=5}">
                                        <c:set var="pageStart" value="1"></c:set>
                                        <c:set var="pageEnd" value="${pageBean.pageCount}"></c:set>
                                    </c:if>
                                    <c:forEach var="i" begin="${pageStart}" end="${pageEnd}">
                                        <a style="color: ${pageBean.pageNow==i?'red':''}"
                                           href="${pageContext.request.contextPath}/product/products?pageNow=${i}&pname=${pageBean.pname}&cid=${pageBean.cid}">
                                            【${i}】 </a>
                                    </c:forEach>
                                    <c:if test="${pageBean.pageNow<pageBean.pageCount}">
                                        <a href="${pageContext.request.contextPath}/product/products?pageNow=${pageBean.pageNow+1}&pname=${pageBean.pname}&cid=${pageBean.cid}">
                                            【下一页】 </a>
                                        <a href="${pageContext.request.contextPath}/product/products?pageNow=${pageBean.pageCount}&pname=${pageBean.pname}&cid=${pageBean.cid}">
                                            【末页】 </a>
                                    </c:if>
                                </c:if>
                            </div>
                            <form action="${pageContext.request.contextPath}/product/products" method="post">
                                <div style=" float: right; margin:-50px 80px 0 0; width: 60px; height: 40px">
                                    <input type="hidden" name="cid" value="${pageBean.cid}">
                                    <input type="hidden" name="pname" value="${pageBean.pname}">
                                    <input type="hidden" name="csid" value="${pageBean.csid}">

                                    <input type="number" id="skipNum" class="form-control" placeholder="页面" size=2
                                           name="pageNow">
                                </div>
                                <div style="float: right; margin:-50px 10px 0 0; width: 60px; height: 40px">
                                    <button type="submit" id="skipBut" class="btn btn-info btn-fill pull-right">跳转
                                    </button>
                                </div>
                            </form>


                        </div>
                    </div>


                </div>

                <%@include file="footer.jsp" %>
            </div>
        </div>
    </div>
</div>


</body>

<!--   Core JS Files   -->

<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"
        type="text/javascript"></script>

<!--  Checkbox, Radio & Switch Plugins -->
<script
        src="${pageContext.request.contextPath}/js/bootstrap-checkbox-radio-switch.js"></script>

<!--  Charts Plugin -->
<script src="${pageContext.request.contextPath}/js/chartist.min.js"></script>

<!--  Notifications Plugin    -->
<script src="${pageContext.request.contextPath}/js/bootstrap-notify.js"></script>


<!-- Light Bootstrap Table Core javascript and methods for Demo purpose -->
<script
        src="${pageContext.request.contextPath}/js/light-bootstrap-dashboard.js"></script>

<!-- Light Bootstrap Table DEMO methods, don't include it in your project! -->
<script src="${pageContext.request.contextPath}/js/demo.js"></script>


</html>