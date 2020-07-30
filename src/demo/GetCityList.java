package demo;

import items.City;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.Writer;
import java.util.List;

public class GetCityList extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String country = req.getParameter("country");
        DAO dao = (DAO) req.getSession().getAttribute("dao");


        String sql = "SELECT AsciiName name, GeoNameID code FROM geocities WHERE Country_RegionCodeISO = ?";
        List<City> list = dao.getForList(City.class, sql, country);

        Writer out = resp.getWriter();
        for (int i = 0; i < list.size(); i++) {
            out.write(list.get(i).getName());
            out.write("%");
            out.write(String.valueOf(list.get(i).getCode()));
            out.write("&");
        }

        out.close();
    }
}
