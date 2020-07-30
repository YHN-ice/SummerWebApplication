package demo;

import items.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class FindFriends extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (req.getParameter("keyword") != null) {
            DAO dao = (DAO) req.getSession().getAttribute("dao");
            User usr = (User) req.getSession().getAttribute("user");

            System.out.print("usr.getUID():" + usr.getUID());

            String keywordForFriend = req.getParameter("keyword");
            String sqlForUserList = "SELECT UID, UserName userName, State state FROM traveluser WHERE UserName LIKE '%" + keywordForFriend + "%' AND UID NOT IN (SELECT recipientUID FROM friends WHERE requesterUID = ?) LIMIT 40";

            List<User> userList = dao.getForList(User.class, sqlForUserList, usr.getUID());

            req.getSession().setAttribute("userList", userList);
            resp.sendRedirect("myfriends.jsp?searched=yes");
        } else
            resp.sendRedirect(req.getHeader("referer"));
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (req.getParameter("isOpen") != null) {
            String isOpen = req.getParameter("isOpen");
            String sql="UPDATE traveluser SET open = ? WHERE UID = ?";
            DAO dao = (DAO) req.getSession().getAttribute("dao");
            User usr = (User) req.getSession().getAttribute("user");
            if(isOpen.equals("true")){
                dao.update(sql,1,usr.getUID());
                usr.setIsOpen(1);
            }
            else{
                dao.update(sql,0,usr.getUID());
                usr.setIsOpen(0);
            }
            resp.sendRedirect(req.getHeader("referer"));
        } else
            resp.sendRedirect(req.getHeader("referer"));

    }
}
