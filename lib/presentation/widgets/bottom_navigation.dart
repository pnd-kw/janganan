import 'package:flutter/material.dart';
import 'package:janganan/presentation/screens/home_screen.dart';
import 'package:janganan/presentation/screens/order_screen.dart';
import 'package:janganan/presentation/screens/user_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  static const List<Widget> _screenWidget = [
    HomeScreen(),
    OrderScreen(),
    UserScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _screenWidget.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: 'Pesanan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedLabelStyle: Theme.of(context).textTheme.titleSmall,
        unselectedLabelStyle: Theme.of(context).textTheme.titleSmall,
        onTap: _onItemTapped,
      ),
    );
  }
}
