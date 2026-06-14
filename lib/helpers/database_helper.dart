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

    return await openDatabase(
      join(dbPath, 'pabrik_kayu.db'),
      version: 10,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE employees(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT NOT NULL,
        jabatan TEXT NOT NULL,
        gaji INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE woods(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        namakayu TEXT NOT NULL,
        kategori TEXT NOT NULL,
        stok INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE kehadiran(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        employee_id INTEGER NOT NULL,
        status TEXT NOT NULL,
        tanggal TEXT NOT NULL,
        jam_masuk TEXT NOT NULL
      )
    ''');
    await db.execute('''
    CREATE TABLE laporan(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      jenis_produk TEXT NOT NULL,
      foto TEXT,
      file_path TEXT,
      tanggal TEXT NOT NULL
    )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS employees(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nama TEXT NOT NULL,
      jabatan TEXT NOT NULL,
      gaji INTEGER NOT NULL
    )
  ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS woods(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      namakayu TEXT NOT NULL,
      kategori TEXT NOT NULL,
      stok INTEGER NOT NULL
    )
  ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS kehadiran(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      employee_id INTEGER NOT NULL,
      status TEXT NOT NULL,
      tanggal TEXT NOT NULL,
      jam_masuk TEXT NOT NULL
    )
  ''');
    await db.execute('''
    CREATE TABLE IF NOT EXISTS laporan(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      jenis_produk TEXT NOT NULL,
      foto TEXT,
      file_path TEXT,
      tanggal TEXT NOT NULL
    )
    ''');
  }

  // ======================
  // CREATE
  // ======================

  Future<int> insert(String table, Map<String, dynamic> data) async {
    final db = await database;

    return await db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // ======================
  // READ ALL
  // ======================

  Future<List<Map<String, dynamic>>> getAll(String table) async {
    final db = await database;

    return await db.query(table);
  }

  // ======================
  // READ BY ID
  // ======================

  Future<Map<String, dynamic>?> getById(String table, int id) async {
    final db = await database;

    final result = await db.query(
      table,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isNotEmpty) {
      return result.first;
    }

    return null;
  }

  // ======================
  // UPDATE
  // ======================

  Future<int> update(String table, int id, Map<String, dynamic> data) async {
    final db = await database;

    return await db.update(table, data, where: 'id = ?', whereArgs: [id]);
  }

  // ======================
  // DELETE
  // ======================

  Future<int> delete(String table, int id) async {
    final db = await database;

    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  // ======================
  // CUSTOM QUERY
  // ======================

  Future<List<Map<String, dynamic>>> rawQuery(
    String sql, [
    List<dynamic>? arguments,
  ]) async {
    final db = await database;

    return await db.rawQuery(sql, arguments);
  }

  Future<int> rawInsert(String sql, [List<dynamic>? arguments]) async {
    final db = await database;

    return await db.rawInsert(sql, arguments);
  }

  Future<int> rawUpdate(String sql, [List<dynamic>? arguments]) async {
    final db = await database;

    return await db.rawUpdate(sql, arguments);
  }

  Future<int> rawDelete(String sql, [List<dynamic>? arguments]) async {
    final db = await database;

    return await db.rawDelete(sql, arguments);
  }
}
