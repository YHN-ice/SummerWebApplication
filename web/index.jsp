<%@ page import="demo.DAO" %>
<%@ page import="items.Illustration" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="items.User" %><%--
  Created by IntelliJ IDEA.
  User: iceoftree
  Date: 2020/7/10
  Time: 10:11 上午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="css/nav.css" media="all">
    <link rel="stylesheet" type="text/css" href="css/homepage.css" media="all">
    <link rel="stylesheet" type="text/css" href="css/footer.css" media="all">
    <script src="js/homepage.js"></script>
    <title>首页</title>
</head>
<body>
<header>
    <nav>
        <div id=logo><img src="images/icons/logo.png"/></div>
        <div id=this-page><a href="index.jsp">首页</a></div>
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
    <div id=auto-display-container>
        <div id=wrap>
            <%
                DAO dao = new DAO();
                session.setAttribute("dao", dao);
                List<Illustration> list = Illustration.getHotList(5,dao);
                for (int i = 0; i < list.size(); i++) {
            %>
            <a href="detail.jsp?imageId=<%=list.get(i).getImageId()%>"><img
                    src="travel-images/large/<%=list.get(i).getSrc()%>"/></a>
            <%
                }
            %>
        </div>
        <div class="buttons">
            <span class="on">1</span>
            <span>2</span>
            <span>3</span>
            <span>4</span>
            <span>5</span>
        </div>
        <a href="javascript:" class="arrow arrow_left">&lt;</a>
        <a href="javascript:" class="arrow arrow_right">&gt;</a>
    </div>
</section>

<aside>
    <div id="show-zone">
        <%
            DateFormat dateFormat = DateFormat.getDateTimeInstance();
            String sqlForRecentPics = "SELECT PATH src, Title title, Description description, upload_Time uploadStamp, UID authorID, travelimage.ImageID imageId FROM travelimage WHERE travelimage.ImageID IN" +
                    "(SELECT travelimage.ImageID FROM travelimage GROUP BY ImageID ORDER BY COUNT(upload_Time) DESC) LIMIT ?";
            List<Illustration> listForRecentPics = dao.getForList(Illustration.class, sqlForRecentPics, 20);

            for (int i = 0; i < listForRecentPics.size(); i++) {
                int authorID = listForRecentPics.get(i).getAuthorID();
                String authorName = User.checkNameById(authorID, dao);


        %>
        <div><a href="detail.jsp?imageId=<%=listForRecentPics.get(i).getImageId()%>"><img
                src="travel-images/large/<%=listForRecentPics.get(i).getSrc()%>"/></a>
            <h3><%=listForRecentPics.get(i).getTitle()%></h3>
            <h6><%=authorName%>
            </h6>
            <p><%=dateFormat.format(listForRecentPics.get(i).getUploadStamp())%>
            </p></div>
        <%
            }
        %>

    </div>
</aside>
<div id="accessibility-icons">
    <button id="back-to-top" onclick="back_to_top()"><img src="images/icons/Back-to-top.png"/>️</button>
</div>
<footer>
    © 2020 fdu19ss沪·证书·备 19302010042·联系我们:<img src="images/icons/wechat2DCode.jpg"/>19302010042@fudan.edu.cn·举报
</footer>
<script src="js/autoPlay.js"></script>
</body>
</html>
