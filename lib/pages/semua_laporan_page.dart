import 'package:flutter/material.dart';
import 'package:pelaporan_insfrastruktur_rusak/pages/comment_section.dart';
import '../services/api_service.dart';
import '../models/laporan_model.dart';

class SemuaLaporanPage extends StatefulWidget {
  const SemuaLaporanPage({super.key});

  @override
  State<SemuaLaporanPage> createState() => _SemuaLaporanPageState();
}

class _SemuaLaporanPageState extends State<SemuaLaporanPage> {
  Future<List<Laporan>>? _cachedLaporan;
  int? _selectedCategoryId;

  final List<Map<String, dynamic>> _categories = [
    {
      'id': 1,
      'name': 'Jalan Rusak',
      'imagePath': 'assets/jalan.png',
      'description':
          'Jalan berlubang atau tidak rata yang membahayakan pengendara',
    },
    {
      'id': 2,
      'name': 'Lampu Mati',
      'imagePath': 'assets/lampu_mati.jpg',
      'description': 'Lampu jalan yang mati atau rusak',
    },
    {
      'id': 3,
      'name': 'Saluran Tersumbat',
      'imagePath': 'assets/saluran_tersumbat.jpg',
      'description': 'Got atau drainase mampet',
    },
    {
      'id': 4,
      'name': 'Sampah Menumpuk',
      'imagePath': 'assets/sampah_menumpuk.jpg',
      'description': 'Tumpukan sampah yang tidak diangkut',
    },
    {
      'id': 5,
      'name': 'Fasilitas Umum Rusak',
      'imagePath': 'assets/fasilitas_umum_rusak.jpg',
      'description': 'Bangku, taman, atau halte yang rusak',
    },
    {
      'id': 6,
      'name': 'Pohon Tumbang',
      'imagePath': 'assets/pohon_tumbang.jpg',
      'description': 'Pohon tumbang yang menutupi jalan atau membahayakan',
    },
    {
      'id': 7,
      'name': 'Rambu Tidak Jelas',
      'imagePath': 'assets/rambu_tidak_jelas.jpg',
      'description': 'Rambu atau marka jalan yang tidak terlihat atau hilang',
    },
  ];

  @override
  void initState() {
    super.initState();
    _cachedLaporan = ApiService().fetchReports();
  }

  Widget _buildCategoryBanner(String title, String imagePath, int categoryId) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategoryId =
              _selectedCategoryId == categoryId ? null : categoryId;
        });
      },
      child: Container(
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
          border:
              _selectedCategoryId == categoryId
                  ? Border.all(color: const Color(0xFF00BF6D), width: 2)
                  : null,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Colors.black.withOpacity(0.5), Colors.transparent],
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Semua Laporan'),
        backgroundColor: const Color(0xFF00BF6D),
        foregroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final newData = await ApiService().fetchReports();
          setState(() {
            _cachedLaporan = Future.value(newData);
          });
        },
        color: const Color(0xFF00BF6D),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Banner Kategori Laporan
            Container(
              height: 120,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  return _buildCategoryBanner(
                    category['name']!,
                    category['imagePath']!,
                    category['id']!,
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(width: 10),
              ),
            ),
            const SizedBox(height: 24),
            // Daftar Laporan
            FutureBuilder<List<Laporan>>(
              future: _cachedLaporan,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Terjadi kesalahan: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Belum ada laporan'));
                }

                final laporanList =
                    snapshot.data!.where((laporan) {
                      return _selectedCategoryId == null ||
                          laporan.categoryId == _selectedCategoryId;
                    }).toList();

                if (laporanList.isEmpty) {
                  return const Center(
                    child: Text('Tidak ada laporan untuk kategori ini'),
                  );
                }

                return Column(
                  children:
                      laporanList.asMap().entries.map((entry) {
                        final index = entry.key;
                        final laporan = entry.value;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // 🔹 Header: Nama Pelapor & Status
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      const CircleAvatar(
                                        backgroundImage: AssetImage(
                                          'assets/logo.jpg',
                                        ),
                                        radius: 20,
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              laporan.userName ??
                                                  'Tidak diketahui',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                            // Jika ingin menampilkan tanggal, bisa tambahkan di sini
                                            // Text('2 jam yang lalu', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            laporan.status == 'Sudah Selesai'
                                                ? Icons.check_circle
                                                : Icons.hourglass_top,
                                            color:
                                                laporan.status ==
                                                        'Sudah Selesai'
                                                    ? Colors.green
                                                    : Colors.orange,
                                            size: 16,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            laporan.status == 'Sudah Selesai'
                                                ? 'Selesai'
                                                : 'Diproses',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  laporan.status ==
                                                          'Sudah Selesai'
                                                      ? Colors.green
                                                      : Colors.orange,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                // 🔹 Gambar Laporan (jika ada)
                                if (laporan.photoUrl != null)
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(0),
                                    ),
                                    child: Image.network(
                                      laporan.photoUrl!,
                                      width: double.infinity,
                                      height: 180,
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                // 🔹 Konten Laporan
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        laporan.title,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        laporan.description,
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.bodyMedium,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on,
                                            size: 16,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              laporan.location,
                                              style:
                                                  Theme.of(
                                                    context,
                                                  ).textTheme.bodySmall,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      if (laporan.category != null)
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.category,
                                              size: 16,
                                              color: Colors.grey,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              laporan.category!,
                                              style:
                                                  Theme.of(
                                                    context,
                                                  ).textTheme.bodySmall,
                                            ),
                                          ],
                                        ),
                                      const SizedBox(height: 6),
                                      // Tombol Komentar
                                      TextButton.icon(
                                        onPressed: () {
                                          showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            builder:
                                                (_) => CommentSection(
                                                  reportId: laporan.id,
                                                ),
                                          );
                                        },
                                        icon: const Icon(Icons.comment),
                                        label: const Text('Komentar'),
                                        style: TextButton.styleFrom(
                                          foregroundColor: Color(0xFF00BF6D),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
