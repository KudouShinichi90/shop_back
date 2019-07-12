<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <link rel="icon" type="image/png" href="img/favicon.ico">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <title>管理页面</title>
    <style>
        @import url("https://fonts.googleapis.com/css?family=Lato:400,700|Montserrat:900");

        html {
            display: grid;
            min-height: 100%;
        }

        body {
            display: grid;
            background: #183059;
        }

        .container {
            position: relative;
            margin: auto;
            overflow: hidden;
            width: 850px;
            height: 580px;
        }

        h1 {
            font-family: "Lato", sans-serif;
            text-align: center;
            margin-top: 2em;
            font-size: 1em;
            text-transform: uppercase;
            letter-spacing: 5px;
            color: #F6F4F3;
        }

        #timer {
            color: #F6F4F3;
            text-align: center;
            text-transform: uppercase;
            font-family: "Lato", sans-serif;
            font-size: .7em;
            letter-spacing: 5px;
        }

        .days, .hours, .minutes, .seconds {
            display: inline-block;
            padding: 20px;
            width: 150px;
            border-radius: 5px;
        }

        .days {
            background: #EF2F3C;
        }

        .hours {
            background: #F6F4F3;
            color: #183059;
        }

        .minutes {
            background: #276FBF;
        }

        .seconds {
            background: #F0A202;
        }

        .numbers {
            font-family: "Montserrat", sans-serif;
            color: #183059;
            font-size: 5em;
        }

        footer {
            position: absolute;
            bottom: 0;
            right: 0;
            text-transform: uppercase;
            padding: 10px;
            font-family: "Lato", sans-serif;
            font-size: 0.7em;
        }

        footer p {
            letter-spacing: 3px;
            color: #EF2F3C;
        }

        footer a {
            color: #F6F4F3;
            text-decoration: none;
        }

        footer a:hover {
            color: #276FBF;
        }
    </style>

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
    <script src="${pageContext.request.contextPath}/js/jquery-1.10.2.js" type="text/javascript"></script>
    <script>
        $(function () {
            const double11 = new Date("11 11, 2019 00:00:00").getTime();
            // get today's date
            const today = new Date().getTime();
            // get the difference
            const diff = double11 - today;
            // math
            let days = Math.floor(diff / (1000 * 60 * 60 * 24));
            let hours = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            let minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
            let seconds = Math.floor((diff % (1000 * 60)) / 1000);
            // display
            if (days < 10) { days = "0" + days; }
            if (hours < 10) { hours = "0" + hours;  }
            if (minutes < 10) {  minutes = "0" + minutes; }
            if (seconds < 10) {  seconds = "0" + seconds; }
            document.getElementById("timer").innerHTML =
                "<div class=\"days\"> \
                 <div class=\"numbers\">" + days + "</div>days</div> \
                 <div class=\"hours\"> \
                 <div class=\"numbers\">" + hours + "</div>hours</div> \
                 <div class=\"minutes\"> \
                 <div class=\"numbers\">" + minutes + "</div>minutes</div> \
                 <div class=\"seconds\"> \
                 <div class=\"numbers\">" + seconds + "</div>seconds</div> \
                 </div>";
            // countdown
            let timer = setInterval(function () {
                // get today's date
                const today = new Date().getTime();
                // get the difference
                const diff = double11 - today;
                // math
                let days = Math.floor(diff / (1000 * 60 * 60 * 24));
                let hours = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                let minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
                let seconds = Math.floor((diff % (1000 * 60)) / 1000);
                // display
                if (days < 10) { days = "0" + days; }
                if (hours < 10) {  hours = "0" + hours; }
                if (minutes < 10) {  minutes = "0" + minutes; }
                if (seconds < 10) {  seconds = "0" + seconds; }
                document.getElementById("timer").innerHTML =
                    "<div class=\"days\"> \
                     <div class=\"numbers\">" + days + "</div>days</div> \
                 <div class=\"hours\"> \
                 <div class=\"numbers\">" + hours + "</div>hours</div> \
                 <div class=\"minutes\"> \
                 <div class=\"numbers\">" + minutes + "</div>minutes</div> \
                 <div class=\"seconds\"> \
                 <div class=\"numbers\">" + seconds + "</div>seconds</div> \
                 </div>";
            }, 1000);
        })
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
                    <div class="card">
                        <div class="header">
                            <h4 class="title">主页</h4>
                            <p class="category">====================</p>
                        </div>
                        <div class="container">
                            <h1 style="color: red">距离 双·11 还剩</h1>
                            <div id="timer"></div>
                            <center><h2>请注意商品上架准备！</h2></center>
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
<!--  Checkbox, Radio & Switch Plugins -->
<script src="${pageContext.request.contextPath}/js/bootstrap-checkbox-radio-switch.js"></script>
<!--  Charts Plugin -->
<script src="${pageContext.request.contextPath}/js/chartist.min.js"></script>
<!--  Notifications Plugin    -->
<script src="${pageContext.request.contextPath}/js/bootstrap-notify.js"></script>
<!-- Light Bootstrap Table Core javascript and methods for Demo purpose -->
<script src="${pageContext.request.contextPath}/js/light-bootstrap-dashboard.js"></script>
<!-- Light Bootstrap Table DEMO methods, don't include it in your project! -->
<script src="${pageContext.request.contextPath}/js/demo.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        demo.initChartist();
        $.notify({
            icon: 'pe-7s-gift',
            message: "欢迎您的登录！"
        }, {
            type: 'info',
            timer: 4000
        });
    });
</script>
</html>