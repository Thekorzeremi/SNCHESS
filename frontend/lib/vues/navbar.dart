import 'package:flutter/material.dart';
import '../color.dart';
import 'trajet.dart';
import 'profil.dart';
import 'travel.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  late List<Widget> _widgetOptions;
  int _selectedIndex = 0;
  bool _isAuthenticated = true;

  // void _handleAuthentication(bool isAuthenticated) {
  //   setState(() {
  //       _widgetOptions[0] = Trajet();
  //       _widgetOptions[1] = Profil();
  //   });
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isAuthenticated) {
      _widgetOptions[0] = Voyage(name: 'John Doe');
      _widgetOptions[1] = Trajet();
      _widgetOptions[2] = Profil();
    }
  }

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[Voyage(name: 'John Doe'), Trajet(), Profil()];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Image.asset('assets/SNCHESS.png', width: 40  , height: 40),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: _isAuthenticated
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
                        _buildNavItem(1, Icons.qr_code_2, 'Trajet'),
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
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }
  
  BottomNavigationBarItem _buildNavItem(int index, IconData icon, String label) {
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
              fontSize: 12
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
