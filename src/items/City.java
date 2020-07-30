package items;

public class City {
    private String name;
    private int code;
    private String countryName;
    private String countryISO;
    private double latitude;
    private double longitude;

    public City(){

    }

    public String getName() {
        return name;
    }

    public int getCode() {
        return code;
    }

    public String getCountryISO() {
        return countryISO;
    }

    public String getCountryName() {
        return countryName;
    }

    public double getLatitude() {
        return latitude;
    }

    public double getLongitude() {
        return longitude;
    }
}
