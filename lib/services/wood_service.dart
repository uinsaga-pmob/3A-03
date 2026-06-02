import '../helpers/database_helper.dart';
import '../models/wood_model.dart';

class WoodService {
  final dbHelper = DatabaseHelper.instance;

  Future<int> insert(Wood wood) async {
    final db = await dbHelper.database;

    return db.insert(
      'woods',
      wood.toMap(),
    );
  }

  Future<List<Wood>> getAll() async {
    final db = await dbHelper.database;

    final result =
        await db.query('woods');

    return result
        .map((e) => Wood.fromMap(e))
        .toList();
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

    return db.delete(
      'woods',
      where: 'id=?',
      whereArgs: [id],
    );
  }

  Future<int> totalStock() async {
    final db = await dbHelper.database;

    final result = await db.rawQuery(
      'SELECT SUM(stok) as total FROM woods',
    );

    return result.first['total'] == null
        ? 0
        : result.first['total'] as int;
  }
}