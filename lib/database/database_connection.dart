import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseConnection {
  static Database? _db;
  static const String _dbName = 'rendu.db';

  static Future<Database> get db async {
    if (_db != null) {
      return _db as Database;
    }
    await connect();
    return _db as Database;
  }

  static connect() async {
    final completer = Completer();
    var dbPath = await getDatabasesPath();
    var path = join(dbPath, _dbName);
    _db = await openDatabase(path, version: 1, onOpen: (db) {
      _onCreate(db);
      completer.complete();
    });
    return completer.future;
  }

  static _onCreate(Database db) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY, userName TEXT, password TEXT, userId TEXT)');
  }
}
