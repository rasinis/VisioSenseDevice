import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:visiosense/authenticate/firstscreen.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase manually using the values from your Firebase Console.
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyA_yRqwOT3IKxsJnF6nnVUiPSfoIzmaywM',
      authDomain: 'database-c4bc2.firebaseapp.com',
      projectId: 'database-c4bc2',
      storageBucket: 'database-c4bc2.appspot.com',
      messagingSenderId: '464841681199',
      appId: '1:464841681199:android:3a10d760e339c7936c59da',
      measurementId: null,
    ),
  );

  runApp(const VisioSenseApp());
}

class VisioSenseApp extends StatelessWidget {
  const VisioSenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstScreen(),
    );
  }
}