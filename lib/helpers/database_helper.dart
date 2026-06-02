import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();

    return openDatabase(
      join(dbPath, 'pabrik_kayu.db'),
      version: 1,
      onCreate: (db, version) async {
        // TABEL KARYAWAN
        await db.execute('''
          CREATE TABLE employees(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nama TEXT,
            jabatan TEXT,
            gaji INTEGER
          )
        ''');

        // TABEL KAYU
        await db.execute('''
          CREATE TABLE woods(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            namakayu TEXT,
            kategori TEXT,
            stok INTEGER
          )
        ''');
      },
    );
  }
}
