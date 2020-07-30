<%@ page import="items.User" %>
<%@ page import="javafx.scene.layout.Background" %>
<%@ page import="java.util.List" %>
<%@ page import="items.Illustration" %>
<%@ page import="demo.DAO" %><%--
  Created by IntelliJ IDEA.
  User: iceoftree
  Date: 2020/7/29
  Time: 6:12 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="css/nav.css" media="all">
    <link rel="stylesheet" type="text/css" href="css/search.css" media="all">
    <link rel="stylesheet" type="text/css" href="css/section-footer-pages.css" media="all">
    <link rel="stylesheet" type="text/css" href="css/footer.css" media="all">
    <script src="js/clamp.js"></script>
    <script src="js/search.js"></script>
    <title>搜索页</title>
</head>
<body>
<header>
    <nav>
        <div id=logo><img src="images/icons/logo.png"/></div>
        <div id=homepage><a href="index.jsp">首页</a></div>
        <div id=this-page><a href="search.jsp">搜索页</a></div>
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
<div id="filter">
    <form method="post" action="searchServlet">
        <input type="radio" name="title-or-description" value="description">描述
        <input type="radio" name="title-or-description" value="title" checked>标题
        <input type="radio" name="popular-or-latest" value="popular" checked>热度
        <input type="radio" name="popular-or-latest" value="time">时间
        <input type="text" name="keyword" placeholder="type keyword here">
        <input type="submit" name="text-search" value="Search">
    </form>
</div>
<section>
    <%
        DAO dao = (DAO) session.getAttribute("dao");
        List<Illustration> list = (List<Illustration>) session.getAttribute("searchResult");
        boolean searched = request.getParameter("searched") != null && list != null && request.getParameter("searched").equals("yes");
        if (!searched)
            list = Illustration.getHotList(5, dao);

        int i;
        for (i = 0; i < list.size(); i++) {
            Illustration pic = list.get(i);
    %>
    <div class='show-zone-container' <%if (i >= 8) out.write("style='display: none'");%>>
        <a href='detail.jsp?imageId=<%=pic.getImageId()%>'>
            <img class='<%=pic.getImageId()%> show-zone-image' id=<%=i%> src='travel-images/large/<%=pic.getSrc()%>'/>
        </a>
        <div><h3><%=pic.getTitle()%>
        </h3>
            <p class="to-be-trimmed"><%=pic.getDescription()%>
            </p>
        </div>
    </div>
    <%}%>

    <div id="pages">
        <a href="#" onclick="changePage(this)" id="last-page"><</a>
        <a href="#" onclick="changePage(this)" class="page-index" id="current-page">1</a>
        <%
            int j = 0;
            while (j < (i / 8) - 1) {
                int k = j + 2;
        %>
        <a href="#" onclick="changePage(this)" class="page-index"><%=k%></a>
        <%
                j++;
            }
        %>
        <a href="#" onclick="changePage(this)" id=\"next-page\">></a>
    </div>
</section>
<footer>
    © 2020 fdu19ss沪·证书·备 19302010042·联系我们:<img src="images/icons/wechat2DCode.jpg"/>19302010042@fudan.edu.cn·举报
</footer>
<script type="text/javascript" src="js/changePages.js"></script>
</body>
</html>
