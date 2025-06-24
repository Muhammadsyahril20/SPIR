import 'package:flutter/material.dart';
import 'package:pelaporan_insfrastruktur_rusak/pages/onboarding.dart';
import 'pages/login_page.dart'; // Import login

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pelaporan Infrastruktur Rusak',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: OnboardingPage1(), // Mulai dari onboarding
    );
  }
}