import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pelaporan_insfrastruktur_rusak/pages/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pelaporan Infrastruktur Rusak',
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: GoogleFonts.manropeTextTheme(),
      ),
      home: SplashScreen(), // Mulai dari onboarding
    );
  }
}
