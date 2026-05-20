import 'package:flutter/material.dart';
import 'package:pabrik_kayu/style.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class EmployeePage extends StatefulWidget {
  const EmployeePage({super.key});

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  Database? database;
  bool isDbReady = false;

  final TextEditingController namaController = TextEditingController();
  final TextEditingController jabatanController = TextEditingController();
  final TextEditingController gajiController = TextEditingController();

  List<Map<String, dynamic>> employeeList = [];

  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  @override
  void dispose() {
    namaController.dispose();
    jabatanController.dispose();
    gajiController.dispose();
    database?.close();
    super.dispose();
  }

  // =========================
  // INIT DATABASE (FIXED)
  // =========================
  Future<void> initDatabase() async {
    database = await openDatabase(
      path.join(await getDatabasesPath(), 'pabrik_kayu_v2.db'), // 🔥 ganti nama DB biar clean
      version: 2,
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
      onUpgrade: (db, oldVersion, newVersion) async {
        await db.execute("DROP TABLE IF EXISTS employees");
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

    isDbReady = true;
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
  // CREATE (FIXED)
  // =========================
  Future<void> addEmployee() async {
    try {
      if (database == null) {
        debugPrint("DATABASE NULL");
        return;
      }

      final nama = namaController.text.trim();
      final jabatan = jabatanController.text.trim();
      final gaji = int.tryParse(gajiController.text.trim());

      if (nama.isEmpty || jabatan.isEmpty || gaji == null) {
        debugPrint("INPUT TIDAK VALID");
        return;
      }

      final id = await database!.insert('employees', {
        'nama': nama,
        'jabatan': jabatan,
        'gaji': gaji,
      });

      debugPrint("INSERT SUCCESS ID: $id");

      clearForm();
      await getEmployees();
    } catch (e) {
      debugPrint("ERROR INSERT: $e");
    }
  }

  // =========================
  // UPDATE (FIXED)
  // =========================
  Future<void> updateEmployee(int id) async {
    try {
      final nama = namaController.text.trim();
      final jabatan = jabatanController.text.trim();
      final gaji = int.tryParse(gajiController.text.trim());

      if (nama.isEmpty || jabatan.isEmpty || gaji == null) return;

      await database!.update(
        'employees',
        {
          'nama': nama,
          'jabatan': jabatan,
          'gaji': gaji,
        },
        where: 'id = ?',
        whereArgs: [id],
      );

      clearForm();
      await getEmployees();

      if (mounted) Navigator.pop(context);
    } catch (e) {
      debugPrint("ERROR UPDATE: $e");
    }
  }

  // =========================
  // DELETE
  // =========================
  Future<void> deleteEmployee(int id) async {
    try {
      await database!.delete(
        'employees',
        where: 'id = ?',
        whereArgs: [id],
      );

      await getEmployees();
    } catch (e) {
      debugPrint("ERROR DELETE: $e");
    }
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
  // EDIT DIALOG
  // =========================
  void showEditDialog(Map<String, dynamic> employee) {
    namaController.text = employee['nama']?.toString() ?? '';
    jabatanController.text = employee['jabatan']?.toString() ?? '';
    gajiController.text = employee['gaji']?.toString() ?? '';

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Edit Karyawan"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: namaController,
                decoration: const InputDecoration(labelText: "Nama"),
              ),
              TextField(
                controller: jabatanController,
                decoration: const InputDecoration(labelText: "Jabatan"),
              ),
              TextField(
                controller: gajiController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Gaji"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                final id = employee['id'];
                if (id != null) {
                  updateEmployee(id);
                }
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }

  // =========================
  // UI (HR CLEAN)
  // =========================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),

      appBar: AppBar(
        title: const Text("Data Karyawan"),
        centerTitle: true,
        backgroundColor: greenColor,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: greenColor,
        onPressed: addEmployee,
        child: const Icon(Icons.add),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // ================= HEADER =================
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
                    "Total Karyawan",
                    style: TextStyle(color: Colors.white70),
                  ),
                  Text(
                    "${employeeList.length}",
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

            // ================= FORM =================
            TextField(
              controller: namaController,
              decoration: const InputDecoration(
                labelText: "Nama",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: jabatanController,
              decoration: const InputDecoration(
                labelText: "Jabatan",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: gajiController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Gaji",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: greenColor,
                ),
                onPressed: addEmployee,
                child: const Text("Tambah Karyawan"),
              ),
            ),

            const SizedBox(height: 20),

            // ================= LIST =================
            Expanded(
              child: ListView.builder(
                itemCount: employeeList.length,
                itemBuilder: (context, index) {
                  final e = employeeList[index];

                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: greenColor,
                        child: Text(
                          (e['nama'] ?? '-')[0].toString().toUpperCase(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(e['nama']?.toString() ?? '-'),
                      subtitle: Text(
                        "${e['jabatan']} • Rp ${e['gaji']}",
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => showEditDialog(e),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              final id = e['id'];
                              if (id != null) deleteEmployee(id);
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