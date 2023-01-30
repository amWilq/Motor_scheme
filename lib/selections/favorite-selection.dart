import 'package:flutter/material.dart';

class FavoriteSelection extends StatefulWidget {
  final List<Map<String, String>> favorites;
  const FavoriteSelection({Key? key, required this.favorites}) : super(key: key);
  @override
  _FavoriteSelectionState createState() => _FavoriteSelectionState();
}

class _FavoriteSelectionState extends State<FavoriteSelection> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: ListView.builder(
        itemCount: widget.favorites.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(widget.favorites[index]['model']!),
              subtitle: Text(widget.favorites[index]['category']!),
            ),
          );
        },
      ),
    );
  decoration(String s) {}
}
}