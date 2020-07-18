import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:qrreader/models/scan_model.dart';
export 'package:qrreader/models/scan_model.dart';

class DBProvider {

  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if( _database != null )
      return _database;
   
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'QRScanner.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {
        
      },
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE Scans ('
          'id INTEGER PRIMARY KEY AUTOINCREMENT,'
          'type TEXT,'
          'value TEXT'
          ')'
        );
      },
    );

  }


  // CRUD Operations

  // Insert
  insertScanRaw(Scan s) async {
    final db = await database;
    final res = db.rawInsert(
      "INSERT INTO Scans (id, type, value) "
      "VALUES (${s.id}, '${s.type}', '${s.value}')"
    );
    return res;
  }
  
  insertScan(Scan s) async {
    final db = await database;
    final res = await db.insert('Scans' , s.toJson());
    return res;
  }


  // Select

  Future<Scan> getScanById(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?' , whereArgs: [id]);
    return res.isNotEmpty ? Scan.fromJson(res.first) : null;
  }

  Future<List<Scan>> getScans() async {
    final db = await database;
    final res = await db.query('Scans');
    return res.isNotEmpty ? res.map((e) => Scan.fromJson(e)).toList() : [];
  }

  Future<List<Scan>> getScansByType(String type) async {
    final db = await database;
    final res = await db.query('Scans', where: 'type = ?', whereArgs: [type]);
    return res.isNotEmpty ? res.map((e) => Scan.fromJson(e)).toList() : [];
  }

  // Update
    Future<int> updateScanById(Scan scan) async {
    final db = await database;
    final res = await db.update('Scans', scan.toJson() ,where: 'id = ?' , whereArgs: [scan.id]);
    return res;
  }

  // Delete
  Future<int> deleteScanById(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?' , whereArgs: [id]);
    return res;
  }

  Future<int> deleteAll() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Scans');
    return res;
  }

}