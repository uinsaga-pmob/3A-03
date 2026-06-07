import 'package:flutter/material.dart';
import 'package:pabrik_kayu/models/wood_model.dart';
import 'package:pabrik_kayu/services/wood_service.dart';
import 'package:pabrik_kayu/style.dart';

class DataKayu extends StatefulWidget {
  const DataKayu({super.key});

  @override
  State<DataKayu> createState() => _DataKayuState();
}

class _DataKayuState extends State<DataKayu> {
  final WoodService woodService = WoodService();

  final TextEditingController namakayuController = TextEditingController();

  final TextEditingController kategoriController = TextEditingController();

  final TextEditingController stokController = TextEditingController();

  List<Wood> woodList = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    namakayuController.dispose();
    kategoriController.dispose();
    stokController.dispose();
    super.dispose();
  }

  Future<void> loadData() async {
    final data = await woodService.getAll();

    if (!mounted) return;

    setState(() {
      woodList = data;
    });
  }

  Future<void> addWood() async {
    final namaKayu = namakayuController.text.trim();

    final kategori = kategoriController.text.trim();

    final stok = int.tryParse(stokController.text.trim());

    if (namaKayu.isEmpty || kategori.isEmpty || stok == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Semua field wajib diisi dan stok harus berupa angka"),
        ),
      );
      return;
    }

    await woodService.insert(
      Wood(namaKayu: namaKayu, kategori: kategori, stok: stok),
    );

    clearForm();

    await loadData();

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Data berhasil ditambahkan")));
  }

  Future<void> updateWood(int id) async {
    final namaKayu = namakayuController.text.trim();

    final kategori = kategoriController.text.trim();

    final stok = int.tryParse(stokController.text.trim());

    if (namaKayu.isEmpty || kategori.isEmpty || stok == null) {
      return;
    }

    await woodService.update(
      Wood(id: id, namaKayu: namaKayu, kategori: kategori, stok: stok),
    );

    clearForm();

    await loadData();

    if (mounted) {
      Navigator.pop(context);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Data berhasil diupdate")));
    }
  }

  Future<void> deleteWood(int id) async {
    await woodService.delete(id);

    await loadData();

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Data berhasil dihapus")));
  }

  void clearForm() {
    namakayuController.clear();
    kategoriController.clear();
    stokController.clear();
  }

  void showEditDialog(Wood wood) {
    namakayuController.text = wood.namaKayu;

    kategoriController.text = wood.kategori;

    stokController.text = wood.stok.toString();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Edit Data Kayu"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: namakayuController,
                  decoration: const InputDecoration(labelText: "Nama Kayu"),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: kategoriController,
                  decoration: const InputDecoration(labelText: "Kategori"),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: stokController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Stok"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                updateWood(wood.id!);
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }

  void showDeleteDialog(Wood wood) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Hapus Data"),
          content: Text("Yakin ingin menghapus ${wood.namaKayu} ?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);

                await deleteWood(wood.id!);
              },
              child: const Text("Hapus"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),

      appBar: AppBar(
        title: const Text("Data Kayu Pabrik Kayu"),
        centerTitle: true,
        backgroundColor: greenColor,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: greenColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Total Jenis Kayu",
                    style: TextStyle(color: Colors.white70),
                  ),
                  Text(
                    "${woodList.length}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: namakayuController,
              decoration: const InputDecoration(
                labelText: "Nama Kayu",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: kategoriController,
              decoration: const InputDecoration(
                labelText: "Kategori",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: stokController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Stok",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: greenColor),
                onPressed: addWood,
                child: const Text("Tambah Data Kayu"),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: woodList.length,
                itemBuilder: (context, index) {
                  final wood = woodList[index];

                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: greenColor,
                        child: Text(
                          wood.namaKayu.substring(0, 1).toUpperCase(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(wood.namaKayu),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Kategori : ${wood.kategori}"),
                          Text("Stok : ${wood.stok}"),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              showEditDialog(wood);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              showDeleteDialog(wood);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
