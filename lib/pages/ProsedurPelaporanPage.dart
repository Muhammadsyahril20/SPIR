import 'package:flutter/material.dart';

class ProsedurPelaporanPage extends StatelessWidget {
  const ProsedurPelaporanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prosedur Pelaporan'),
        backgroundColor: const Color(0xFF00BF6D),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Prosedur Pelaporan Infrastruktur Rusak',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF00BF6D),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 2,
            color: const Color(0xFFF5FCF9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(
                Icons.check_circle_outline,
                color: Color(0xFF00BF6D),
              ),
              title: const Text('Langkah 1: Login ke Aplikasi'),
              subtitle: const Text(
                'Masuk ke aplikasi SPIR menggunakan akun terdaftar Anda.',
              ),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            elevation: 2,
            color: const Color(0xFFF5FCF9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(Icons.camera_alt, color: Color(0xFF00BF6D)),
              title: const Text('Langkah 2: Unggah Foto Kerusakan'),
              subtitle: const Text(
                'Ambil atau pilih foto dari galeri yang menunjukkan kerusakan infrastruktur.',
              ),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            elevation: 2,
            color: const Color(0xFFF5FCF9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(Icons.location_on, color: Color(0xFF00BF6D)),
              title: const Text('Langkah 3: Masukkan Lokasi'),
              subtitle: const Text(
                'Masukkan lokasi kejadian kerusakan dengan detail.',
              ),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            elevation: 2,
            color: const Color(0xFFF5FCF9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(Icons.description, color: Color(0xFF00BF6D)),
              title: const Text('Langkah 4: Tambahkan Deskripsi'),
              subtitle: const Text(
                'Isi deskripsi kerusakan dengan informasi yang jelas dan lengkap.',
              ),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            elevation: 2,
            color: const Color(0xFFF5FCF9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(
                Icons.calendar_today,
                color: Color(0xFF00BF6D),
              ),
              title: const Text('Langkah 5: Pilih Tanggal Kejadian'),
              subtitle: const Text('Tentukan tanggal kapan kerusakan terjadi.'),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            elevation: 2,
            color: const Color(0xFFF5FCF9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(Icons.person, color: Color(0xFF00BF6D)),
              title: const Text('Langkah 6: Isi Data Pelapor'),
              subtitle: const Text(
                'Masukkan nama dan nomor telepon Anda sebagai pelapor.',
              ),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            elevation: 2,
            color: const Color(0xFFF5FCF9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(Icons.send, color: Color(0xFF00BF6D)),
              title: const Text('Langkah 7: Kirim Laporan'),
              subtitle: const Text(
                'Tekan tombol "Kirim Laporan" untuk mengirimkan laporan ke sistem.',
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Catatan: Pastikan semua data yang dimasukkan akurat untuk proses penanganan yang cepat.',
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
