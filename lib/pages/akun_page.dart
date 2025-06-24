import 'package:flutter/material.dart';
import 'package:pelaporan_insfrastruktur_rusak/pages/RiwayatLaporanPage.dart';
import 'package:pelaporan_insfrastruktur_rusak/pages/TentangAplikasiPage.dart';
import 'package:pelaporan_insfrastruktur_rusak/pages/UbahAkunPage.dart';
import 'login_page.dart'; // Import untuk logout ke SignInScreen
import 'ProsedurPelaporanPage.dart'; // Import untuk halaman prosedur pelaporan

class AkunPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Akun'),
        backgroundColor: const Color(0xFF00BF6D),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Profil Sederhana
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF5FCF9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Color(0xFF00BF6D),
                  child: Icon(Icons.person, color: Colors.white, size: 40),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Nama Pengguna',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text('nomor@example.com'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Menu Akun
          ListTile(
            leading: const Icon(Icons.edit, color: Color(0xFF00BF6D)),
            title: const Text('Ubah Akun'),
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
           onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => UbahAkunPage()),
  );
},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline, color: Color(0xFF00BF6D)),
            title: const Text('Prosedur Pelaporan'),
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            onTap: () {
              // Navigasi ke halaman prosedur pelaporan
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProsedurPelaporanPage()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info, color: Color(0xFF00BF6D)),
            title: const Text('Tentang Aplikasi'),
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => TentangAplikasiPage()),
  );
},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.history, color: Color(0xFF00BF6D)),
            title: const Text('Riwayat Laporan'),
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            onTap: () {
              // Navigasi ke halaman riwayat laporan
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RiwayatLaporanPage()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Color(0xFF00BF6D)),
            title: const Text('Logout'),
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            onTap: () {
              // Navigasi ke SignInScreen saat logout
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignInScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}