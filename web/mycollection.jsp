<%@ page import="demo.DAO" %>
<%@ page import="items.User" %>
<%@ page import="items.Illustration" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: iceoftree
  Date: 2020/7/30
  Time: 4:06 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%
    boolean guestMode = false;
    boolean isOpen = false;
    User guest = null, host = null, usr = null;
    List<Illustration> favorList;

    DAO dao = (DAO) session.getAttribute("dao");

    System.out.print("guest:" + request.getParameter("guest"));
    System.out.print("user:" + request.getParameter("user"));
    if (request.getParameter("guest") != null && request.getParameter("user") != null) {
        int guestUID = Integer.parseInt(request.getParameter("guest"));
        int hostUID = Integer.parseInt(request.getParameter("user"));
        host = User.getUserFromUID(hostUID, dao);
        guest = User.getUserFromUID(guestUID, dao);
        guestMode = true;
    }

%>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="css/nav.css" media="all">
    <link rel="stylesheet" type="text/css" href="css/my-collection.css" media="all">

    <link rel="stylesheet" type="text/css" href="css/section-footer-pages.css" media="all">

    <link rel="stylesheet" type="text/css" href="css/footer.css" media="all">
    <script src="js/clamp.js"></script>
    <script src="js/search.js"></script>

    <title>我的收藏</title>
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
    <header>My Collection</header>

    <%
        if (session.getAttribute("dao") == null && session.getAttribute("user") == null)
            response.sendRedirect("index.jsp");


        usr = (User) session.getAttribute("user");
        String sql = "SELECT PATH src, ImageID imageId, Title title, Description description FROM travelimage WHERE ImageID IN (SELECT ImageID FROM travelimagefavor WHERE UID = ?) LIMIT 40";


        //String isUpload = req.getParameter("isUpload");
        //Boolean up = Boolean.valueOf(isUpload);

        if (guestMode) {
            usr = host;
            String sqlForOpen = "SELECT open FROM traveluser WHERE UID = ?";
            Integer result = dao.getForValue(sqlForOpen, usr.getUID());
            isOpen = (result == 1);
            if (!isOpen)
                favorList = new ArrayList<>();
            else
                favorList = dao.getForList(Illustration.class, sql, usr.getUID());

        } else {
            favorList = dao.getForList(Illustration.class, sql, usr.getUID());
        }


    %>


    <%
        int index = 0;
        for (Illustration pic : favorList) {
    %>

    <div class='show-zone-container' <%if (index >= 8) out.write("style='display: none'");%>><a
            href="detail.jsp?imageId=<%=pic.getImageId()%>"><img class='<%=pic.getImageId()%> show-zone-image'
                                                                 id=<%=index%> src="travel-images/large/<%=pic.getSrc()%>"/></a>
        <div>
            <h3><%=pic.getTitle()%>
                <%if (!guestMode) {%>
                <button class="remove"><a href='cancelLike?ImageID=<%=pic.getImageId()%>'>取消收藏</a>
                </button>
                <%}%>
            </h3>
            <p class="to-be-trimmed"><%=pic.getDescription()%>.</p>
        </div>
    </div>

    <%
            index++;
        }

        if (!guestMode) {
            System.out.print(guestMode);
            if (index == 0)
                out.write("<h1>您还没有收藏照片，赶紧点击图片详情页的收藏按钮增加一 张吧!</h1>");
        } else if (!isOpen)
            out.write("<h1>对方设置了图片收藏不可见!</h1>");
        else if (index == 0)
            out.write("<h1>对方还没有收藏照片</h1>");
    %>

    <div id="pages">
        <a href="#" onclick="changePage(this)" id="last-page"><</a>
        <a href="#" onclick="changePage(this)" class="page-index" id="current-page">1</a>
        <%
            int i = 0;
            while (i < (index / 8) - 1) {
                int k = i + 2;
        %>
        <a href="#" onclick="changePage(this)" class="page-index"><%=k%>
        </a>
        <% i++;
        }
        %>
        <a href="#" onclick="changePage(this)" id="next-page">></a>
    </div>
</section>

<% if (!guestMode) {%>

<div id="recent">
    <%
        List<Illustration> recent = (List<Illustration>) session.getAttribute("recentlyViewed");
        if (recent.size() > 0)
            out.write("<h4 id=recents>我的足迹</h4>");
    %>
    <ul>
        <%
            List<Illustration> recentlyViewed = (List<Illustration>) session.getAttribute("recentlyViewed");
            int max = 10;
            for (int ii = 0; ii < recentlyViewed.size() && ii < max; ii++) {
                Illustration illustration = recentlyViewed.get(ii);
                if (!illustration.isAccessible())
                    continue;
        %>
        <li><a href="detail.jsp?imageId=<%=illustration.getImageId()%>"><%=illustration.getTitle()%>
        </a></li>
        <%}%>
    </ul>

</div>

<%}%>
<footer>
    © 2020 fdu19ss沪·证书·备 19302010042·联系我们:<img src="images/icons/wechat2DCode.jpg"/>19302010042@fudan.edu.cn·举报
</footer>
<script type="text/javascript" src="js/changePages.js"></script>
</body>

</html>
