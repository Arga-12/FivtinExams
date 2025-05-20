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
  final List<GlobalKey> _pageKeys = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
  ];
  final List<ScrollController> _scrollControllers = List.generate(
    5,
    (index) => ScrollController(),
  );

  final List<Widget> _pages = [
    const BerandaPage(),
    const KisiKisi(),
    const UjianPage(),
    const LatihanSoal(),
    const PeringkatPage(),
  ];

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
  void dispose() {
    for (var controller in _scrollControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 247, 247),
      appBar: CustomAppBar(
        title: _titles[_selectedIndex],
        scrollController: _scrollControllers[_selectedIndex],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: List.generate(_pages.length, (index) {
          return _wrapWithScrollController(
            child: _pages[index],
            controller: _scrollControllers[index],
            key: _pageKeys[index],
          );
        }),
      ),
      bottomNavigationBar: CustomBottomNavbar(
        currentIndex: _selectedIndex,
        onTap: _onNavTapped,
      ),
    );
  }

  Widget _wrapWithScrollController({
    required Widget child,
    required ScrollController controller,
    required Key key,
  }) {
    return KeyedSubtree(
      key: key,
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          // Biarkan scroll controller menangani scroll
          return false;
        },
        child: child,
      ),
    );
  }
}