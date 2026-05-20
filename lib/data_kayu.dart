import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';


class EmployeePage extends StatefulWidget {
  const EmployeePage({super.key});

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  Database? database;

  final TextEditingController namakayuController = TextEditingController();
  final TextEditingController kategoriController = TextEditingController();
  final TextEditingController stokController = TextEditingController();

  List<Map<String, dynamic>> employeeList = [];

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
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE employees(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            namakayu TEXT,
            kategori TEXT,
            stok INTEGER
          )
        ''');
      },
    );

    await getEmployees();
  }

  // =========================
  // CREATE
  // =========================
  Future<void> addEmployee() async {
    if (database == null) return;

    if (namakayuController.text.isEmpty ||
        kategoriController.text.isEmpty ||
        stokController.text.isEmpty) {
      return;
    }

    await database!.insert('employees', {
      'namakayu': namakayuController.text,
      'kategori': kategoriController.text,
      'stok': int.parse(stokController.text),
    });

    clearForm();
    await getEmployees();
  }

  // =========================
  // READ
  // =========================
  Future<void> getEmployees() async {
    if (database == null) return;

    final data = await database!.query('employees');

    if (mounted) {
      setState(() {
        employeeList = data;
      });
    }
  }

  // =========================
  // UPDATE
  // =========================
  Future<void> updateEmployee(int id) async {
    if (database == null) return;

    await database!.update(
      'employees',
      {
        'namakayu': namakayuController.text,
        'kategori': kategoriController.text,
        'stok': int.parse(stokController.text),
      },
      where: 'id = ?',
      whereArgs: [id],
    );

    clearForm();
    await getEmployees();

    if (mounted) {
      Navigator.pop(context);
    }
  }

  // =========================
  // DELETE
  // =========================
  Future<void> deleteEmployee(int id) async {
    if (database == null) return;

    await database!.delete('employees', where: 'id = ?', whereArgs: [id]);

    await getEmployees();
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
  void showEditDialog(Map<String, dynamic> employee) {
    namakayuController.text = employee['namakayu'];
    kategoriController.text = employee['kategori'];
    stokController.text = employee['stok'].toString();

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
                updateEmployee(employee['id']);
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
                onPressed: addEmployee,
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
              itemCount: employeeList.length,
              itemBuilder: (context, index) {
                final employee = employeeList[index];

                return Card(
                  child: ListTile(
                    title: Text(employee['namakayu']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Kategori : ${employee['kategori']}"),
                        Text("Stok : ${employee['stok']}"),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            showEditDialog(employee);
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            deleteEmployee(employee['id']);
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
