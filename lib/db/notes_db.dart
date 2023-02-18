import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:motor_scheme/models/bike.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();

  static Database? _database;

  NotesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('data.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1);
  }

  // Future _createDB(Database db, int version) async {
  //   print('tworzenie bazy');
  //   await db.execute(
  //       "CREATE TABLE bike (id integer PRIMARY KEY,mark text,model text,year text,type_bike integer,FOREIGN KEY(type_bike) REFERENCES type_bike(id))");
  // }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<List<Bike>> readAllBikes() async {
    final db = await instance.database;
    final result = await db.query(tableBike);
    print(result.map((json) => Bike.fromJson(json)).toList());
    return result.map((json) => Bike.fromJson(json)).toList();
  }

  // Future<Bike> readBike(int id) async {
  //   final db = await instance.database;

  //   final maps = await db.query(tableBike,
  //       columns: BikeFields.values,
  //       where: '${BikeFields.id} = ?',
  //       whereArgs: [id]);

  //   if (maps.isNotEmpty) {
  //     return Bike.fromJson(maps.first);
  //   } else {
  //     throw Exception('ID $id not found');
  //   }
  // }
}
