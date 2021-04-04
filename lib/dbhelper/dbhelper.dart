import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:uts/models/datarawatjalan.dart';
import 'package:uts/models/login.dart';

class DbHelper {
  static DbHelper _dbHelper;
  static Database _database;
  DbHelper._createObject();
  Future<Database> initDb() async {
//untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'rawatjalan.db';
//create, read databases
    var db = openDatabase(path,
        version: 7,
        onCreate: _createDb,
        onUpgrade:
            _onUpgrade); //mengembalikan nilai object sebagai hasil dari fungsinya
    return db;
  }

//update table baru
  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    _createDb(db, newVersion);
  }

//buat tabel baru dengan nama rawatjalan
  void _createDb(Database db, int version) async {
    var batch = db.batch();
    batch.execute('DROP TABLE IF EXISTS rawatjalan');
    batch.execute('DROP TABLE IF EXISTS login');
    batch.execute('''
    CREATE TABLE rawatjalan (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nosurat INTEGER,
    nama TEXT,
    diagnosis TEXT,
    poli TEXT
    )
    ''');
    batch.execute('''
    CREATE TABLE login (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT,
    password TEXT
    )
    ''');
    await batch.commit();
  }

//select databases rawatjalan
  Future<List<Map<String, dynamic>>> select() async {
    Database db = await this.initDb();
    var mapList = await db.query('rawatjalan', orderBy: 'nama');
    return mapList;
  }

//select databases login
  Future<List<Map<String, dynamic>>> selectLogin(int id) async {
    Database db = await this.initDb();
    var mapList = await db.query('login', where: 'id = $id');
    return mapList;
  }

//create databases rawat jalan
  Future<int> insert(RawatJalan object) async {
    Database db = await this.initDb();
    int count = await db.insert('rawatjalan', object.toMap());
    return count;
  }

//create databases login
  Future<int> insertLogin(Login login) async {
    Database db = await this.initDb();
    int count = await db.insert('login', login.toMap());
    return count;
  }

//update databases rawat jalan
  Future<int> update(RawatJalan object) async {
    Database db = await this.initDb();
    int count = await db.update('rawatjalan', object.toMap(),
        where: 'id=?', whereArgs: [object.id]);
    return count;
  }

//update databases login
  Future<int> updateLogin(Login login) async {
    Database db = await this.initDb();
    int count = await db
        .update('login', login.toMap(), where: 'id=?', whereArgs: [login.id]);
    return count;
  }

  //delete databases
  Future<int> delete(int id) async {
    Database db = await this.initDb();
    int count = await db.delete('rawatjalan', where: 'id=?', whereArgs: [id]);
    return count;
  }

// listview database rawat jalan
  Future<List<RawatJalan>> getItemList() async {
    var rawatjalanMapList = await select();
    int count = rawatjalanMapList.length;
    List<RawatJalan> rawatjalanList = List<RawatJalan>();
    for (int i = 0; i < count; i++) {
      rawatjalanList.add(RawatJalan.fromMap(rawatjalanMapList[i]));
    }
    return rawatjalanList;
  }

// listview database login
  Future<List<Login>> getLoginList() async {
    var LoginMapList = await select();
    int count = LoginMapList.length;
    List<Login> LoginList = List<Login>();
    for (int i = 0; i < count; i++) {
      LoginList.add(Login.fromMap(LoginMapList[i]));
    }
    return LoginList;
  }

  Future<List<Login>> getAllUser() async {
    var dbClient = await this.initDb();
    var res = await dbClient.query("login");

    List<Login> list =
        res.isNotEmpty ? res.map((c) => Login.fromMap(c)).toList() : null;

    return list;
  }

  Future<Login> getLogin(String username, String password) async {
    var dbClient = await this.initDb();
    var res = await dbClient.rawQuery(
        "SELECT * FROM login WHERE username = '$username' and password = '$password'");

    if (res.length > 0) {
      return new Login.fromMap(res.first);
    }

    return null;
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
