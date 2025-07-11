import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:pelaporan_insfrastruktur_rusak/services/api_service.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..addListener(() {
      setState(() {});
    });
    _opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(decoration: const BoxDecoration(color: Colors.white)),
          CustomPaint(painter: CurvePainter(), child: Container()),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF00BF6D), Color(0xFF1eb090)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: constraints.maxHeight * 0.05),
                        AnimatedOpacity(
                          opacity: _opacity.value,
                          duration: const Duration(milliseconds: 1000),
                          child: Image.asset(
                            'assets/fix.png',
                            height: 120,
                            width: 120,
                            errorBuilder: (context, error, stackTrace) {
                              print('Error loading asset: $error');
                              return Container(
                                height: 120,
                                width: 120,
                                color: Colors.grey,
                                child: const Center(
                                  child: Text('Logo gagal dimuat'),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: constraints.maxHeight * 0.05),
                        AnimatedOpacity(
                          opacity: _opacity.value,
                          duration: const Duration(milliseconds: 1200),
                          child: Text(
                            "Daftar Akun",
                            style: Theme.of(
                              context,
                            ).textTheme.headlineSmall!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black26,
                                  offset: const Offset(2, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: constraints.maxHeight * 0.05),
                        AnimatedOpacity(
                          opacity: _opacity.value,
                          duration: const Duration(milliseconds: 1400),
                          child: Container(
                            padding: const EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.85),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 3,
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: _nameController,
                                    decoration: const InputDecoration(
                                      hintText: 'Nama Lengkap',
                                      filled: true,
                                      fillColor: Color(0xFFF5FCF9),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 20.0,
                                        vertical: 18.0,
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(30),
                                        ),
                                      ),
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Color(0xFF00BF6D),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Masukkan nama lengkap';
                                      }
                                      return null;
                                    },
                                    onSaved: (name) {},
                                  ),
                                  const SizedBox(height: 16.0),
                                  TextFormField(
                                    controller: _phoneController,
                                    decoration: const InputDecoration(
                                      hintText: 'Nomor Telepon',
                                      filled: true,
                                      fillColor: Color(0xFFF5FCF9),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 20.0,
                                        vertical: 18.0,
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(30),
                                        ),
                                      ),
                                      prefixIcon: Icon(
                                        Icons.phone,
                                        color: Color(0xFF00BF6D),
                                      ),
                                    ),
                                    keyboardType: TextInputType.phone,
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Masukkan nomor telepon';
                                      }
                                      if (value.trim().length > 255) {
                                        return 'Nomor telepon terlalu panjang';
                                      }
                                      return null;
                                    },
                                    onSaved: (phone) {},
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16.0,
                                    ),
                                    child: TextFormField(
                                      controller: _passwordController,
                                      obscureText: _obscurePassword,
                                      decoration: InputDecoration(
                                        hintText: 'Kata Sandi',
                                        filled: true,
                                        fillColor: const Color(0xFFF5FCF9),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                              horizontal: 20.0,
                                              vertical: 18.0,
                                            ),
                                        border: const OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(30),
                                          ),
                                        ),
                                        prefixIcon: const Icon(
                                          Icons.lock,
                                          color: Color(0xFF00BF6D),
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _obscurePassword
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: Colors.grey,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _obscurePassword =
                                                  !_obscurePassword;
                                            });
                                          },
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Masukkan kata sandi';
                                        }
                                        if (value.length < 6) {
                                          return 'Kata sandi minimal 6 karakter';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),

                                  const SizedBox(height: 20.0),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          final name =
                                              _nameController.text.trim();
                                          final phone =
                                              _phoneController.text.trim();
                                          final password =
                                              _passwordController.text;

                                          final result = await ApiService()
                                              .register(name, phone, password);

                                          if (result['status']) {
                                            AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.success,
                                              animType: AnimType.bottomSlide,
                                              title: 'Pendaftaran Berhasil',
                                              desc:
                                                  'Akun Anda berhasil dibuat. Silakan login untuk melanjutkan.',
                                              btnOkText: 'Login',
                                              btnOkOnPress: () {
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder:
                                                        (context) =>
                                                            const SignInScreen(),
                                                  ),
                                                );
                                              },
                                              btnOkColor: const Color(
                                                0xFF00BF6D,
                                              ),
                                            ).show();
                                          } else {
                                            String errorText = '';
                                            if (result['errors'] != null) {
                                              result['errors'].forEach((
                                                key,
                                                value,
                                              ) {
                                                errorText += '${value[0]}\n';
                                              });
                                            } else {
                                              errorText =
                                                  result['message'] ??
                                                  'Terjadi kesalahan';
                                            }

                                            AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.error,
                                              animType: AnimType.rightSlide,
                                              title: 'Gagal Mendaftar',
                                              desc: errorText,
                                              btnOkText: 'OK',
                                              btnOkColor: Colors.red,
                                              btnOkOnPress: () {},
                                            ).show();
                                          }
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        elevation: 6,
                                        backgroundColor: Color(0xFF00BF6D),
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 14,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                        ),
                                      ),
                                      child: const Text(
                                        "Daftar",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20.0),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SignInScreen(),
                                        ),
                                      );
                                    },
                                    child: Text.rich(
                                      const TextSpan(
                                        text: "Sudah punya akun? ",
                                        children: [
                                          TextSpan(
                                            text: "Masuk",
                                            style: TextStyle(
                                              color: Color(0xFF00BF6D),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(color: Colors.black87),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.4); // Mulai dari 40% tinggi
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.5, // Puncak kurva
      size.width,
      size.height * 0.4,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
