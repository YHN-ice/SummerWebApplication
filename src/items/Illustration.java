package items;

import com.sun.nio.sctp.IllegalUnbindException;
import demo.DAO;

import java.util.Date;
import java.util.List;

public class Illustration {
    private String src;
    private String title;
    private String description;
    private int imageId;
    private String country;
    private int cityCode;
    private String countryISO;
    private String city;
    private String category;
    private int authorID;
    private String authorName;
    private Date uploadStamp;
    private boolean accessible = true;

    public Illustration() {
    }

    public Illustration(String src) {
        this.src = src;
        this.imageId = 0;
        this.title = "Title";
        this.description = "brief description:Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean et nisl in ex aliquet eleifend. Quisque congue bibendum egestas. Morbi ipsum massa, accumsan ut quam nec, ultrices eleifend leo. Donec sed arcu eu urna malesuada scelerisque. Aliquam et lobortis lacus. Nam et est tincidunt, tristique odio nec, sagittis erat. Curabitur tincidunt consequat odio vitae lacinia. Nulla dignissim massa sed ipsum porttitor, ac malesuada tellus sagittis. Aliquam finibus dui urna, nec ornare nibh pulvinar sed. Fusce vitae vestibulum mi, venenatis venenatis risus. Nam quis erat ac nulla tincidunt luctus sit amet ut libero. Quisque blandit nulla quis felis vulputate vulputate id imperdiet neque. Vivamus et erat dictum, dictum orci vel, fermentum tortor. Aliquam tincidunt porttitor nulla sed tempus. In congue eget diam ut laoreet. Curabitur eget nunc ut metus faucibus interdum at in magna.";
        this.country = "US";
        this.city = "NYC";
        this.category = "scenery";
        this.authorID = 0000;
        this.authorName = "anonymous";
        this.uploadStamp = new Date();
    }


    public String getSrc() {
        return src;
    }


    public int getImageId() {
        return imageId;
    }

    public String getTitle() {
        return title;
    }

    public String getDescription() {
        return description;
    }

    public int getAuthorID() {
        return authorID;
    }

    public String getAuthorName() {
        return authorName;
    }


    public String getCategory() {
        return category;
    }

    public String getCountry() {
        return country;
    }

    public String getCity() {
        return city;
    }

    public Date getUploadStamp() {
        return uploadStamp;
    }


    public String getCountryISO() {
        return countryISO;
    }

    public int getCityCode() {
        return cityCode;
    }

    public boolean isAccessible() {
        return accessible;
    }

    public void setAccessible(boolean accessible) {
        this.accessible = accessible;
    }

    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public void setCity(String city) {
        this.city = city;
    }


    public void setImageId(int imageId) {
        this.imageId = imageId;
    }

    public static String getCountryNameByImageId(int imageId, DAO dao) {
        String sql = "SELECT Country_RegionName FROM geocountries_regions WHERE ISO IN (SELECT Country_RegionCodeISO FROM travelimage WHERE ImageID = ?)";
        String countryName = dao.getForValue(sql, imageId);
        return countryName;
    }

    public static String getCityNameByImageId(int imageId, DAO dao) {
        String sql = "SELECT AsciiName FROM geocities WHERE GeoNameID IN (SELECT CityCode FROM travelimage WHERE ImageID = ?)";
        String cityName = dao.getForValue(sql, imageId);
        return cityName;
    }

    public static long getLikesByImageId(int imageId, DAO dao) {
        String sql = "SELECT COUNT(FavorID) FROM travelimagefavor WHERE ImageID = ?";
        long likes = dao.getForValue(sql, imageId);
        return likes;
    }

    public static Illustration getIllustrationFromImageId(int imageId, DAO dao) {
        String sql = "SELECT Title title, Description description, PATH src, Content category, UID authorID FROM travelimage WHERE ImageID = ?";
        Illustration illustration = dao.get(Illustration.class, sql, imageId);
        illustration.setImageId(imageId);
        return illustration;

    }

    public static List<Illustration> getHotList(int number, DAO dao){
        String sql = "SELECT PATH src, Title title, Description description, travelimage.ImageID imageId  FROM travelimage ORDER BY likeS DESC LIMIT ?";
        List<Illustration> list = dao.getForList(Illustration.class, sql, number);
        return list;
    }
}
