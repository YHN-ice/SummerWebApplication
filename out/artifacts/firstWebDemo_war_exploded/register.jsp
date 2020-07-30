<%--
  Created by IntelliJ IDEA.
  User: iceoftree
  Date: 2020/7/29
  Time: 2:17 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="css/index.css" media="all">
    <link rel="stylesheet" type="text/css" href="css/register.css" media="all">
    <link rel="stylesheet" type="text/css" href="css/footer.css" media="all">
    <script type="text/javascript" src="js/idCheck.js"></script>

    <title>注册</title>
</head>
<body>
<header>Sign Up</header>
<form method="post" action="createAccount">
    <div>邮箱<input type="email" name="email" required></div>
    <div>用户名<input type="text" placeholder="a-z A-Z 0-9 or _" pattern="\w{4,15}" name="id"
                   onchange='idCheck(this.value)'
                   required></div>
    <div id='tips'>请起一个独特的用户名</div>
    <div>密码<input type="password" onchange='passwordCheck()' onKeyUp="passwordTest(this)" name="password"
                  placeholder="a-z A-Z or 0-9, length > 6"
                  pattern="[a-zA-Z0-9]{6,12}" required></div>
    <div id="note"> 请输入大小写字母和数字混合密码，长度不小于6不大于12</div>
    <div>再次输入<input type="password" onchange='passwordCheck()' name="password-again" required></div>
    <div id='password-tips'>请再次输入密码</div>
    <div class="code" id="checkCode" onclick="createCode()" ></div>
    <div><a href="#" onclick="createCode()">刷新验证码</a></div>
    <div id = tip></div>
    <div>验证码<input type="text" id=inputCode onchange="validateCode()" name="checkCode" required></div>
    <input type="submit" id='submit-button' disabled name='register' value="注册" onload="init()"></form>
<footer>
    © 2020 fdu19ss沪·证书·备 19302010042·联系我们:<img src="images/icons/wechat2DCode.jpg"/>19302010042@fudan.edu.cn·举报
</footer>
</body>
</html>
