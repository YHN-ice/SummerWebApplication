package demo;

import items.City;
import items.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;

@MultipartConfig

public class UploadHandler extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String title = req.getParameter("title");
        String description = req.getParameter("description");
        String category = req.getParameter("content");
        String country = req.getParameter("countries");
        String city = req.getParameter("cities");
        String isUpload = req.getParameter("isUpload");
        boolean up = Boolean.parseBoolean(isUpload);
        int UID = ((User) req.getSession().getAttribute("user")).getUID();
        DAO dao = (DAO) req.getSession().getAttribute("dao");

        String sqlForCity = "SELECT GeoNameID code, Latitude latitude,Longitude longitude,AsciiName name FROM geocities WHERE GeoNameID = ?";
        City cityModel = dao.get(City.class, sqlForCity, city);
        double latitude = cityModel.getLatitude();
        double longitude = cityModel.getLongitude();

        if (up) {
            String filename = upload(req, resp);
            String sql = "INSERT INTO travelimage (Title, Description, Content, PATH, Latitude,Longitude,CityCode,Country_RegionCodeISO,UID,upload_Time,likeS)  VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            dao.update(sql, title, description, category, filename, latitude, longitude, city, country, UID, new Date(), 0);
        } else {
            int imageId = Integer.parseInt(req.getParameter("imgId"));
            String sql = "UPDATE travelimage SET Title = ?, Description = ?, Content = ?, Latitude = ?, Longitude = ?, CityCode = ?, Country_RegionCodeISO = ?, upload_Time = ?  WHERE ImageID = ?";
            dao.update(sql, title, description, category, latitude, longitude, city, country, new Date(), imageId);
        }

        resp.sendRedirect(req.getHeader("referer"));


    }

    private static String upload(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Part part = req.getPart("file");
        String disposition = part.getHeader("Content-Disposition");
        String suffix = disposition.substring(disposition.lastIndexOf("."), disposition.length() - 1);
        //随机的生存一个32的字符串
        String filename = Long.toString(System.currentTimeMillis() / 1000L) + suffix;
        //获取上传的文件名
        InputStream is = part.getInputStream();
        //动态获取服务器的路径
        String serverpath = req.getServletContext().getRealPath("travel-images/large");
        FileOutputStream fos = new FileOutputStream(serverpath + "/" + filename);
        byte[] bty = new byte[1024];
        int length = 0;
        while ((length = is.read(bty)) != -1) {
            fos.write(bty, 0, length);
        }
        fos.close();
        is.close();
        return filename;
    }


}
