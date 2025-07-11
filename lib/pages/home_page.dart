import 'package:flutter/material.dart';
import 'laporkan_page.dart';
import 'semua_laporan_page.dart';
import 'akun_page.dart';
import 'RiwayatLaporanPage.dart'; // Pastikan import ini ada

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    LaporkanPage(),
    SemuaLaporanPage(),
    RiwayatLaporanPage(),
    AkunPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pages[_currentIndex]), // Tambah SafeArea
      floatingActionButton:
          _currentIndex == 0
              ? null
              : FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LaporkanPage()),
                  );
                },
                backgroundColor: const Color(0xFF00BF6D),
                tooltip: 'Laporkan Kerusakan',
                child: const Icon(Icons.add, color: Colors.white),
              ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF00BF6D),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed, // Wajib untuk 4 tab
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.report), label: 'Laporkan'),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Semua Laporan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Riwayat', // Tab Riwayat
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Akun'),
        ],
        onTap: (index) {
          print('Tapped index: $index'); // Debug
          setState(() => _currentIndex = index);
        },
      ),
    );
  }
}
