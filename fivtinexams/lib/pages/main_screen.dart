import 'package:flutter/material.dart';
import 'beranda.dart';
import 'kisi_kisi.dart';
import 'ujian.dart';
import 'latihan.dart';
import 'peringkat.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/bottom_navbar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Gunakan lazy loading dengan fungsi builder agar widget hanya dibuat saat diperlukan
  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return const BerandaPage();
      case 1:
        return const KisiKisi();
      case 2:
        return const UjianPage();
      case 3:
        return const LatihanSoal();
      case 4:
        return const PeringkatPage();
      default:
        return const BerandaPage();
    }
  }

  final List<String> _titles = [
    'Beranda',
    'Kisi-Kisi',
    'Ujian',
    'Latihan',
    'Peringkat',
  ];

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 247, 247),
      appBar: CustomAppBar(
        title: _titles[_selectedIndex],
      ),
      body: _getPage(_selectedIndex),
      bottomNavigationBar: CustomBottomNavbar(
        currentIndex: _selectedIndex,
        onTap: _onNavTapped,
      ),
    );
  }
}