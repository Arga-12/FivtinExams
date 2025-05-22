import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PeringkatPage extends StatelessWidget {
  const PeringkatPage({super.key});

  // Data peringkat sesuai dengan gambar
  final List<Map<String, dynamic>> _peringkatData = const [
    {"nama": "Fabiel Syaindra Putra", "skor": 120},
    {"nama": "Eva Nissa Anggani", "skor": 110},
    {"nama": "Quenna Intan Shabrina", "skor": 90},
    {"nama": "Kin Kin Wilma Tabhita Wijaya", "skor": 90},
    {"nama": "Farhan Abdillah Subagio", "skor": 90},
    {"nama": "Almira Siwi Nurrohimah", "skor": 80},
    {"nama": "Muhammad Rizqi Hidayatullah", "skor": 80},
    {"nama": "Ramadhan Arga Adiansyah", "skor": 80},
    {"nama": "Richardson James Mc Lean", "skor": 80},
    {"nama": "Reno Dani Irfansyah", "skor": 70},
  ];

  @override
  Widget build(BuildContext context) {
    final backgroundColor = const Color.fromARGB(255, 247, 247, 247);
    
    return Container(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            // Header dengan SVG icon dan judul kelas (langsung di halaman)
            Column(
              children: [
                // SVG Icon
                SvgPicture.asset(
                  'assets/icons/peringkat.svg',
                  height: 60,
                  colorFilter: const ColorFilter.mode(
                    Colors.black,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(height: 16),
                // Judul "Kelas 8A"
                const Text(
                  'Kelas 8A',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                // Subtitle
                const Text(
                  'Top 10 Siswa dengan poin terbanyak',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 12),
                // Divider
                Container(
                  width: 80,
                  height: 3,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
            
            // Daftar peringkat dalam card
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 8),
                    itemCount: _peringkatData.length + 1, // +1 untuk info footer
                    itemBuilder: (context, index) {
                      // Jika ini adalah item terakhir, tampilkan info footer
                      if (index == _peringkatData.length) {
                        return Container(
                          margin: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                size: 16,
                                color: Colors.grey.shade700,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Klik di sini untuk mengetahui bagaimana sistem poin bekerja dalam aplikasi ini',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      
                      // Item peringkat dengan styling yang lebih menarik
                      final item = _peringkatData[index];
                      
                      // Styling khusus untuk 3 teratas
                      final bool isTopThree = index < 3;
                      final bool isFirst = index == 0;
                      
                      return Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            decoration: BoxDecoration(
                              color: isTopThree 
                                ? _getRankBackgroundColor(index).withOpacity(0.08)
                                : Colors.transparent,
                            ),
                            child: Row(
                              children: [
                                // Badge nomor peringkat
                                Container(
                                  width: 30,
                                  height: 30,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: _getRankBackgroundColor(index),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    '${index + 1}',
                                    style: TextStyle(
                                      color: isTopThree ? Colors.white : Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                
                                // Nama siswa
                                Expanded(
                                  child: Text(
                                    item['nama'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: isFirst ? FontWeight.bold : FontWeight.w500,
                                    ),
                                  ),
                                ),
                                
                                // Badge skor dengan styling menarik
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: _getPointColor(index),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    '${item['skor']} P',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Divider
                          if (index < _peringkatData.length - 1)
                            Padding(
                              padding: const EdgeInsets.only(left: 60),
                              child: Container(
                                height: 1,
                                color: Colors.grey.shade200,
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk mendapatkan warna background berdasarkan peringkat
  Color _getRankBackgroundColor(int index) {
    if (index == 0) return const Color(0xFFFFD700); // Gold
    if (index == 1) return const Color(0xFFC0C0C0); // Silver
    if (index == 2) return const Color(0xFFCD7F32); // Bronze
    return Colors.grey.shade300;
  }

  // Fungsi untuk mendapatkan warna poin berdasarkan peringkat
  Color _getPointColor(int index) {
    if (index == 0) return const Color(0xFFFFAA00); // Gold
    if (index == 1) return const Color(0xFF71839B); // Silver
    if (index == 2) return const Color(0xFFB87333); // Bronze
    if (index <= 4) return Colors.blue;
    return Colors.grey.shade700;
  }
}