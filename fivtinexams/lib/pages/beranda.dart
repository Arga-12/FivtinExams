import 'package:flutter/material.dart';

class BerandaPage extends StatelessWidget {
  const BerandaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BerandaContent();
  }
}

// Widget konten beranda dengan implementasi baru
class BerandaContent extends StatelessWidget {
  const BerandaContent({super.key});

  Widget judulBeranda() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 0),
      child: Center(
        child: Text(
          'Beranda',
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scrollController = PrimaryScrollController.of(context);
    return SingleChildScrollView(
      controller: scrollController,
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          judulBeranda(), // Judul Beranda
          const SizedBox(height: 10),
          // Profile Info Card
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nama info
                _buildProfileRow("Nama", "Ramadhan Arga A."),
                const SizedBox(height: 20),
                
                // NIS info
                _buildProfileRow("NIS", "9012"),
                const SizedBox(height: 16),
                
                // Status Card
                _buildStatusCard(),
                const SizedBox(height: 16),
                
                // On Going Exams
                _buildOnGoingExamsCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk menampilkan baris informasi profil (nama, NIS)
  Widget _buildProfileRow(String label, String value) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const Text(
          ":",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }

  // Widget untuk menampilkan kartu status
  Widget _buildStatusCard() {
    return Container(
      padding: const EdgeInsets.all(12),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "Status",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF2A7C8E),
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.info_outline,
                color: Color.fromARGB(255, 64, 95, 121),
                size: 25,
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildStatusRow("Tahun Pelajaran", "2024 / 2025"),
          const SizedBox(height: 8),
          _buildStatusRow("Semester", "3"),
          const SizedBox(height: 5),

          // Progress Ujian dimasukkan di sini
          _buildProgressCard(),
        ],
      ),
    );
  }

  // Widget untuk menampilkan baris informasi status
  Widget _buildStatusRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2A7C8E),
          ),
        ),
        const SizedBox(width: 8),
        const Text(
          ":",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Color(0xFF2A7C8E),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2A7C8E),
          ),
        ),
      ],
    );
  }

  // Widget untuk menampilkan kartu progres ujian
  Widget _buildProgressCard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFCB6040),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Teks Progress Ujian
          const Text(
            "Progress Ujian",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
          const SizedBox(width: 20),
          
          // Progress Bar
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: const LinearProgressIndicator(
                value: 0.73,
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFD8B51)),
                minHeight: 8,
              ),
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Persentase
          const Text(
            "73%",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk menampilkan kartu ujian yang sedang berlangsung
  Widget _buildOnGoingExamsCard() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // warna bayangan
            spreadRadius: 2,                      // sebaran bayangan
            blurRadius: 6,                        // seberapa blur bayangan
            offset: const Offset(0, 3),           // posisi bayangan (x, y)
          ),
        ],
        color: const Color(0xFFCB6040),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children: [
                const Text(
                  "On Going Exams",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                  size: 30,
                ),
              ],
            ),
          ),
          
          // Garis pemisah pertama
          const Divider(
            color: Colors.white,
            thickness: 1,
            height: 1,
            indent: 16,
            endIndent: 16,
          ),
          
          // Ujian Header (IPAS, B. Inggris)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: Text(
                    "Ujian",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: Text(
                    "IPAS",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: Text(
                    "B. Inggris",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Garis pemisah kedua
          const Divider(
            color: Colors.white,
            thickness: 1,
            height: 1,
            indent: 16,
            endIndent: 16,
          ),
          
          // Waktu Ujian
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: Text(
                    "Waktu",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: Text(
                    "07.00",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: Text(
                    "10.00",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}