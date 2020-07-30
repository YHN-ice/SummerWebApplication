<%@ page import="items.User" %>
<%@ page import="items.Illustration" %>
<%@ page import="demo.DAO" %>
<%@ page import="java.util.List" %>
<%@ page import="items.City" %><%--
  Created by IntelliJ IDEA.
  User: iceoftree
  Date: 2020/7/29
  Time: 10:40 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="css/nav.css" media="all">
    <link rel="stylesheet" type="text/css" href="css/upload.css" media="all">
    <link rel="stylesheet" type="text/css" href="css/footer.css" media="all">
    <script src="js/upload.js"></script>
    <script type="text/javascript" src="js/selector-onchange.js"></script>

    <title>上传页</title>
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
<%
    boolean isUpload = true;
    Illustration pic = null;
    DAO dao = (DAO) session.getAttribute("dao");
    if (request.getParameter("imageId") != null)
        isUpload = false;
    if (!isUpload) {
        int imageId = Integer.parseInt(request.getParameter("imageId"));
        String sql = "SELECT ImageID imageId, Title title, Description description, Content category, PATH src, CityCode cityCode,Country_RegionCodeISO countryISO, UID authorID,upload_Time uploadStamp FROM travelimage WHERE ImageID = ?";
        pic = dao.get(Illustration.class, sql, imageId);
    }

%>
<form method="post" enctype="multipart/form-data" action='uploadHandler'>
    <%if (!isUpload) {%>
    <img src="travel-images/large/<%=pic.getSrc()%>" alt="图片未上传" id="preview" class="text"/>
    <% } else { %>
    <img src="" alt="图片未上传" id="preview" class="text"/>
    <%}%>
    <%if (isUpload) {%><input type="file" name="file" onchange="previewFile(this)" class="text" required><%}%>
    <div><span class="text">图片标题</span>
        <%if (!isUpload) {%>
        <input type="text" name="title" value="<%=pic.getTitle()%>" pattern=\"{0,28}\" required>
        <% } else { %>
        <input type="text" name="title" pattern=\"{0,28}\" required>
        <%}%>
    </div>
    <p class="text">图片描述</p>
    <%if (!isUpload) {%>
    <textarea name="description" value="<%=pic.getDescription()%>" required></textarea>
    <% } else { %>
    <textarea name="description" required></textarea>
    <%}%>
    <p class="text">图片主题</p>
    <select name="content" id="content-selector"
            required>
        <option value="scenery" <%if (!isUpload && pic.getCategory().equals("scenery")) out.write("selected");%>>
            Scenery
        </option>
        <option value="city" <%if (!isUpload && pic.getCategory().equals("city")) out.write("selected");%>>City</option>
        <option value="people" <%if (!isUpload && pic.getCategory().equals("people")) out.write("selected");%>>People
        </option>
        <option value="animal" <%if (!isUpload && pic.getCategory().equals("animal")) out.write("selected");%>>Animal
        </option>
        <option value="building" <%if (!isUpload && pic.getCategory().equals("building")) out.write("selected");%>>
            Building
        </option>
        <option value="wonder" <%if (!isUpload && pic.getCategory().equals("wonder")) out.write("selected");%>>Wonder
        </option>
        <option value="other" <%if (!isUpload && pic.getCategory().equals("other")) out.write("selected");%>>Other
        </option>
    </select>
    <p class="text">拍摄国家</p>

    <select name="countries" id="country-selector" onchange="getCities(this, this.form.cities,true)" required>
        <option value="AD" <%if (!isUpload && pic.getCountryISO().equals("AD")) out.write("selected");%>>Andorra
        </option>
        <option value="AE" <%if (!isUpload && pic.getCountryISO().equals("AE")) out.write("selected");%>>United Arab
            Emirates
        </option>
        <option value="AF" <%if (!isUpload && pic.getCountryISO().equals("AF")) out.write("selected");%>>Afghanistan
        </option>
        <option value="AG" <%if (!isUpload && pic.getCountryISO().equals("AG")) out.write("selected");%>>Antigua and
            Barbuda
        </option>
        <option value="AI" <%if (!isUpload && pic.getCountryISO().equals("AI")) out.write("selected");%>>Anguilla
        </option>
        <option value="AL" <%if (!isUpload && pic.getCountryISO().equals("AL")) out.write("selected");%>>Albania
        </option>
        <option value="AM" <%if (!isUpload && pic.getCountryISO().equals("AM")) out.write("selected");%>>Armenia
        </option>
        <option value="AN" <%if (!isUpload && pic.getCountryISO().equals("AN")) out.write("selected");%>>Netherlands
            Antilles
        </option>
        <option value="AO" <%if (!isUpload && pic.getCountryISO().equals("AO")) out.write("selected");%>>Angola</option>
        <option value="AQ" <%if (!isUpload && pic.getCountryISO().equals("AQ")) out.write("selected");%>>Antarctica
        </option>
        <option value="AR" <%if (!isUpload && pic.getCountryISO().equals("AR")) out.write("selected");%>>Argentina
        </option>
        <option value="AS" <%if (!isUpload && pic.getCountryISO().equals("AS")) out.write("selected");%>>American
            Samoa
        </option>
        <option value="AT" <%if (!isUpload && pic.getCountryISO().equals("AT")) out.write("selected");%>>Austria
        </option>
        <option value="AU" <%if (!isUpload && pic.getCountryISO().equals("AU")) out.write("selected");%>>Australia
        </option>
        <option value="AW" <%if (!isUpload && pic.getCountryISO().equals("AW")) out.write("selected");%>>Aruba</option>
        <option value="AX" <%if (!isUpload && pic.getCountryISO().equals("AX")) out.write("selected");%>>Aland Islands
        </option>
        <option value="AZ" <%if (!isUpload && pic.getCountryISO().equals("AZ")) out.write("selected");%>>Azerbaijan
        </option>
        <option value="BA" <%if (!isUpload && pic.getCountryISO().equals("BA")) out.write("selected");%>>Bosnia and
            Herzegovina
        </option>
        <option value="BB" <%if (!isUpload && pic.getCountryISO().equals("BB")) out.write("selected");%>>Barbados
        </option>
        <option value="BD" <%if (!isUpload && pic.getCountryISO().equals("BD")) out.write("selected");%>>Bangladesh
        </option>
        <option value="BE" <%if (!isUpload && pic.getCountryISO().equals("BE")) out.write("selected");%>>Belgium
        </option>
        <option value="BF" <%if (!isUpload && pic.getCountryISO().equals("BF")) out.write("selected");%>>Burkina Faso
        </option>
        <option value="BG" <%if (!isUpload && pic.getCountryISO().equals("BG")) out.write("selected");%>>Bulgaria
        </option>
        <option value="BH" <%if (!isUpload && pic.getCountryISO().equals("BH")) out.write("selected");%>>Bahrain
        </option>
        <option value="BI" <%if (!isUpload && pic.getCountryISO().equals("BI")) out.write("selected");%>>Burundi
        </option>
        <option value="BJ" <%if (!isUpload && pic.getCountryISO().equals("BJ")) out.write("selected");%>>Benin</option>
        <option value="BL" <%if (!isUpload && pic.getCountryISO().equals("BL")) out.write("selected");%>>Saint
            Barthelemy
        </option>
        <option value="BM" <%if (!isUpload && pic.getCountryISO().equals("BM")) out.write("selected");%>>Bermuda
        </option>
        <option value="BN" <%if (!isUpload && pic.getCountryISO().equals("BN")) out.write("selected");%>>Brunei</option>
        <option value="BO" <%if (!isUpload && pic.getCountryISO().equals("BO")) out.write("selected");%>>Bolivia
        </option>
        <option value="BQ" <%if (!isUpload && pic.getCountryISO().equals("BQ")) out.write("selected");%>>Bonaire, Saint
            Eustatius and Saba
        </option>
        <option value="BR" <%if (!isUpload && pic.getCountryISO().equals("BR")) out.write("selected");%>>Brazil</option>
        <option value="BS" <%if (!isUpload && pic.getCountryISO().equals("BS")) out.write("selected");%>>Bahamas
        </option>
        <option value="BT" <%if (!isUpload && pic.getCountryISO().equals("BT")) out.write("selected");%>>Bhutan</option>
        <option value="BV" <%if (!isUpload && pic.getCountryISO().equals("BV")) out.write("selected");%>>Bouvet Island
        </option>
        <option value="BW" <%if (!isUpload && pic.getCountryISO().equals("BW")) out.write("selected");%>>Botswana
        </option>
        <option value="BY" <%if (!isUpload && pic.getCountryISO().equals("BY")) out.write("selected");%>>Belarus
        </option>
        <option value="BZ" <%if (!isUpload && pic.getCountryISO().equals("BZ")) out.write("selected");%>>Belize</option>
        <option value="CA" <%if (!isUpload && pic.getCountryISO().equals("CA")) out.write("selected");%>>Canada</option>
        <option value="CC" <%if (!isUpload && pic.getCountryISO().equals("CC")) out.write("selected");%>>Cocos Islands
        </option>
        <option value="CD" <%if (!isUpload && pic.getCountryISO().equals("CD")) out.write("selected");%>>Democratic
            Republic of the Congo
        </option>
        <option value="CF" <%if (!isUpload && pic.getCountryISO().equals("CF")) out.write("selected");%>>Central African
            Republic
        </option>
        <option value="CG" <%if (!isUpload && pic.getCountryISO().equals("CG")) out.write("selected");%>>Republic of the
            Congo
        </option>
        <option value="CH" <%if (!isUpload && pic.getCountryISO().equals("CH")) out.write("selected");%>>Switzerland
        </option>
        <option value="CI" <%if (!isUpload && pic.getCountryISO().equals("CI")) out.write("selected");%>>Ivory Coast
        </option>
        <option value="CK" <%if (!isUpload && pic.getCountryISO().equals("CK")) out.write("selected");%>>Cook Islands
        </option>
        <option value="CL" <%if (!isUpload && pic.getCountryISO().equals("CL")) out.write("selected");%>>Chile</option>
        <option value="CM" <%if (!isUpload && pic.getCountryISO().equals("CM")) out.write("selected");%>>Cameroon
        </option>
        <option value="CN" <%if (!isUpload && pic.getCountryISO().equals("CN")) out.write("selected");%>>China</option>
        <option value="CO" <%if (!isUpload && pic.getCountryISO().equals("CO")) out.write("selected");%>>Colombia
        </option>
        <option value="CR" <%if (!isUpload && pic.getCountryISO().equals("CR")) out.write("selected");%>>Costa Rica
        </option>
        <option value="CS" <%if (!isUpload && pic.getCountryISO().equals("CS")) out.write("selected");%>>Serbia and
            Montenegro
        </option>
        <option value="CU" <%if (!isUpload && pic.getCountryISO().equals("CU")) out.write("selected");%>>Cuba</option>
        <option value="CV" <%if (!isUpload && pic.getCountryISO().equals("CV")) out.write("selected");%>>Cape Verde
        </option>
        <option value="CW" <%if (!isUpload && pic.getCountryISO().equals("CW")) out.write("selected");%>>Curacao
        </option>
        <option value="CX" <%if (!isUpload && pic.getCountryISO().equals("CX")) out.write("selected");%>>Christmas
            Island
        </option>
        <option value="CY" <%if (!isUpload && pic.getCountryISO().equals("CY")) out.write("selected");%>>Cyprus</option>
        <option value="CZ" <%if (!isUpload && pic.getCountryISO().equals("CZ")) out.write("selected");%>>Czech
            Republic
        </option>
        <option value="DE" <%if (!isUpload && pic.getCountryISO().equals("DE")) out.write("selected");%>>Germany
        </option>
        <option value="DJ" <%if (!isUpload && pic.getCountryISO().equals("DJ")) out.write("selected");%>>Djibouti
        </option>
        <option value="DK" <%if (!isUpload && pic.getCountryISO().equals("DK")) out.write("selected");%>>Denmark
        </option>
        <option value="DM" <%if (!isUpload && pic.getCountryISO().equals("DM")) out.write("selected");%>>Dominica
        </option>
        <option value="DO" <%if (!isUpload && pic.getCountryISO().equals("DO")) out.write("selected");%>>Dominican
            Republic
        </option>
        <option value="DZ" <%if (!isUpload && pic.getCountryISO().equals("DZ")) out.write("selected");%>>Algeria
        </option>
        <option value="EC" <%if (!isUpload && pic.getCountryISO().equals("EC")) out.write("selected");%>>Ecuador
        </option>
        <option value="EE" <%if (!isUpload && pic.getCountryISO().equals("EE")) out.write("selected");%>>Estonia
        </option>
        <option value="EG" <%if (!isUpload && pic.getCountryISO().equals("EG")) out.write("selected");%>>Egypt</option>
        <option value="EH" <%if (!isUpload && pic.getCountryISO().equals("EH")) out.write("selected");%>>Western
            Sahara
        </option>
        <option value="ER" <%if (!isUpload && pic.getCountryISO().equals("ER")) out.write("selected");%>>Eritrea
        </option>
        <option value="ES" <%if (!isUpload && pic.getCountryISO().equals("ES")) out.write("selected");%>>Spain</option>
        <option value="ET" <%if (!isUpload && pic.getCountryISO().equals("ET")) out.write("selected");%>>Ethiopia
        </option>
        <option value="FI" <%if (!isUpload && pic.getCountryISO().equals("FI")) out.write("selected");%>>Finland
        </option>
        <option value="FJ" <%if (!isUpload && pic.getCountryISO().equals("FJ")) out.write("selected");%>>Fiji</option>
        <option value="FK" <%if (!isUpload && pic.getCountryISO().equals("FK")) out.write("selected");%>>Falkland
            Islands
        </option>
        <option value="FM" <%if (!isUpload && pic.getCountryISO().equals("FM")) out.write("selected");%>>Micronesia
        </option>
        <option value="FO" <%if (!isUpload && pic.getCountryISO().equals("FO")) out.write("selected");%>>Faroe Islands
        </option>
        <option value="FR" <%if (!isUpload && pic.getCountryISO().equals("FR")) out.write("selected");%>>France</option>
        <option value="GA" <%if (!isUpload && pic.getCountryISO().equals("GA")) out.write("selected");%>>Gabon</option>
        <option value="GB" <%if (!isUpload && pic.getCountryISO().equals("GB")) out.write("selected");%>>United
            Kingdom
        </option>
        <option value="GD" <%if (!isUpload && pic.getCountryISO().equals("GD")) out.write("selected");%>>Grenada
        </option>
        <option value="GE" <%if (!isUpload && pic.getCountryISO().equals("GE")) out.write("selected");%>>Georgia
        </option>
        <option value="GF" <%if (!isUpload && pic.getCountryISO().equals("GF")) out.write("selected");%>>French Guiana
        </option>
        <option value="GG" <%if (!isUpload && pic.getCountryISO().equals("GG")) out.write("selected");%>>Guernsey
        </option>
        <option value="GH" <%if (!isUpload && pic.getCountryISO().equals("GH")) out.write("selected");%>>Ghana</option>
        <option value="GI" <%if (!isUpload && pic.getCountryISO().equals("GI")) out.write("selected");%>>Gibraltar
        </option>
        <option value="GL" <%if (!isUpload && pic.getCountryISO().equals("GL")) out.write("selected");%>>Greenland
        </option>
        <option value="GM" <%if (!isUpload && pic.getCountryISO().equals("GM")) out.write("selected");%>>Gambia</option>
        <option value="GN" <%if (!isUpload && pic.getCountryISO().equals("GN")) out.write("selected");%>>Guinea</option>
        <option value="GP" <%if (!isUpload && pic.getCountryISO().equals("GP")) out.write("selected");%>>Guadeloupe
        </option>
        <option value="GQ" <%if (!isUpload && pic.getCountryISO().equals("GQ")) out.write("selected");%>>Equatorial
            Guinea
        </option>
        <option value="GR" <%if (!isUpload && pic.getCountryISO().equals("GR")) out.write("selected");%>>Greece</option>
        <option value="GS" <%if (!isUpload && pic.getCountryISO().equals("GS")) out.write("selected");%>>South Georgia
            and the South Sandwich Islands
        </option>
        <option value="GT" <%if (!isUpload && pic.getCountryISO().equals("GT")) out.write("selected");%>>Guatemala
        </option>
        <option value="GU" <%if (!isUpload && pic.getCountryISO().equals("GU")) out.write("selected");%>>Guam</option>
        <option value="GW" <%if (!isUpload && pic.getCountryISO().equals("GW")) out.write("selected");%>>Guinea-Bissau
        </option>
        <option value="GY" <%if (!isUpload && pic.getCountryISO().equals("GY")) out.write("selected");%>>Guyana</option>
        <option value="HK" <%if (!isUpload && pic.getCountryISO().equals("HK")) out.write("selected");%>>Hong Kong
        </option>
        <option value="HM" <%if (!isUpload && pic.getCountryISO().equals("HM")) out.write("selected");%>>Heard Island
            and McDonald Islands
        </option>
        <option value="HN" <%if (!isUpload && pic.getCountryISO().equals("HN")) out.write("selected");%>>Honduras
        </option>
        <option value="HR" <%if (!isUpload && pic.getCountryISO().equals("HR")) out.write("selected");%>>Croatia
        </option>
        <option value="HT" <%if (!isUpload && pic.getCountryISO().equals("HT")) out.write("selected");%>>Haiti</option>
        <option value="HU" <%if (!isUpload && pic.getCountryISO().equals("HU")) out.write("selected");%>>Hungary
        </option>
        <option value="ID" <%if (!isUpload && pic.getCountryISO().equals("ID")) out.write("selected");%>>Indonesia
        </option>
        <option value="IE" <%if (!isUpload && pic.getCountryISO().equals("IE")) out.write("selected");%>>Ireland
        </option>
        <option value="IL" <%if (!isUpload && pic.getCountryISO().equals("IL")) out.write("selected");%>>Israel</option>
        <option value="IM" <%if (!isUpload && pic.getCountryISO().equals("IM")) out.write("selected");%>>Isle of Man
        </option>
        <option value="IN" <%if (!isUpload && pic.getCountryISO().equals("IN")) out.write("selected");%>>India</option>
        <option value="IO" <%if (!isUpload && pic.getCountryISO().equals("IO")) out.write("selected");%>>British Indian
            Ocean Territory
        </option>
        <option value="IQ" <%if (!isUpload && pic.getCountryISO().equals("IQ")) out.write("selected");%>>Iraq</option>
        <option value="IR" <%if (!isUpload && pic.getCountryISO().equals("IR")) out.write("selected");%>>Iran</option>
        <option value="IS" <%if (!isUpload && pic.getCountryISO().equals("IS")) out.write("selected");%>>Iceland
        </option>
        <option value="IT" <%if (!isUpload && pic.getCountryISO().equals("IT")) out.write("selected");%>>Italy</option>
        <option value="JE" <%if (!isUpload && pic.getCountryISO().equals("JE")) out.write("selected");%>>Jersey</option>
        <option value="JM" <%if (!isUpload && pic.getCountryISO().equals("JM")) out.write("selected");%>>Jamaica
        </option>
        <option value="JO" <%if (!isUpload && pic.getCountryISO().equals("JO")) out.write("selected");%>>Jordan</option>
        <option value="JP" <%if (!isUpload && pic.getCountryISO().equals("JP")) out.write("selected");%>>Japan</option>
        <option value="KE" <%if (!isUpload && pic.getCountryISO().equals("KE")) out.write("selected");%>>Kenya</option>
        <option value="KG" <%if (!isUpload && pic.getCountryISO().equals("KG")) out.write("selected");%>>Kyrgyzstan
        </option>
        <option value="KH" <%if (!isUpload && pic.getCountryISO().equals("KH")) out.write("selected");%>>Cambodia
        </option>
        <option value="KI" <%if (!isUpload && pic.getCountryISO().equals("KI")) out.write("selected");%>>Kiribati
        </option>
        <option value="KM" <%if (!isUpload && pic.getCountryISO().equals("KM")) out.write("selected");%>>Comoros
        </option>
        <option value="KN" <%if (!isUpload && pic.getCountryISO().equals("KN")) out.write("selected");%>>Saint Kitts and
            Nevis
        </option>
        <option value="KP" <%if (!isUpload && pic.getCountryISO().equals("KP")) out.write("selected");%>>North Korea
        </option>
        <option value="KR" <%if (!isUpload && pic.getCountryISO().equals("KR")) out.write("selected");%>>South Korea
        </option>
        <option value="KW" <%if (!isUpload && pic.getCountryISO().equals("KW")) out.write("selected");%>>Kuwait</option>
        <option value="KY" <%if (!isUpload && pic.getCountryISO().equals("KY")) out.write("selected");%>>Cayman
            Islands
        </option>
        <option value="KZ" <%if (!isUpload && pic.getCountryISO().equals("KZ")) out.write("selected");%>>Kazakhstan
        </option>
        <option value="LA" <%if (!isUpload && pic.getCountryISO().equals("LA")) out.write("selected");%>>Laos</option>
        <option value="LB" <%if (!isUpload && pic.getCountryISO().equals("LB")) out.write("selected");%>>Lebanon
        </option>
        <option value="LC" <%if (!isUpload && pic.getCountryISO().equals("LC")) out.write("selected");%>>Saint Lucia
        </option>
        <option value="LI" <%if (!isUpload && pic.getCountryISO().equals("LI")) out.write("selected");%>>Liechtenstein
        </option>
        <option value="LK" <%if (!isUpload && pic.getCountryISO().equals("LK")) out.write("selected");%>>Sri Lanka
        </option>
        <option value="LR" <%if (!isUpload && pic.getCountryISO().equals("LR")) out.write("selected");%>>Liberia
        </option>
        <option value="LS" <%if (!isUpload && pic.getCountryISO().equals("LS")) out.write("selected");%>>Lesotho
        </option>
        <option value="LT" <%if (!isUpload && pic.getCountryISO().equals("LT")) out.write("selected");%>>Lithuania
        </option>
        <option value="LU" <%if (!isUpload && pic.getCountryISO().equals("LU")) out.write("selected");%>>Luxembourg
        </option>
        <option value="LV" <%if (!isUpload && pic.getCountryISO().equals("LV")) out.write("selected");%>>Latvia</option>
        <option value="LY" <%if (!isUpload && pic.getCountryISO().equals("LY")) out.write("selected");%>>Libya</option>
        <option value="MA" <%if (!isUpload && pic.getCountryISO().equals("MA")) out.write("selected");%>>Morocco
        </option>
        <option value="MC" <%if (!isUpload && pic.getCountryISO().equals("MC")) out.write("selected");%>>Monaco</option>
        <option value="MD" <%if (!isUpload && pic.getCountryISO().equals("MD")) out.write("selected");%>>Moldova
        </option>
        <option value="ME" <%if (!isUpload && pic.getCountryISO().equals("ME")) out.write("selected");%>>Montenegro
        </option>
        <option value="MF" <%if (!isUpload && pic.getCountryISO().equals("MF")) out.write("selected");%>>Saint Martin
        </option>
        <option value="MG" <%if (!isUpload && pic.getCountryISO().equals("MG")) out.write("selected");%>>Madagascar
        </option>
        <option value="MH" <%if (!isUpload && pic.getCountryISO().equals("MH")) out.write("selected");%>>Marshall
            Islands
        </option>
        <option value="MK" <%if (!isUpload && pic.getCountryISO().equals("MK")) out.write("selected");%>>Macedonia
        </option>
        <option value="ML" <%if (!isUpload && pic.getCountryISO().equals("ML")) out.write("selected");%>>Mali</option>
        <option value="MM" <%if (!isUpload && pic.getCountryISO().equals("MM")) out.write("selected");%>>Myanmar
        </option>
        <option value="MN" <%if (!isUpload && pic.getCountryISO().equals("MN")) out.write("selected");%>>Mongolia
        </option>
        <option value="MO" <%if (!isUpload && pic.getCountryISO().equals("MO")) out.write("selected");%>>Macao</option>
        <option value="MP" <%if (!isUpload && pic.getCountryISO().equals("MP")) out.write("selected");%>>Northern
            Mariana Islands
        </option>
        <option value="MQ" <%if (!isUpload && pic.getCountryISO().equals("MQ")) out.write("selected");%>>Martinique
        </option>
        <option value="MR" <%if (!isUpload && pic.getCountryISO().equals("MR")) out.write("selected");%>>Mauritania
        </option>
        <option value="MS" <%if (!isUpload && pic.getCountryISO().equals("MS")) out.write("selected");%>>Montserrat
        </option>
        <option value="MT" <%if (!isUpload && pic.getCountryISO().equals("MT")) out.write("selected");%>>Malta</option>
        <option value="MU" <%if (!isUpload && pic.getCountryISO().equals("MU")) out.write("selected");%>>Mauritius
        </option>
        <option value="MV" <%if (!isUpload && pic.getCountryISO().equals("MV")) out.write("selected");%>>Maldives
        </option>
        <option value="MW" <%if (!isUpload && pic.getCountryISO().equals("MW")) out.write("selected");%>>Malawi</option>
        <option value="MX" <%if (!isUpload && pic.getCountryISO().equals("MX")) out.write("selected");%>>Mexico</option>
        <option value="MY" <%if (!isUpload && pic.getCountryISO().equals("MY")) out.write("selected");%>>Malaysia
        </option>
        <option value="MZ" <%if (!isUpload && pic.getCountryISO().equals("MZ")) out.write("selected");%>>Mozambique
        </option>
        <option value="NA" <%if (!isUpload && pic.getCountryISO().equals("NA")) out.write("selected");%>>Namibia
        </option>
        <option value="NC" <%if (!isUpload && pic.getCountryISO().equals("NC")) out.write("selected");%>>New Caledonia
        </option>
        <option value="NE" <%if (!isUpload && pic.getCountryISO().equals("NE")) out.write("selected");%>>Niger</option>
        <option value="NF" <%if (!isUpload && pic.getCountryISO().equals("NF")) out.write("selected");%>>Norfolk
            Island
        </option>
        <option value="NG" <%if (!isUpload && pic.getCountryISO().equals("NG")) out.write("selected");%>>Nigeria
        </option>
        <option value="NI" <%if (!isUpload && pic.getCountryISO().equals("NI")) out.write("selected");%>>Nicaragua
        </option>
        <option value="NL" <%if (!isUpload && pic.getCountryISO().equals("NL")) out.write("selected");%>>Netherlands
        </option>
        <option value="NO" <%if (!isUpload && pic.getCountryISO().equals("NO")) out.write("selected");%>>Norway</option>
        <option value="NP" <%if (!isUpload && pic.getCountryISO().equals("NP")) out.write("selected");%>>Nepal</option>
        <option value="NR" <%if (!isUpload && pic.getCountryISO().equals("NR")) out.write("selected");%>>Nauru</option>
        <option value="NU" <%if (!isUpload && pic.getCountryISO().equals("NU")) out.write("selected");%>>Niue</option>
        <option value="NZ" <%if (!isUpload && pic.getCountryISO().equals("NZ")) out.write("selected");%>>New Zealand
        </option>
        <option value="OM" <%if (!isUpload && pic.getCountryISO().equals("OM")) out.write("selected");%>>Oman</option>
        <option value="PA" <%if (!isUpload && pic.getCountryISO().equals("PA")) out.write("selected");%>>Panama</option>
        <option value="PE" <%if (!isUpload && pic.getCountryISO().equals("PE")) out.write("selected");%>>Peru</option>
        <option value="PF" <%if (!isUpload && pic.getCountryISO().equals("PF")) out.write("selected");%>>French
            Polynesia
        </option>
        <option value="PG" <%if (!isUpload && pic.getCountryISO().equals("PG")) out.write("selected");%>>Papua New
            Guinea
        </option>
        <option value="PH" <%if (!isUpload && pic.getCountryISO().equals("PH")) out.write("selected");%>>Philippines
        </option>
        <option value="PK" <%if (!isUpload && pic.getCountryISO().equals("PK")) out.write("selected");%>>Pakistan
        </option>
        <option value="PL" <%if (!isUpload && pic.getCountryISO().equals("PL")) out.write("selected");%>>Poland</option>
        <option value="PM" <%if (!isUpload && pic.getCountryISO().equals("PM")) out.write("selected");%>>Saint Pierre
            and Miquelon
        </option>
        <option value="PN" <%if (!isUpload && pic.getCountryISO().equals("PN")) out.write("selected");%>>Pitcairn
        </option>
        <option value="PR" <%if (!isUpload && pic.getCountryISO().equals("PR")) out.write("selected");%>>Puerto Rico
        </option>
        <option value="PS" <%if (!isUpload && pic.getCountryISO().equals("PS")) out.write("selected");%>>Palestinian
            Territory
        </option>
        <option value="PT" <%if (!isUpload && pic.getCountryISO().equals("PT")) out.write("selected");%>>Portugal
        </option>
        <option value="PW" <%if (!isUpload && pic.getCountryISO().equals("PW")) out.write("selected");%>>Palau</option>
        <option value="PY" <%if (!isUpload && pic.getCountryISO().equals("PY")) out.write("selected");%>>Paraguay
        </option>
        <option value="QA" <%if (!isUpload && pic.getCountryISO().equals("QA")) out.write("selected");%>>Qatar</option>
        <option value="RE" <%if (!isUpload && pic.getCountryISO().equals("RE")) out.write("selected");%>>Reunion
        </option>
        <option value="RO" <%if (!isUpload && pic.getCountryISO().equals("RO")) out.write("selected");%>>Romania
        </option>
        <option value="RS" <%if (!isUpload && pic.getCountryISO().equals("RS")) out.write("selected");%>>Serbia</option>
        <option value="RU" <%if (!isUpload && pic.getCountryISO().equals("RU")) out.write("selected");%>>Russia</option>
        <option value="RW" <%if (!isUpload && pic.getCountryISO().equals("RW")) out.write("selected");%>>Rwanda</option>
        <option value="SA" <%if (!isUpload && pic.getCountryISO().equals("SA")) out.write("selected");%>>Saudi Arabia
        </option>
        <option value="SB" <%if (!isUpload && pic.getCountryISO().equals("SB")) out.write("selected");%>>Solomon
            Islands
        </option>
        <option value="SC" <%if (!isUpload && pic.getCountryISO().equals("SC")) out.write("selected");%>>Seychelles
        </option>
        <option value="SD" <%if (!isUpload && pic.getCountryISO().equals("SD")) out.write("selected");%>>Sudan</option>
        <option value="SE" <%if (!isUpload && pic.getCountryISO().equals("SE")) out.write("selected");%>>Sweden</option>
        <option value="SG" <%if (!isUpload && pic.getCountryISO().equals("SG")) out.write("selected");%>>Singapore
        </option>
        <option value="SH" <%if (!isUpload && pic.getCountryISO().equals("SH")) out.write("selected");%>>Saint Helena
        </option>
        <option value="SI" <%if (!isUpload && pic.getCountryISO().equals("SI")) out.write("selected");%>>Slovenia
        </option>
        <option value="SJ" <%if (!isUpload && pic.getCountryISO().equals("SJ")) out.write("selected");%>>Svalbard and
            Jan Mayen
        </option>
        <option value="SK" <%if (!isUpload && pic.getCountryISO().equals("SK")) out.write("selected");%>>Slovakia
        </option>
        <option value="SL" <%if (!isUpload && pic.getCountryISO().equals("SL")) out.write("selected");%>>Sierra Leone
        </option>
        <option value="SM" <%if (!isUpload && pic.getCountryISO().equals("SM")) out.write("selected");%>>San Marino
        </option>
        <option value="SN" <%if (!isUpload && pic.getCountryISO().equals("SN")) out.write("selected");%>>Senegal
        </option>
        <option value="SO" <%if (!isUpload && pic.getCountryISO().equals("SO")) out.write("selected");%>>Somalia
        </option>
        <option value="SR" <%if (!isUpload && pic.getCountryISO().equals("SR")) out.write("selected");%>>Suriname
        </option>
        <option value="SS" <%if (!isUpload && pic.getCountryISO().equals("SS")) out.write("selected");%>>South Sudan
        </option>
        <option value="ST" <%if (!isUpload && pic.getCountryISO().equals("ST")) out.write("selected");%>>Sao Tome and
            Principe
        </option>
        <option value="SV" <%if (!isUpload && pic.getCountryISO().equals("SV")) out.write("selected");%>>El Salvador
        </option>
        <option value="SX" <%if (!isUpload && pic.getCountryISO().equals("SX")) out.write("selected");%>>Sint Maarten
        </option>
        <option value="SY" <%if (!isUpload && pic.getCountryISO().equals("SY")) out.write("selected");%>>Syria</option>
        <option value="SZ" <%if (!isUpload && pic.getCountryISO().equals("SZ")) out.write("selected");%>>Swaziland
        </option>
        <option value="TC" <%if (!isUpload && pic.getCountryISO().equals("TC")) out.write("selected");%>>Turks and
            Caicos Islands
        </option>
        <option value="TD" <%if (!isUpload && pic.getCountryISO().equals("TD")) out.write("selected");%>>Chad</option>
        <option value="TF" <%if (!isUpload && pic.getCountryISO().equals("TF")) out.write("selected");%>>French Southern
            Territories
        </option>
        <option value="TG" <%if (!isUpload && pic.getCountryISO().equals("TG")) out.write("selected");%>>Togo</option>
        <option value="TH" <%if (!isUpload && pic.getCountryISO().equals("TH")) out.write("selected");%>>Thailand
        </option>
        <option value="TJ" <%if (!isUpload && pic.getCountryISO().equals("TJ")) out.write("selected");%>>Tajikistan
        </option>
        <option value="TK" <%if (!isUpload && pic.getCountryISO().equals("TK")) out.write("selected");%>>Tokelau
        </option>
        <option value="TL" <%if (!isUpload && pic.getCountryISO().equals("TL")) out.write("selected");%>>East Timor
        </option>
        <option value="TM" <%if (!isUpload && pic.getCountryISO().equals("TM")) out.write("selected");%>>Turkmenistan
        </option>
        <option value="TN" <%if (!isUpload && pic.getCountryISO().equals("TN")) out.write("selected");%>>Tunisia
        </option>
        <option value="TO" <%if (!isUpload && pic.getCountryISO().equals("TO")) out.write("selected");%>>Tonga</option>
        <option value="TR" <%if (!isUpload && pic.getCountryISO().equals("TR")) out.write("selected");%>>Turkey</option>
        <option value="TT" <%if (!isUpload && pic.getCountryISO().equals("TT")) out.write("selected");%>>Trinidad and
            Tobago
        </option>
        <option value="TV" <%if (!isUpload && pic.getCountryISO().equals("TV")) out.write("selected");%>>Tuvalu</option>
        <option value="TW" <%if (!isUpload && pic.getCountryISO().equals("TW")) out.write("selected");%>>Taiwan</option>
        <option value="TZ" <%if (!isUpload && pic.getCountryISO().equals("TZ")) out.write("selected");%>>Tanzania
        </option>
        <option value="UA" <%if (!isUpload && pic.getCountryISO().equals("UA")) out.write("selected");%>>Ukraine
        </option>
        <option value="UG" <%if (!isUpload && pic.getCountryISO().equals("UG")) out.write("selected");%>>Uganda</option>
        <option value="UM" <%if (!isUpload && pic.getCountryISO().equals("UM")) out.write("selected");%>>United States
            Minor Outlying Islands
        </option>
        <option value="US" <%if (!isUpload && pic.getCountryISO().equals("US")) out.write("selected");%>>United States
        </option>
        <option value="UY" <%if (!isUpload && pic.getCountryISO().equals("UY")) out.write("selected");%>>Uruguay
        </option>
        <option value="UZ" <%if (!isUpload && pic.getCountryISO().equals("UZ")) out.write("selected");%>>Uzbekistan
        </option>
        <option value="VA" <%if (!isUpload && pic.getCountryISO().equals("VA")) out.write("selected");%>>Vatican
        </option>
        <option value="VC" <%if (!isUpload && pic.getCountryISO().equals("VC")) out.write("selected");%>>Saint Vincent
            and the Grenadines
        </option>
        <option value="VE" <%if (!isUpload && pic.getCountryISO().equals("VE")) out.write("selected");%>>Venezuela
        </option>
        <option value="VG" <%if (!isUpload && pic.getCountryISO().equals("VG")) out.write("selected");%>>British Virgin
            Islands
        </option>
        <option value="VI" <%if (!isUpload && pic.getCountryISO().equals("VI")) out.write("selected");%>>U.S. Virgin
            Islands
        </option>
        <option value="VN" <%if (!isUpload && pic.getCountryISO().equals("VN")) out.write("selected");%>>Vietnam
        </option>
        <option value="VU" <%if (!isUpload && pic.getCountryISO().equals("VU")) out.write("selected");%>>Vanuatu
        </option>
        <option value="WF" <%if (!isUpload && pic.getCountryISO().equals("WF")) out.write("selected");%>>Wallis and
            Futuna
        </option>
        <option value="WS" <%if (!isUpload && pic.getCountryISO().equals("WS")) out.write("selected");%>>Samoa</option>
        <option value="XK" <%if (!isUpload && pic.getCountryISO().equals("XK")) out.write("selected");%>>Kosovo</option>
        <option value="YE" <%if (!isUpload && pic.getCountryISO().equals("YE")) out.write("selected");%>>Yemen</option>
        <option value="YT" <%if (!isUpload && pic.getCountryISO().equals("YT")) out.write("selected");%>>Mayotte
        </option>
        <option value="ZA" <%if (!isUpload && pic.getCountryISO().equals("ZA")) out.write("selected");%>>South Africa
        </option>
        <option value="ZM" <%if (!isUpload && pic.getCountryISO().equals("ZM")) out.write("selected");%>>Zambia</option>
        <option value="ZW" <%if (!isUpload && pic.getCountryISO().equals("ZW")) out.write("selected");%>>Zimbabwe
        </option>
    </select>
    <p class=" text">拍摄城市</p>
    <select name="cities" id="city-selector" required>
        <%
            if (!isUpload) {
                String sql = "SELECT Country_RegionCodeISO countryISO, AsciiName name,GeoNameID code FROM geocities WHERE Country_RegionCodeISO = ?";
                List<City> cityList = dao.getForList(City.class, sql, pic.getCountryISO());
                for (int i = 0; i < cityList.size(); i++) {
                    City city = cityList.get(i);
                    if (city.getCountryISO().equals(pic.getCountryISO()))
                        out.write("<option value=" + city.getCode() + " selected>" + city.getName() + "</option>");
                    else
                        out.write("<option value=" + city.getCode() + ">" + city.getName() + "</option>");
                    ;
                }
            }
        %>
    </select>
    <%if (isUpload) {%>
    <input type="radio" class="isUpload" name=isUpload value="true" checked>
    <input type="radio" class="isUpload" name=isUpload value="false">
    <%} else {%>
    <input type="radio" class="isUpload" name=isUpload value="true">
    <input type="radio" class="isUpload" name=isUpload value="false" checked>
    <%}%>

    <%if (!isUpload) {%>
    <input type=text name=imgId value=<%=pic.getImageId()%>/>
    <input type="submit" value="modify" name="upload" onclick="checkModify()" class="text">
    <%} else {%>
    <input type="submit" value="upload" name="upload" class="text">
    <%}%>
</form>
<footer>
    © 2020 fdu19ss沪·证书·备 19302010042·联系我们:<img src="images/icons/wechat2DCode.jpg"/>19302010042@fudan.edu.cn·举报
</footer>
</body>

</html>
