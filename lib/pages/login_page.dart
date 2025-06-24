import 'package:flutter/material.dart';
import 'home_page.dart';
import 'register_page.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
          ),
          CustomPaint(
            painter: CurvePainter(),
            child: Container(),
          ),
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
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
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
                                child: const Center(child: Text('Logo gagal dimuat')),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: constraints.maxHeight * 0.05),
                        AnimatedOpacity(
                          opacity: _opacity.value,
                          duration: const Duration(milliseconds: 1200),
                          child: Text(
                            "Sign In",
                            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
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
                                    controller: _phoneController,
                                    decoration: const InputDecoration(
                                      hintText: 'Nomor Telepon',
                                      filled: true,
                                      fillColor: Color(0xFFF5FCF9),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 18.0),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(Radius.circular(30)),
                                      ),
                                      prefixIcon: Icon(Icons.phone, color: Color(0xFF00BF6D)),
                                    ),
                                    keyboardType: TextInputType.phone,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Masukkan nomor telepon';
                                      }
                                      if (!RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(value)) {
                                        return 'Nomor telepon tidak valid';
                                      }
                                      return null;
                                    },
                                    onSaved: (phone) {},
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                                    child: TextFormField(
                                      controller: _passwordController,
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                        hintText: 'Kata Sandi',
                                        filled: true,
                                        fillColor: Color(0xFFF5FCF9),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 18.0),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(Radius.circular(30)),
                                        ),
                                        prefixIcon: Icon(Icons.lock, color: Color(0xFF00BF6D)),
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
                                      onSaved: (password) {},
                                    ),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => HomePage(),
                                            ),
                                          );
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        elevation: 6,
                                        backgroundColor: Color(0xFF00BF6D),
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(vertical: 14),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                      ),
                                      child: const Text(
                                        "Masuk",
                                        style: TextStyle(
                                            fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20.0),
                                  TextButton(
                                    onPressed: () {
                                      // TODO: Implementasi lupa kata sandi
                                    },
                                    child: Text(
                                      'Lupa Kata Sandi?',
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                            color: Color(0xFF00BF6D),
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SignUpScreen(),
                                        ),
                                      );
                                    },
                                    child: Text.rich(
                                      const TextSpan(
                                        text: "Belum punya akun? ",
                                        children: [
                                          TextSpan(
                                            text: "Daftar",
                                            style: TextStyle(
                                              color: Color(0xFF00BF6D),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                            color: Colors.black87,
                                          ),
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
    final paint = Paint()
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