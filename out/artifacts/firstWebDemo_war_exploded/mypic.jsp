<%@ page import="demo.DAO" %>
<%@ page import="items.User" %>
<%@ page import="java.util.List" %>
<%@ page import="items.Illustration" %><%--
  Created by IntelliJ IDEA.
  User: iceoftree
  Date: 2020/7/30
  Time: 1:23 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="css/nav.css" media="all">
    <link rel="stylesheet" type="text/css" href="css/my-pics.css" media="all">

    <link rel="stylesheet" type="text/css" href="css/section-footer-pages.css" media="all">

    <link rel="stylesheet" type="text/css" href="css/footer.css" media="all">
    <script src="js/clamp.js"></script>
    <script src="js/search.js"></script>
    <title>我的照片</title>
</head>
<body>

<header>
    <nav>
        <div id=logo><img src="images/icons/logo.png"/></div>
        <div id=homepage><a href="index.jsp">首页</a></div>
        <div id=search><a href="search.jsp">搜索页</a></div>
        <div class="dropdown">

            <div class="menu">
                <%
                    if (session.getAttribute("user") == null)
                        out.print("<a href=login.jsp>未登陆</a></div>");

                    else {
                        out.print(((User) session.getAttribute("user")).getUserName() + "</div>");
                %>


                <div class="drop-content">
                    <a href="upload.jsp"><img src="images/icons/upload.png"/>上传</a>
                    <a href="mypic.jsp"><img src="images/icons/my-pics.png"/>我的照片</a>
                    <a href="mycollection.jsp"><img src="images/icons/my-collection.png"/>我的收藏</a>
                    <a href="myfriends.jsp"><img src="images/icons/friend.png"/>我的好友</a>
                    <a href="logout?logout=true"><img src="images/icons/log-in.png"/>退出登录</a>
                </div>
                <%
                    }
                %>
            </div>
        </div>
    </nav>
</header>
<section>
    <header>My Photographs</header>

    <%
        DAO dao = (DAO) session.getAttribute("dao");
        User usr = (User) session.getAttribute("user");
        String sql = "SELECT PATH src, ImageID imageId, Title title, Description description FROM travelimage WHERE UID = ? LIMIT 40";
        List<Illustration> list = dao.getForList(Illustration.class, sql, usr.getUID());
        int index = 0;
        for (int i = 0; i < list.size(); i++) {
            Illustration pic = list.get(i);
    %>

    <div class='show-zone-container' <%if (index >= 8) out.write("style='display: none'");%>><a
            href="detail.jsp?imageId=<%=pic.getImageId()%>"><img class='<%=pic.getImageId()%> show-zone-image'
                                                                 id=<%=index%> src="travel-images/large/<%=pic.getSrc()%>"/></a>
        <div>
            <h3><%=pic.getTitle()%>
                <a href="upload.jsp?imageId=<%=pic.getImageId()%>">
                    <button class="modify">修改</button>
                </a>
                <a href="#" onclick="checkDelete('deletePhoto?imageId=<%=pic.getImageId()%>')">
                    <button class="delete">删除</button>
                </a>
            </h3>
            <p class="to-be-trimmed"><%=pic.getDescription()%>.</p>
        </div>
    </div>

    <%
            index++;
        }

        if (index == 0)
            out.write("<h1>您还没有上传照片，赶紧点击个人中心的上传按钮增加一 张吧!</h1>");
    %>

    <div id="pages">
        <a href="#" onclick="changePage(this)" id="last-page"><</a>
        <a href="#" onclick="changePage(this)" class="page-index" id="current-page">1</a>
        <%
            int i = 0;
            while (i < (index / 8) - 1) {
                int k = i + 2;
        %>
        <a href="#" onclick="changePage(this)" class="page-index"><%=k%></a>
        <%   i++;
            }
        %>
        <a href="#" onclick="changePage(this)" id="next-page">></a>
    </div>
</section>
<footer>
    © 2020 fdu19ss沪·证书·备 19302010042·联系我们:<img src="images/icons/wechat2DCode.jpg"/>19302010042@fudan.edu.cn·举报
</footer>
<script type="text/javascript" src="js/changePages.js"></script>
</body>
</html>
