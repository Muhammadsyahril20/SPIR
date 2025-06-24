import 'package:flutter/material.dart';

class SemuaLaporanPage extends StatelessWidget {
  const SemuaLaporanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Semua Laporan'),
        backgroundColor: const Color(0xFF00BF6D),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Profil
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF00BF6D), Color(0xFF1eb090)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, color: Color(0xFF00BF6D), size: 40),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Rian',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.check_circle, color: Colors.white, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                'Pelapor Aktif',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.access_time, color: Colors.white, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                'Terakhir Login: 02:52 PM, 23 Jun 2025',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white70),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  height: 2,
                  width: double.infinity,
                  color: Colors.white.withOpacity(0.3),
                ),
                const SizedBox(height: 12),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Laporan: 3',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Icon(Icons.star, color: Colors.white, size: 20),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Banner Kategori Laporan
          Container(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildCategoryBanner('Jembatan Rusak', 'assets/jembatan.jpg'),
                const SizedBox(width: 10),
                _buildCategoryBanner('Jalan Rusak', 'assets/jembatan.jpg'),
                const SizedBox(width: 10),
                _buildCategoryBanner('Lampu Rusak', 'assets/jembatan.jpg'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Daftar Laporan
          ..._laporanItems.map((item) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         _AvatarImage(),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.judul,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.deskripsi,
                                style: Theme.of(context).textTheme.bodyMedium,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Lokasi: ${item.lokasi}',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              if (item.fotoUrl != null)
                                Container(
                                  height: 150,
                                  margin: const EdgeInsets.only(top: 8.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(item.fotoUrl!),
                                    ),
                                  ),
                                ),
                              const SizedBox(height: 4),
                              Text(
                                'Status: ${item.status}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: item.status == 'Sudah Selesai' ? Colors.green : Colors.orange,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildCategoryBanner(String title, String imagePath) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black.withOpacity(0.5),
              Colors.transparent,
            ],
          ),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class _AvatarImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage('assets/logo.jpg'),
        ),
      ),
    );
  }
}

class LaporanItem {
  final String judul;
  final String deskripsi;
  final String lokasi;
  final String? fotoUrl;
  final String status;

  LaporanItem({
    required this.judul,
    required this.deskripsi,
    required this.lokasi,
    this.fotoUrl,
    required this.status,
  });
}

final List<LaporanItem> _laporanItems = [
  LaporanItem(
    judul: 'Jembatan Retak',
    deskripsi: 'Jembatan di Jalan Raya Utama mengalami retakan besar.',
    lokasi: 'Jalan Raya Utama, Jakarta',
    fotoUrl: 'assets/jembatan.jpg',
    status: 'Sedang Diproses',
  ),
  LaporanItem(
    judul: 'Lampu Jalan Mati',
    deskripsi: 'Beberapa lampu jalan di perumahan tidak menyala.',
    lokasi: 'Perumahan Citra, Bandung',
    fotoUrl: 'assets/jembatan.jpg',
    status: 'Sudah Selesai',
  ),
  LaporanItem(
    judul: 'Jalan Berlubang',
    deskripsi: 'Jalan utama berlubang dan membahayakan pengguna jalan.',
    lokasi: 'Jalan Sudirman, Surabaya',
    fotoUrl: 'assets/logo.jpg',
    status: 'Sedang Diproses',
  ),
];