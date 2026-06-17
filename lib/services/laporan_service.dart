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

  Future<int> getTotalLaporan() async {
    final result = await dbHelper.rawQuery(
      "SELECT COUNT(*) as total FROM laporan",
    );

    return result.first["total"] as int;
  }

  Future<int> getTotalHariIni() async {
    final today = DateTime.now().toString().substring(0, 10);

    final result = await dbHelper.rawQuery(
      '''
      SELECT COUNT(*) as total
      FROM laporan
      WHERE substr(tanggal,1,10) = ?
      ''',
      [today],
    );

    return result.first['total'] as int;
  }

  Future<Map<String, int>> getKategoriCount() async {
    final result = await dbHelper.rawQuery('''
    SELECT jenis_produk, COUNT(*) as total
    FROM laporan
    GROUP BY jenis_produk
  ''');

    Map<String, int> data = {};

    for (var item in result) {
      data[item['jenis_produk'].toString()] = item['total'] as int;
    }

    return data;
  }
}
