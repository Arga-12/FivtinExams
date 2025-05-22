import 'package:flutter/material.dart';

class LatihanSoal extends StatelessWidget {
  const LatihanSoal({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = PrimaryScrollController.of(context);
    return SingleChildScrollView(
      controller: scrollController,
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Card Modern
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: Stack(
              children: [
                // Card utama dengan gradient
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFE07A5F), Color(0xFFCB6040)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Text section
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              '8A',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Latihan soal ujian',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white70,
                                height: 1.2,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Periode Angkatan - 24',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.white60,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Semester section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            'Semester',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white70,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '3',
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              height: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Elemen dekoratif kecil
                Positioned(
                  top: 0,
                  right: 31,
                  child: Container(
                    height: 6,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(3),
                        bottomRight: Radius.circular(3),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Grid Layout untuk Mata Pelajaran
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 0.8, // Diperbesar dari 0.9 ke 1.1 untuk memberikan ruang lebih
            ),
            itemCount: _subjectData.length,
            itemBuilder: (context, index) {
              final subject = _subjectData[index];
              return _buildSubjectCard(subject);
            },
          ),

          const SizedBox(height: 20),

          // Upload Section Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF2A7C8E), Color(0xFF1E5A68)],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Upload hasil pekerjaan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Melalui link GDrive di sini',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.cloud_upload_outlined,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectCard(Map<String, dynamic> subject) {
    return Container(
      decoration: BoxDecoration(
        color: subject['bgColor'],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background pattern
          Positioned(
            top: -20,
            right: -20,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon dan Badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        subject['icon'],
                        color: subject['iconColor'],
                        size: 18, // Diperkecil dari 20 ke 18
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: subject['badgeColor'],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        subject['type'],
                        style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 8),
                
                // Nama Mata Pelajaran
                Flexible(
                  child: Text(
                    subject['name'],
                    style: const TextStyle(
                      fontSize: 13, // Diperkecil dari 14 ke 13
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3748),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                
                const SizedBox(height: 4),
                
                // Detail Latihan
                Text(
                  subject['detail'],
                  style: TextStyle(
                    fontSize: 10, // Diperkecil dari 11 ke 10
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                const SizedBox(height: 4),
                
                // Jumlah Soal
                Text(
                  '${subject['totalSoal']} Soal',
                  style: const TextStyle(
                    fontSize: 11, // Diperkecil dari 12 ke 11
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4A5568),
                  ),
                ),
                
                const Spacer(), // Menambahkan spacer untuk mendorong button ke bawah
                
                // Download Button
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 8), // Diperbesar dari 6 ke 8
                  decoration: BoxDecoration(
                    color: subject['buttonColor'],
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: subject['buttonColor'].withOpacity(0.3),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.download_rounded,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Data mata pelajaran
  static final List<Map<String, dynamic>> _subjectData = [
    {
      'name': 'PPKn',
      'detail': 'Latihan Soal\nBu Rika',
      'totalSoal': 35,
      'type': 'PDF',
      'icon': Icons.description_rounded,
      'iconColor': Color(0xFF4A5568),
      'bgColor': Color(0xFFFFF5F5),
      'buttonColor': Color(0xFFE53E3E),
      'badgeColor': Color(0xFFE53E3E),
    },
    {
      'name': 'PAI',
      'detail': 'Latihan Soal\nPak Ino',
      'totalSoal': 30,
      'type': 'PDF',
      'icon': Icons.description_rounded,
      'iconColor': Color(0xFF4A5568),
      'bgColor': Color(0xFFF0FFF4),
      'buttonColor': Color(0xFF38A169),
      'badgeColor': Color(0xFF38A169),
    },
    {
      'name': 'Bahasa Inggris',
      'detail': 'Latihan Soal\nBu Tika',
      'totalSoal': 30,
      'type': 'PDF',
      'icon': Icons.description_rounded,
      'iconColor': Color(0xFF4A5568),
      'bgColor': Color(0xFFEBF8FF),
      'buttonColor': Color(0xFF3182CE),
      'badgeColor': Color(0xFF3182CE),
    },
    {
      'name': 'Bahasa Indonesia',
      'detail': 'Latihan Soal\nPak Indra',
      'totalSoal': 40,
      'type': 'DOC',
      'icon': Icons.description_rounded,
      'iconColor': Color(0xFF4A5568),
      'bgColor': Color(0xFFFAF5FF),
      'buttonColor': Color(0xFF805AD5),
      'badgeColor': Color(0xFF805AD5),
    },
    {
      'name': 'Bahasa Jawa',
      'detail': 'Latihan Soal\nBu Reza',
      'totalSoal': 30,
      'type': 'PDF',
      'icon': Icons.description_rounded,
      'iconColor': Color(0xFF4A5568),
      'bgColor': Color(0xFFFFFBF0),
      'buttonColor': Color(0xFFD69E2E),
      'badgeColor': Color(0xFFD69E2E),
    },
    {
      'name': 'Seni Budaya',
      'detail': 'Latihan Soal\nPak Alfiq',
      'totalSoal': 30,
      'type': 'DOC',
      'icon': Icons.description_rounded,
      'iconColor': Color(0xFF4A5568),
      'bgColor': Color(0xFFFFF5F5),
      'buttonColor': Color(0xFFE53E3E),
      'badgeColor': Color(0xFFE53E3E),
    },
    {
      'name': 'Matematika',
      'detail': 'Latihan Soal\nBu Yayuk',
      'totalSoal': 40,
      'type': 'PDF',
      'icon': Icons.description_rounded,
      'iconColor': Color(0xFF4A5568),
      'bgColor': Color(0xFFF0FFF4),
      'buttonColor': Color(0xFF38A169),
      'badgeColor': Color(0xFF38A169),
    },
    {
      'name': 'IPAS',
      'detail': 'Latihan Soal\nBu Yayuk',
      'totalSoal': 30,
      'type': 'PDF',
      'icon': Icons.description_rounded,
      'iconColor': Color(0xFF4A5568),
      'bgColor': Color(0xFFEBF8FF),
      'buttonColor': Color(0xFF3182CE),
      'badgeColor': Color(0xFF3182CE),
    },
  ];
}