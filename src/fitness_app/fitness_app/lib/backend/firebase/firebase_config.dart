import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDj8juIljX-2t-pb83kkz2NcR-7fPNlgx4",
            authDomain: "fitnessapp-14f61.firebaseapp.com",
            projectId: "fitnessapp-14f61",
            storageBucket: "fitnessapp-14f61.appspot.com",
            messagingSenderId: "268478790100",
            appId: "1:268478790100:web:c9c65b786789e7aac9be41",
            measurementId: "G-6MEW14WFQP"));
  } else {
    await Firebase.initializeApp();
  }
}
