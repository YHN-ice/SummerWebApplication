package demo;

import items.*;
import javafx.scene.layout.StackPane;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.Properties;

public class JDBCTools {
    public static Connection getConnection() throws SQLException, IOException, ClassNotFoundException {
        Properties properties = new Properties();
        InputStream in = JDBCTools.class.getResourceAsStream("jdbc.properties");
        //FileInputStream in = new FileInputStream("jdbc.properties");
        properties.load(in);

        String driver = properties.getProperty("driver");
        String jdbcUrl = properties.getProperty("jdbcUrl");
        String user = properties.getProperty("user");
        String password = properties.getProperty("password");

        Class.forName(driver);

        return DriverManager.getConnection(jdbcUrl, user, password);
    }

    public static void releaseDB(ResultSet resultSet, Statement statement, Connection conn) {
        if (resultSet != null) {
            try {
                resultSet.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        if (statement != null) {
            try {
                statement.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        if (conn != null) {
            try {
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

    }

    //insert、update、delete不包含select
    public static void update(String sql) {
        Connection conn = null;
        Statement statement = null;
        try {
            conn = getConnection();
            statement = conn.createStatement();
            statement.executeUpdate(sql);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            releaseDB(null, statement, conn);
        }


    }
}
