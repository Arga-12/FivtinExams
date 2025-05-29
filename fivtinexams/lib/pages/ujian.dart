import 'package:flutter/material.dart';
import '../ujian/ujian_ongoing.dart'; // Import file UjianOngoingPage
import '../ujian/ujian_history.dart'; // Import file UjianHistoryPage
import '../ujian/ujian_oncoming.dart'; // Import file UjianOncomingPage
// Import jadwalujian.dart dihapus karena tidak diperlukan lagi

class UjianPage extends StatelessWidget {
  final Function(int)? onTabChange;
  
  const UjianPage({super.key, this.onTabChange});

  @override
  Widget build(BuildContext context) {
    final scrollController = PrimaryScrollController.of(context);
    return SingleChildScrollView(
      controller: scrollController,
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress Card Modern
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: Stack(
              children: [
                // Card utama dengan gradient
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFCB6040),
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
                            SizedBox(height: 8),
                            Text(
                              'Progress ujian mu sudah',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                height: 1.4,
                              ),
                            ),
                            Text(
                              'sampai mana nih?',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Progress circle
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            height: 60,
                            width: 60,
                            child: CircularProgressIndicator(
                              value: 0.73,
                              strokeWidth: 8,
                              backgroundColor: Color(0xFFF2E5BF),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Color(0xFF2A7C8E),
                              ),
                            ),
                          ),
                          const Text(
                            '73%',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
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

          // On Going Exams
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                const Text(
                  'On Going Exams',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.amber[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    '2',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // IPAS Exam Card - MODIFIKASI DI SINI: Tambahkan onTap untuk navigasi ke UjianOngoingPage
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UjianOngoingPage()),
              );
            },
            child: _buildExamCard(
              subject: 'IPAS',
              time: '07:00 - 09:30',
              points: '- / 20 Poin',
              isOngoing: true,
              activeUsers: '10',
              buttonText: 'Kerjakan Ujian Sekarang',
            ),
          ),

          // Bahasa Inggris Exam Card - MODIFIKASI DI SINI: Tambahkan onTap untuk navigasi ke UjianOngoingPage
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UjianOngoingPage()),
              );
            },
            child: _buildExamCard(
              subject: 'Bahasa Inggris',
              time: '10:00 - 11:30',
              points: '- / 20 Poin',
              isOngoing: true,
              activeUsers: '-',
              buttonText: 'Kerjakan Ujian Sekarang',
            ),
          ),

          // Upcoming Exams Title
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  const Text(
                    'Upcoming Exams',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Color(0xFF2A7C8E),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      '3',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Seni Budaya Exam Card (Upcoming)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UjianOncomingPage(
                      subject: 'Seni Budaya',
                      date: '12 September 2024',
                      time: '07:00 - 09:00',
                      duration: 120,
                      totalQuestions: 20,
                      points: '- / 20 Poin',
                      examDateTime: DateTime(2025, 9, 12, 7, 0), // Tambahkan ini
                    ),
                  ),
                );
              },
              child: _buildExamCard(
                subject: 'Seni Budaya', 
                time: '12 • 9 • 2024',
                points: '- / 20 Poin',
                isUpcoming: true,
                activeUsers: '-',
                buttonText: 'Lihat detail ujian',
              ),
            ),

            // PJOK Exam Card (Upcoming)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UjianOncomingPage(
                      subject: 'PJOK',
                      date: '12 September 2024',
                      time: '09:30 - 11:00',
                      duration: 90,
                      totalQuestions: 20,
                      points: '- / 20 Poin',
                      examDateTime: DateTime(2025, 9, 12, 7, 0), // Tambahkan ini
                    ),
                  ),
                );
              },
              child: _buildExamCard(
                subject: 'PJOK',
                time: '12 • 9 • 2024',
                points: '- / 20 Poin',
                isUpcoming: true,
                activeUsers: '-',
                buttonText: 'Lihat detail ujian',
              ),
            ),

            // Matematika Exam Card (Upcoming)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UjianOncomingPage(
                      subject: 'Matematika',
                      date: '13 September 2024',
                      time: '07:00 - 09:30',
                      duration: 150,
                      totalQuestions: 25,
                      points: '- / 20 Poin',
                      examDateTime: DateTime(2025, 9, 13, 7, 0), // Tambahkan ini
                    ),
                  ),
                );
              },
              child: _buildExamCard(
                subject: 'Matematika',
                time: '13 • 9 • 2024',
                points: '- / 20 Poin',
                isUpcoming: true,
                activeUsers: '-',
                buttonText: 'Lihat detail ujian',
              ),
            ),
          // Past Exams Title
          const Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Text(
              'Past Exams',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // PAI Exam Card - MODIFIKASI DI SINI: Tambahkan onTap untuk navigasi ke UjianHistoryPage
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UjianHistoryPage()),
              );
            },
            child: _buildExamCard(
              subject: 'PAI',
              time: '9 • 9 • 2024',
              points: '18 / 20 Poin',
              isPast: true,
              activeUsers: '-',
              buttonText: 'Lihat history pengerjaan',
            ),
          ),

          // PPKn Exam Card - MODIFIKASI DI SINI: Tambahkan onTap untuk navigasi ke UjianHistoryPage
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UjianHistoryPage()),
              );
            },
            child: _buildExamCard(
              subject: 'PPKn',
              time: '9 • 9 • 2024',
              points: '17 / 20 Poin',
              isPast: true,
              activeUsers: '-',
              buttonText: 'Lihat history pengerjaan',
            ),
          ),

          // Bahasa Indonesia Exam Card - MODIFIKASI DI SINI: Tambahkan onTap untuk navigasi ke UjianHistoryPage
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UjianHistoryPage()),
              );
            },
            child: _buildExamCard(
              subject: 'Bahasa Indonesia',
              time: '10 • 9 • 2024',
              points: '19 / 20 Poin',
              isPast: true,
              activeUsers: '-',
              buttonText: 'Lihat history pengerjaan',
            ),
          ),

          // Bahasa Jawa Exam Card - MODIFIKASI DI SINI: Tambahkan onTap untuk navigasi ke UjianHistoryPage
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UjianHistoryPage()),
              );
            },
            child: _buildExamCard(
              subject: 'Bahasa Jawa',
              time: '10 • 9 • 2024',
              points: '16 / 20 Poin',
              isPast: true,
              activeUsers: '-',
              buttonText: 'Lihat history pengerjaan',
            ),
          ),

          const SizedBox(height: 80), // Space for bottom navigation
        ],
      ),
    );
  }

  Widget _buildExamCard({
    required String subject,
    required String time,
    required String points,
    bool isOngoing = false,
    bool isPast = false,
    bool isUpcoming = false,
    required String activeUsers,
    required String buttonText,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Subject side (left)
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Subject and time info
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subject,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.access_time, size: 14, color: Colors.grey),
                          const SizedBox(width: 16),
                          Text(
                            time,
                            style: const TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Action button
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
                  child: Row(
                    children: [
                      Text(
                        buttonText,
                        style: const TextStyle(
                          color: Color(0xFFD66D55),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right,
                        color: Color(0xFFD66D55),
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Right side with active users and points (removed score)
          Container(
            width: 100,
            height: 130,
            decoration: const BoxDecoration(
              color: Color(0xFFFFF0E8),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            padding: const EdgeInsets.all(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // User indicator (with value or "-")
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 12,
                        color: Color(0xFF2A7C8E),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      activeUsers,
                      style: TextStyle(
                        fontSize: 12,
                        color: activeUsers != '-' ? const Color(0xFF2A7C8E) : Colors.grey,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 8),
                // Points
                Text(
                  points,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
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