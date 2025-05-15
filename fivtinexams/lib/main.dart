import 'package:flutter/material.dart';
import 'pages/splash_screen.dart'; // Tambahkan import

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FivtIn Exams',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // Ganti dari HomePage() ke SplashScreen()
    );
  }
}
