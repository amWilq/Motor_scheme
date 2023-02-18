import 'dart:convert';

import 'package:flutter/material.dart';

import '../db/notes_db.dart';
import '../models/bike.dart';
import 'package:http/http.dart' as http;

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<Bike> notes = [];
  // List<Bike> bikeModel = [];
  bool isLoading = false;
  late var controller = TextEditingController();
  String name = '';

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    Future.delayed(Duration.zero, () => asyncMethod());
    refreshNotes();
    // readBike();
  }

// Implementation of Dispose pattern callable

  @override
  void dispose() {
    NotesDatabase.instance.close();
    super.dispose();
  }

  void asyncMethod() async {
    if (name == null || name.isEmpty) return;
    setState(() => this.name = name);
    refreshNotes();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);
    notes = await NotesDatabase.instance.readAllBikes();

    setState(() => isLoading = false);
  }

  // Future readBike() async {
  //   setState(() => isLoading = true);
  //   var bikeModel = await NotesDatabase.instance.readBike(3);

  //   setState(() => isLoading = false);
  // }

//build method

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Bike from db',
            style: TextStyle(fontSize: 24),
          ),
        ),
        body: notes.isNotEmpty
            ? Center(
                child: Text(notes.map((e) => e.model).toString()),
              )
            : const Center(
                child: Text(
                  'Add notes',
                  style: TextStyle(fontSize: 20),
                ),
              ),
      );

// To build notes to display in Listview

  Widget buildNotes() {
    return ListView.builder(
      itemCount: notes.length,
      padding: EdgeInsets.only(bottom: 120),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final note = notes[index];
        Text(note.toString());
        return Container();
      },
    );
  }
}
