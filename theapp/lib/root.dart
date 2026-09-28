import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';

// Root widget untuk mengelola navigasi halaman lewat BottomNavigationBar
class Root extends StatefulWidget {
  final String username; // Menerima data username dari LoginPage
  const Root({super.key, required this.username});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  // Index halaman yang sedang aktif (0: Home, 1: Profile)
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Daftar halaman yang dihubungkan dengan BottomNav
    final List<Widget> pages = [
      const HomeScreen(),
      ProfileScreen(username: widget.username),
    ];

    return Scaffold(
      body: pages[_selectedIndex], // Menampilkan halaman sesuai tab yang dipilih
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal, // Warna tab yang sedang aktif
        onTap: (index) {
          setState(() {
            _selectedIndex = index; // Ganti halaman saat tab ditekan
          });
        },
        items: const [
          BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: "Profile", icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}
