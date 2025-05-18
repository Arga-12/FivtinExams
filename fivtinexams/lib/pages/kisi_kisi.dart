import 'package:flutter/material.dart';

class KisiKisi extends StatefulWidget {
  const KisiKisi({super.key});

  @override
  State<KisiKisi> createState() => _KisiKisiState();
}

class _KisiKisiState extends State<KisiKisi> {
  // List untuk melacak apakah kisi-kisi sudah dibaca
  final Map<String, bool> _readStatus = {
    'PAI': false,
    'PPKn': false,
    'B. Indonesia': false,
    'B. Jawa': false,
    'IPAS': false,
    'B. Inggris': false,
    'Matematika': false,
    'Seni Budaya': false,
  };

  // Icon untuk setiap mata pelajaran
  final Map<String, IconData> _subjectIcons = {
    'PAI': Icons.menu_book,
    'PPKn': Icons.account_balance,
    'B. Indonesia': Icons.book,
    'B. Jawa': Icons.translate,
    'IPAS': Icons.science,
    'B. Inggris': Icons.language,
    'Matematika': Icons.calculate,
    'Seni Budaya': Icons.brush,
  };

  // Warna untuk setiap mata pelajaran (diambil dari style guide)
  final Map<String, Color> _subjectColors = {
    'PAI': const Color(0xFF257180),     // Warna tosca #257180
    'PPKn': const Color(0xFFCB6040),    // Warna coklat kemerahan #CB6040
    'B. Indonesia': const Color(0xFFFD8B51), // Warna oranye #FD8B51
    'B. Jawa': const Color(0xFF257180),  // Warna tosca #257180
    'IPAS': const Color(0xFFCB6040),     // Warna coklat kemerahan #CB6040
    'B. Inggris': const Color(0xFFFD8B51), // Warna oranye #FD8B51
    'Matematika': const Color(0xFF257180),     // Warna tosca #257180
    'Seni Budaya': const Color(0xFFCB6040), // Warna coklat kemerahan #CB6040
  };

  // Poin kisi-kisi untuk setiap mata pelajaran
  final Map<String, List<String>> _subjectPoints = {
    'PAI': [
      'Memahami konsep iman kepada Allah',
      'Mempraktikkan tata cara shalat wajib dan sunnah',
      'Mengenal sejarah Nabi dan Rasul',
      'Menerapkan akhlak terpuji dalam kehidupan sehari-hari',
      'Memahami hukum-hukum dalam Al-Quran',
    ],
    'PPKn': [
      'Memahami Pancasila sebagai dasar negara',
      'Menganalisis UUD 1945 dan amendemennya',
      'Mengenal sistem pemerintahan Indonesia',
      'Memahami hak dan kewajiban warga negara',
      'Mengidentifikasi nilai-nilai persatuan dan kesatuan',
    ],
    'B. Indonesia': [
      'Menganalisis struktur teks eksposisi',
      'Menulis teks persuasi dengan baik dan benar',
      'Memahami penggunaan kalimat efektif',
      'Mengidentifikasi unsur-unsur dalam puisi',
      'Menyusun teks prosedur yang baik',
    ],
    'B. Jawa': [
      'Memahami unggah-ungguh basa jawa',
      'Menggunakan ragam krama inggil dengan tepat',
      'Menulis cerita pengalaman dengan bahasa Jawa',
      'Memahami tembang macapat',
      'Mengidentifikasi peribahasa Jawa',
    ],
    'IPAS': [
      'Memahami sistem tata surya',
      'Menganalisis interaksi makhluk hidup dengan lingkungan',
      'Memahami konsep energi dan perubahannya',
      'Mengidentifikasi struktur jaringan tumbuhan',
      'Menganalisis sifat-sifat zat dan perubahannya',
    ],
    'B. Inggris': [
      'Memahami penggunaan tenses (Simple Past, Present Perfect)',
      'Mengidentifikasi jenis-jenis text (narrative, descriptive)',
      'Menyusun dialog dalam bahasa Inggris',
      'Menggunakan phrasal verbs dengan tepat',
      'Memahami passive voice',
    ],
    'Matematika': [
      'Menyelesaikan persamaan linear dua variabel',
      'Memahami konsep perbandingan dan skala',
      'Menganalisis sifat-sifat bangun ruang sisi datar',
      'Menghitung luas permukaan dan volume bangun ruang',
      'Menginterpretasikan data dalam bentuk diagram',
    ],
    'Seni Budaya': [
      'Memahami seni rupa daerah setempat',
      'Menampilkan sikap apresiatif terhadap keunikan seni musik daerah',
      'Mengidentifikasi jenis tari tradisional',
      'Mempraktikkan teknik vokal dalam bernyanyi',
      'Membuat karya seni rupa 2 dimensi',
    ],
  };

  void _markAsRead(String subject) {
    setState(() {
      _readStatus[subject] = true;
    });
    
    // Menampilkan snackbar ketika kisi-kisi dibaca
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Kisi-kisi $subject telah ditandai sebagai dibaca'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Widget Header Semester
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 20), // Padding disesuaikan
            decoration: BoxDecoration(
              color: const Color(0xFFCB6040), // Warna coklat kemerahan
              borderRadius: BorderRadius.circular(12), // Border radius sedikit lebih besar
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '8A',
                  style: TextStyle(
                    fontSize: 28, // Ukuran font sedikit lebih kecil
                    fontWeight: FontWeight.w800, // Ketebalan font disesuaikan
                    color: Colors.white,
                    height: 1.2, // Line height disesuaikan
                  ),
                ),
                const SizedBox(height: 8), // Spasi disesuaikan
                const Text(
                  'Berikut adalah kisi-kisi ujian yang harus kalian pelajari!',
                  style: TextStyle(
                    fontSize: 14, // Ukuran font lebih kecil
                    color: Colors.white,
                    height: 1.4, // Line height disesuaikan
                  ),
                ),
                const SizedBox(height: 12), // Spasi disesuaikan
                Container(
                  alignment: Alignment.centerRight,
                  child: const Text(
                    'Periode Angkatan - 24',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                      fontStyle: FontStyle.italic, // Ditambahkan italic
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Judul Kisi-Kisi
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: const Text(
              'Kisi Kisi Ujian',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          // Widget semester aktif
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF2E5BF), // Warna cream #F2E5BF dari style guide
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFF2E5BF).withOpacity(0.7)),
            ),
            child: InkWell(
              onTap: () {
                // Fungsi untuk melihat detail semester 3 (sudah terbuka)
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Semester 3',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFF257180).withOpacity(0.2), // Warna tosca dengan opacity
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Aktif',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF257180), // Warna tosca
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Daftar mata pelajaran
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: _subjectIcons.length,
            itemBuilder: (context, index) {
              final subject = _subjectIcons.keys.elementAt(index);
              final icon = _subjectIcons[subject];
              final color = _subjectColors[subject];
              final isRead = _readStatus[subject] ?? false;
              
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () {
                    _showSubjectDetails(subject);
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                                                // Icon mata pelajaran
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: color!.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(icon, color: color),
                        ),
                        const SizedBox(width: 16),
                        
                        // Nama mata pelajaran dan status
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
                              const SizedBox(height: 4),
                              Text(
                                isRead ? 'Sudah dibaca' : 'Belum dibaca',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isRead ? Colors.green : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Tombol checklist
                        IconButton(
                          onPressed: () => _markAsRead(subject),
                          icon: Icon(
                            isRead ? Icons.check_circle : Icons.check_circle_outline,
                            color: isRead ? Colors.green : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // Fungsi untuk menampilkan detail mata pelajaran
  void _showSubjectDetails(String subject) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  subject,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            
            // Garis pemisah
            Divider(color: Colors.grey[300]),
            const SizedBox(height: 10),
            
            // Poin-poin kisi-kisi
            Expanded(
              child: ListView.builder(
                itemCount: _subjectPoints[subject]!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 4, right: 12),
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _subjectColors[subject],
                            shape: BoxShape.circle,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            _subjectPoints[subject]![index],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            
            // Tombol tandai sebagai dibaca
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _markAsRead(subject);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _subjectColors[subject],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Tandai sebagai Dibaca',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}