<%--
  Created by IntelliJ IDEA.
  User: iceoftree
  Date: 2020/7/12
  Time: 11:42 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="items.Illustration" import="items.User" %>
<%@ page import="java.util.Arrays" %>
<html>
<%
    /**if (session.getAttribute("originPics") == null) {
        Illustration[] pics = {
                new Illustration("images/travel-images/normal/medium/5855174537.jpg", 'm', 0),
                new Illustration("images/travel-images/normal/medium/5855191275.jpg", 'm', 1),
                new Illustration("images/travel-images/normal/medium/5855209453.jpg", 'm', 2),
                new Illustration("images/travel-images/normal/medium/5855213165.jpg", 'm', 3),
                new Illustration("images/travel-images/normal/medium/5855729828.jpg", 'm', 4)};
        session.setAttribute("originPics", pics);
    }

    if (session.getAttribute("user") == null) {
        Illustration[] originCollection = {
                new Illustration("images/travel-images/normal/medium/5855174537.jpg", 'm', 0),
                new Illustration("images/travel-images/normal/medium/5855191275.jpg", 'm', 1),
                new Illustration("images/travel-images/normal/medium/5855209453.jpg", 'm', 2),
                new Illustration("images/travel-images/normal/medium/5855213165.jpg", 'm', 3),
                new Illustration("images/travel-images/normal/medium/5855729828.jpg", 'm', 4)};
        User user = new User(000, "test", "1234", "io@qq.com", originCollection, null);
        session.setAttribute("user", user);
    }*/

%>
<head>
    <link rel="stylesheet" type="text/css" href="css/nav.css" media="all">
    <link rel="stylesheet" type="text/css" href="css/my-collection.css" media="all">
    <link rel="stylesheet" type="text/css" href="css/section-footer-pages.css" media="all">
    <link rel="stylesheet" type="text/css" href="css/footer.css" media="all">

    <title>我的收藏</title>
</head>
<body>
<header>
    <nav>
        <div id=homepage><a href=#>首页</a></div>
        <div id=browser><a href=#>浏览页</a></div>
        <div id=search><a href=#>搜索页</a></div>
    </nav>
</header>
<section>
    <header>My Collection</header>

    <%
        if (((User) session.getAttribute("user")).getCollection() == null)
            out.print("<h1>您还没有收藏照片!</h1>");
        else {

            for (Illustration pic : ((User) session.getAttribute("user")).getCollection()
            ) {
                if (pic != null) {%>


    <div class='show-zone-container'>
        <a href="detail.jsp?imageNumber=<%=pic.getId()%>">
            <img class='<%=pic.getId()%> show-zone-image' id='<%=pic.getId()%>' src="<%=pic.getSrc()%>"/>
        </a>
        <div>
            <h3><%=pic.getTitle()%>
                <button class="remove"><a href="cancelLike?ImageID=<%=pic.getId()%>">取消收藏</a></button>
            </h3>
            <p class="to-be-trimmed"><%=pic.getDescription()%>
            </p>
        </div>
    </div>


    <%
                }
            }
        }
    %>


    <div id="pages">
        <a href="#" id="last page" onclick="alert('unable to turn')"><</a>
        <a href="#" id="current page" onclick="alert('unable to turn')">1</a>
        <a href="#" onclick="alert('unable to turn')">2</a>
        <a href="#" onclick="alert('unable to turn')">3</a>
        <a href="#" onclick="alert('unable to turn')">4</a>
        <a href="#" onclick="alert('unable to turn')">5</a>
        <a href="#" onclick="alert('unable to turn')">6</a>
        <span>...</span>
        <a href="#" onclick="alert('unable to turn')">9</a>
        <a href="#" id="next page" onclick="alert('unable to turn')">></a>
    </div>
</section>
<footer>
    © 2020 fdu19ss沪·证书·备 19302010042·联系我们:<img src="images/icons/wechat2DCode.jpg"/>19302010042@fudan.edu.cn·举报
</footer>
</body>
</html>
