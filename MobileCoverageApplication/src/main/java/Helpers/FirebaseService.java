package Helpers;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;

import java.io.FileInputStream;
import java.io.IOException;

public class FirebaseService {
    private static final String DATABASE_URL = "https://mobile-coverage-insights-default-rtdb.firebaseio.com";
    private static DatabaseReference databaseReference;

    public FirebaseService() {
        initializeFirebase();
    }

    private void initializeFirebase() {
        if (databaseReference == null) {
            try {
                FileInputStream serviceAccount = new FileInputStream("C:\\Users\\DEWIDAR\\Desktop\\TestFire\\Mobile.json");

                FirebaseOptions options = new FirebaseOptions.Builder()
                        .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                        .setDatabaseUrl(DATABASE_URL)
                        .build();

                FirebaseApp.initializeApp(options);
                FirebaseDatabase database = FirebaseDatabase.getInstance();
                databaseReference = database.getReference("data");
                System.out.println("Connected to Firebase");
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public DatabaseReference getDatabaseReference() {
        return databaseReference;
    }
}
