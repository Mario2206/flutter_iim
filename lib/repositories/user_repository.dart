
import 'package:rendu/database/DatabaseConnection.dart';
import 'package:rendu/models/User.dart';
import 'package:sqflite/sqflite.dart';

class UserRepository {
  static const table = 'users';

  static Future<User?> findById(int id) async {
    var db = await DatabaseConnection.db;
    var result = await db.query(table, where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? User.fromMap(result.first) : null;
  }

   static Future<User?> findByUserId(String userId) async {
    var db = await DatabaseConnection.db;
    var result = await db.query(table, where: 'userId = ?', whereArgs: [userId]);
    return result.isNotEmpty ? User.fromMap(result.first) : null;
  }

  static Future<User?> findByUsername(String username) async {
    var db = await DatabaseConnection.db;
    var result = await db.query(table, where: 'userName = ?', whereArgs: [username]);
    return result.isNotEmpty ? User.fromMap(result.first) : null;
  }

  static Future<int> create(User user) async {
    var db = await DatabaseConnection.db;
    return db.insert(table, user.toMap());
  }

  static Future<int> update(User user) async {
    var db = await DatabaseConnection.db;
    return db.update(table, user.toMap(), where: 'id = ?', whereArgs: [user.id]);
  }

  static Future<int> delete(User user) async {
    var db = await DatabaseConnection.db;
    return db.delete(table, where: 'id = ?', whereArgs: [user.id]);
  }

  static Future<int> count() async {
    var db = await DatabaseConnection.db;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'))!;
  }
}
