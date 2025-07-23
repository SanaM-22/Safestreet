import 'package:flutter/material.dart';
import 'screens/incidents_screen.dart';
import  'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'splash_screen.dart'; // Import SplashScreen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SafeStreet',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.green),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.green),
          bodyMedium: TextStyle(color: Colors.green),
          titleLarge: TextStyle(color: Colors.white),
        ),
      ),
      home: const SplashScreen(), // Corrected: Removed duplicate 'home' property
    );
  }
}

