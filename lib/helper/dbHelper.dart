import 'package:moomi/helper/safe.dart';
import 'package:moomi/models/note.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart' as sql;

class DbHelper {
  static Future<sql.Database> database() async {
    var dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(p.join(dbPath, 'notes.db'),
        onCreate: (db, version) {
      db.execute('''
      CREATE TABLE userNotes(
            ${Safe.id} TEXT PRIMARY KEY,
            ${Safe.title} TEXT,
            ${Safe.description} TEXT,
            ${Safe.tags} TEXT,
            ${Safe.date} TEXT,
            ${Safe.reminderTime} TEXT)
            ''');
    }, version: 1);
  }

  static Future<int> insertNote(
      String tableName, Map<String, dynamic> data) async {
    final newDb = await DbHelper.database();
    return newDb.insert(tableName, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getNotes(String tableName) async {
    final newDb = await DbHelper.database();
    return newDb.query(tableName);
  }

  static Future<int> setNotes(
      String tableName, Map<String, dynamic> note) async {
    final newDb = await DbHelper.database();
    var updateInt = await newDb.update(tableName, note,
        where: '${Safe.id} = ?', whereArgs: [note[Safe.id]]);
    print('update int return is : $updateInt');
    return updateInt;
  }

  static Future<int> removeNote(String tableName, String id) async {
    final newDb = await DbHelper.database();
    return newDb.delete(tableName, where: '${Safe.id} =?', whereArgs: [id]);
  }
  // Future close() async => await DbHelper.database() ..close();
}
