import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final ScrollController? scrollController;
  
  const CustomAppBar({
    super.key, 
    this.title = 'Beranda',
    this.showBackButton = false,
    this.scrollController,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 30);
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool _showShadow = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController?.addListener(_handleScroll);
  }

  @override
  void dispose() {
    widget.scrollController?.removeListener(_handleScroll);
    super.dispose();
  }

  void _handleScroll() {
    final showShadow = widget.scrollController?.hasClients == true && 
                      widget.scrollController!.offset > 5;
    if (showShadow != _showShadow) {
      setState(() {
        _showShadow = showShadow;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: widget.showBackButton,
      backgroundColor: const Color.fromARGB(255, 247, 247, 247),
      elevation: _showShadow ? 4 : 0, // Elevation akan membuat shadow muncul
      scrolledUnderElevation: 0, // Matikan efek bawaan Flutter
      shadowColor: Colors.black, // Warna shadow
      surfaceTintColor: Colors.transparent, // Pastikan warna tidak berubah
      toolbarHeight: kToolbarHeight + 30,
      title: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Image.asset(
          'assets/Logo2.png',
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
              CircleAvatar(
                backgroundColor: Colors.orange.shade100,
                radius: 18,
                child: const Icon(
                  Icons.person,
                  color: Colors.orange,
                  size: 24,
                ),
              ),
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