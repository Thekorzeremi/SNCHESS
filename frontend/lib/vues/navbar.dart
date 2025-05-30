import 'package:flutter/material.dart';
import 'package:frontend/vues/landing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../color.dart';
import 'tickets/tickets.dart';
import 'profil/profil.dart';
import 'travels/travels.dart';
import 'admin/admin.dart';
import '../services/firebaseAuthentificationService.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  late List<Widget> _widgetOptions;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    final userInfo = FirebaseAuthentificationService().getCurrentUserInformation();
    final isAdmin = userInfo != null && userInfo['email'] == 'fiinnnhh@gmail.com';
    _widgetOptions = <Widget>[
      Travels(name: 'John Doe'),
      Tickets(),
      Profil(),
      if (isAdmin) Admin(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isAuthenticated = FirebaseAuth.instance.currentUser != null;
    final userInfo = FirebaseAuthentificationService().getCurrentUserInformation();
    final isAdmin = userInfo != null && userInfo['email'] == 'fiinnnhh@gmail.com';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: isAuthenticated
            ? Image.asset('assets/SNCHESS.png', width: 40, height: 40)
            : null,
      ),
      body: isAuthenticated
          ? _widgetOptions.elementAt(_selectedIndex)
          : LandingPage(),
      bottomNavigationBar: isAuthenticated
          ? SizedBox(
              height: 80,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 80,
                    child: BottomNavigationBar(
                      backgroundColor: AppColors.primary,
                      items: <BottomNavigationBarItem>[
                        _buildNavItem(0, Icons.card_travel, 'Voyage'),
                        _buildNavItem(1, Icons.qr_code_2, 'Tickets'),
                        _buildNavItem(2, Icons.person_2_outlined, 'Mon profil'),
                        if (isAdmin) _buildNavItem(3, Icons.admin_panel_settings, 'Admin'),
                      ],
                      currentIndex: _selectedIndex,
                      selectedItemColor: AppColors.secondary,
                      unselectedItemColor: AppColors.white,
                      selectedFontSize: 12,
                      unselectedFontSize: 12,
                      type: BottomNavigationBarType.fixed,
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      onTap: (index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                    ),
                  ),
                ],
              ),
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
