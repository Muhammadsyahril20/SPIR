import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:pelaporan_insfrastruktur_rusak/models/user_model.dart';
import '../models/laporan_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/comment_model.dart';

class ApiService {
  final String baseUrl = 'https://6cc739fc415f.ngrok-free.app/api';

  // Register
  Future<Map<String, dynamic>> register(
    String name,
    String phone,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'phone_number': phone,
        'password': password,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 201) {
      return {'status': true, 'message': data['message'], 'data': data['data']};
    } else {
      return {
        'status': false,
        'message': data['message'] ?? 'Gagal mendaftar',
        'errors': data['errors'],
      };
    }
  }

  // Login
  Future<Map<String, dynamic>> login(String phone, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Accept': 'application/json'},
        body: {'phone_number': phone, 'password': password},
      );

      final data = jsonDecode(response.body);

      return data;
    } catch (e) {
      return {'status': false, 'message': 'Terjadi kesalahan: $e'};
    }
  }

  // Get Data User
  Future<UserModel> getCurrentUser() async {
    final token = await getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/user'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return UserModel.fromJson(json['data']);
    } else {
      throw Exception('Gagal memuat data user');
    }
  }

  // Update Profil
  Future<bool> updateProfile(String name, String phone) async {
    final token = await getToken();

    final response = await http.patch(
      Uri.parse('$baseUrl/user'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
      body: {'name': name, 'phone_number': phone},
    );

    return response.statusCode == 200;
  }

  // Logout
  Future<bool> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) return false;

    final response = await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      await prefs.remove('token');
      return true;
    } else {
      return false;
    }
  }

  // Get Data Laporan
  Future<List<Laporan>> fetchReports() async {
    final response = await http.get(Uri.parse('$baseUrl/reports'));

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      List data = body['data'];
      return data.map((item) => Laporan.fromJson(item)).toList();
    } else {
      throw Exception('Gagal memuat data laporan');
    }
  }

  // Create Report atau Buat Laporan
  Future<Map<String, dynamic>> createReport({
    required String title,
    required String description,
    required String location,
    required double latitude,
    required double longitude,
    required File photo,
    required int categoryId,
  }) async {
    final token = await getToken();
    if (token == null) {
      throw Exception('User not authenticated');
    }

    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/reports'));
    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Accept'] = 'application/json';

    request.fields['title'] = title;
    request.fields['description'] = description;
    request.fields['location'] = location;
    request.fields['latitude'] = latitude.toString();
    request.fields['longitude'] = longitude.toString();
    request.fields['category_id'] = categoryId.toString();

    request.files.add(await http.MultipartFile.fromPath('photo', photo.path));

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(responseBody);
    } else {
      throw Exception('Failed to create report: $responseBody');
    }
  }

  // Hapus Laporan
  Future<bool> deleteMyReport(int reportId) async {
    final token = await getToken(); // Ambil token dari SharedPreferences

    final response = await http.delete(
      Uri.parse('$baseUrl/my-reports/$reportId'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      // Bisa juga cek response.body untuk informasi error lebih lengkap
      throw Exception('Gagal menghapus laporan');
    }
  }

  // Get Komentar
  Future<List<Comment>> fetchComments(int reportId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/reports/$reportId/comments'),
    );
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body)['data'];
      return data.map((json) => Comment.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat komentar');
    }
  }

  // Tambah Komentar
  Future<bool> postComment(int reportId, String content) async {
    final token = await getToken();
    final response = await http.post(
      Uri.parse('$baseUrl/reports/$reportId/comments'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
      body: {'content': content},
    );
    return response.statusCode == 201;
  }

  // Update komentar
  Future<bool> updateComment(int commentId, String content) async {
    final token = await getToken();
    final response = await http.put(
      Uri.parse('$baseUrl/comments/$commentId'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
      body: {'content': content},
    );
    return response.statusCode == 200;
  }

  // Hapus komentar
  Future<bool> deleteComment(int commentId) async {
    final token = await getToken();
    final response = await http.delete(
      Uri.parse('$baseUrl/comments/$commentId'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );
    return response.statusCode == 200;
  }

  // Get User Token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Get Riwayat Laporan
  Future<List<Laporan>> getMyReports() async {
    final token = await getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/my-reports'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List data = jsonData['data'];
      return data.map((item) => Laporan.fromJson(item)).toList();
    } else {
      throw Exception('Gagal memuat laporan pengguna');
    }
  }

  // Category Helper
  String _getImagePath(String categoryName) {
    switch (categoryName) {
      case 'Jalan Rusak':
        return 'assets/jalan.png';
      case 'Lampu Mati':
        return 'assets/lampu_mati.jpg';
      case 'Saluran Tersumbat':
        return 'assets/saluran_tersumbat.jpg';
      case 'Sampah Menumpuk':
        return 'assets/sampah_menumpuk.jpg';
      case 'Fasilitas Umum Rusak':
        return 'assets/fasilitas_umum_rusak.jpg';
      case 'Pohon Tumbang':
        return 'assets/pohon_tumbang.jpg';
      case 'Rambu Tidak Jelas':
        return 'assets/rambu_tidak_jelas.jpg';
      default:
        return 'assets/default.jpg'; // Fallback image
    }
  }

  // Get Category
  Future<List<Map<String, dynamic>>> fetchCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/categories'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final List<dynamic> data = responseData['data'];
      return data
          .map(
            (json) => {
              'id': json['id'],
              'name': json['name'],
              'description': json['description'] ?? '',
              'imagePath': _getImagePath(json['name']),
            },
          )
          .toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
