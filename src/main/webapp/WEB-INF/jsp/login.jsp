<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="java.net.URLDecoder" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <script type="application/x-javascript">

        addEventListener("load", function () {
            setTimeout(hideURLbar, 0);
        }, false);

        function hideURLbar() {
            window.scrollTo(0, 1);
        }

    </script>
    <meta name="keywords"
          content="Flat Dark Web Login Form Responsive Templates, Iphone Widget Template, Smartphone login forms,Login form, Widget Template, Responsive Templates, a Ipad 404 Templates, Flat Responsive Templates"/>
    <link href="${pageContext.request.contextPath}/css/style.css" rel='stylesheet' type='text/css'/>
    <script>
        window.onload = function () {
            var username = "${cookie.backname.value}";
            var password = "${cookie.backpass.value}";
            if (username != "" && password != "") {
                var username = document.getElementById("name");
                var name = decodeURI(username.value);
                username.value = name;
                var pwd = document.getElementById("pwd");
                var password = decodeURI(pwd.value);
                pwd.value = password;
// 			document.getElementById("login_submit").click();
            }
        }

        function check() {
            var name = $("#name").val();
            var pass = $("#pwd").val();
            if (name == null || name.trim() == "" || pass == null || pass.trim() == "") {
                return false;
            } else {
                return true;
            }
        }
    </script>
</head>
<body>
<!--SIGN UP-->
<h1 style="font-family: '方正华隶简体'; color: #0e4277;">管理员登陆</h1>
<div class="login-form">
    <div class="close"></div>
    <div class="head-info">
        <label class="lbl-1"> </label> <label class="lbl-2"> </label> <label class="lbl-3"> </label>
    </div>
    <div class="clear"></div>
    <div class="avtar">
        <img src="${pageContext.request.contextPath}/images/avtar.png"/>
        <!-- 			清除session -->
    </div>
    <c:if test="${sessionScope.user!=null}">
        <c:remove var="user" scope="session"/>
    </c:if>
    <!-- 		提交登陆表单 -->
    <form action='${pageContext.request.contextPath}/user/dologin' method="post" onsubmit="return check();">
        <input type='text' name='username' id='name' value="${empty errname?cookie.backname.value:errname}"
               class="text"/>
        <div class="key">
            <input type='password' name='password' id='pwd' value="${empty errpass?cookie.backpass.value:errpass}"
                   class='text'/>
        </div>
        <span><font style='font-size: 15px; color: red;'>${empty errlogin?"":errlogin}</font></span><br/> <input
            type='CheckBox' name='remember' class="text"
    ${cookie.backname!=null?"checked":"" } /><i style="color: #9199aa;">一周内免登陆</i>

        <div class="signin" style="margin: 10px 7.5%;">;
            <input type="submit" id="login_submit" value="登录"
                   style="border-radius:5px;height:50px;padding:0px;font-size:18px;"/>
        </div>
        <div class="signin">
        </div>
        <div class="signin" style="height:8px;">
        </div>
    </form>
</div>
<div class="copy-rights">
    <p>
        Copyright &copy; 2015.Company name All rights reserved.More Templates <a href=# target="_blank" title="#">#</a>
        - Collect from <a href=# title=#
                          target="_blank">#</a>
    </p>
</div>

</body>
</html>

