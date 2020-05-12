import 'dart:developer';

import 'package:moomi/helper/safe.dart';
import 'package:moomi/models/note.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart' as sql;

class DbHelper {
  static Future<sql.Database> database() async {
    var dbPath = await sql.getDatabasesPath();
    return await sql.openDatabase(p.join(dbPath, 'notesmoomi.db'),
        onCreate: (db, version) async {
      await db.execute('''
      CREATE TABLE userNotes(
            ${Safe.id} TEXT PRIMARY KEY,
            ${Safe.title} TEXT,
            ${Safe.description} TEXT,
            ${Safe.tags} TEXT,
            ${Safe.date} TEXT,
            ${Safe.reminderTime} TEXT)
            ''');
      print('user notes database created: ***');
      await db.execute('''
        CREATE TABLE generalData(
          ${Safe.generalId} TEXT PRIMARY KEY,
          ${Safe.userName} TEXT,
          ${Safe.tagsList} TEXT)
        ''');
      print('general note database created: ***');
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

//----------------------- general data ---------------------------------------**
  static Future<int> setGeneralData(
      String tableName, Map<String, String> generalData) async {
    final newDb = await DbHelper.database();
    print('add check return : $generalData');
    return newDb.insert(tableName, generalData);
  }

  static Future<int> updateGenData(
      String tableName, Map<String, String> generalData) async {
    final newDb = await DbHelper.database();
    var updatedGen = newDb.update(tableName, generalData);
    // print('Update check return : $generalData');
    return updatedGen;
  }

  static Future<List<Map<String, dynamic>>> getGenData(String tableName) async {
    final newDb = await DbHelper.database();
    return newDb.query(tableName);
  }

  static Future<int> deleteGenData(String table) async {
    final newDb = await DbHelper.database();
    newDb.delete(table);
  }
}
