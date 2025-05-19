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
  void didChangeDependencies() {
    super.didChangeDependencies();
    final itemWidth = MediaQuery.of(context).size.width / 5;
    _indicatorPosition = widget.currentIndex * itemWidth;
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
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                // Animated Indicator - Modernized
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  left: _indicatorPosition + (itemWidth - 45) / 2, // Posisi tengah item
                  bottom: 5, // Posisi di bawah
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
                    _buildNavItemWithImage(0, 'assets/icons/beranda.png', 'Beranda', itemWidth),
                    _buildNavItemWithImage(1, 'assets/icons/kisiksi.png', 'Kisi-kisi', itemWidth),
                    
                    // Item tengah (Ujian) dengan style khusus
                    _buildCenterNavItem(2, 'assets/icons/ujian.png', 'Ujian', itemWidth),
                    
                    _buildNavItemWithImage(3, 'assets/icons/latsol.png', 'Lat. Soal', itemWidth),
                    _buildNavItemWithImage(4, 'assets/icons/peringkat.png', 'Peringkat', itemWidth),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget untuk item navbar biasa
  Widget _buildNavItemWithImage(int index, String imagePath, String label, double width) {
    final bool isSelected = widget.currentIndex == index;
    
    return GestureDetector(
      onTap: () => widget.onTap(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: width,
        child: Center(
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              final double scale = isSelected 
                  ? 1.0 + (_animation.value * 0.4)
                  : 1.0;
              
              return Transform.scale(
                scale: isSelected && _animationController.isAnimating 
                    ? scale
                    : isSelected ? 1.4 : 1.0,
                child: Image.asset(
                  imagePath,
                  width: 40,
                  height: 40,
                  color: isSelected ? Colors.white : Colors.white70,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
  
  // Widget khusus untuk item tengah (Ujian) dengan style yang modern
  Widget _buildCenterNavItem(int index, String imagePath, String label, double width) {
    final bool isSelected = widget.currentIndex == index;
    
    return GestureDetector(
      onTap: () => widget.onTap(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: width,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 17),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                // Background circular dengan efek bayangan
                Positioned(
                  bottom: -7,
                  child: Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected ? Colors.white : Colors.white.withOpacity(0.9),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 8,
                          spreadRadius: 1,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Ikon ujian dengan efek scale saat aktif
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    final double scale = isSelected 
                        ? 1.0 + (_animation.value * 0.3)
                        : 1.0;
                    
                    return Positioned(
                      bottom: isSelected ? 0 : 0,
                      child: Transform.scale(
                        scale: isSelected && _animationController.isAnimating 
                            ? scale
                            : isSelected ? 1.3 : 1.0,
                        child: Image.asset(
                          imagePath,
                          width: 35,
                          height: 35,
                          color: isSelected ? const Color(0xFFCB5D29) : const Color(0xFFE87A45),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}