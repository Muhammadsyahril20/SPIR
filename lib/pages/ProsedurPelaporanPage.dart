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
        elevation: 0,
      ),
      body: Column(
        children: [
          // Ilustrasi atau banner di bagian atas
          Container(
            width: double.infinity,
            color: const Color(0xFF00BF6D),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Ikuti langkah-langkah berikut untuk membuat pelaporan:',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildStep(
                  icon: Icons.login,
                  title: 'Login ke Aplikasi',
                  description:
                      'Masuk ke aplikasi SPIR menggunakan akun terdaftar Anda.',
                ),
                _buildStep(
                  icon: Icons.camera_alt_outlined,
                  title: 'Unggah Foto Kerusakan',
                  description:
                      'Ambil atau pilih foto dari galeri yang menunjukkan kerusakan.',
                ),
                _buildStep(
                  icon: Icons.location_on_outlined,
                  title: 'Masukkan Lokasi',
                  description:
                      'Tentukan lokasi kejadian secara akurat menggunakan peta.',
                ),
                _buildStep(
                  icon: Icons.description_outlined,
                  title: 'Tambahkan Deskripsi',
                  description:
                      'Jelaskan kerusakan dengan detail untuk membantu penanganan.',
                ),
                _buildStep(
                  icon: Icons.send_outlined,
                  title: 'Kirim Laporan',
                  description:
                      'Tekan tombol "Kirim Laporan" untuk menyelesaikan proses.',
                ),
                const SizedBox(height: 16),
                // Tips Section
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF4E6),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFFF8A00).withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.lightbulb_outline,
                        color: Color(0xFFFF8A00),
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Tips Penting',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFF8A00),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Pastikan semua data yang dimasukkan akurat dan lengkap untuk proses penanganan yang cepat dan tepat.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF8B4513),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Material(
        elevation: 2,
        color: const Color(0xFFF5FCF9),
        borderRadius: BorderRadius.circular(12),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: const Color(0xFF00BF6D).withOpacity(0.1),
            child: Icon(icon, color: const Color(0xFF00BF6D)),
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(description),
        ),
      ),
    );
  }
}
