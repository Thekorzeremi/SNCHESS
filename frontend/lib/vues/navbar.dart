import 'package:flutter/material.dart';
import 'package:frontend/vues/landing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../color.dart';
import 'tickets/tickets.dart';
import 'profil/profil.dart';
import 'travels/travels.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;
  bool? isAuthenticated;

  final List<Widget> _widgetOptions = [
    Travels(name: 'John Doe'),
    Tickets(),
    Profil(),
  ];

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (mounted) {
        setState(() {
          isAuthenticated = user != null;
        });
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isAuthenticated == null) {
      return Scaffold(
        backgroundColor: AppColors.primary,
        body: Center(
          child: CircularProgressIndicator(color: AppColors.secondary),
        ),
      );
    }

    final isAuth = isAuthenticated!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: isAuth
            ? Image.asset('assets/SNCHESS.png', width: 40, height: 40)
            : null,
      ),
      body: isAuth ? _widgetOptions[_selectedIndex] : const LandingPage(),
      bottomNavigationBar: isAuth
          ? BottomNavigationBar(
              backgroundColor: AppColors.primary,
              items: <BottomNavigationBarItem>[
                _buildNavItem(0, Icons.card_travel, 'Voyage'),
                _buildNavItem(1, Icons.qr_code_2, 'Tickets'),
                _buildNavItem(2, Icons.person_2_outlined, 'Mon profil'),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: AppColors.secondary,
              unselectedItemColor: AppColors.white,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              onTap: _onItemTapped,
            )
          : null,
    );
  }

  BottomNavigationBarItem _buildNavItem(
    int index,
    IconData icon,
    String label,
  ) {
    bool isSelected = _selectedIndex == index;

    return BottomNavigationBarItem(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? AppColors.secondary : AppColors.white,
            size: 22,
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? AppColors.secondary : AppColors.white,
              fontSize: 12,
            ),
          ),
          if (isSelected)
            Container(
              margin: EdgeInsets.only(top: 4),
              height: 2,
              width: 40,
              color: AppColors.secondary,
            ),
        ],
      ),
      label: '',
    );
  }
}
