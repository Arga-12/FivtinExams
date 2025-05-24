import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Data dummy untuk profil (tidak bisa diedit)
  final String _profileName = "Ramadhan Arga Adiansyah";
  final String _nisn = "9012";
  final String _kelas = "VIII A";

  // Settings yang bisa diubah
  bool _notifikasi = true;
  bool _darkMode = false;
  String _bahasa = 'Indonesia';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 247, 247),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 247, 247, 247),
        surfaceTintColor: Colors.transparent, // Mencegah perubahan warna saat scroll
        elevation: 0, // Sama seperti notifikasi
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2D3748)), // Sama seperti notifikasi
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Pengaturan',
          style: TextStyle(
            color: Color(0xFF2D3748), // Sama seperti notifikasi
            fontSize: 18, // Sama seperti notifikasi
            fontWeight: FontWeight.bold, // Sama seperti notifikasi
          ),
        ),
        // Hapus centerTitle: true agar konsisten dengan notifikasi
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
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
              child: Column(
                children: [
                  // Profile Picture
                  CircleAvatar(
                    backgroundColor: Colors.orange.shade100,
                    radius: 40,
                    child: const Icon(
                      Icons.person,
                      color: Colors.orange,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Profile Info
                  _buildProfileInfo('Nama', _profileName),
                  const SizedBox(height: 12),
                  _buildProfileInfo('NISN', _nisn),
                  const SizedBox(height: 12),
                  _buildProfileInfo('Kelas', _kelas),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Settings Section
            const Text(
              'Pengaturan Aplikasi',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            
            Container(
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
              child: Column(
                children: [
                  // Notifikasi Setting
                  _buildSwitchTile(
                    'Notifikasi',
                    'Terima pemberitahuan dari aplikasi',
                    Icons.notifications_outlined,
                    _notifikasi,
                    (value) {
                      setState(() {
                        _notifikasi = value;
                      });
                    },
                  ),
                  
                  const Divider(height: 1, indent: 56),
                  
                  // Dark Mode Setting
                  _buildSwitchTile(
                    'Mode Gelap',
                    'Ubah tema aplikasi ke mode gelap',
                    Icons.dark_mode_outlined,
                    _darkMode,
                    (value) {
                      setState(() {
                        _darkMode = value;
                      });
                    },
                  ),
                  
                  const Divider(height: 1, indent: 56),
                  
                  // Language Setting
                  _buildMenuTile(
                    'Bahasa',
                    _bahasa,
                    Icons.language_outlined,
                    () {
                      _showLanguageDialog();
                    },
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Other Options
            const Text(
              'Lainnya',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            
            Container(
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
              child: Column(
                children: [
                  _buildMenuTile(
                    'Bantuan',
                    'Dapatkan bantuan dan dukungan',
                    Icons.help_outline,
                    () {
                      // Implement help functionality
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Fitur bantuan akan segera hadir')),
                      );
                    },
                  ),
                  
                  const Divider(height: 1, indent: 56),
                  
                  _buildMenuTile(
                    'Tentang Aplikasi',
                    'Informasi tentang aplikasi',
                    Icons.info_outline,
                    () {
                      _showAboutDialog();
                    },
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfo(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 60,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const Text(' : ', style: TextStyle(color: Colors.grey)),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSwitchTile(String title, String subtitle, IconData icon, bool value, Function(bool) onChanged) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Icon(icon, color: Colors.orange, size: 24),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.orange,
      ),
    );
  }

  Widget _buildMenuTile(String title, String subtitle, IconData icon, VoidCallback onTap, {bool isDestructive = false}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Icon(
        icon, 
        color: isDestructive ? Colors.red : Colors.orange, 
        size: 24,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: isDestructive ? Colors.red : Colors.black87,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: Colors.grey[400],
      ),
      onTap: onTap,
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pilih Bahasa'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: const Text('Indonesia'),
                value: 'Indonesia',
                groupValue: _bahasa,
                activeColor: Colors.orange,
                onChanged: (String? value) {
                  setState(() {
                    _bahasa = value!;
                  });
                  Navigator.pop(context);
                },
              ),
              RadioListTile<String>(
                title: const Text('English'),
                value: 'English',
                groupValue: _bahasa,
                activeColor: Colors.orange,
                onChanged: (String? value) {
                  setState(() {
                    _bahasa = value!;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tentang Aplikasi'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nama Aplikasi: Fivtin Exams'),
              SizedBox(height: 8),
              Text('Versi: 1.0.7'),
              SizedBox(height: 8),
              Text('Dikembangkan oleh: UdangKeju'),
              SizedBox(height: 16),
              Text('Aplikasi ujian sekolah untuk memudahkan siswa dan guru dalam mengelola kegiatan ujian.'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Tutup',
                style: TextStyle(color: Colors.orange),
              ),
            ),
          ],
        );
      },
    );
  }
}