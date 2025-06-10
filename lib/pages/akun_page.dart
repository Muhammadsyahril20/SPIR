import 'package:flutter/material.dart';
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
              // TODO: Navigasi ke halaman ubah akun
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Fitur Ubah Akun belum tersedia')),
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
              // TODO: Navigasi ke halaman tentang aplikasi
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Fitur Tentang Aplikasi belum tersedia')),
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