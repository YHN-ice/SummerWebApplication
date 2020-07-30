package demo;

import items.Illustration;
import items.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class CancelLikeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        DAO dao = (DAO)req.getSession().getAttribute("dao");
        int imageID = Integer.parseInt(req.getParameter("ImageID"));
        if(req.getSession().getAttribute("user")!=null){
            User user = (User) req.getSession().getAttribute("user");
            user.unlike(imageID, dao);
            resp.sendRedirect(req.getHeader("referer"));
        }else
            resp.sendRedirect("index.jsp");
    }
}
