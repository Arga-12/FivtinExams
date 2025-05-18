import 'package:flutter/material.dart';

class UjianPage extends StatelessWidget {
  const UjianPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Ujian',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 20),
          
          // Card Upcoming Exams
          _buildSectionTitle("Jadwal Ujian Mendatang"),
          const SizedBox(height: 10),
          
          _buildExamCard(
            subject: "Matematika",
            date: "20 Mei 2025",
            time: "08:00 - 10:00",
            status: ExamStatus.upcoming,
          ),
          const SizedBox(height: 10),
          
          _buildExamCard(
            subject: "Bahasa Indonesia",
            date: "21 Mei 2025",
            time: "08:00 - 10:00",
            status: ExamStatus.upcoming,
          ),
          
          const SizedBox(height: 24),
          
          // Card Today's Exams
          _buildSectionTitle("Ujian Hari Ini"),
          const SizedBox(height: 10),
          
          _buildExamCard(
            subject: "IPAS",
            date: "18 Mei 2025",
            time: "07:00 - 09:00",
            status: ExamStatus.today,
          ),
          const SizedBox(height: 10),
          
          _buildExamCard(
            subject: "Bahasa Inggris",
            date: "18 Mei 2025",
            time: "10:00 - 12:00",
            status: ExamStatus.today,
          ),
          
          const SizedBox(height: 24),
          
          // Card Completed Exams
          _buildSectionTitle("Ujian Selesai"),
          const SizedBox(height: 10),
          
          _buildExamCard(
            subject: "Pendidikan Kewarganegaraan",
            date: "17 Mei 2025",
            time: "08:00 - 10:00",
            status: ExamStatus.completed,
            score: "85",
          ),
          const SizedBox(height: 10),
          
          _buildExamCard(
            subject: "Kesenian",
            date: "16 Mei 2025",
            time: "10:00 - 12:00",
            status: ExamStatus.completed,
            score: "92",
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Color(0xFF2A7C8E),
      ),
    );
  }

  Widget _buildExamCard({
    required String subject,
    required String date,
    required String time,
    required ExamStatus status,
    String? score,
  }) {
    Color cardColor;
    String statusText;
    IconData statusIcon;
    Color statusColor;
    bool showButton = false;
    bool showScore = false;
    
    switch (status) {
      case ExamStatus.upcoming:
        cardColor = Colors.white;
        statusText = "Mendatang";
        statusIcon = Icons.event;
        statusColor = Colors.blue;
        showButton = false;
        break;
      case ExamStatus.today:
        cardColor = const Color(0xFFD66D55);
        statusText = "Hari Ini";
        statusIcon = Icons.access_time;
        statusColor = Colors.white;
        showButton = true;
        break;
      case ExamStatus.completed:
        cardColor = Colors.white;
        statusText = "Selesai";
        statusIcon = Icons.check_circle;
        statusColor = Colors.green;
        showScore = true;
        break;
    }
    
    return Card(
      color: cardColor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(statusIcon, color: statusColor),
                const SizedBox(width: 8),
                Text(
                  statusText,
                  style: TextStyle(
                    color: status == ExamStatus.today ? Colors.white : statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                if (showScore)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Nilai: $score",
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              subject,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: status == ExamStatus.today ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.calendar_today, 
                  size: 16,
                  color: status == ExamStatus.today ? Colors.white70 : Colors.grey,
                ),
                const SizedBox(width: 4),
                Text(
                  date,
                  style: TextStyle(
                    color: status == ExamStatus.today ? Colors.white70 : Colors.grey,
                  ),
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.access_time, 
                  size: 16,
                  color: status == ExamStatus.today ? Colors.white70 : Colors.grey,
                ),
                const SizedBox(width: 4),
                Text(
                  time,
                  style: TextStyle(
                    color: status == ExamStatus.today ? Colors.white70 : Colors.grey,
                  ),
                ),
              ],
            ),
            if (showButton) ...[
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFFD66D55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: const Text(
                    "Mulai Ujian",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

enum ExamStatus {
  upcoming,
  today,
  completed,
}