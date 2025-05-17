import 'package:flutter/material.dart';
import 'dart:ui';

class CustomBottomNavbar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<CustomBottomNavbar> createState() => _CustomBottomNavbarState();
}

class _CustomBottomNavbarState extends State<CustomBottomNavbar> with SingleTickerProviderStateMixin {
  // Controller untuk animasi
  late AnimationController _animationController;
  late Animation<double> _animation;
  
  // Posisi indikator aktif
  double _indicatorPosition = 0;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }
  
  @override
  void didUpdateWidget(CustomBottomNavbar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _animationController.reset();
      _animationController.forward();
    }
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Definisi warna utama dan gradasi
    const Color primaryColor = Color(0xFFCB5D29);
    const Color secondaryColor = Color(0xFFE87A45);
    
    // Hitung lebar layar untuk penentuan posisi yang akurat
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = screenWidth / 5; // 5 menu items
    
    // Update posisi indikator berdasarkan lebar layar sebenarnya
    if (_indicatorPosition == 0 || _indicatorPosition / itemWidth != widget.currentIndex) {
      _indicatorPosition = widget.currentIndex * itemWidth;
    }
    
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            height: 75,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [primaryColor, secondaryColor],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Stack(
              children: [
                // Animated Indicator - Modernized
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  left: _indicatorPosition + (itemWidth - 45) / 2, // Posisi tengah item
                  bottom: 12, // Posisi di bawah
                  child: Container(
                    width: 45,
                    height: 3,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.5),
                          blurRadius: 5,
                          spreadRadius: 0.5,
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Nav Items
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNavItem(0, Icons.home_rounded, 'Beranda', itemWidth),
                    _buildNavItem(1, Icons.menu_book_rounded, 'Kisi-kisi', itemWidth),
                    _buildNavItem(2, Icons.edit_rounded, 'Ujian', itemWidth),
                    _buildNavItem(3, Icons.article_rounded, 'Lat. Soal', itemWidth),
                    _buildNavItem(4, Icons.leaderboard_rounded, 'Peringkat', itemWidth),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label, double width) {
    final bool isSelected = widget.currentIndex == index;
    
    return GestureDetector(
      onTap: () => widget.onTap(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon dengan animasi fade dan ukuran
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                final double scale = isSelected 
                    ? 1.0 + (_animation.value * 0.4)
                    : 1.0;
                
                return Transform.scale(
                  scale: isSelected && _animationController.isAnimating 
                      ? scale
                      : isSelected ? 1.4 : 1.0,
                  child: Icon(
                    icon,
                    color: isSelected ? Colors.white : Colors.white70,
                    size: 24,
                  ),
                );
              },
            ),
            const SizedBox(height: 5),
            
            // Label dengan animasi opacity
            AnimatedOpacity(
              opacity: isSelected ? 1.0 : 0.7,
              duration: const Duration(milliseconds: 200),
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isSelected ? 12 : 11,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}