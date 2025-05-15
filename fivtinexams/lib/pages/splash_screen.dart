import 'package:flutter/material.dart';
import 'dart:async';
import 'home.dart'; // Import halaman utama

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay 3 detik, lalu pindah ke HomePage
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Warna latar belakang splash
      body: Center(
        child: Image.asset('assets/Logo1.png', width: 200), // Gambar logo
      ),
    );
  }
}
