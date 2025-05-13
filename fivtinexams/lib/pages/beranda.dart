import 'package:flutter/material.dart';

class BerandaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beranda'),
        backgroundColor: Color(0xFFFFA069),
      ),
      body: Center(
        child: Text(
          'Selamat datang di Beranda!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
