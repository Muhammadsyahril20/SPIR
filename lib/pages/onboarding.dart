import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';

final pages = [
  const PageData(
    icon: Icons.report,
    title: "Laporkan Infrastruktur Rusak",
    bgColor: Color(0xFF00BF6D),
    textColor: Colors.white,
  ),
  const PageData(
    icon: Icons.track_changes,
    title: "Pantau Laporan Anda",
    bgColor: Color.fromARGB(255, 4, 72, 128),
    textColor: Colors.white,
  ),
  const PageData(
    icon: Icons.login,
    title: "Mulai Sekarang",
    bgColor: Color.fromARGB(255, 0, 182, 136),
    textColor: Colors.white,
  ),
];

class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ConcentricPageView(
        colors: pages.map((p) => p.bgColor).toList(),
        radius: screenWidth * 0.1,
        nextButtonBuilder: (context) => Padding(
          padding: const EdgeInsets.only(left: 3),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.navigate_next, size: screenWidth * 0.08, color: Color(0xFF00BF6D)),
          ),
        ),
        itemCount: pages.length,
        scaleFactor: 2,
        itemBuilder: (index) {
          final page = pages[index];
          return SafeArea(child: _Page(page: page));
        },
        onFinish: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SignInScreen()),
          );
        },
      ),
    );
  }
}

class PageData {
  final String? title;
  final IconData? icon;
  final Color bgColor;
  final Color textColor;

  const PageData({
    this.title,
    this.icon,
    this.bgColor = Colors.white,
    this.textColor = Colors.black,
  });
}

class _Page extends StatelessWidget {
  final PageData page;

  const _Page({required this.page});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: page.textColor,
          ),
          child: Icon(page.icon, size: screenHeight * 0.1, color: page.bgColor),
        ),
        Text(
          page.title ?? "",
          style: TextStyle(
            color: page.textColor,
            fontSize: screenHeight * 0.035,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}