import 'package:flutter/material.dart';
import 'beranda.dart'; // Pastikan sudah import BerandaPage

Future<void> showSuccessNotification(BuildContext context) async {
  final screenWidth = MediaQuery.of(context).size.width;

  ScaffoldMessenger.of(context).removeCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Container(
        width: double.infinity,
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: const Icon(
                Icons.check_rounded,
                color: Color(0xFFCB5D29),
                size: 30,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Login Berhasil',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Selamat datang kembali!',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ],
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Color(0xFFCB5D29),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.only(
        bottom: 70,
        left: screenWidth * 0.1,
        right: screenWidth * 0.1,
      ),
      duration: const Duration(milliseconds: 1500),
      elevation: 5,
    ),
  );

  // ⏳ Tunggu sampai snackbar selesai tampil
  await Future.delayed(const Duration(milliseconds: 1500));

  // 🚀 Setelah selesai, baru navigasi ke halaman beranda
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => BerandaPage()),
  );
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  // Username dan Password yang valid
  final String validUsername = 'Arga';
  final String validPassword = 'Arga';
  
  // Error messages
  String? _usernameError;
  String? _passwordError;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  
  // Method untuk validasi login
  Future<void> _validateLogin() async {
    // Reset error messages
    setState(() {
      _usernameError = null;
      _passwordError = null;
    });

    bool isValid = true;

    // Validasi username
    if (_usernameController.text.isEmpty) {
      setState(() {
        _usernameError = 'Username tidak boleh kosong';
      });
      isValid = false;
    } else if (_usernameController.text != validUsername) {
      setState(() {
        _usernameError = 'Username tidak ditemukan';
      });
      isValid = false;
    }

    // Validasi password
    if (_passwordController.text.isEmpty) {
      setState(() {
        _passwordError = 'Password tidak boleh kosong';
      });
      isValid = false;
    } else if (_passwordController.text != validPassword) {
      setState(() {
        _passwordError = 'Password salah';
      });
      isValid = false;
    }

    // Jika semua valid, tampilkan notifikasi dan tunggu dulu
    if (isValid) {
      await showSuccessNotification(context);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Mencegah layar resize saat keyboard muncul
      body: Stack(
        children: [
          // Bottom gradient decoration (kotak-kotak di bawah)
          Positioned(
            bottom: -MediaQuery.of(context).size.height * 0.01,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/bottom.png',
              height: MediaQuery.of(context).size.height * 0.3,
              fit: BoxFit.cover,
            ),
          ),

          // Main content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 100),
                  
                  // Title
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  SizedBox(height: 20),
                  
                  // Username field
                  Text(
                    'Username',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF5E5C0),
                      borderRadius: BorderRadius.circular(4),
                      border: _usernameError != null 
                          ? Border.all(color: Colors.red, width: 1.5)
                          : null,
                    ),
                    child: TextField(
                      controller: _usernameController,
                      textInputAction: TextInputAction.next,
                      onSubmitted: (_) => _validateLogin(),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                        suffixIcon: _usernameError != null
                            ? Icon(Icons.error_outline, color: Colors.red)
                            : null,
                      ),
                      onChanged: (value) {
                        // Reset error when user types
                        if (_usernameError != null) {
                          setState(() {
                            _usernameError = null;
                          });
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    _usernameError ?? 'Masukkan username yang sudah terdaftar.',
                    style: TextStyle(
                      fontSize: 12,
                      color: _usernameError != null ? Colors.red : Colors.grey[600],
                    ),
                  ),
                  
                  SizedBox(height: 16),
                  
                  // Password field
                  Text(
                    'Password',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF5E5C0),
                      borderRadius: BorderRadius.circular(4),
                      border: _passwordError != null 
                          ? Border.all(color: Colors.red, width: 1.5)
                          : null,
                    ),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _validateLogin(),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                        suffixIcon: _passwordError != null
                            ? Icon(Icons.error_outline, color: Colors.red)
                            : null,
                      ),
                      onChanged: (value) {
                        // Reset error when user types
                        if (_passwordError != null) {
                          setState(() {
                            _passwordError = null;
                          });
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    _passwordError ?? 'Masukkan password yang sudah terdaftar.',
                    style: TextStyle(
                      fontSize: 12,
                      color: _passwordError != null ? Colors.red : Colors.grey[600],
                    ),
                  ),
                  
                  SizedBox(height: 24),
                  
                  // Login button
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: _validateLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFFA069),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        elevation: 5,
                        shadowColor: Colors.black.withOpacity(0.7),  // Mengubah warna bayangan
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}