import '../models/wood_model.dart';
import '../services/wood_service.dart';

final WoodService woodService = WoodService();

List<Wood> woodList = [];

int totalStock = 0;

// Load data from service and update local variables
Future<void> loadData() async {
  final data = await woodService.getAll();
  final stock = await woodService.totalStock();
  woodList = data;
  totalStock = stock;
}

// Add a new wood entry using provided values
Future<void> addWood({
  required String namaKayu,
  required String kategori,
  required int stok,
}) async {
  await woodService.insert(
    Wood(namaKayu: namaKayu, kategori: kategori, stok: stok),
  );
  await loadData();
}

// Update existing wood by id
Future<void> updateWood(
  int id, {
  required String namaKayu,
  required String kategori,
  required int stok,
}) async {
  await woodService.update(
    Wood(id: id, namaKayu: namaKayu, kategori: kategori, stok: stok),
  );
  await loadData();
}

// Delete wood by id
Future<void> deleteWood(int id) async {
  await woodService.delete(id);
  await loadData();
}

// Helper getter for item count
int get itemCount => woodList.length;
