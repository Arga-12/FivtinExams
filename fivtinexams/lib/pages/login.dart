import 'package:flutter/material.dart';
import 'beranda.dart'; // Pastikan sudah import BerandaPage

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  // Username dan Password yang valid
  final String validUsername = 'user123';
  final String validPassword = 'password123';
  
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
  void _validateLogin() {
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
    
    // Jika semua valid, navigasi ke halaman beranda
    if (isValid) {
      // Tampilkan pesan sukses
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login berhasil!'),
          backgroundColor: Colors.green,
        ),
      );
      
      // Navigasi ke beranda setelah login sukses
      Future.delayed(Duration(milliseconds: 500), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BerandaPage()),
        );
      });
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
                  SizedBox(height: 50),
                  
                  // Title
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  SizedBox(height: 150),
                  
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
                    _passwordError ?? 'Masukkan password sesuai dengan username.',
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