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
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 30); // Height yang lebih konsisten
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: widget.showBackButton,
      backgroundColor: const Color.fromARGB(255, 247, 247, 247),
      elevation: 0,
      toolbarHeight: kToolbarHeight + 30, // Menggunakan nilai yang sama dengan preferredSize
      title: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Image.asset(
          'assets/Logo2.png', // Logo sudah mencakup teks "FIVTIN EXAMS"
          height: 50,
          fit: BoxFit.contain,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.orange, size: 28),
            onPressed: () {
              // Implement notification action
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, right: 16.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // User Avatar
              CircleAvatar(
                backgroundColor: Colors.orange.shade100,
                radius: 18,
                child: const Icon(
                  Icons.person,
                  color: Colors.orange,
                  size: 24,
                ),
              ),
              // Small Settings Icon in a circle at the bottom right corner of the user avatar
              Positioned(
                bottom: 0,
                right: 0,
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
        ),
      ],
    );
  }
}