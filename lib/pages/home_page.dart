import 'package:flutter/material.dart';
import 'laporkan_page.dart';
import 'semua_laporan_page.dart';
import 'akun_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    LaporkanPage(),
    SemuaLaporanPage(),
    AkunPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      floatingActionButton: _currentIndex == 0 ? null : FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LaporkanPage()),
          );
        },
        backgroundColor: const Color(0xFF00BF6D),
        child: const Icon(Icons.add, color: Colors.white),
        tooltip: 'Laporkan Kerusakan',
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF00BF6D), // Warna hijau saat aktif
        unselectedItemColor: Colors.grey, // Warna abu-abu saat tidak aktif
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.report), label: 'Laporkan'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Semua Laporan'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Akun'),
        ],
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
      ),
    );
  }
}