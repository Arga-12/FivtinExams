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

  // Theme colors
  Color get _backgroundColor => _darkMode ? const Color(0xFF1A1A1A) : const Color.fromARGB(255, 247, 247, 247);
  Color get _cardColor => _darkMode ? const Color(0xFF2D2D2D) : Colors.white;
  Color get _textPrimaryColor => _darkMode ? Colors.white : const Color(0xFF2D3748);
  Color get _textSecondaryColor => _darkMode ? Colors.grey[400]! : Colors.grey[600]!;
  Color get _dividerColor => _darkMode ? Colors.grey[700]! : Colors.grey[300]!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _backgroundColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: _textPrimaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Pengaturan',
          style: TextStyle(
            color: _textPrimaryColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
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
                color: _cardColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: _darkMode 
                        ? Colors.black.withOpacity(0.3)
                        : Colors.black.withOpacity(0.05),
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
            Text(
              'Pengaturan Aplikasi',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: _textPrimaryColor,
              ),
            ),
            const SizedBox(height: 12),
            
            Container(
              decoration: BoxDecoration(
                color: _cardColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: _darkMode 
                        ? Colors.black.withOpacity(0.3)
                        : Colors.black.withOpacity(0.05),
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
                  
                  Divider(height: 1, indent: 56, color: _dividerColor),
                  
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
                  
                  Divider(height: 1, indent: 56, color: _dividerColor),
                  
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
            Text(
              'Lainnya',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: _textPrimaryColor,
              ),
            ),
            const SizedBox(height: 12),
            
            Container(
              decoration: BoxDecoration(
                color: _cardColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: _darkMode 
                        ? Colors.black.withOpacity(0.3)
                        : Colors.black.withOpacity(0.05),
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
                        SnackBar(
                          content: const Text('Fitur bantuan akan segera hadir'),
                          backgroundColor: _darkMode ? Colors.grey[800] : null,
                        ),
                      );
                    },
                  ),
                  
                  Divider(height: 1, indent: 56, color: _dividerColor),
                  
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
              color: _textSecondaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(' : ', style: TextStyle(color: _textSecondaryColor)),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: _textPrimaryColor,
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
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: _textPrimaryColor,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 12,
          color: _textSecondaryColor,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.orange,
        inactiveThumbColor: _darkMode ? Colors.grey[300] : null,
        inactiveTrackColor: _darkMode ? Colors.grey[600] : null,
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
          color: isDestructive ? Colors.red : _textPrimaryColor,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 12,
          color: _textSecondaryColor,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: _textSecondaryColor,
      ),
      onTap: onTap,
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: _cardColor,
          title: Text(
            'Pilih Bahasa',
            style: TextStyle(color: _textPrimaryColor),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: Text(
                  'Indonesia',
                  style: TextStyle(color: _textPrimaryColor),
                ),
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
                title: Text(
                  'English',
                  style: TextStyle(color: _textPrimaryColor),
                ),
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
          backgroundColor: _cardColor,
          title: Text(
            'Tentang Aplikasi',
            style: TextStyle(color: _textPrimaryColor),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nama Aplikasi: Fivtin Exams',
                style: TextStyle(color: _textPrimaryColor),
              ),
              const SizedBox(height: 8),
              Text(
                'Versi: 1.0.7',
                style: TextStyle(color: _textPrimaryColor),
              ),
              const SizedBox(height: 8),
              Text(
                'Dikembangkan oleh: UdangKeju',
                style: TextStyle(color: _textPrimaryColor),
              ),
              const SizedBox(height: 16),
              Text(
                'Aplikasi ujian sekolah untuk memudahkan siswa dan guru dalam mengelola kegiatan ujian.',
                style: TextStyle(color: _textSecondaryColor),
              ),
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