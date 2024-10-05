// lib/database_helper.dart
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'subject.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'subjects.db');
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE subjects (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      timeSpent INTEGER
    )
    ''');
  }

  Future<List<Subject>> getSubjects() async {
    Database db = await instance.database;
    final maps = await db.query('subjects');

    return List.generate(maps.length, (i) {
      return Subject(
        id: maps[i]['id'],
        name: maps[i]['name'],
        timeSpent: maps[i]['timeSpent'],
      );
    });
  }

  Future<void> addSubject(Subject subject) async {
    Database db = await instance.database;
    await db.insert('subjects', {
      'name': subject.name,
      'timeSpent': subject.timeSpent,
    });
  }

  Future<void> updateTimeSpent(int id, int timeSpent) async {
    Database db = await instance.database;
    await db.update(
      'subjects',
      {'timeSpent': timeSpent},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
