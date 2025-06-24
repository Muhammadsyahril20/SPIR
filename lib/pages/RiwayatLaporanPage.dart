import 'package:flutter/material.dart';

class RiwayatLaporanPage extends StatelessWidget {
  const RiwayatLaporanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Laporan'),
        backgroundColor: const Color(0xFF00BF6D),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ListView.separated(
            itemCount: _laporanItems.length,
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
            itemBuilder: (BuildContext context, int index) {
              final item = _laporanItems[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
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
                            'Rian', // Nama kamu
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
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
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Lokasi: ${item.lokasi}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          if (item.fotoUrl != null)
                            Container(
                              height: 200,
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
                              color:
                                  item.status == 'Sudah Selesai'
                                      ? Colors.green
                                      : Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
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
          image: AssetImage('assets/logo.jpg'), // Pake logo lokal
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
    fotoUrl: 'assets/jembatan.jpg', // Pake logo sebagai placeholder
    status: 'Sedang Diproses',
  ),
];

