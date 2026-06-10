import '../helpers/database_helper.dart';
import '../models/wood_model.dart';

class WoodService {
  final dbHelper = DatabaseHelper.instance;

  Future<int> insert(Wood wood) async {
    final db = await dbHelper.database;

    return db.insert('woods', wood.toMap());
  }

  Future<List<Wood>> getAll() async {
    final db = await dbHelper.database;

    final result = await db.query('woods');

    return result.map((e) => Wood.fromMap(e)).toList();
  }

  Future<int> update(Wood wood) async {
    final db = await dbHelper.database;

    return db.update(
      'woods',
      wood.toMap(),
      where: 'id=?',
      whereArgs: [wood.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await dbHelper.database;

    return db.delete('woods', where: 'id=?', whereArgs: [id]);
  }

  Future<int> totalStock() async {
    final db = await dbHelper.database;

    try {
      final result = await db.rawQuery('SELECT SUM(stok) as total FROM woods');

      // Cek apakah hasilnya ada dan tidak null
      if (result.isNotEmpty && result.first['total'] != null) {
        // Ubah secara eksplisit menjadi int
        return (result.first['total'] as num).toInt();
      }
      return 0; // Kembalikan 0 jika tabel kosong
    } catch (e) {
      print("Error di totalStock: $e");
      return 0; // Kembalikan 0 jika terjadi error database
    }
  }
}
