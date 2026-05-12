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

  final TextEditingController namaController = TextEditingController();
  final TextEditingController jabatanController = TextEditingController();
  final TextEditingController gajiController = TextEditingController();

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
    namaController.dispose();
    jabatanController.dispose();
    gajiController.dispose();
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
            nama TEXT,
            jabatan TEXT,
            gaji INTEGER
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

    if (namaController.text.isEmpty ||
        jabatanController.text.isEmpty ||
        gajiController.text.isEmpty) {
      return;
    }

    await database!.insert('employees', {
      'nama': namaController.text,
      'jabatan': jabatanController.text,
      'gaji': int.parse(gajiController.text),
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
        'nama': namaController.text,
        'jabatan': jabatanController.text,
        'gaji': int.parse(gajiController.text),
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
    namaController.clear();
    jabatanController.clear();
    gajiController.clear();
  }

  // =========================
  // DIALOG UPDATE
  // =========================
  void showEditDialog(Map<String, dynamic> employee) {
    namaController.text = employee['nama'];
    jabatanController.text = employee['jabatan'];
    gajiController.text = employee['gaji'].toString();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Edit Data Karyawan"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: namaController,
                decoration: const InputDecoration(labelText: "Nama"),
              ),
              const SizedBox(height: 10),

              TextField(
                controller: jabatanController,
                decoration: const InputDecoration(labelText: "Jabatan"),
              ),
              const SizedBox(height: 10),

              TextField(
                controller: gajiController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Gaji"),
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
        title: const Text("Data Karyawan Pabrik Kayu"),
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
              controller: namaController,
              decoration: const InputDecoration(
                labelText: "Nama Karyawan",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: jabatanController,
              decoration: const InputDecoration(
                labelText: "Jabatan",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: gajiController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Gaji",
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
                    title: Text(employee['nama']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Jabatan : ${employee['jabatan']}"),
                        Text("Gaji : Rp ${employee['gaji']}"),
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
