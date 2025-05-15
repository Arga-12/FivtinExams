import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  
  const CustomAppBar({
    super.key, 
    this.title = 'Beranda',
    this.showBackButton = false,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
  
  @override
  Size get preferredSize => const Size.fromHeight(100); // Ukuran AppBar yang lebih besar
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: widget.showBackButton,
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 90, 
      title: Image.asset(
        'assets/Logo2.png', // Logo sudah mencakup teks "FIVTIN EXAMS"
        height: 60,
        fit: BoxFit.contain,
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.orange, size: 30),
          onPressed: () {
            // Implement notification action
          },
        ),
        Stack(
          children: [
            // User Avatar
            Container(
              margin: const EdgeInsets.only(right: 16),
              child: CircleAvatar(
                backgroundColor: Colors.orange.shade100,
                radius: 18,
                child: const Icon(
                  Icons.person,
                  color: Colors.orange,
                  size: 24,
                ),
              ),
            ),
            // Small Settings Icon in a circle at the bottom right corner of the user avatar
            Positioned(
              bottom: 0,
              right: 12,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/settings');
                },
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 2,
                        spreadRadius: 0.5,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 10,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}