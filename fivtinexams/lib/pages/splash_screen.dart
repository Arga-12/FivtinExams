import 'package:flutter/material.dart';
import 'dart:async';
import 'home.dart'; // Import halaman utama

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _bottomBoxController;
  late AnimationController _topBoxController;
  late AnimationController _logoController;
  
  late Animation<double> _bottomBoxAnimation;
  late Animation<double> _topBoxAnimation;
  late Animation<double> _logoOpacityAnimation;
  late Animation<double> _logoScaleAnimation;

  @override
  void initState() {
    super.initState();
    
    // Initialize animation controllers
    _bottomBoxController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    
    _topBoxController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    
    _logoController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    // Initialize animations
    _bottomBoxAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _bottomBoxController,
      curve: Curves.easeInOut,
    ));

    _topBoxAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _topBoxController,
      curve: Curves.easeInOut,
    ));

    _logoOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeIn,
    ));

    _logoScaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut,
    ));

    // Start animations sequence
    _startAnimations();
  }

  void _startAnimations() async {
    // Start bottom box animation first
    _bottomBoxController.forward();
    
    // Wait for bottom animation to complete, then start top
    await Future.delayed(Duration(milliseconds: 800));
    _topBoxController.forward();
    
    // Wait for top animation to complete, then start logo
    await Future.delayed(Duration(milliseconds: 800));
    _logoController.forward();
    
    // Navigate to home after all animations complete
    Timer(Duration(milliseconds: 4000), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomePage()),
      );
    });
  }

  @override
  void dispose() {
    _bottomBoxController.dispose();
    _topBoxController.dispose();
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Bottom PNG animation
          AnimatedBuilder(
            animation: _bottomBoxAnimation,
            builder: (context, child) {
              return Positioned(
                bottom: -50, // Mengatur posisi vertikal (-50 = lebih ke bawah, 50 = lebih ke atas)
                left: -20,   // Mengatur posisi horizontal (-20 = lebih ke kiri, 20 = lebih ke kanan)
                child: Transform.translate(
                  offset: Offset(0, screenHeight * 0.4 * (1 - _bottomBoxAnimation.value)),
                  child: Transform.scale(
                    scale: 1.2, // Mengatur ukuran PNG (1.0 = normal, 1.5 = 150%, 0.8 = 80%)
                    child: Container(
                      width: screenWidth * 0.97, // Mengatur lebar (1.1 = 110% dari layar)
                      height: screenHeight * 0.4,
                      child: Image.asset(
                        'assets/bottom_shape.png',
                        fit: BoxFit.contain, // contain = mempertahankan rasio, cover = memenuhi area
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          
          // Top PNG animation
          AnimatedBuilder(
            animation: _topBoxAnimation,
            builder: (context, child) {
              return Positioned(
                top: -55,    // Mengatur posisi vertikal (-50 = lebih ke atas, 50 = lebih ke bawah)
                right: -35,  // Mengatur posisi horizontal (-20 = lebih ke kanan, 20 = lebih ke kiri)
                child: Transform.translate(
                  offset: Offset(0, -screenHeight * 0.4 * (1 - _topBoxAnimation.value)),
                  child: Transform.scale(
                    scale: 0.8, // Mengatur ukuran PNG (1.0 = normal, 1.5 = 150%, 0.8 = 80%)
                    child: Container(
                      width: screenWidth * 0.8, // Mengatur lebar (1.1 = 110% dari layar)
                      height: screenHeight * 0.4,
                      child: Image.asset(
                        'assets/top_shape.png',
                        fit: BoxFit.contain, // contain = mempertahankan rasio, cover = memenuhi area
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          
          // Logo with dissolve and scale effect
          Center(
            child: AnimatedBuilder(
              animation: _logoController,
              builder: (context, child) {
                return Opacity(
                  opacity: _logoOpacityAnimation.value,
                  child: Transform.scale(
                    scale: _logoScaleAnimation.value,
                    child: Container(
                      width: 200,
                      height: 200,
                      child: Image.asset(
                        'assets/Logo1.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}