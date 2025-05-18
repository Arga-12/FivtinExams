import 'package:flutter/material.dart';

class LatihanSoal extends StatelessWidget {
  const LatihanSoal({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Latihan Soal',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 20),
          
          // Kategori Latihan
          _buildSectionTitle("Kategori"),
          const SizedBox(height: 16),
          
          // Grid kategori
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.5,
            children: [
              _buildCategoryCard(
                title: "Matematika",
                iconData: Icons.calculate,
                color: Colors.blue,
                onTap: () {},
              ),
              _buildCategoryCard(
                title: "IPAS",
                iconData: Icons.science,
                color: Colors.green,
                onTap: () {},
              ),
              _buildCategoryCard(
                title: "B. Indonesia",
                iconData: Icons.book,
                color: Colors.red,
                onTap: () {},
              ),
              _buildCategoryCard(
                title: "B. Inggris",
                iconData: Icons.language,
                color: Colors.orange,
                onTap: () {},
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Latihan Terakhir
          _buildSectionTitle("Latihan Terakhir"),
          const SizedBox(height: 16),
          
          _buildRecentPracticeCard(
            subject: "Matematika",
            topic: "Persamaan Kuadrat",
            score: 85,
            date: "17 Mei 2025",
            onTap: () {},
          ),
          
          const SizedBox(height: 10),
          
          _buildRecentPracticeCard(
            subject: "Bahasa Inggris",
            topic: "Tenses",
            score: 90,
            date: "16 Mei 2025",
            onTap: () {},
          ),
          
          const SizedBox(height: 24),
          
          // Rekomendasi Latihan
          _buildSectionTitle("Rekomendasi Untukmu"),
          const SizedBox(height: 16),
          
          _buildRecommendationCard(
            title: "Latihan Soal UTBK",
            description: "Kumpulan soal-soal persiapan UTBK dengan pembahasan lengkap",
            progress: 0.3,
            onTap: () {},
          ),
          
          const SizedBox(height: 10),
          
          _buildRecommendationCard(
            title: "Soal Olimpiade Matematika",
            description: "Soal-soal matematika tingkat olimpiade dengan tingkat kesulitan bervariasi",
            progress: 0.0,
            isNew: true,
            onTap: () {},
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

  Widget _buildCategoryCard({
    required String title,
    required IconData iconData,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 36,
                color: color,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentPracticeCard({
    required String subject,
    required String topic,
    required int score,
    required String date,
    required VoidCallback onTap,
  }) {
    Color scoreColor;
    if (score >= 90) {
      scoreColor = Colors.green;
    } else if (score >= 75) {
      scoreColor = Colors.orange;
    } else {
      scoreColor = Colors.red;
    }

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: scoreColor.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    "$score",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: scoreColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subject,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      topic,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendationCard({
    required String title,
    required String description,
    required double progress,
    bool isNew = false,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (isNew)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "Baru",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 12),
              if (progress > 0) ...[
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFD8B51)),
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(4),
                ),
                const SizedBox(height: 8),
                Text(
                  "${(progress * 100).toInt()}% selesai",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ] else ...[
                ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD66D55),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: const Text("Mulai Latihan"),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}