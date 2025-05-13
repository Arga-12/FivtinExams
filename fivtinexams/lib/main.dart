import 'package:flutter/material.dart';
import 'pages/home.dart'; // Import HomePage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FivtIn Exams',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,  // Menonaktifkan debug banner
      home: HomePage(), // Set halaman awal ke HomePage
    );
  }
}
