<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
            $("[name='updateOrder']").each(function () {
                $(this).click(function () {
                    var state = $(this).parent().parent().find($("[name='thisState']")).val();
                    var addr = $(this).parent().parent().find($("[name='thisAddr']")).val();
                    var oid = $(this).parent().parent().attr("id");
                    $.ajax({
                        url: '${pageContext.request.contextPath}/order/updateOrder',
                        data: {
                            state: state,
                            addr: addr,
                            oid: oid
                        },
                        success: function (data) {
                            if (data == "ok") {
                                alert("修改成功！");
                            }
                        }
                    })
                })
            })
        })

        function showDetails(oid) {
            var info = $('[name=' + oid + ']').css("display");
            if (info == "none") {
                $("#bt" + oid).val("关闭详情");
                $("#bt" + oid).css("background-color", "lightpink");
                $('[name=' + oid + ']').fadeIn();
            } else {
                $("#bt" + oid).val("查看详情");
                $("#bt" + oid).css("background-color", "lightblue");
                $('[name=' + oid + ']').fadeOut();
            }

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
                                <h4 class="title">订单管理</h4>
                                <p class="category">Here is a subtitle for this table</p>
                                <form action="${pageContext.request.contextPath}/order/orders" method="get">
                                    <div style="float:left;  width: 130px;">
                                        <input type="hidden" name="pageNow" value="1">
                                        <select id="state" name="state" class="form-control" style="width: 125px;">
                                            <option value="-1" ${pageBeanForOrder.state==-1?"selected":""}>-订单状态-
                                            </option>
                                            <option value="0" ${pageBeanForOrder.state==0?"selected":""}>-未付款-
                                            </option>
                                            <option value="1" ${pageBeanForOrder.state==1?"selected":""}>-未发货-
                                            </option>
                                            <option value="2" ${pageBeanForOrder.state==2?"selected":""}>-待收货-
                                            </option>
                                            <option value="3" ${pageBeanForOrder.state==3?"selected":""}>-已验收-
                                            </option>
                                        </select>

                                    </div>
                                    <div style="float:left; margin:0 2px; width: 65px;">
                                        <button type="submit" class="btn btn-info btn-fill pull-right">查询</button>
                                    </div>
                                </form>

                            </div>
                            <div class="content table-responsive table-full-width">
                                <table class="table table-hover table-striped">
                                    <thead>
                                    <th>订单号</th>
                                    <th>订单总价</th>
                                    <th>生成时间</th>
                                    <th>订单状态</th>
                                    <th>收货人</th>
                                    <th>收货地址</th>
                                    <th>联系电话</th>
                                    <th>操作</th>
                                    <th>操作</th>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="order" items="${pageBeanForOrder.products}">

                                        <tr height="35px" id="${order.oid}">
                                            <td>${order.oid}</td>
                                            <td style="color: red;">¥ ${order.total}</td>
                                            <td><fmt:formatDate value="${order.ordertime}"
                                                                pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate></td>
                                            <td><select name="thisState" class="form-control">
                                                <option value="0" ${order.state==0?"selected":""}>未付款</option>
                                                <option value="1" ${order.state==1?"selected":""}>未发货</option>
                                                <option value="2" ${order.state==2?"selected":""}>待收货</option>
                                                <option value="3" ${order.state==3?"selected":""}>已验收</option>
                                            </select></td>
                                            <td>${order.name}</td>
                                            <td><input class="form-control" name="thisAddr" type="text"
                                                       value="${order.addr}" style="width: 180px;" required>
                                            </td>
                                            <td>${order.phone}</td>
                                            <td>
                                                <input type="button" onclick="showDetails(${order.oid});" value="查看详情"
                                                       class="form-control" id="bt${order.oid}"
                                                       style="width: 100px;background-color: lightblue;">
                                            </td>
                                            <td>
                                                <input type="button" class="form-control" name="updateOrder" value="修改"
                                                       style="background-color: lightblue;margin-left: -10px;">
                                            </td>
                                        </tr>

                                        <tr name="${order.oid}"
                                            style="display: none;background-color: lavenderblush;font-size: smaller;color: #05AE0E">
                                            <td>商品编号</td>
                                            <td>商品名称</td>
                                            <td>商品图片</td>
                                            <td></td>
                                            <td>商品详情</td>
                                            <td></td>
                                            <td>商品价格</td>
                                            <td>购买数量</td>
                                            <td>小计金额</td>
                                        </tr>
                                        <c:forEach items="${order.orderItemExts}" var="oi">
                                            <tr name="${order.oid}"
                                                style="display: none;background-color: lavenderblush;font-size: smaller;color: #05AE0E">
                                                <td>${oi.product.pid}</td>
                                                <td>${oi.product.pname}</td>
                                                <td><img
                                                        src="${pageContext.request.contextPath}/${oi.product.image}"
                                                        width="40" height="30"></td>
                                                <td></td>
                                                <td>
                                                    <p style="overflow : hidden;text-overflow:ellipsis;white-space: nowrap;width:150px;font-size: smaller">${oi.product.pdesc}</p>
                                                </td>
                                                <td></td>
                                                <td>${oi.product.shop_price}</td>
                                                <td>${oi.count}</td>
                                                <td style="color: red">￥${oi.subtotal}</td>
                                            </tr>
                                        </c:forEach>
                                    </c:forEach>
                                    </tbody>
                                </table>

                            </div>
                            <div style=" margin: 0 0 0px 50px;padding:0 0 20px 0; width: 70%;">
                                <c:if test="${pageBeanForOrder.products!=null}">
                                    <c:if test="${pageBeanForOrder.pageNow>1}">
                                        <a href="${pageContext.request.contextPath}/order/orders?pageNow=1&state=${pageBeanForOrder.state}">
                                            【首页】 </a>
                                        <a href="${pageContext.request.contextPath}/order/orders?pageNow=${pageBeanForOrder.pageNow-1}&state=${pageBeanForOrder.state}">
                                            【上一页】 </a>
                                    </c:if>
                                    <c:if test="${pageBeanForOrder.pageCount>5}">
                                        <c:choose>
                                            <c:when test="${pageBeanForOrder.pageNow >= 4 && pageBeanForOrder.pageNow <= pageBeanForOrder.pageCount - 2}">
                                                <c:set var="pageStart" value="${pageBeanForOrder.pageNow-2}"></c:set>
                                                <c:set var="pageEnd" value="${pageBeanForOrder.pageNow+2}"></c:set>
                                            </c:when>
                                            <c:when test="${pageBeanForOrder.pageNow>pageBeanForOrder.pageCount-2}">
                                                <c:set var="pageStart" value="${pageBeanForOrder.pageCount-4}"></c:set>
                                                <c:set var="pageEnd" value="${pageBeanForOrder.pageCount}"></c:set>
                                            </c:when>
                                            <c:otherwise>
                                                <c:set var="pageStart" value="1"></c:set>
                                                <c:set var="pageEnd" value="5"></c:set>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:if>
                                    <c:if test="${pageBeanForOrder.pageCount<=5}">
                                        <c:set var="pageStart" value="1"></c:set>
                                        <c:set var="pageEnd" value="${pageBeanForOrder.pageCount}"></c:set>
                                    </c:if>
                                    <c:forEach var="i" begin="${pageStart}" end="${pageEnd}">
                                        <a style="color: ${pageBeanForOrder.pageNow==i?'red':''}"
                                           href="${pageContext.request.contextPath}/order/orders?pageNow=${i}&state=${pageBeanForOrder.state}">
                                            【${i}】 </a>
                                    </c:forEach>
                                    <c:if test="${pageBeanForOrder.pageNow<pageBeanForOrder.pageCount}">
                                        <a href="${pageContext.request.contextPath}/order/orders?pageNow=${pageBeanForOrder.pageNow+1}&state=${pageBeanForOrder.state}">
                                            【下一页】 </a>
                                        <a href="${pageContext.request.contextPath}/order/orders?pageNow=${pageBeanForOrder.pageCount}&state=${pageBeanForOrder.state}">
                                            【末页】 </a>
                                    </c:if>
                                </c:if>
                            </div>
                            <form action="${pageContext.request.contextPath}/order/orders" method="post">
                                <div style=" float: right; margin:-50px 80px 0 0; width: 60px; height: 40px">
                                    <input type="hidden" name="state" value="${pageBeanForOrder.state}">
                                    <input type="number" id="skipNum" class="form-control" placeholder="页面" size=2
                                           min="1" max="${pageBeanForOrder.pageCount}" name="pageNow" required
                                           style="margin-right: 200px;">
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