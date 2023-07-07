package Helpers;

import java.util.List;

public class test {
    public static void main(String[] args) {
        BaseStationResource base = new BaseStationResource();
//        Map<String,BaseStation> data = base.getAllData();
//        for (Map.Entry<String, BaseStation> entry : data.entrySet()) {
//            String nodeId = entry.getKey();
//            BaseStation baseStation = entry.getValue();
//
//            System.out.println("Node ID: " + nodeId);
//            System.out.println("Base Station: " + baseStation);
//            System.out.println("------------------------------------");
//        }
//
//        base.storeInPostgres(data);

//        BaseStation neew = new BaseStation("El Haram","Egypt","eg","30.966001666666664 32.047090000000004","122","602","02","Etisalat","50","Giza","OPPO");
//        base.createBaseStation(neew);



//        System.out.println("result = " + result);


//        String hi = "Hello world";
//        String[] coordinates = hi.split(" ");
//        if (coordinates.length == 2) {
//            String lat = coordinates[0];
//            String lang = coordinates[1];
//            System.out.println(lat);
//            System.out.println(lang);
//        }else {
//            System.out.println("Error");
//        }


        PostgreConnection conn = new PostgreConnection();
//        Double result = conn.getPowerPercentage("vodafone","70","40");
//        System.out.println("Number of countries = " + result );

//        List<Point> points = conn.getCoordinates();
//        System.out.println(points.toString()+"\n");
//        List<Point> resultt = conn.getCoordinates();
        int result = conn.noOfCellsByOperator("Vodafone");
        System.out.println("Number of cells = " + result);
//
//        System.out.println(resultt.toString());

    }
}
