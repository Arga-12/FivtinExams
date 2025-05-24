import 'package:flutter/material.dart';

class JadwalUjianPage extends StatefulWidget {
  const JadwalUjianPage({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white, // Warna solid tanpa transparansi
          elevation: 4, // Shadow default
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.black), // Ikon dari contoh kedua
          ),
          title: const Text(
            'Jadwal Ujian',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: false,
        ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Text(
              'Jadwal ujian semester 3',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Calendar Card
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Month/Year header
                  Text(
                    'September - 2024',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Calendar grid
                  _buildCalendar(),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Schedule section title
            const Text(
              'Detail Jadwal',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Schedule cards
            ...examSchedule.entries.map((entry) {
              final date = entry.key;
              final exams = entry.value;
              
              return Column(
                children: exams.map((exam) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          // Date circle
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: _getStatusColor(exam['status']!),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '$date',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: _getStatusTextColor(exam['status']!),
                                ),
                              ),
                            ),
                          ),
                          
                          const SizedBox(width: 16),
                          
                          // Exam details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  exam['subject']!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.access_time,
                                      size: 14,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      exam['time']!,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Sep $date, 2024',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Status badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(exam['status']!),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              _getStatusText(exam['status']!),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _getStatusTextColor(exam['status']!),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            }).toList(),
            
            const SizedBox(height: 80), // Space for bottom navigation
          ],
        ),
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
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ))
              .toList(),
        ),
        
        const SizedBox(height: 12),
        
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
            color: hasExam ? const Color(0xFFFFE4B5) : null,
            border: isToday ? Border.all(color: const Color(0xFF2A7C8E), width: 2) : null,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Center(
            child: Text(
              '$day',
              style: TextStyle(
                fontSize: 14,
                fontWeight: hasExam ? FontWeight.bold : FontWeight.normal,
                color: hasExam ? const Color(0xFF2A7C8E) : 
                       isToday ? const Color(0xFF2A7C8E) : 
                       Colors.black,
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
        rows.add(const SizedBox(height: 8));
      }
    }
    
    return Column(children: rows);
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Selesai':
        return Colors.green.withOpacity(0.15);
      case 'Berlangsung':
        return Colors.orange.withOpacity(0.15);
      case 'Akan Datang':
        return Colors.blue.withOpacity(0.15);
      default:
        return Colors.grey.withOpacity(0.15);
    }
  }

  Color _getStatusTextColor(String status) {
    switch (status) {
      case 'Selesai':
        return Colors.green.shade700;
      case 'Berlangsung':
        return Colors.orange.shade700;
      case 'Akan Datang':
        return Colors.blue.shade700;
      default:
        return Colors.grey.shade700;
    }
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