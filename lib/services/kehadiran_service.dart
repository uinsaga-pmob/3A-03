import 'package:pabrik_kayu/helpers/database_helper.dart';
import 'package:pabrik_kayu/models/kehadiran_model.dart';

class KehadiranService {
  final db = DatabaseHelper.instance;

  Future<int> save(KehadiranModel kehadiran) async {
    return await db.insert('kehadiran', kehadiran.toMap());
  }

  Future<List<KehadiranModel>> getAll() async {
    final result = await db.getAll('kehadiran');

    return result.map((e) => KehadiranModel.fromMap(e)).toList();
  }

  Future<int> delete(int id) async {
    return await db.delete('kehadiran', id);
  }

  /// JOIN ke employees
  Future<List<Map<String, dynamic>>> getKehadiranWithEmployee() async {
    return await db.rawQuery('''
      SELECT
        kehadiran.id,
        employees.id as employee_id,
        employees.nama,
        employees.jabatan,
        kehadiran.status,
        kehadiran.tanggal,
        kehadiran.jam_masuk
      FROM kehadiran
      INNER JOIN employees
      ON kehadiran.employee_id = employees.id
      ORDER BY kehadiran.id DESC
    ''');
  }
}
