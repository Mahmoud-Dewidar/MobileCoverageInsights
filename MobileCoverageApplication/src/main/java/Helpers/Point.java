package Helpers;

public class Point {
    private String latitude;
    private String longitude;
    private Double signalStrength;
    private String city;
    private String operator;

    public String getOperator() {
        return operator;
    }

    public void setOperator(String operator) {
        this.operator = operator;
    }

    public Point(String latitude, String longitude, Double signalStrength, String city) {
        this.latitude = latitude;
        this.longitude = longitude;
        this.signalStrength = signalStrength;
        this.city = city;
    }

    @Override
    public String toString() {
        return "Point{" +
                "latitude='" + latitude + '\'' +
                ", longitude='" + longitude + '\'' +
                ", signalStrength=" + signalStrength +
                ", city='" + city + '\'' +
                ", operator='" + operator + '\'' +
                '}';
    }

    public Double getSignalStrength() {
        return signalStrength;
    }

    public void setSignalStrength(Double signalStrength) {
        this.signalStrength = signalStrength;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getLatitude() {
        return latitude;
    }

    public void setLatitude(String latitude) {
        this.latitude = latitude;
    }

    public String getLongitude() {
        return longitude;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }
}
