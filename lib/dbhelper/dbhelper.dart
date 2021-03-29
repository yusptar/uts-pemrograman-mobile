import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:uts/models/datarawatjalan.dart';

class DbHelper {
  static DbHelper _dbHelper;
  static Database _database;
  DbHelper._createObject();
  Future<Database> initDb() async {
//untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'rawatjalan.db';
//create, read databases
    var rawatjalanDatabase = openDatabase(path,
        version: 6,
        onCreate:
            _createDb); //mengembalikan nilai object sebagai hasil dari fungsinya
    return rawatjalanDatabase;
  }

//buat tabel baru dengan nama rawatjalan
  void _createDb(Database db, int version) async {
    await db.execute('''
    CREATE TABLE rawatjalan (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nosurat INTEGER,
    nama TEXT,
    diagnosis TEXT,
    poli TEXT
    )
    ''');
  }

//select databases
  Future<List<Map<String, dynamic>>> select() async {
    Database db = await this.initDb();
    var mapList = await db.query('rawatjalan', orderBy: 'nama');
    return mapList;
  }

//create databases
  Future<int> insert(RawatJalan object) async {
    Database db = await this.initDb();
    int count = await db.insert('rawatjalan', object.toMap());
    return count;
  }

//update databases
  Future<int> update(RawatJalan object) async {
    Database db = await this.initDb();
    int count = await db.update('rawatjalan', object.toMap(),
        where: 'id=?', whereArgs: [object.id]);
    return count;
  }

  //delete databases
  Future<int> delete(int id) async {
    Database db = await this.initDb();
    int count = await db.delete('rawatjalan', where: 'id=?', whereArgs: [id]);
    return count;
  }

  Future<List<RawatJalan>> getItemList() async {
    var rawatjalanMapList = await select();
    int count = rawatjalanMapList.length;
    List<RawatJalan> rawatjalanList = List<RawatJalan>();
    for (int i = 0; i < count; i++) {
      rawatjalanList.add(RawatJalan.fromMap(rawatjalanMapList[i]));
    }
    return rawatjalanList;
  }

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper;
  }
  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }
}
