import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static Database? _db;
  static const String DB_NAME = 'recipes.db';
  static const String TABLE_NAME = 'recipes';
  static const String COLUMN_NAME = 'nama';
  static const String COLUMN_INGREDIENTS = 'bahan';
  static const String COLUMN_STEPS = 'tahapan';

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $TABLE_NAME (
        $COLUMN_NAME TEXT,
        $COLUMN_INGREDIENTS TEXT,
        $COLUMN_STEPS TEXT
      )
    ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database dbClient = await db;
    return await dbClient.insert(TABLE_NAME, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database dbClient = await db;
    return await dbClient.query(TABLE_NAME);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database dbClient = await db;
    String name = row[COLUMN_NAME];
    return await dbClient.update(TABLE_NAME, row, where: '$COLUMN_NAME = ?', whereArgs: [name]);
  }

  Future<int> delete(String name) async {
    Database dbClient = await db;
    return await dbClient.delete(TABLE_NAME, where: '$COLUMN_NAME = ?', whereArgs: [name]);
  }
}
