package demo;

import items.Illustration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class SearchServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String titleOrDescription = req.getParameter("title-or-description");
        String popularOrTime = req.getParameter("popular-or-latest");
        String keyword = req.getParameter("keyword");
        HttpSession session = req.getSession();
        DAO dao = (DAO) session.getAttribute("dao");
        String sqlForTitleAndTime = "SELECT PATH src, ImageID imageId, Title title, Description description FROM travelimage WHERE Title LIKE '%" + keyword + "%' ORDER BY upload_Time DESC LIMIT 40";
        String sqlForDescriptionAndTime = "SELECT PATH src, ImageID imageId, Title title, Description description FROM travelimage WHERE Description LIKE '%" + keyword + "%' ORDER BY upload_Time DESC LIMIT 40";
        String sqlForTitleAndPopular = "SELECT PATH src, Title title, Description description, travelimage.ImageID imageId FROM travelimage WHERE Title LIKE '%" + keyword + "%' ORDER BY likeS DESC LIMIT 40";
        String sqlForDescriptionAndPopular = "SELECT PATH src, Title title, Description description, travelimage.ImageID imageId FROM travelimage WHERE Description LIKE '%" + keyword + "%' ORDER BY likeS DESC LIMIT 40";
        String sql = "";
        if (titleOrDescription != null && popularOrTime != null && keyword != null) {
            if (titleOrDescription.equals("title") && popularOrTime.equals("time"))
                sql = sqlForTitleAndTime;
            else if (titleOrDescription.equals("description") && popularOrTime.equals("time"))
                sql = sqlForDescriptionAndTime;
            else if (titleOrDescription.equals("title") && popularOrTime.equals("popular"))
                sql = sqlForTitleAndPopular;
            else if (titleOrDescription.equals("description") && popularOrTime.equals("popular"))
                sql = sqlForDescriptionAndPopular;
            List<Illustration> list = dao.getForList(Illustration.class, sql);

            session.setAttribute("searchResult", list);
            resp.sendRedirect("search.jsp?searched=yes");
        } else
            resp.sendRedirect("search.jsp");
    }
}
