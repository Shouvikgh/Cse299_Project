import 'package:flutter/material.dart';
// Ensure this import matches the actual file where NearbyHospitalsScreen is defined
import 'nearby_hospitals_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medicine & Hospitals Finder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Ensure NearbyHospitalsScreen is correctly referenced here

    );
  }
}

class NearbyHospitalsScreen {
  const NearbyHospitalsScreen();
}








