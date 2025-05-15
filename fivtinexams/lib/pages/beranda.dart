import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart'; // import custom appbar
import '../widgets/bottom_navbar.dart'; // pastikan path-nya sesuai

class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const BerandaContent(), // konten beranda tetap dipisah agar tidak rekursif
    const PlaceholderWidget('Kisi-kisi'), // kamu bisa ganti nanti
    const PlaceholderWidget('Ujian'),
    const PlaceholderWidget('Lat. Soal'),
    const PlaceholderWidget('Peringkat'),
  ];

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
        title: 'Beranda',
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomBottomNavbar(
        currentIndex: _selectedIndex,
        onTap: _onNavTapped,
      ),
    );
  }
}

// Widget konten beranda asli kamu
class BerandaContent extends StatelessWidget {
  const BerandaContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          'Selamat datang di Beranda!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

// Placeholder sementara untuk halaman lain
class PlaceholderWidget extends StatelessWidget {
  final String title;
  const PlaceholderWidget(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('$title Page', style: TextStyle(fontSize: 24)),
    );
  }
}
