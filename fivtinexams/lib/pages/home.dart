import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beranda Di Update!!!!'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.home,
              size: 100,
              color: Color.fromARGB(255, 235, 144, 60),
            ),
            const SizedBox(height: 20),
            const Text(
              'Selamat datang di Fivtin Exams!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            //Tambah tombol
            ElevatedButton(
              onPressed: () {
                // Aksi saat tombol ditekan
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Tombol ditekan!'),
                  ),
                );
              },
              child: const Text('Tekan Aku'),
            )
          ],
        ),)
    );
  }
}