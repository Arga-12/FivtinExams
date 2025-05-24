import 'dart:async';
import 'package:flutter/material.dart';

class UjianOncomingPage extends StatefulWidget {
  final String subject;
  final String date;
  final String time;
  final int duration;
  final int totalQuestions;
  final String points;
  final DateTime examDateTime;

  UjianOncomingPage({
    super.key,
    required this.subject,
    required this.date,
    required this.time,
    required this.duration,
    required this.totalQuestions,
    this.points = '20 Pts',
    DateTime? examDateTime,
  }) : examDateTime = examDateTime ?? DateTime.now().add(const Duration(days: 1));

  @override
  State<UjianOncomingPage> createState() => _UjianOncomingPageState();
}

class _UjianOncomingPageState extends State<UjianOncomingPage> {
  // Variabel untuk countdown
  int _remainingDays = 0;
  int _remainingHours = 0;
  int _remainingMinutes = 0;
  int _remainingSeconds = 0;
  late Timer _timer;
  bool _isExamTime = false;

  @override
  void initState() {
    super.initState();
    // Inisialisasi dengan nilai awal
    _updateCountdown();
    
    // Setup timer untuk update setiap detik
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateCountdown();
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Batalkan timer saat widget dihapus
    super.dispose();
  }

  // Method untuk menghitung selisih waktu dan memperbarui countdown
  void _updateCountdown() {
    final now = DateTime.now();
    
    final difference = widget.examDateTime.difference(now);
    
    if (difference.isNegative) {
      // Jika waktu ujian sudah lewat
      setState(() {
        _remainingDays = 0;
        _remainingHours = 0;
        _remainingMinutes = 0;
        _remainingSeconds = 0;
        _isExamTime = true; // Tandai bahwa waktu ujian sudah tiba
      });
    } else {
      // Jika waktu ujian belum tiba
      setState(() {
        _remainingDays = difference.inDays;
        _remainingHours = difference.inHours.remainder(24);
        _remainingMinutes = difference.inMinutes.remainder(60);
        _remainingSeconds = difference.inSeconds.remainder(60);
        _isExamTime = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(
        title: const Text(
          'Detail Ujian',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      backgroundColor: Colors.white, // Warna solid tanpa transparansi
      elevation: 4, // Mengembalikan shadow default
      titleTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25.0), // Padding konsisten 25.0 seperti di beranda
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card
            _buildHeaderCard(),
            
            const SizedBox(height: 20),
            
            // Exam Details Card
            _buildExamDetailsCard(),
            
            const SizedBox(height: 20),
            
            // Rules & Information Card
            _buildRulesCard(),
            
            const SizedBox(height: 20),
            
            // Teacher Notes Card
            _buildTeacherNotesCard(),
            
            const SizedBox(height: 20),
            
            // Bottom Notice Card
            _buildNoticeCard(),
            
            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: _isExamTime ? _buildStartExamButton() : null,
    );
  }

  // Widget tombol mulai ujian yang hanya muncul ketika waktu ujian tiba
  Widget _buildStartExamButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 16.0), // Konsistensi padding horizontal
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          // Navigasi ke halaman ujian
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Memulai ujian...')),
          );
          // Implementasi navigasi ke halaman ujian
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE07A5F),
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          'Mulai Ujian Sekarang',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      width: double.infinity,
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
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.subject,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.event_note,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Wrap dalam column untuk menghindari tabrakan pada layar kecil
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tanggal
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.white, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      widget.date,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              
              // Waktu
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.access_time, color: Colors.white, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      widget.time,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          _isExamTime 
              ? _buildExamTimeNotice() 
              : _buildCountdownTimer(),
        ],
      ),
    );
  }

  // Widget untuk tampilan ketika waktu ujian sudah tiba
  Widget _buildExamTimeNotice() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.notifications_active, 
            color: Colors.white, 
            size: 24,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Ujian sudah dapat dikerjakan sekarang!',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk tampilan countdown
  Widget _buildCountdownTimer() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _CountdownItem(title: 'Hari', value: _remainingDays.toString()),
          _CountdownItem(title: 'Jam', value: _remainingHours.toString()),
          _CountdownItem(title: 'Menit', value: _remainingMinutes.toString()),
          _CountdownItem(title: 'Detik', value: _remainingSeconds.toString()),
        ],
      ),
    );
  }

  Widget _buildExamDetailsCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.info_outline, color: Color(0xFF2A7C8E)),
            SizedBox(width: 10),
            Text(
              'Detail Ujian',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2A7C8E),
              ),
            ),
          ],
        ),
        const Divider(height: 30),
        _buildDetailItem(
          icon: Icons.subject,
          title: 'Mata Pelajaran',
          value: widget.subject,
        ),
        _buildDetailItem(
          icon: Icons.event,
          title: 'Tanggal Ujian',
          value: widget.date,
        ),
        _buildDetailItem(
          icon: Icons.access_time,
          title: 'Waktu Ujian',
          value: widget.time,
        ),
        _buildDetailItem(
          icon: Icons.timelapse,
          title: 'Durasi',
          value: '${widget.duration} menit',
        ),
        _buildDetailItem(
          icon: Icons.help_outline,
          title: 'Jumlah Soal',
          value: '${widget.totalQuestions} soal',
          isLast: true,
        ),
      ],
    );
  }

  Widget _buildRulesCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.rule_folder, color: Color(0xFF2A7C8E)),
            SizedBox(width: 10),
            Text(
              'Peraturan & Informasi',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2A7C8E),
              ),
            ),
          ],
        ),
        const Divider(height: 30),
        _buildRuleItem(
          '1. Pastikan koneksi internet stabil selama ujian berlangsung.'
        ),
        _buildRuleItem(
          '2. Tidak diperbolehkan membuka aplikasi lain selama ujian.'
        ),
        _buildRuleItem(
          '3. Jawaban akan otomatis tersimpan setiap kali Anda pindah soal.'
        ),
        _buildRuleItem(
          '4. Pastikan baterai perangkat mencukupi untuk durasi ujian.'
        ),
        _buildRuleItem(
          '5. Ujian dapat dikerjakan disaat jadwal sudah sesuai.',
          isLast: true,
        ),
      ],
    );
  }

  Widget _buildTeacherNotesCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.message, color: Color(0xFF2A7C8E)),
            SizedBox(width: 10),
            Text(
              'Catatan dari Guru',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2A7C8E),
              ),
            ),
          ],
        ),
        const Divider(height: 30),
        const Text(
          'Silahkan pelajari bab 3-5 tentang Seni Budaya Daerah, dan perhatikan khususnya pada bagian kesenian tradisional. Bahan ujian mencakup materi yang sudah dibahas di kelas dan yang ada di dalam buku paket.',
          style: TextStyle(
            fontSize: 14,
            height: 1.5,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildNoticeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: _isExamTime ? const Color(0xFFE4F5EA) : const Color(0xFFE4F2F5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _isExamTime ? const Color(0xFF388E3C) : const Color(0xFF2A7C8E), 
          width: 1
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _isExamTime ? const Color(0xFF388E3C) : const Color(0xFF2A7C8E),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _isExamTime ? Icons.check_circle : Icons.lock_clock,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isExamTime ? 'Ujian Sudah Dimulai' : 'Ujian Belum Dimulai',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _isExamTime ? const Color(0xFF388E3C) : const Color(0xFF2A7C8E),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _isExamTime 
                      ? 'Anda dapat mengerjakan ujian sekarang.'
                      : 'Untuk dapat mengerjakan ujian, akan aktif sesuai jadwal ujian yang telah ditentukan.',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildDetailItem({
    required IconData icon,
    required String title,
    required String value,
    bool isLast = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF2E5BF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFFCB6040), size: 20),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildRuleItem(String text, {bool isLast = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CountdownItem extends StatelessWidget {
  final String title;
  final String value;

  const _CountdownItem({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFFCB6040),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}