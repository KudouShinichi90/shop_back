<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <link rel="icon" type="image/png" href="img/favicon.ico">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>

    <title>添加商品</title>

    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport'/>
    <meta name="viewport" content="width=device-width"/>
    <!-- Bootstrap core CSS     -->
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet"/>

    <!-- Animation library for notifications   -->
    <link href="${pageContext.request.contextPath}/css/animate.min.css" rel="stylesheet"/>

    <!--  Light Bootstrap Table core CSS    -->
    <link href="${pageContext.request.contextPath}/css/light-bootstrap-dashboard.css" rel="stylesheet"/>


    <!--  CSS for Demo Purpose, don't include it in your project     -->
    <link href="${pageContext.request.contextPath}/css/demo.css" rel="stylesheet"/>


    <!--     Fonts and icons     -->

    <link href="${pageContext.request.contextPath}/css/pe-icon-7-stroke.css" rel="stylesheet"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/XMLHttpRequest.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.10.2.js"></script>
    <script>
        $(function () {
            $.ajax({
                url: "${pageContext.request.contextPath}/product/addProductJson",
                dataType: "json",
                success: function (data) {
                    for (var i = 0; i < data.length; i++) {
                        if (${empty product}) {
                            $('#cid').append("<option value='" + data[i].cid + "'>" + data[i].cname + "</option>")
                        }
                        if (${!empty cs}) {
                            var sel = '';
                            if (data[i].cid == "${cs.cid}") {
                                sel = "selected"
                            }
                            $('#cid').append("<option " + sel + "   value='" + data[i].cid + "'>" + data[i].cname + "</option>")
                        }
                    }

                    var cid = $("#cid").val();
                    $.ajax({
                        url: "${pageContext.request.contextPath}/product/addProductJson2?cid=" + cid,
                        dataType: 'json',
                        success: function (data2) {
                            if (data2 != "no") {
                                $("#csid").empty();
                                for (var i = 0; i < data2.length; i++) {
                                    var sele = "";
                                    if (data2[i].csid == "${product.csid}") {
                                        sele = "selected";
                                    }
                                    $('#csid').append("<option  " + sele + " value='" + data2[i].csid + "'>" + data2[i].csname + "</option>")
                                }
                            } else {
                                $("#csid").empty();
                                $('#csid').append("<option value='0'>请选择二级类目</option>")
                            }
                        }
                    })

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
                            $('#csid').append("<option value='0'>--请选择二级类目--</option>")
                        }
                    }
                })
            })
        })

        //图片回显:
        function preview(file) {
            $("#imgHidden").css("display", "none");
            var prevDiv = document.getElementById('preview');
            if (file.files && file.files[0]) {
                if (!(file.files[0].type == 'image/jpeg' || file.files[0].type == 'image/png')) {
                    alert('上传为非图片');
                    return;
                }
                if (file.files[0].size > 30000) {
                    alert("上传图片大于3M！")
                }
                var reader = new FileReader();
                reader.onload = function (evt) {
                    prevDiv.innerHTML = '<img style="width: 100px;height: 100px;" src="' + evt.target.result + '" />';
                }
                reader.readAsDataURL(file.files[0]);
                $('#OldImg').remove();
            } else {
                prevDiv.innerHTML = '<div class="img" style="width: 100px;height:100px;filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src=\'' +
                    file.value + '\'"></div>';
            }
        }

        // 表单验证
        function check() {
            var image = $('#images').val();
            var oldimg = $('#OldImg').size();

            if ((image == null || image == '') && oldimg == 1) {
                $('#hiddenID').append("<input type='hidden' name='image' value='${product.image}'>")
                return true;
            } else if ((image != null && image != '') && oldimg == 0) {
                return true;
            } else {
                return false;
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
                    <div class="col-md-8">
                        <div class="card">
                            <div class="header">
                                <h4 class="title">商品Goods</h4>
                            </div>
                            <div class="content">
                                <form action="${pageContext.request.contextPath}/product/upload" method="post"
                                      enctype="multipart/form-data" onsubmit="return check();">
                                    <div class="col-md-8">
                                        <div class="form-group">
                                            <label>图片文件</label>
                                            <input style="width:200px;" type="file" id="images" class="form-control"
                                                   name="file" onchange="javascript:preview(this)" accept="image/*"/>
                                            <!-- 这个是在上传之前回显图片图片展示 -->
                                            <div id="preview">
                                                　　<!--这个是为了将页面返回的图片展示出来的.默认隐藏-->
                                                　　<img style="width: 100px; height: 100px;display:none" id="imgHidden"/>
                                            </div>
                                            <c:if test="${!empty product}">
                                                <img src="${pageContext.request.contextPath}/${product.image}"
                                                     style="width: 100px; height: 100px;" id="OldImg">
                                            </c:if>
                                        </div>
                                    </div>
                                    <div>
                                        <div id="hiddenID">
                                            <c:if test="${!empty product}">
                                                <input type="hidden" name="pid" value="${product.pid}">
                                            </c:if>
                                        </div>

                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>一级类目</label>
                                                <select style="width: 210px" id="cid" class="form-control" name="cid">
                                                    <option value="0">--请选择一级类目--</option>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <label>二级类目</label>
                                                <select style="width: 210px" id="csid" class="form-control" name="csid">
                                                    <option value="0">--请选择二级类目--</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label>商品名</label>
                                                <input style="width: 400px" type="text" name="pname" id="pname"
                                                       class="form-control"
                                                       value="${product.pname}" required>
                                                <label>商城价</label>
                                                <input style="width: 400px" type="number" name="shop_price"
                                                       id="shop_price" class="form-control"
                                                       value="${product.shop_price}" required>
                                                <label>市场价</label>
                                                <input style="width: 400px" type="number" name="market_price"
                                                       id="market_price" class="form-control"
                                                       value="${product.market_price}" required>
                                                <label>库存</label>
                                                 <input type="number" min="0" name="stock"  class="form-control" style="width: 400px;" value="${empty product?"":product.stock}" required>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label>详细描述</label>
                                                <textarea rows="15" name="pdesc" id="pdesc"
                                                          class="form-control"
                                                          placeholder="商品描述...." required>${product.pdesc}</textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <button type="submit" id="ssb"
                                            class="btn btn-info btn-fill pull-right">${empty product?"添加":"修改"}
                                    </button>
                                    <div class="clearfix"></div>
                                </form>
                            </div>
                        </div>
                    </div>


                </div>
            </div>
        </div>


        <%@include file="footer.jsp" %>
    </div>
</div>


</body>

<!--   Core JS Files   -->
<script
        src="${pageContext.request.contextPath}/js/jquery-1.10.2.js"
        type="text/javascript"></script>
<script
        src="${pageContext.request.contextPath}/js/bootstrap.min.js"
        type="text/javascript"></script>

<!--  Checkbox, Radio & Switch Plugins -->
<script
        src="${pageContext.request.contextPath}/js/bootstrap-checkbox-radio-switch.js"></script>

<!--  Charts Plugin -->
<script
        src="${pageContext.request.contextPath}/js/chartist.min.js"></script>

<!--  Notifications Plugin    -->
<script
        src="${pageContext.request.contextPath}/js/bootstrap-notify.js"></script>


<!-- Light Bootstrap Table Core javascript and methods for Demo purpose -->
<script
        src="${pageContext.request.contextPath}/js/light-bootstrap-dashboard.js"></script>

<!-- Light Bootstrap Table DEMO methods, don't include it in your project! -->
<script
        src="${pageContext.request.contextPath}/js/demo.js"></script>

</html>