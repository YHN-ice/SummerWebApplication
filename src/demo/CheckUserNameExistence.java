package demo;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.Writer;

public class CheckUserNameExistence extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        DAO dao = (DAO) req.getSession().getAttribute("dao");

        req.setCharacterEncoding("UTF-8");
        String id = req.getParameter("id");
        String sql = "SELECT COUNT(UserName) FROM traveluser WHERE UserName = ?";
        long count = dao.getForValue(sql, id);
        Writer out = resp.getWriter();
        out.write(String.valueOf(count));
        out.close();
    }

}
