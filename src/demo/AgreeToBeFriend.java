package demo;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class AgreeToBeFriend extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (req.getParameter("requester") != null && req.getParameter("recipient") != null&& req.getParameter("recipientUID") != null&& req.getParameter("requesterUID") != null) {
            DAO dao = (DAO) req.getSession().getAttribute("dao");
            String requester = req.getParameter("requester");
            String recipient = req.getParameter("recipient");
            String recipientUID = req.getParameter("recipientUID");
            String requesterUID = req.getParameter("requesterUID");

            String sqlForAgreeFirst = "UPDATE friends SET IsAccepted=1 WHERE requesterUID = ? AND recipientUID = ?";
            dao.update(sqlForAgreeFirst,requesterUID,recipientUID);

            String sqlForAgree = "INSERT INTO friends (requesterUID,recipientUID,Recipient,Requester, IsAccepted) VALUES (?,?,?,?,?)";
            dao.update(sqlForAgree,recipientUID,requesterUID,requester,recipient,1);

            resp.sendRedirect(req.getHeader("referer"));
        } else
            resp.sendRedirect(req.getHeader("referer"));

    }
}
