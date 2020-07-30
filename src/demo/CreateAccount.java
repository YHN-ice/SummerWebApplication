package demo;

import items.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.Date;

public class CreateAccount extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        String password = req.getParameter("password");
        try {
            password = User.hash(password);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }

        String email = req.getParameter("email");
        int UID;
        DAO dao = (DAO)req.getSession().getAttribute("dao");

        String sql = "INSERT INTO traveluser (Email,UserName,Pass,DateJoined,State) VALUES (?,?,?,?,?)";
        dao.update(sql, email, id, password, new Date(),1);

        String sqlForUID = "SELECT UID FROM traveluser WHERE UserName = ?";
        UID = dao.getForValue(sqlForUID,id);

        User usr = new User(UID,id,password,email);
        User.login(usr,req.getSession());
        resp.sendRedirect("index.jsp");
    }
}
