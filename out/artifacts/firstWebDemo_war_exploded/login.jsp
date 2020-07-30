<%--
  Created by IntelliJ IDEA.
  User: iceoftree
  Date: 2020/7/29
  Time: 4:16 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="css/index.css" media="all">
    <script type="text/javascript" src="js/idCheck.js"></script>
    <title>登录</title>
</head>


<body>
<header>Log In</header>
<form method="POST" action="login" role='form'>
    <div>用户名<input type="text" name="id"
        <% if (request.getParameter("loginSuccess")!=null&&request.getParameter("loginSuccess").equals("false"))
        out.write("value = "+request.getParameter("userName"));%>
                   required></div>
    <div id="last">密码<input type="password" name="password"
        <% if (request.getParameter("loginSuccess")!=null&&request.getParameter("loginSuccess").equals("false"))
        out.write("value = "+request.getParameter("password"));%>
                   required></div>
    <h5><%
        if (request.getParameter("loginSuccess") != null && request.getParameter("loginSuccess").equals("false"))
            out.write("用户名密码不正确");
    %></h5>
    <div class="code" id="checkCode" onclick="createCode()" ></div>
    <div><a href="#" onclick="createCode()">刷新验证码</a></div>
    <div id = tip></div>
    <div>验证码<input type="text" id=inputCode onchange="validateCode()" name="checkCode" required></div>
    <input type="submit" value="登陆">
</form>
<h5>
</h5>
<div>新用户？<a href="register.jsp">请先注册账户</a>
    <a href="register.jsp">
        <button>注册</button>
    </a></div>
<footer>
    © 2020 fdu19ss沪·证书·备 19302010042·联系我们:<img src="images/icons/wechat2DCode.jpg"/>19302010042@fudan.edu.cn·举报
</footer>
</body>
<%
    if (request.getParameter("loginSuccess") != null && request.getParameter("loginSuccess").equals("true"))
        out.write("<script language='javascript'>alert('成功登陆');window.location.href='index.jsp';</script>");
%>
</html>
