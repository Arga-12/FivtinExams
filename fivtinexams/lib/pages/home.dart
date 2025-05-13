import 'package:flutter/material.dart';
import 'login.dart'; // Import halaman login

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,  // Disable resizing when keyboard appears
      body: Stack(
        children: [
          // Bottom separuh layar
          Positioned(
            bottom: -MediaQuery.of(context).size.height * 0.01, // Biar sebagian keluar layar
            left: 0,
            right: 0,
            child: Transform.rotate(
              angle: -0.0, // Miringin sedikit
              child: Image.asset(
                'assets/bottom.png',
                height: MediaQuery.of(context).size.height * 0.3, // Tinggi gambar
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Main content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Bagian atas (judul)
                  SizedBox(height: 60),
                  Text(
                    'Selamat datang di',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    'Fivtin Exams',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Expanded agar bagian bawah bisa berada di tengah vertikal
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min, // agar kolom dalam center tidak mengisi penuh
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Selamat datang, Peserta didik!',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Mohon untuk login terlebih dahulu agar dapat mengakses aplikasi ujian yang khusus disediakan untuk sekolah ini.',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Terima kasih!',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                // Arahkan ke halaman Login
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
                                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFFFA069),  // Ubah warna background tombol
                                foregroundColor: Colors.white,        // Ubah warna teks tombol
                                padding: EdgeInsets.symmetric(vertical: 13, horizontal: 24),  // Mengubah padding tombol
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),  // Mengubah radius tombol menjadi lebih bulat
                                ),
                                elevation: 5,  // Memberikan efek bayangan pada tombol
                                shadowColor: Colors.black.withOpacity(0.7),  // Mengubah warna bayangan
                              ),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 18,  // Ukuran font lebih besar
                                  fontWeight: FontWeight.w500,  // Font tebal
                                  letterSpacing: 1.2,  // Jarak antar huruf
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 200), // Tambahan bawah jika perlu
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
