package demo;

import items.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class Logout extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String logout = req.getParameter("logout");
        if (logout.equals("true")) {
            HttpSession session = req.getSession();
            User usr = (User) session.getAttribute("user");
            User.logout(usr, session);
            resp.sendRedirect("index.jsp");
        }
    }
}
