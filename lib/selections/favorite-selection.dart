import 'package:flutter/material.dart';

class FavoriteSelection extends StatefulWidget {
  const FavoriteSelection({super.key});

  @override
  State<FavoriteSelection> createState() => _FavoriteSelectionState();
}

class _FavoriteSelectionState extends State<FavoriteSelection> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Lista ulubionych schematów/motorów',
          style: TextStyle(fontSize: 48),
        ),
      ),
    );
  }

  decoration(String s) {}
}
