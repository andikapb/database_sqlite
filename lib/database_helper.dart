import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'mahasiswa.dart';
 
class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
 
  static Database _database;
  Future<Database> get database async => _database = await _initDatabase();
 
  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'akademik.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }
 
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE mahasiswa(
          id INTEGER PRIMARY KEY,
          nama TEXT,
          jenjang TEXT,
          prodi TEXT
      )
      ''');
  }
 
  Future<List<Mahasiswa>> getAllMahasiswa() async {
    Database db = await instance.database;
    var mahasiswa = await db.query('mahasiswa', orderBy: 'nama');
    List<Mahasiswa> mahasiswaList = mahasiswa.isNotEmpty
        ? mahasiswa.map((c) => Mahasiswa.fromMap(c)).toList()
        : [];
    return mahasiswaList;
  }
 
  Future<List<Mahasiswa>> getMahasiswaById(int id) async {
    Database db = await instance.database;
    var mahasiswa =
        await db.query('mahasiswa', where: 'id = ?', whereArgs: [id]);
    List<Mahasiswa> mahasiswaList = mahasiswa.isNotEmpty
        ? mahasiswa.map((c) => Mahasiswa.fromMap(c)).toList()
        : [];
    return mahasiswaList;
  }
 
  Future<int> add(Mahasiswa mahasiswa) async {
    Database db = await instance.database;
    return await db.insert('mahasiswa', mahasiswa.toMap());
  }
 
  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete('mahasiswa', where: 'id = ?', whereArgs: [id]);
  }
 
  Future<int> update(Mahasiswa mahasiswa) async {
    Database db = await instance.database;
    return await db.update('mahasiswa', mahasiswa.toMap(),
        where: "id = ?", whereArgs: [mahasiswa.id]);
  }
}
