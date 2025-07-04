import 'package:flutter/material.dart';
import 'package:pelaporan_insfrastruktur_rusak/models/user_model.dart';
import 'package:pelaporan_insfrastruktur_rusak/pages/RiwayatLaporanPage.dart';
import 'package:pelaporan_insfrastruktur_rusak/pages/TentangAplikasiPage.dart';
import 'package:pelaporan_insfrastruktur_rusak/pages/UbahAkunPage.dart';
import 'package:pelaporan_insfrastruktur_rusak/services/api_service.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'login_page.dart';
import 'ProsedurPelaporanPage.dart';

class AkunPage extends StatefulWidget {
  const AkunPage({super.key});

  @override
  State<AkunPage> createState() => _AkunPageState();
}

class _AkunPageState extends State<AkunPage> {
  late Future<UserModel> _futureUser;

  @override
  void initState() {
    super.initState();
    _futureUser = _loadUser();
  }

  Future<UserModel> _loadUser() async {
    return await ApiService().getCurrentUser();
  }

  // Function to handle refresh
  Future<void> _handleRefresh() async {
    setState(() {
      _futureUser = _loadUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Akun'),
        backgroundColor: const Color(0xFF00BF6D),
        foregroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        color: const Color(0xFF00BF6D),
        child: FutureBuilder<UserModel>(
          future: _futureUser,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Gagal memuat data pengguna'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('Data tidak ditemukan'));
            }

            final user = snapshot.data!;

            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                // Kartu Profil
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
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(user.phoneNumber),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Menu
                _buildMenuTile(
                  icon: Icons.edit,
                  title: "Ubah Akun",
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const UbahAkunPage()),
                      ),
                ),
                _buildMenuTile(
                  icon: Icons.info_outline,
                  title: "Prosedur Pelaporan",
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ProsedurPelaporanPage(),
                        ),
                      ),
                ),
                _buildMenuTile(
                  icon: Icons.info,
                  title: "Tentang Aplikasi",
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const TentangAplikasiPage(),
                        ),
                      ),
                ),
                _buildMenuTile(
                  icon: Icons.history,
                  title: "Riwayat Laporan",
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RiwayatLaporanPage(),
                        ),
                      ),
                ),
                _buildMenuTile(
                  icon: Icons.logout,
                  title: "Logout",
                  onTap: () {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.noHeader,
                      customHeader: const Icon(
                        Icons.help_outline,
                        size: 80,
                        color: Colors.blue,
                      ),
                      animType: AnimType.bottomSlide,
                      title: 'Konfirmasi Logout',
                      desc: 'Apakah kamu yakin ingin keluar dari aplikasi?',
                      btnCancelText: "Batal",
                      btnCancelColor: Colors.green,
                      btnCancelOnPress: () {},
                      btnOkText: "Logout",
                      btnOkColor: Colors.red,
                      btnOkOnPress: () async {
                        final success = await ApiService().logout();
                        if (success && context.mounted) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SignInScreen(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                '❌ Gagal logout. Silakan coba lagi.',
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                    ).show();
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildMenuTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: const Color(0xFF00BF6D)),
          title: Text(title),
          trailing: const Icon(Icons.chevron_right, color: Colors.grey),
          onTap: onTap,
        ),
        const Divider(),
      ],
    );
  }
}
