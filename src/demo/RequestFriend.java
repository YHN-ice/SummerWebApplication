package demo;

import items.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class RequestFriend extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (req.getParameter("requester") != null && req.getParameter("recipient") != null&& req.getParameter("recipientUID") != null&& req.getParameter("requesterUID") != null) {
            DAO dao = (DAO) req.getSession().getAttribute("dao");
            String requester = req.getParameter("requester");
            String recipient = req.getParameter("recipient");
            String recipientUID = req.getParameter("recipientUID");
            String requesterUID = req.getParameter("requesterUID");

            System.out.print("requester:"+requester+"\nrecipient:"+recipient+"\nrecipientUID:"+recipientUID + "\nrequesterUID:"+requesterUID);

            String sqlForRequest = "INSERT INTO friends (requesterUID,recipientUID,Recipient,Requester) VALUES (?,?,?,?)";
            dao.update(sqlForRequest,requesterUID,recipientUID,recipient,requester);

            resp.sendRedirect(req.getHeader("referer"));
        } else
            resp.sendRedirect(req.getHeader("referer"));
    }
}
