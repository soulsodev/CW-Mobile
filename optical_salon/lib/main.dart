import 'package:flutter/material.dart';
import 'package:optical_salon/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Optical Salon',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
