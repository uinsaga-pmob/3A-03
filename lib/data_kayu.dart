import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';


class KayuPage extends StatefulWidget {
  const KayuPage({super.key});

  @override
  State<KayuPage> createState() => _KayuPageState();
}

class _KayuPageState extends State<KayuPage> {
  Database? database;

  final TextEditingController namakayuController = TextEditingController();
  final TextEditingController kategoriController = TextEditingController();
  final TextEditingController stokController = TextEditingController();

  List<Map<String, dynamic>> kayuList = [];

  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  // =========================
  // DISPOSE
  // =========================
  @override
  void dispose() {
    namakayuController.dispose();
    kategoriController.dispose();
    stokController.dispose();
    database?.close();
    super.dispose();
  }

  // =========================
  // INIT DATABASE
  // =========================
 Future<void> initDatabase() async {
  database = await openDatabase(
    path.join(await getDatabasesPath(), 'pabrik_kayu.db'),
    version: 2,
    onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS kayu(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          namakayu TEXT,
          kategori TEXT,
          stok INTEGER
        )
      ''');
    },
    onUpgrade: (db, oldVersion, newVersion) async {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS kayu(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          namakayu TEXT,
          kategori TEXT,
          stok INTEGER
        )
      ''');
    },
  );

  await getkayu();
}

  // =========================
  // CREATE
  // =========================
  Future<void> addkayu() async {
    if (database == null) return;

    if (namakayuController.text.isEmpty ||
        kategoriController.text.isEmpty ||
        stokController.text.isEmpty) {
      return;
    }

    await database!.insert('kayu', {
      'namakayu': namakayuController.text,
      'kategori': kategoriController.text,
      'stok': int.parse(stokController.text),
    });

    clearForm();
    await getkayu();
  }

  // =========================
  // READ
  // =========================
  Future<void> getkayu() async {
    if (database == null) return;

    final data = await database!.query('kayu');

    if (mounted) {
      setState(() {
        kayuList = data;
      });
    }
  }

  // =========================
  // UPDATE
  // =========================
  Future<void> updatekayu(int id) async {
    if (database == null) return;

    await database!.update(
      'kayu',
      {
        'namakayu': namakayuController.text,
        'kategori': kategoriController.text,
        'stok': int.parse(stokController.text),
      },
      where: 'id = ?',
      whereArgs: [id],
    );

    clearForm();
    await getkayu();

    if (mounted) {
      Navigator.pop(context);
    }
  }

  // =========================
  // DELETE
  // =========================
  Future<void> deletekayu(int id) async {
    if (database == null) return;

    await database!.delete('kayu', where: 'id = ?', whereArgs: [id]);

    await getkayu();
  }

  // =========================
  // CLEAR FORM
  // =========================
  void clearForm() {
    namakayuController.clear();
    kategoriController.clear();
    stokController.clear();
  }

  // =========================
  // DIALOG UPDATE
  // =========================
  void showEditDialog(Map<String, dynamic> kayu) {
    namakayuController.text = kayu['namakayu'];
    kategoriController.text = kayu['kategori'];
    stokController.text = kayu['stok'].toString();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Edit Kayu"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: namakayuController,
                decoration: const InputDecoration(labelText: "Nama"),
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
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                updatekayu(kayu['id']);
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Kayu Pabrik Kayu"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // =========================
            // FORM INPUT
            // =========================
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
                onPressed: addkayu,
                child: const Text("Tambah Data"),
              ),
            ),

            const SizedBox(height: 20),

            // =========================
            // LIST DATA
            // =========================
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: kayuList.length,
              itemBuilder: (context, index) {
                final kayu = kayuList[index];

                return Card(
                  child: ListTile(
                    title: Text(kayu['namakayu']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Kategori : ${kayu['kategori']}"),
                        Text("Stok : ${kayu['stok']}"),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            showEditDialog(kayu);
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            deletekayu(kayu['id']);
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
