import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 247, 247),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 247, 247, 247),
        surfaceTintColor: Colors.transparent, // Ini yang ditambahkan untuk mencegah perubahan warna saat scroll
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2D3748)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notifikasi',
          style: TextStyle(
            color: Color(0xFF2D3748),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Mark all as read
            },
            child: Text(
              'Tandai Semua',
              style: TextStyle(
                color: Colors.orange[600],
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          ..._notificationData.map((notification) => _buildNotificationItem(notification)).toList(),
        ],
      ),
    );
  }



  Widget _buildNotificationItem(Map<String, dynamic> notification) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: notification['isRead'] ? Colors.white : Colors.orange.withOpacity(0.05),
          ),
          child: Row(
            children: [
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification['title'],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: notification['isRead'] ? FontWeight.w500 : FontWeight.bold,
                              color: const Color(0xFF2D3748),
                            ),
                          ),
                        ),
                        if (!notification['isRead'])
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.orange,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    
                    const SizedBox(height: 4),
                    
                    Text(
                      notification['message'],
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        height: 1.3,
                      ),
                    ),
                    
                    const SizedBox(height: 6),
                    
                    Row(
                      children: [
                        if (notification['points'] != null) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: notification['iconColor'].withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '+${notification['points']} Poin',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: notification['iconColor'],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          notification['time'],
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        // Divider
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          height: 1,
          color: Colors.grey.withOpacity(0.1),
        ),
      ],
    );
  }

  // Data notifikasi
  static final List<Map<String, dynamic>> _notificationData = [
    // Notifikasi Ujian IPAS
    {
      'title': 'Ujian IPAS Dimulai',
      'message': 'Ujian IPAS telah dimulai hari ini pukul 07:00 - 09:30. Segera bergabung untuk mengikuti ujian.',
      'time': '11 detik lalu',
      'points': null,
      'isRead': false,
      'icon': Icons.science_rounded,
      'iconColor': Color(0xFFCB6040),
      'iconBgColor': Color(0xFFCB6040).withOpacity(0.1),
    },
    // Notifikasi Ujian Bahasa Inggris
    {
      'title': 'Ujian Bahasa Inggris Akan Dimulai',
      'message': 'Ujian Bahasa Inggris akan dimulai pukul 10:00 - 11:30. Pastikan Anda siap mengikuti ujian.',
      'time': '11 detik lalu',
      'points': null,
      'isRead': false,
      'icon': Icons.translate_rounded,
      'iconColor': Color(0xFF257180),
      'iconBgColor': Color(0xFF257180).withOpacity(0.1),
    },
    {
      'title': 'Tugas PAI Diterima ✅',
      'message': 'Selamat! Tugas latihan soal PAI Anda telah disetujui oleh Pak Ino. Pertahankan semangat belajarnya!',
      'time': '2 jam lalu',
      'points': 18,
      'isRead': false,
      'icon': Icons.check_circle_rounded,
      'iconColor': Color(0xFFCB6040),
      'iconBgColor': Color(0xFFCB6040).withOpacity(0.1),
    },
    {
      'title': 'Perfect Score! 🎉',
      'message': 'Luar biasa! Anda mendapat nilai sempurna untuk tugas Bahasa Inggris dari Bu Tika.',
      'time': '5 jam lalu',
      'points': 20,
      'isRead': false,
      'icon': Icons.stars_rounded,
      'iconColor': Color(0xFFFD8B51),
      'iconBgColor': Color(0xFFFD8B51).withOpacity(0.1),
    },
    {
      'title': 'Tugas Matematika Dinilai',
      'message': 'Bu Yayuk telah menilai tugas latihan soal Matematika Anda. Excellent work!',
      'time': '1 hari lalu',
      'points': 20,
      'isRead': false,
      'icon': Icons.calculate_rounded,
      'iconColor': Color(0xFF257180),
      'iconBgColor': Color(0xFF257180).withOpacity(0.1),
    },
    {
      'title': 'Tugas Bahasa Indonesia Diterima',
      'message': 'Pak Indra telah menyetujui tugas latihan soal Bahasa Indonesia Anda.',
      'time': '1 hari lalu',
      'points': 15,
      'isRead': true,
      'icon': Icons.translate_rounded,
      'iconColor': Color(0xFF257180),
      'iconBgColor': Color(0xFF257180).withOpacity(0.1),
    },
    {
      'title': 'Tugas Seni Budaya Dinilai',
      'message': 'Pak Alfiq telah memberikan nilai untuk tugas latihan soal Seni Budaya Anda.',
      'time': '2 hari lalu',
      'points': 12,
      'isRead': true,
      'icon': Icons.palette_rounded,
      'iconColor': Color(0xFFFD8B51),
      'iconBgColor': Color(0xFFFD8B51).withOpacity(0.1),
    },
    {
      'title': 'Tugas IPAS Diterima',
      'message': 'Bu Yayuk telah menilai tugas latihan soal IPAS Anda. Keep up the good work!',
      'time': '3 hari lalu',
      'points': 8,
      'isRead': true,
      'icon': Icons.science_rounded,
      'iconColor': Color(0xFFCB6040),
      'iconBgColor': Color(0xFFCB6040).withOpacity(0.1),
    },
    {
      'title': 'Selamat Datang! 👋',
      'message': 'Selamat datang di aplikasi ujian online. Mulai kumpulkan poin dari setiap mata pelajaran!',
      'time': '1 minggu lalu',
      'points': null,
      'isRead': true,
      'icon': Icons.celebration_rounded,
      'iconColor': Colors.orange,
      'iconBgColor': Colors.orange.withOpacity(0.1),
    },
  ];
}