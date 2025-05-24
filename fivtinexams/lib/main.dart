import 'package:flutter/material.dart';
import 'pages/splash_screen.dart'; // Tambahkan import
import 'package:flutter/services.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();

  // Mengunci orientasi ke potret saja
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

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
