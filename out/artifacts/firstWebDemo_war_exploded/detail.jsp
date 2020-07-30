<%@ page import="items.Illustration" %>
<%@ page import="items.User" %>
<%@ page import="com.sun.nio.sctp.IllegalUnbindException" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="demo.DAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.DateFormat" %><%--
  Created by IntelliJ IDEA.
  User: iceoftree
  Date: 2020/7/13
  Time: 1:41 上午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<%
    boolean liked = false;
    System.out.print("a" + liked);
    DAO dao = (DAO) session.getAttribute("dao");

    int presentImageId = Integer.parseInt(request.getParameter("imageId"));
    Illustration pic = null;

    String sqlForPresentPic = "SELECT PATH src, Title title, Description description, upload_Time uploadStamp, Content category, UID authorID, ImageID imageId FROM travelimage WHERE ImageID = ?";
    //List<Illustration> pics = dao.getForList(Illustration.class, sqlForPresentPic, presentImageId);
    pic = dao.get(Illustration.class, sqlForPresentPic, presentImageId);
    //pic = pics.get(0);

    pic.setAuthorName(User.checkNameById(pic.getAuthorID(), dao));
    pic.setCity(Illustration.getCityNameByImageId(presentImageId, dao));
    pic.setCountry(Illustration.getCountryNameByImageId(presentImageId, dao));

    if (session.getAttribute("user") != null) {
        User usr = (User) session.getAttribute("user");
        String sql = "SELECT ImageID imageId FROM travelimagefavor WHERE UID = ?";
        List<Illustration> favorList = dao.getForList(Illustration.class, sql, usr.getUID());
        for (Illustration value : favorList) {
            if (presentImageId == value.getImageId()) {
                liked = true;
            }
        }

        List<Illustration> recentlyViewed = (List<Illustration>) session.getAttribute("recentlyViewed");
        boolean existed = false;
        for (Illustration illustration : recentlyViewed) {
            if (illustration.getImageId() == pic.getImageId())
                existed = true;
        }
        if (!existed)
            recentlyViewed.add(pic);
    }

%>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="css/nav.css" media="all">
    <link rel="stylesheet" type="text/css" href="css/detail.css" media="all">


    <link rel="stylesheet" type="text/css" href="css/footer.css" media="all">
    <title>图片详情</title>
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
    <div id="title"><%=pic.getTitle()%><span id="photographer">by <%=pic.getAuthorName()%></span></div>
    <div id="trunk">
        <div><img id="photo" class=<%=presentImageId%> src="travel-images/large/<%=pic.getSrc()%>">
            <button id="like"><a
                    href='<%if(!liked)out.print("likeAdded"); else out.print("cancelLike");%>?ImageID=<%=presentImageId%>'><%
                if (liked) out.print("unlike·取消收藏");
                else out.print("like·收藏");
            %></a>
            </button>
        </div>
        <table>
            <caption>Details</caption>
            <tr>
                <td>likes</td>
                <td><%=Illustration.getLikesByImageId(presentImageId, dao)%>
                </td>
            </tr>
            <tr>
                <td>content</td>
                <td><%=pic.getCategory()%>
                </td>
            </tr>
            <tr>
                <td>country</td>
                <td><%=pic.getCountry()%>
                </td>
            </tr>
            <tr>
                <td>city</td>
                <td><%=pic.getCity()%>
                </td>
            </tr>
            <tr>
                <td>upload-time</td>
                <td><%=DateFormat.getDateTimeInstance().format(pic.getUploadStamp())%>
                </td>
            </tr>
        </table>
        <p id="complete-description">description:<%=pic.getDescription()%>
        </p></div>
</section>
<footer>
    © 2020 fdu19ss沪·证书·备 19302010042·联系我们:<img src="images/icons/wechat2DCode.jpg"/>19302010042@fudan.edu.cn·举报
</footer>
</body>
</html>