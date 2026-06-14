import '../helpers/database_helper.dart';
import '../models/laporan_model.dart';

class LaporanService {
  final dbHelper = DatabaseHelper.instance;

  Future<int> insert(LaporanModel laporan) async {
    return await dbHelper.insert('laporan', laporan.toMap());
  }

  Future<List<LaporanModel>> getAll() async {
    final result = await dbHelper.getAll('laporan');

    return result.map((e) => LaporanModel.fromMap(e)).toList();
  }

  Future<int> delete(int id) async {
    return await dbHelper.delete('laporan', id);
  }
}
