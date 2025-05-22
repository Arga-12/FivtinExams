import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

class _CustomBottomNavbarState extends State<CustomBottomNavbar>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  double _indicatorPosition = 0;
  
  final Map<int, AnimationController> _itemControllers = {};
  final Map<int, Animation<double>> _itemAnimations = {};

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
    
    // Initialize controllers for each menu item
    for (int i = 0; i < 5; i++) {
      _itemControllers[i] = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 350),
      );
      _itemAnimations[i] = CurvedAnimation(
        parent: _itemControllers[i]!,
        curve: Curves.easeInOutCubic,
      );
      
      if (i == widget.currentIndex) {
        _itemControllers[i]!.value = 1.0;
      }
    }
  }

  @override
  void didUpdateWidget(CustomBottomNavbar oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (oldWidget.currentIndex != widget.currentIndex) {
      _itemControllers[oldWidget.currentIndex]!.reverse();
      _itemControllers[widget.currentIndex]!.forward();
      _animationController.reset();
      _animationController.forward();
      
      // Update indicator position
      final screenWidth = MediaQuery.of(context).size.width;
      final itemWidth = screenWidth / 5;
      setState(() {
        _indicatorPosition = widget.currentIndex * itemWidth;
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    for (final controller in _itemControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFFCB5D29);
    const Color secondaryColor = Color(0xFFE87A45);

    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = screenWidth / 5;

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
            height: 85,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [primaryColor, secondaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Animated Indicator
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  left: _indicatorPosition + (itemWidth - 45) / 2,
                  bottom: 5,
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
                  children: [
                    _buildNavItem(0, 'assets/icons/beranda.svg', 'Beranda', itemWidth),
                    _buildNavItem(1, 'assets/icons/kisiksi.svg', 'Kisi-kisi', itemWidth),
                    _buildCenterItem(2, 'assets/icons/ujian.svg', 'Ujian', itemWidth),
                    _buildNavItem(3, 'assets/icons/latsol.svg', 'Lat. Soal', itemWidth),
                    _buildNavItem(4, 'assets/icons/peringkat.svg', 'Peringkat', itemWidth),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String iconPath, String label, double width) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => widget.onTap(index),
        splashColor: Colors.white.withOpacity(0.0),
        highlightColor: Colors.white.withOpacity(0.00),
        child: SizedBox(
          width: width,
          height: 85, // Ensure the tap area is tall enough
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _itemAnimations[index]!,
                builder: (context, _) {
                  return Transform.scale(
                    scale: 1.0 + (0.4 * _itemAnimations[index]!.value),
                    child: SvgPicture.asset(
                      iconPath,
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        Color.lerp(
                          Colors.white70, 
                          Colors.white, 
                          _itemAnimations[index]!.value
                        )!,
                        BlendMode.srcIn,
                      ),
                      placeholderBuilder: (context) => const Icon(Icons.error),
                    ),
                  );
                },
              ),
              const SizedBox(height: 4),
              AnimatedBuilder(
                animation: _itemAnimations[index]!,
                builder: (context, _) {
                  return Text(
                    label,
                    style: TextStyle(
                      color: Color.lerp(
                        Colors.white70, 
                        Colors.white, 
                        _itemAnimations[index]!.value
                      ),
                      fontSize: 11,
                      fontWeight: FontWeight.lerp(
                        FontWeight.w400,
                        FontWeight.w600,
                        _itemAnimations[index]!.value,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCenterItem(int index, String iconPath, String label, double width) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => widget.onTap(index),
        splashColor: const Color(0xFFE87A45).withOpacity(0.1),
        highlightColor: const Color(0xFFE87A45).withOpacity(0.05),
        borderRadius: BorderRadius.circular(60),
        child: SizedBox(
          width: width,
          height: 85, // Ensure the tap area is tall enough
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.translate(
                offset: const Offset(0, 0),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedBuilder(
                          animation: _itemAnimations[index]!,
                          builder: (context, _) {
                            return Transform.scale(
                              scale: 1.0 + (0.5 * _itemAnimations[index]!.value),
                              child: SvgPicture.asset(
                                iconPath,
                                width: 20,
                                height: 20,
                                colorFilter: ColorFilter.mode(
                                  Color.lerp(
                                    const Color(0xFFE87A45),
                                    const Color(0xFFCB5D29),
                                    _itemAnimations[index]!.value
                                  )!,
                                  BlendMode.srcIn,
                                ),
                                placeholderBuilder: (context) => const Icon(Icons.error),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 2),
                        AnimatedBuilder(
                          animation: _itemAnimations[index]!,
                          builder: (context, _) {
                            return Text(
                              label,
                              style: TextStyle(
                                color: Color.lerp(
                                  const Color(0xFFE87A45),
                                  const Color(0xFFCB5D29),
                                  _itemAnimations[index]!.value
                                ),
                                fontSize: 10,
                                fontWeight: FontWeight.lerp(
                                  FontWeight.w500,
                                  FontWeight.bold,
                                  _itemAnimations[index]!.value,
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
            ],
          ),
        ),
      ),
    );
  }
}