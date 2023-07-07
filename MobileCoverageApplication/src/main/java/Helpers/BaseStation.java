package Helpers;

import java.util.HashMap;
import java.util.Map;

public class BaseStation {
    private String id;
    private String city;
    private String country;
    private String countryName;
    private String gpsLocation;
    private String knownName;
    private String mcc;
    private String mnc;
    private String operatorName;
    private String signalStrengthInfo;
    private String state;
    private String typeText;
    private String latitude;
    private String longitude;

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


    public BaseStation() {
    }
    public BaseStation(String city, String country, String countryName, String gpsLocation, String knownName, String mcc, String mnc, String operatorName, String signalStrengthInfo, String state, String typeText) {
        this.city = city;
        this.country = country;
        this.countryName = countryName;
        this.gpsLocation = gpsLocation;
        this.knownName = knownName;
        this.mcc = mcc;
        this.mnc = mnc;
        this.operatorName = operatorName;
        this.signalStrengthInfo = signalStrengthInfo;
        this.state = state;
        this.typeText = typeText;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getCountryName() {
        return countryName;
    }

    public void setCountryName(String countryName) {
        this.countryName = countryName;
    }

    public String getGpsLocation() {
        return gpsLocation;
    }

    public void setGpsLocation(String gpsLocation) {
        this.gpsLocation = gpsLocation;
    }

    public String getKnownName() {
        return knownName;
    }

    public void setKnownName(String knownName) {
        this.knownName = knownName;
    }

    public String getMcc() {
        return mcc;
    }

    public void setMcc(String mcc) {
        this.mcc = mcc;
    }

    public String getMnc() {
        return mnc;
    }

    public void setMnc(String mnc) {
        this.mnc = mnc;
    }

    public String getOperatorName() {
        return operatorName;
    }

    public void setOperatorName(String operatorName) {
        this.operatorName = operatorName;
    }

    public String getSignalStrengthInfo() {
        return signalStrengthInfo;
    }

    public void setSignalStrengthInfo(String signalStrengthInfo) {
        this.signalStrengthInfo = signalStrengthInfo;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getTypeText() {
        return typeText;
    }

    public void setTypeText(String typeText) {
        this.typeText = typeText;
    }

//    @Override
//    public String toString() {
//        return "BaseStation{" +
//                "city='" + city + '\'' +
//                ", country='" + country + '\'' +
//                ", countryName='" + countryName + '\'' +
//                ", gpsLocation='" + gpsLocation + '\'' +
//                ", knownName='" + knownName + '\'' +
//                ", mcc='" + mcc + '\'' +
//                ", mnc='" + mnc + '\'' +
//                ", operatorName='" + operatorName + '\'' +
//                ", signalStrengthInfo='" + signalStrengthInfo + '\'' +
//                ", state='" + state + '\'' +
//                ", typeText='" + typeText + '\'' +
//                '}';
//    }

    @Override
    public String toString() {
        return "BaseStation{" +
                "id='" + id + '\'' +
                ", city='" + city + '\'' +
                ", country='" + country + '\'' +
                ", countryName='" + countryName + '\'' +
                ", gpsLocation='" + gpsLocation + '\'' +
                ", knownName='" + knownName + '\'' +
                ", mcc='" + mcc + '\'' +
                ", mnc='" + mnc + '\'' +
                ", operatorName='" + operatorName + '\'' +
                ", signalStrengthInfo='" + signalStrengthInfo + '\'' +
                ", state='" + state + '\'' +
                ", typeText='" + typeText + '\'' +
                ", latitude='" + latitude + '\'' +
                ", longitude='" + longitude + '\'' +
                '}';
    }

    public Map<String, Object> toMap() {
        Map<String, Object> map = new HashMap<>();
//        map.put("id", id);
        map.put("city", city);
        map.put("country", country);
        map.put("countryName", countryName);
        map.put("gpsLocation", gpsLocation);
        map.put("knownName", knownName);
        map.put("mcc", mcc);
        map.put("mnc", mnc);
        map.put("operatorName", operatorName);
        map.put("signalStrengthInfo", signalStrengthInfo);
        map.put("stat", state);
        map.put("typeText", typeText);
        return map;
    }

}
