import 'package:flutter/material.dart';
import 'generater_screen.dart';
import 'home_screen.dart';
import 'history_screen.dart';
import 'nev_bar.dart';

class MainNav extends StatefulWidget {
  const MainNav({super.key});

  @override
  State<MainNav> createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  int _currentIndex = 1;

  final List<Widget> _pages = const [
    GenerateScreen(),
    HomeScreen(),
    HistoryScreen(),
  ];

  void _onNavTap(int idx) {
    setState(() => _currentIndex = idx);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: NevBar(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }
}
