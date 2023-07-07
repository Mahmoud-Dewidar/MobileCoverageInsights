package scheduler;

import Helpers.BaseStation;
import Helpers.BaseStationResource;
import Helpers.PostgreConnection;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.util.Map;

@WebListener
public class DataFetchScheduler implements ServletContextListener {
    private Thread dataFetchThread;
    private BaseStationResource fireBase;
    private PostgreConnection postgreConnection;

    @Override
    public void contextInitialized(ServletContextEvent event) {
        dataFetchThread = new Thread(new DataFetchTask());
        dataFetchThread.start();
    }

    @Override
    public void contextDestroyed(ServletContextEvent event) {
        if (dataFetchThread != null) {
            dataFetchThread.interrupt();
        }
        if (postgreConnection != null) {
            postgreConnection.disconnect(); // Close the Postgres connection
        }
    }

    private class DataFetchTask implements Runnable {
        @Override
        public void run() {
            fireBase = new BaseStationResource();
            postgreConnection = new PostgreConnection();
            while (true) {
                try {
                    // Fetch data from Firebase
                    Map<String, BaseStation> baseStations = fireBase.getAllData();

                    // Store in PostgreSQL
                    String result = fireBase.storeInPostgres(baseStations);

                    System.out.println("Data fetched and stored: " + result);

                    Thread.sleep(60000); // Sleep for 1 minute
                } catch (InterruptedException e) {
                    // Thread interrupted, exit the loop
                    break;
                }
            }
            // Disconnect from PostgreSQL
            postgreConnection.disconnect();
        }
    }

}
