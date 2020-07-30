package demo;

import items.Illustration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.List;

public class DeletePhoto extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int imageId = Integer.parseInt(req.getParameter("imageId"));
        DAO dao = (DAO) req.getSession().getAttribute("dao");


        String sqlForPATH = "SELECT PATH FROM travelimage WHERE ImageID = ?";
        String src = dao.getForValue(sqlForPATH, imageId);
        String realPath = getServletContext().getRealPath("/");
        System.out.print(realPath);
        File image = new File(realPath + "travel-images/large/" + src);
        if (image.delete())
            System.out.println("文件已删除");
        else
            System.out.println(image.exists());


        String sql = "DELETE FROM travelimage WHERE ImageID = ?";
        dao.update(sql, imageId);

        if (req.getSession().getAttribute("recentlyViewed") != null) {
            List<Illustration> recent = (List<Illustration>) req.getSession().getAttribute("recentlyViewed");
            for (Illustration illustration:recent) {
                if(illustration.getImageId()==imageId)
                    illustration.setAccessible(false);
            }
        }

        resp.sendRedirect("mypic.jsp");

    }


}
