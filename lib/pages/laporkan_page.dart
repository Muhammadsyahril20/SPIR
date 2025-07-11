import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pelaporan_insfrastruktur_rusak/pages/map_picker_date.dart';
import '../services/api_service.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class LaporkanPage extends StatefulWidget {
  const LaporkanPage({super.key});

  @override
  _LaporkanPageState createState() => _LaporkanPageState();
}

class _LaporkanPageState extends State<LaporkanPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  XFile? _image;
  int? _selectedCategoryId;
  Future<List<Map<String, dynamic>>>? _categoriesFuture;

  final ImagePicker _picker = ImagePicker();
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _categoriesFuture = _apiService.fetchCategories();
  }

  void showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(color: Color(0xFF00BF6D)),
                SizedBox(height: 16),
                Text('Mengirim laporan...', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickImage() async {
    final XFile? pickedImage = await _picker.pickImage(
      source: ImageSource.camera,
    );
    if (pickedImage != null) {
      final dir = await getTemporaryDirectory();
      final targetPath = path.join(
        dir.path,
        "${DateTime.now().millisecondsSinceEpoch}.jpg",
      );

      final compressedFile = await FlutterImageCompress.compressAndGetFile(
        pickedImage.path,
        targetPath,
        quality:
            70, // kamu bisa atur 0-100 (semakin kecil, semakin kecil ukuran file)
      );

      if (compressedFile != null) {
        setState(() {
          _image = XFile(compressedFile.path);
        });
      }
    }
  }

  Future<void> _pickLocation() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MapPickerPage()),
    );
    if (result != null) {
      setState(() {
        _locationController.text = result['address'];
        _latitudeController.text = result['latitude'].toString();
        _longitudeController.text = result['longitude'].toString();
      });
    }
  }

  Future<void> _submitReport() async {
    if (_formKey.currentState!.validate()) {
      if (_image == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Harap unggah foto laporan')),
        );
        return;
      }
      if (_selectedCategoryId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Harap pilih kategori laporan')),
        );
        return;
      }

      showLoadingDialog();

      try {
        await _apiService.createReport(
          title: _titleController.text,
          description: _descriptionController.text,
          location: _locationController.text,
          latitude: double.parse(_latitudeController.text),
          longitude: double.parse(_longitudeController.text),
          photo: File(_image!.path),
          categoryId: _selectedCategoryId!,
        );

        Navigator.of(context).pop();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Laporan berhasil dikirim')),
        );

        // Reset form
        _formKey.currentState!.reset();
        setState(() {
          _image = null;
          _selectedCategoryId = null;
          _titleController.clear();
          _descriptionController.clear();
          _locationController.clear();
          _latitudeController.clear();
          _longitudeController.clear();
        });
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Gagal mengirim laporan: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buat Laporan'),
        backgroundColor: const Color(0xFF00BF6D),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Kategori
                const Text(
                  'Kategori Laporan',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                FutureBuilder<List<Map<String, dynamic>>>(
                  future: _categoriesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text('Gagal memuat kategori');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text('Tidak ada kategori tersedia');
                    }
                    return DropdownButtonFormField<int>(
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFF5FCF9),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                      hint: const Text('Pilih Kategori'),
                      value: _selectedCategoryId,
                      items:
                          snapshot.data!.map((category) {
                            return DropdownMenuItem<int>(
                              value: category['id'],
                              child: Text(category['name']),
                            );
                          }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategoryId = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Pilih kategori laporan';
                        }
                        return null;
                      },
                    );
                  },
                ),
                const SizedBox(height: 16),

                // Judul
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Judul Laporan',
                    filled: true,
                    fillColor: Color(0xFFF5FCF9),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan judul laporan';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Upload Foto
                const Text(
                  'Foto Laporan',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5FCF9),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child:
                        _image == null
                            ? const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera_alt,
                                    color: Colors.grey,
                                    size: 40,
                                  ),
                                  Text('Ketuk untuk unggah foto'),
                                ],
                              ),
                            )
                            : ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                File(_image!.path),
                                fit: BoxFit.cover,
                                height: 150,
                                width: double.infinity,
                              ),
                            ),
                  ),
                ),
                const SizedBox(height: 16),

                // Lokasi
                const Text(
                  'Lokasi Laporan',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: _pickLocation,
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: _locationController,
                      decoration: const InputDecoration(
                        labelText: 'Lokasi',
                        filled: true,
                        fillColor: Color(0xFFF5FCF9),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Pilih lokasi laporan';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Latitude
                TextFormField(
                  controller: _latitudeController,
                  decoration: const InputDecoration(
                    labelText: 'Latitude',
                    filled: true,
                    fillColor: Color(0xFFF5FCF9),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Pilih lokasi untuk mendapatkan latitude';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Longitude
                TextFormField(
                  controller: _longitudeController,
                  decoration: const InputDecoration(
                    labelText: 'Longitude',
                    filled: true,
                    fillColor: Color(0xFFF5FCF9),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Pilih lokasi untuk mendapatkan longitude';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Deskripsi
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Deskripsi Laporan',
                    filled: true,
                    fillColor: Color(0xFFF5FCF9),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan deskripsi laporan';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Tombol Kirim
                ElevatedButton(
                  onPressed: _submitReport,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00BF6D),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 48),
                    shape: const StadiumBorder(),
                  ),
                  child: const Text('Kirim Laporan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
