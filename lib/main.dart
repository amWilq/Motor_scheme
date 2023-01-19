import 'package:flutter/material.dart';
import 'selections/brand-selection.dart';
import 'selections/favorite-selection.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;

  final screens = [
    const BrandSelection(),
    const FavoriteSelection(),
  ];

  void _navigateToFeed() {
    setState(() {
      currentIndex = 1;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: screens,
        ),
        // body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            iconSize: 32,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            backgroundColor: Colors.blue,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            onTap: (index) => setState(() => currentIndex = index),
            currentIndex: currentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Feed',
              ),
            ]),
      ),
    );
  }
}
