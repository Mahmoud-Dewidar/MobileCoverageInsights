package Helpers;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PostgreConnection {

    private static final String URL = "jdbc:postgresql://localhost:5432/MobileCoverage";
    private static final String USERNAME = "postgres";
    private static final String PASSWORD = "123";
    private Connection connection;

    public PostgreConnection() {
        try {
            Class.forName("org.postgresql.Driver"); // Load the PostgreSQL JDBC driver
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            System.out.println("Connected To Postgres Successfully");
        } catch (ClassNotFoundException e) {
            System.out.println("Error loading PostgreSQL JDBC driver: " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("Connection Error: Can't connect to Postgres: " + e.getMessage());
        }
    }

    public void insertBaseStation(BaseStation baseStation)  {

        String query = "INSERT INTO stations (id, city, country, country_name, gps_location, known_name, mcc, mnc, operator_name, signal_strength_info, state, type_text, latitude, longitude) " +
                "VALUES (?,?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"+
                "ON CONFLICT (id) DO NOTHING";

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, baseStation.getId());
            statement.setString(2, baseStation.getCity());
            statement.setString(3, baseStation.getCountry());
            statement.setString(4, baseStation.getCountryName());
            statement.setString(5, baseStation.getGpsLocation());
            statement.setString(6, baseStation.getKnownName());
            statement.setString(7, baseStation.getMcc());
            statement.setString(8, baseStation.getMnc());
            statement.setString(9, baseStation.getOperatorName());
            statement.setString(10, baseStation.getSignalStrengthInfo());
            statement.setString(11, baseStation.getState());
            statement.setString(12, baseStation.getTypeText());
            statement.setString(13, baseStation.getLatitude());
            statement.setString(14, baseStation.getLongitude());

            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Insertion failed");
        }
    }

    public List<BaseStation> getAllData() {
        String query = "SELECT * FROM stations";
        List<BaseStation> data = new ArrayList<>();

        try (PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                BaseStation baseStation = new BaseStation();
                baseStation.setId(resultSet.getString("id"));
                baseStation.setCity(resultSet.getString("city"));
                baseStation.setCountry(resultSet.getString("country"));
                baseStation.setCountryName(resultSet.getString("country_name"));
                baseStation.setGpsLocation(resultSet.getString("gps_location"));
                baseStation.setKnownName(resultSet.getString("known_name"));
                baseStation.setMcc(resultSet.getString("mcc"));
                baseStation.setMnc(resultSet.getString("mnc"));
                baseStation.setOperatorName(resultSet.getString("operator_name"));
                baseStation.setSignalStrengthInfo(resultSet.getString("signal_strength_info"));
                baseStation.setState(resultSet.getString("state"));
                baseStation.setTypeText(resultSet.getString("type_text"));
                baseStation.setLatitude(resultSet.getString("latitude"));
                baseStation.setLongitude(resultSet.getString("longitude"));

                data.add(baseStation);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return data;
    }

    public int noOfOperators() {
        // SQL query to retrieve the count of different operator_name values
        String query = "SELECT COUNT(DISTINCT lower(operator_name)) AS count FROM stations";

        try (PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {

            if (resultSet.next()) {
                int count = resultSet.getInt("count");
                return count;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0; // Return 0 if an error occurs or no result is found
    }

    public List<Point> getCoordinates2() {

        String query = "SELECT city, latitude, longitude, signal_strength_info, operator_name " +
                "FROM (" +
                "   SELECT city, latitude, longitude, signal_strength_info, operator_name, " +
                "          ROW_NUMBER() OVER (PARTITION BY city) AS row_num " +
                "   FROM stations" +
                ") subquery " +
                "WHERE row_num <= 15";

        List<Point> points = new ArrayList<>();;
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                String latitude = rs.getString("latitude");
                String longitude = rs.getString("longitude");
                String city = rs.getString("city");
                Double signalStrength = (Double) rs.getDouble("signal_strength_info")/100.0;
                Point point = new Point(latitude, longitude,signalStrength,city);
                point.setOperator(rs.getString("operator_name"));
                points.add(point);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return points;
    }

    public List<Point> getCoordinates() {

        String query = "SELECT latitude, longitude, city, signal_strength_info,operator_name FROM stations";
        List<Point> points = new ArrayList<>();;
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                String latitude = rs.getString("latitude");
                String longitude = rs.getString("longitude");
                String city = rs.getString("city");
                Double signalStrength = (Double) rs.getDouble("signal_strength_info")/100.0;
                Point point = new Point(latitude, longitude,signalStrength,city);
                point.setOperator(rs.getString("operator_name"));
                points.add(point);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return points;
    }

    public List<Point> getPointsByOperator(String operatorName) {
        String query = "SELECT latitude, longitude, city, signal_strength_info FROM stations WHERE operator_name = ?";
        List<Point> points = new ArrayList<>();

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, operatorName);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                String latitude = resultSet.getString("latitude");
                String longitude = resultSet.getString("longitude");
                String city = resultSet.getString("city");
                Double signalStrength = resultSet.getDouble("signal_strength_info") / 100.0;
                Point point = new Point(latitude, longitude, signalStrength, city);
                points.add(point);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return points;
    }
    public int noOfCountries() {
        String query = "SELECT COUNT(DISTINCT country) AS count FROM stations";

        try (PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {

            if (resultSet.next()) {
                int count = resultSet.getInt("count");
                return count;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    public int noOfCells() {
        String query = "SELECT COUNT(DISTINCT id) AS count FROM stations";

        try (PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {

            if (resultSet.next()) {
                int count = resultSet.getInt("count");
                return count;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    public int noOfCitiesByOperator(String operatorName) {
        String query = "SELECT COUNT(DISTINCT city) AS count FROM stations WHERE operator_name ilike ?";

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, operatorName);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                int count = resultSet.getInt("count");
                return count;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int noOfCellsByOperator(String operatorName) {
        String query = "SELECT COUNT(id) AS count FROM stations WHERE operator_name ilike ?";

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, operatorName);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                int count = resultSet.getInt("count");
                return count;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int noOfPhoneType(String operatorName, String keyword) {
        String query = "SELECT COUNT(type_text) AS count FROM stations WHERE operator_name ilike ? AND LOWER(type_text) iLIKE ?";

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, operatorName);
            statement.setString(2, "%" + keyword.toLowerCase() + "%");
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                int count = resultSet.getInt("count");
                return count;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public double getPowerPercentage(String operatorName, String max , String min) {
        String query = "SELECT COUNT(*) AS cell_count " +
                "FROM stations " +
                "WHERE operator_name ilike ? AND signal_strength_info::numeric <= ?::numeric AND signal_strength_info::numeric >= ?::numeric";

        int totalCells = 0;
        int powerCells = 0;

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, operatorName);
            statement.setString(2, max);
            statement.setString(3, min);

            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                powerCells = resultSet.getInt("cell_count");
            }

            // Get the total number of cells for the specified operator
            totalCells = noOfCellsByOperator(operatorName);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Calculate the power percentage
        double powerPercentage = (double) powerCells / totalCells * 100;

        return powerPercentage;
    }








    public void disconnect() {
        if (connection != null) {
            try {
                connection.close();
                System.out.println("Disconnected from Postgres");
            } catch (SQLException e) {
                System.out.println("Error disconnecting from Postgres: " + e.getMessage());
            }
        }
    }

}
