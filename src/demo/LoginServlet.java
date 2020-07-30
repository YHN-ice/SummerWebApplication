package demo;

import items.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;

import javax.servlet.GenericServlet;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.security.NoSuchAlgorithmException;
import java.util.Date;

public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userName = req.getParameter("id");
        String originPassword = req.getParameter("password");
        String password = originPassword;
        try {
            password = User.hash(password);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }

        DAO dao = (DAO) req.getSession().getAttribute("dao");

        String sqlForCheck = "SELECT COUNT(UserName) FROM traveluser WHERE UserName = ? AND Pass = ?";
        long count = dao.getForValue(sqlForCheck,userName, password);
        if(count>0){
            String sqlForUID = "SELECT UID FROM traveluser WHERE UserName = ?";
            int UID = dao.getForValue(sqlForUID, userName);
            String sqlForEmail = "SELECT Email FROM traveluser WHERE UserName = ?";
            String email = dao.getForValue(sqlForEmail,userName);
            User usr = new User(UID,userName,password,email);
            User.login(usr, req.getSession());
            resp.sendRedirect("login.jsp?loginSuccess=true");
        }
        else
            resp.sendRedirect("login.jsp?loginSuccess=false&userName="+userName+"&password="+originPassword);

    }
}
