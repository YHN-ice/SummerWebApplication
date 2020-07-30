package items;

import com.sun.nio.sctp.IllegalUnbindException;
import demo.DAO;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class User {
    private int UID;
    private String userName;
    private String password;
    private String email;
    private int state;
    private int accepted;
    private Date registerTime;
    private int isOpen;

    public User() {

    }

    public User(int UID, String userName, String password, String email) {
        this.email = email;
        this.UID = UID;
        this.userName = userName;
        this.password = password;
    }

    public User(int UID, String userName){
        this.UID = UID;
        this.userName = userName;
    }


    public int getUID() {
        return UID;
    }

    public void setUID(int UID) {
        this.UID = UID;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public String getUserName() {
        return userName;
    }

    public int getState() { return state; }

    public int getAccepted() { return accepted; }

    public Date getRegisterTime() {
        return registerTime;
    }

    public int getIsOpen() {
        return isOpen;
    }

    public void setIsOpen(int isOpen) {
        this.isOpen = isOpen;
    }

    public static String checkNameById(int UID, DAO dao) {
        String sqlForAuthorName = "SELECT UserName FROM traveluser WHERE UID = ?";
        String authorName = dao.getForValue(sqlForAuthorName, UID);
        return authorName;
    }

    public static int getUIDByName(String userName, DAO dao) {
        String sql = "SELECT UID FROM traveluser WHERE UserName = ?";
        int UID = dao.getForValue(sql, userName);
        return UID;
    }

    public void like(int imageId, DAO dao) {
        String sql = "INSERT INTO travelimagefavor (UID, ImageID) VALUES (?,?)";
        dao.update(sql, getUID(), imageId);

        long likesBefore = Illustration.getLikesByImageId(imageId,dao);
        String sqlLikeS = "UPDATE travelimage SET likeS = ? WHERE travelimage.ImageID = ?";
        dao.update(sqlLikeS, likesBefore + 1, imageId);
    }

    public void unlike(int imageId, DAO dao) {
        String sql = "DELETE FROM travelimagefavor WHERE ImageID = ? AND UID = ?";
        dao.update(sql, imageId, getUID());

        long likesBefore = Illustration.getLikesByImageId(imageId,dao);
        String sqlLikeS = "UPDATE travelimage SET likeS = ? WHERE travelimage.ImageID = ?";
        dao.update(sqlLikeS, likesBefore - 1, imageId);
    }

    public static void login(User usr, HttpSession session) {
        DAO dao = (DAO) session.getAttribute("dao");

        usr = getUserFromUID(usr.getUID(),dao);
        session.setAttribute("user", usr);
        List<Illustration> recentlyViewed = new ArrayList<>();
        session.setAttribute("recentlyViewed",recentlyViewed);
        String sql = "UPDATE traveluser SET State = '1' WHERE UID = ?";
        dao.update(sql, usr.getUID());
    }

    public static void logout(User usr, HttpSession session) {
        session.removeAttribute("user");

        String sql = "UPDATE traveluser SET State = '0', DateLastModified = ? WHERE UID = ?";
        DAO dao = (DAO) session.getAttribute("dao");
        dao.update(sql, new Date(), usr.getUID());
    }

    public static User getUserFromUID(int UID, DAO dao) {
        String sql = "SELECT Email email, UserName userName, Pass password, DateJoined registerTime, open isOpen FROM traveluser WHERE UID = ?";
        User user = dao.get(User.class, sql, UID);
        user.setUID(UID);
        return user;
    }

    public static String hash(String originPassword) throws NoSuchAlgorithmException, UnsupportedEncodingException {
        // 创建一个MessageDigest实例:
        MessageDigest md = MessageDigest.getInstance("MD5");
        String salt = "icesalt";  //定义一个salt值，程序员规定下来的随机字符串
        md.update(salt.getBytes("UTF-8"));// 反复调用update输入数据:
        md.update(originPassword.getBytes("UTF-8"));//把密码和salt连接
        byte[] result = md.digest();//执行MD5散列
        return (new BigInteger(1, result).toString(16));
        //返回散列
        // 16 bytes: (eg)68e109f0f40ca72a15e05cc22786f8e6
    }

}
