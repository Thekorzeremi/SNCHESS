import 'package:flutter/material.dart';
import '../color.dart';
import 'trajet.dart';
import 'profil.dart';
import 'voyage.dart';

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
      _widgetOptions[0] = Voyage();
      _widgetOptions[1] = Trajet();
      _widgetOptions[2] = Profil();
    }
  }

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[Voyage(), Trajet(), Profil()];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isAuthenticated
          ? PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  border: Border(
                    bottom: BorderSide(color: AppColors.primary, width: 2.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Voyage',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          spacing: 8,
                          children: [
                            Text(
                              'Déconnexion',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                            Icon(Icons.logout, size: 16, color: Colors.red),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: _isAuthenticated
          ? Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppColors.primary, width: 2.0),
                ),
              ),
              child: BottomNavigationBar(
                backgroundColor: AppColors.secondary,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.dashboard_customize_outlined,
                      color: _selectedIndex == 0
                          ? AppColors.primary
                          : AppColors.black,
                    ),
                    label: 'Voyage',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.face,
                      color: _selectedIndex == 1
                          ? AppColors.primary
                          : AppColors.black,
                    ),
                    label: 'Trajet',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.face,
                      color: _selectedIndex == 2
                          ? AppColors.primary
                          : AppColors.black,
                    ),
                      label: 'Mon profil',
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: AppColors.primary,
                unselectedItemColor: AppColors.black,
                onTap: _onItemTapped,
              ),
            )
          : null,
    );
  }
}
