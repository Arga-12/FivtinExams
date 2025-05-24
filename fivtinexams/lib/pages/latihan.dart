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
                            SizedBox(height: 4),
                            Text(
                              'Latihan soal ujian',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                height: 1.4,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Periode Angkatan - 24',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white70,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500,
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

          // List Layout untuk Mata Pelajaran
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
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
                colors: [Color(0xFF257180), Color(0xFF1E5A68)],
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
                        'Melalui link Google Form di sini',
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Row(
            children: [
              // Content Section (tanpa icon)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Subject Name
                    Text(
                      subject['name'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3748),
                      ),
                    ),
                    
                    const SizedBox(height: 6),
                    
                    // Points with indicator
                    Row(
                      children: [
                        Text(
                          'Poin: ',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[700],
                          ),
                        ),
                        Text(
                          '${subject['currentPoints']}/20',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: subject['currentPoints'] > 0 
                                ? subject['iconColor'] 
                                : Colors.grey[500],
                          ),
                        ),
                        const SizedBox(width: 6),
                        // Status indicator
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: subject['currentPoints'] == 0 
                                ? Colors.orange[100]
                                : subject['currentPoints'] == 20
                                  ? Colors.green[100]
                                  : Colors.blue[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            subject['currentPoints'] == 0 
                                ? Icons.priority_high_rounded
                                : subject['currentPoints'] == 20
                                  ? Icons.check_circle_rounded
                                  : Icons.trending_up_rounded,
                            size: 14,
                            color: subject['currentPoints'] == 0 
                                ? Colors.orange[700]
                                : subject['currentPoints'] == 20
                                  ? Colors.green[700]
                                  : Colors.blue[700],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(width: 16),
              
              // Download Button
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: subject['iconColor'],
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: subject['iconColor'].withOpacity(0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.download_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
        
        // Divider
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          height: 1,
          color: Colors.grey.withOpacity(0.2),
        ),
      ],
    );
  }

  // Subject data tanpa icon
  static final List<Map<String, dynamic>> _subjectData = [
    {
      'name': 'PPKn',
      'currentPoints': 0,
      'iconColor': Color(0xFF257180),
    },
    {
      'name': 'PAI',
      'currentPoints': 18,
      'iconColor': Color(0xFFCB6040),
    },
    {
      'name': 'Bahasa Inggris',
      'currentPoints': 20,
      'iconColor': Color(0xFFFD8B51),
    },
    {
      'name': 'Bahasa Indonesia',
      'currentPoints': 15,
      'iconColor': Color(0xFF257180),
    },
    {
      'name': 'Bahasa Jawa',
      'currentPoints': 0,
      'iconColor': Color(0xFFCB6040),
    },
    {
      'name': 'Seni Budaya',
      'currentPoints': 12,
      'iconColor': Color(0xFFFD8B51),
    },
    {
      'name': 'Matematika',
      'currentPoints': 20,
      'iconColor': Color(0xFF257180),
    },
    {
      'name': 'IPAS',
      'currentPoints': 8,
      'iconColor': Color(0xFFCB6040),
    },
  ];
}