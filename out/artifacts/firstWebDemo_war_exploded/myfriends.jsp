<%@ page import="items.User" %>
<%@ page import="items.Illustration" %>
<%@ page import="java.util.List" %>
<%@ page import="demo.DAO" %>
<%@ page import="java.text.DateFormat" %><%--
  Created by IntelliJ IDEA.
  User: iceoftree
  Date: 2020/7/30
  Time: 6:31 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%
    User usr = (User) session.getAttribute("user");
    DAO dao = (DAO) session.getAttribute("dao");
    List<User> list = (List<User>) session.getAttribute("userList");
    boolean searched = request.getParameter("searched") != null && list != null && request.getParameter("searched").equals("yes");

%>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="css/nav.css" media="all">
    <link rel="stylesheet" type="text/css" href="css/search.css" media="all">
    <link rel="stylesheet" type="text/css" href="css/section-footer-pages.css" media="all">
    <link rel="stylesheet" type="text/css" href="css/footer.css" media="all">
    <link rel="stylesheet" type="text/css" href="css/myfriends.css" media="all">
    <link rel="stylesheet" type="text/css" href="css/section-footer-pages.css" media="all">


    <script src="js/clamp.js"></script>
    <script src="js/search.js"></script>
    <title>我的好友</title>
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
<div id="filter2">
    <form method="get" action="findFriends">
        <input type="radio" name="isOpen" value=true <%if(usr.getIsOpen() ==1 ) out.write("checked");%>>开放收藏
        <input type="radio" name="isOpen" value=false <%if(usr.getIsOpen() !=1 ) out.write("checked");%>>不展示收藏
        <input type="submit" name="selectOpen" value="confirm">
    </form>
</div>
<section>
    <%
        String sqlForFriendsInList = "SELECT Recipient userName, recipientUID UID, IsAccepted accepted FROM friends WHERE requesterUID = ?";
        List<User> myFriendList = dao.getForList(User.class, sqlForFriendsInList, usr.getUID());

        int a;
        for (a = 0; a < myFriendList.size(); a++) {
            User friend = myFriendList.get(a);
            User friendForDetail = User.getUserFromUID(friend.getUID(), dao);
    %>
    <div class='show-zone-container'>
        <a href='mycollection.jsp?user=<%=friend.getUID()%>&guest=<%=usr.getUID()%>'>
            <h3><%=friend.getUserName()%>
            </h3>
        </a>
        <div>
            <p class="to-be-trimmed">

                <%
                    if (friend.getAccepted() == 1) out.write("已成为好友");
                    else out.write("已发送请求");
                %><br>邮箱:<%=friendForDetail.getEmail()%>
                <br>注册时间:<%=DateFormat.getDateTimeInstance().format(friendForDetail.getRegisterTime())%>
            </p>
        </div>
    </div>
    <%}%>
</section>
<section>
    <%
        String sqlForFriendsToBe = "SELECT Requester userName, requesterUID UID FROM friends WHERE recipientUID = ? AND IsAccepted = 0";
        List<User> myFriendToBe = dao.getForList(User.class, sqlForFriendsToBe, usr.getUID());

        int b;
        for (b = 0; b < myFriendToBe.size(); b++) {
            User friendToBe = myFriendToBe.get(b);
    %>
    <div class='show-zone-container'>
        <a href='agreeToBeFriend?requester=<%=friendToBe.getUserName()%>&recipient=<%=usr.getUserName()%>&recipientUID=<%=usr.getUID()%>&requesterUID=<%=friendToBe.getUID()%>'>
            <h3><%=friendToBe.getUserName()%>
            </h3>
        </a>
        <div>
            <p class="to-be-trimmed">待通过请求
            </p>
        </div>
    </div>
    <%}%>
</section>
<div id="filter">
    <form method="post" action="findFriends">
        <input type="text" name="keyword" placeholder="type keyword here">
        <input type="submit" name="text-search" value="Search">
    </form>
</div>
<div id="recent">

    <ul>
        <%
            int i = 0;
            if (searched)
                if (list != null && list.size() > 0) {
                    out.write("<h4 id=recents>搜索结果</h4>");
                    for (i = 0; i < list.size(); i++) {
                        User account = list.get(i);
        %>
        <li <%if (i >= 8) out.write("style='display: none'");%>>
            <a href="requestFriend?requester=<%=usr.getUserName()%>&recipient=<%=account.getUserName()%>&recipientUID=<%=account.getUID()%>&requesterUID=<%=usr.getUID()%>"><%=account.getUserName()%> <%
                if (account.getState() == 1) out.write(" 在线");%></a></li>
        <%
                    }
                }
        %>
    </ul>

</div>
<div id="pages">
    <a href="#" onclick="changePage(this)" id="last-page"><</a>
    <a href="#" onclick="changePage(this)" class="page-index" id="current-page">1</a>
    <%
        int j = 0;
        while (j < (i / 8) - 1) {
            int k = j + 2;
    %>
    <a href="#" onclick="changePage(this)" class="page-index"><%=k%>
    </a>
    <%
            j++;
        }
    %>
    <a href="#" onclick="changePage(this)" id=\"next-page\">></a>
</div>
<footer>
    © 2020 fdu19ss沪·证书·备 19302010042·联系我们:<img src="images/icons/wechat2DCode.jpg"/>19302010042@fudan.edu.cn·举报
</footer>
<script type="text/javascript" src="js/changePages.js"></script>
</body>
</html>
