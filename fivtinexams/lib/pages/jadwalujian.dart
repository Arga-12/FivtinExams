import 'package:flutter/material.dart';

class JadwalUjianPage extends StatefulWidget {
  const JadwalUjianPage({super.key});

  @override
  State<JadwalUjianPage> createState() => _JadwalUjianPageState();
}

class _JadwalUjianPageState extends State<JadwalUjianPage> {
  DateTime selectedDate = DateTime.now();
  int selectedMonth = 9; // September
  int selectedYear = 2024;

  // Data jadwal ujian (sama seperti yang diminta)
  final Map<int, List<Map<String, String>>> examSchedule = {
    9: [
      {'subject': 'PAI', 'time': '07:00 - 09:30', 'status': 'Selesai'},
      {'subject': 'PPKn', 'time': '10:00 - 11:30', 'status': 'Selesai'},
    ],
    10: [
      {'subject': 'Bahasa Indonesia', 'time': '07:00 - 09:30', 'status': 'Selesai'},
      {'subject': 'Bahasa Jawa', 'time': '10:00 - 11:30', 'status': 'Selesai'},
    ],
    11: [
      {'subject': 'IPAS', 'time': '07:00 - 09:30', 'status': 'Berlangsung'},
      {'subject': 'Bahasa Inggris', 'time': '10:00 - 11:30', 'status': 'Berlangsung'},
    ],
    12: [
      {'subject': 'Seni Budaya', 'time': '07:00 - 09:00', 'status': 'Akan Datang'},
      {'subject': 'PJOK', 'time': '09:30 - 11:00', 'status': 'Akan Datang'},
    ],
    13: [
      {'subject': 'Matematika', 'time': '07:00 - 09:30', 'status': 'Akan Datang'},
    ],
  };

  // Convert examSchedule to flat list for ListView
  List<Map<String, dynamic>> get examList {
    List<Map<String, dynamic>> list = [];
    examSchedule.entries.forEach((entry) {
      final date = entry.key;
      entry.value.forEach((exam) {
        list.add({
          'date': date,
          'subject': exam['subject'],
          'time': exam['time'],
          'status': exam['status'],
        });
      });
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final scrollController = PrimaryScrollController.of(context);
    return SingleChildScrollView(
      controller: scrollController,
      padding: const EdgeInsets.all(25.0), // Sama seperti beranda
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress Card Modern (unchanged)
          Container(
            margin: const EdgeInsets.only(bottom: 20),
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
                                Color(0xFF257180),
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

          // Title
          const Text(
            'Jadwal ujian semester 3',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2A7C8E),
            ),
          ),
          
          const SizedBox(height: 10),
          
          // Calendar Card
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Month/Year header
                Text(
                  'September 2024',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2A7C8E),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Calendar grid
                _buildCalendar(),
              ],
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Detail Jadwal Header
          Text(
            'Detail Jadwal',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2A7C8E),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Transparent ListView
          ...examList.map((exam) => _buildTransparentExamItem(exam)),
          
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildTransparentExamItem(Map<String, dynamic> exam) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          // Date Circle
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: _getStatusColor(exam['status']),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: _getStatusColor(exam['status']).withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                '${exam['date']}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exam['subject'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2A7C8E),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 16,
                      color: const Color(0xFF2A7C8E).withOpacity(0.7),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      exam['time'],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF2A7C8E).withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Sep ${exam['date']}, 2024',
                  style: TextStyle(
                    fontSize: 12,
                    color: const Color(0xFF2A7C8E).withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
          
          // Status Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _getStatusColor(exam['status']),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _getStatusText(exam['status']),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return Column(
      children: [
        // Day headers
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min']
              .map((day) => SizedBox(
                    width: 36,
                    child: Text(
                      day,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF2A7C8E).withOpacity(0.7),
                        fontSize: 12,
                      ),
                    ),
                  ))
              .toList(),
        ),
        
        const SizedBox(height: 16),
        
        // Calendar days
        _buildCalendarDays(),
      ],
    );
  }

  Widget _buildCalendarDays() {
    final daysInMonth = DateTime(2024, 10, 0).day; // September has 30 days
    final firstDayOfMonth = DateTime(2024, 9, 1).weekday; // Monday = 1
    
    List<Widget> dayWidgets = [];
    
    // Empty cells for days before the first day of month
    for (int i = 1; i < firstDayOfMonth; i++) {
      dayWidgets.add(const SizedBox(width: 36, height: 36));
    }
    
    // Days of the month
    for (int day = 1; day <= daysInMonth; day++) {
      final hasExam = examSchedule.containsKey(day);
      final isToday = day == DateTime.now().day;
      
      dayWidgets.add(
        Container(
          width: 36,
          height: 36,
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: hasExam ? const Color(0xFFF2E5BF) : null, // Ganti orange dengan warna beranda
            border: isToday ? Border.all(color: const Color(0xFF2A7C8E), width: 2) : null,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Center(
            child: Text(
              '$day',
              style: TextStyle(
                fontSize: 14,
                fontWeight: hasExam ? FontWeight.bold : FontWeight.normal,
                color: hasExam ? const Color(0xFF257180) : 
                       isToday ? const Color(0xFF2A7C8E) : 
                       const Color(0xFF2A7C8E),
              ),
            ),
          ),
        ),
      );
    }
    
    // Arrange in rows of 7
    List<Widget> rows = [];
    for (int i = 0; i < dayWidgets.length; i += 7) {
      rows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: dayWidgets.sublist(
            i, 
            (i + 7 < dayWidgets.length) ? i + 7 : dayWidgets.length
          ),
        ),
      );
      if (i + 7 < dayWidgets.length) {
        rows.add(const SizedBox(height: 12));
      }
    }
    
    return Column(children: rows);
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Selesai':
        return const Color(0xFF257180);
      case 'Berlangsung':
        return const Color(0xFFFD8B51);
      case 'Akan Datang':
        return const Color(0xFFCB6040);
      default:
        return const Color(0xFF257180);
    }
  }

  Color _getStatusTextColor(String status) {
    return Colors.white;
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'Selesai':
        return 'Selesai';
      case 'Berlangsung':
        return 'Berlangsung';
      case 'Akan Datang':
        return 'Akan Datang';
      default:
        return status;
    }
  }
}