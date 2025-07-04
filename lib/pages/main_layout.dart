import 'package:flutter/material.dart';
import 'laporkan_page.dart';
import 'semua_laporan_page.dart';
import 'akun_page.dart';

class MainLayout extends StatefulWidget {
  final int initialIndex;

  const MainLayout({super.key, this.initialIndex = 0});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  late int _currentIndex;

  final List<Widget> _pages = const [
    LaporkanPage(),
    SemuaLaporanPage(),
    AkunPage(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      floatingActionButton:
          _currentIndex == 0
              ? null
              : FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                },
                backgroundColor: const Color(0xFF00BF6D),
                tooltip: 'Laporkan Kerusakan',
                child: const Icon(Icons.add, color: Colors.white),
              ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF00BF6D),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.report), label: 'Laporkan'),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Semua Laporan',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Akun'),
        ],
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
      ),
    );
  }
}
