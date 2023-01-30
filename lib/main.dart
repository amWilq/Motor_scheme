import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/fav_cubit.dart';
import 'fav_page/fav_page.dart';
import 'selections/brand-selection.dart';

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
    const FavouritePage(),
  ];

  void _navigateToFeed() {
    setState(() {
      currentIndex = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {},
      home: BlocProvider<FavCubit>(
        create: (context) => FavCubit(),
        child: Scaffold(
          body: Center(
            child: screens.elementAt(currentIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
              iconSize: 32,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white70,
              backgroundColor: Colors.grey,
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: false,
              showSelectedLabels: false,
              onTap: (index) {
                currentIndex = index;
                setState(() {});
              },
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
      ),
    );
  }
}
