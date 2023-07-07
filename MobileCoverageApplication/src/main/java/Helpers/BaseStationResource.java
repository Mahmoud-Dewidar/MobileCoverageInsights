package Helpers;

import com.google.firebase.database.*;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.CountDownLatch;


public class BaseStationResource {
    private DatabaseReference databaseReference;

    public BaseStationResource() {
        FirebaseService firebaseService = new FirebaseService();
        databaseReference = firebaseService.getDatabaseReference();
    }

    public Map<String, BaseStation> getAllData() {
        FirebaseService firebaseService = new FirebaseService();
        DatabaseReference databaseReference = firebaseService.getDatabaseReference();

        Map<String, BaseStation> baseStations = new HashMap<>();
        CountDownLatch latch = new CountDownLatch(1); // Create a CountDownLatch with initial count 1

        if (databaseReference != null) {
            databaseReference.addListenerForSingleValueEvent(new ValueEventListener() {
                @Override
                public void onDataChange(DataSnapshot dataSnapshot) {
                    for (DataSnapshot nodeSnapshot : dataSnapshot.getChildren()) {
                        String nodeId = nodeSnapshot.getKey();

                        BaseStation baseStation = nodeSnapshot.getValue(BaseStation.class);
                        baseStation.setId(nodeId);

                        String gpsLocation = baseStation.getGpsLocation();
                        if (gpsLocation != null && !gpsLocation.isEmpty()) {
                            String[] coordinates = gpsLocation.split(" ");
                            if (coordinates.length == 2) {
                                String latitude = coordinates[0];
                                String longitude = coordinates[1];
                                baseStation.setLatitude(latitude);
                                baseStation.setLongitude(longitude);
                            }
                        }
                        System.out.println("Node ID: " + nodeId);
                        System.out.println("Base Station: " + baseStation);
                        System.out.println("------------------------------------");
                        baseStations.put(nodeId, baseStation);
                    }

                    latch.countDown(); // Decrease the latch count to 0 to indicate the operation is complete
                }

                @Override
                public void onCancelled(DatabaseError databaseError) {
                    System.out.println("Error: " + databaseError.getMessage());
                    latch.countDown(); // Decrease the latch count to 0 to indicate the operation is complete
                }
            });
        } else {
            System.out.println("Error: DatabaseReference is null");
            latch.countDown(); // Decrease the latch count to 0 to indicate the operation is complete
        }

        try {
            latch.await(); // Wait until the latch count reaches 0
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        return baseStations;
    }

    public String storeInPostgres(Map<String, BaseStation> fireData) {
        try {
            Map<String, BaseStation> baseStations = getAllData();
            PostgreConnection conn = new PostgreConnection();

            for (Map.Entry<String, BaseStation> entry : baseStations.entrySet()) {
                BaseStation baseStation = entry.getValue();
                conn.insertBaseStation(baseStation);
            }
            conn.disconnect();
            return "Success";
        } catch (Exception e) {
            System.out.println("Error storing data in PostgreSQL: " + e.getMessage());
            return "Failed";
        }
    }

    public String createBaseStation(BaseStation baseStation) {
        String id = databaseReference.push().getKey();
        String timestamp = String.valueOf(System.currentTimeMillis());

        try {
            databaseReference.child(timestamp).setValueAsync(baseStation);
            System.out.println("BaseStation created successfully");
            return "Success";
        } catch (DatabaseException e) {
            System.out.println("Error creating BaseStation: " + e.getMessage());
            return "Failed";
        }
    }

    public void updateBaseStation(String id, BaseStation baseStation) {
        databaseReference.child(id).setValueAsync(baseStation);
    }


    public void deleteBaseStation( String id) {
        databaseReference.child(id).removeValueAsync();
    }

}
