import 'package:pabrik_kayu/helpers/database_helper.dart';
import 'package:pabrik_kayu/models/kehadiran_model.dart';

class KehadiranService {
  final db = DatabaseHelper.instance;

  // CREATE
  Future<int> save(KehadiranModel kehadiran) async {
    return await db.insert('kehadiran', kehadiran.toMap());
  }

  // READ ALL
  Future<List<KehadiranModel>> getAll() async {
    final result = await db.getAll('kehadiran');

    return result.map((e) => KehadiranModel.fromMap(e)).toList();
  }

  // READ BY ID
  Future<KehadiranModel?> getById(int id) async {
    final result = await db.getById('kehadiran', id);

    if (result == null) return null;

    return KehadiranModel.fromMap(result);
  }

  // UPDATE
  Future<int> update(KehadiranModel kehadiran) async {
    return await db.update('kehadiran', kehadiran.id!, kehadiran.toMap());
  }

  // DELETE
  Future<int> delete(int id) async {
    return await db.delete('kehadiran', id);
  }
}
