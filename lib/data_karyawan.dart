import 'package:flutter/material.dart';
import 'package:pabrik_kayu/models/employee_model.dart';
import 'package:pabrik_kayu/services/employee_service.dart';
import 'package:pabrik_kayu/style.dart';
import 'package:pabrik_kayu/gaji.dart'; // Tetap mengimpor gaji.dart

class EmployeePage extends StatefulWidget {
  const EmployeePage({super.key});

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  final EmployeeService employeeService = EmployeeService();

  final TextEditingController namaController = TextEditingController();
  final TextEditingController jabatanController = TextEditingController();
  final TextEditingController gajiController = TextEditingController();

  List<EmployeeModel> employeeList = [];

  @override
  void initState() {
    super.initState();
    loadEmployees();
  }

  @override
  void dispose() {
    namaController.dispose();
    jabatanController.dispose();
    gajiController.dispose();
    super.dispose();
  }

  Future<void> loadEmployees() async {
    final data = await employeeService.getAll();

    if (mounted) {
      setState(() {
        employeeList = data;
      });
    }
  }

  Future<void> addEmployee() async {
    final nama = namaController.text.trim();
    final jabatan = jabatanController.text.trim();
    final gaji = int.tryParse(gajiController.text.trim());

    if (nama.isEmpty || jabatan.isEmpty || gaji == null) {
      return;
    }

    await employeeService.save(
      EmployeeModel(nama: nama, jabatan: jabatan, gaji: gaji),
    );

    clearForm();
    await loadEmployees();
  }

  Future<void> updateEmployee(int id) async {
    final nama = namaController.text.trim();
    final jabatan = jabatanController.text.trim();
    final gaji = int.tryParse(gajiController.text.trim());

    if (nama.isEmpty || jabatan.isEmpty || gaji == null) {
      return;
    }

    await employeeService.update(
      EmployeeModel(id: id, nama: nama, jabatan: jabatan, gaji: gaji),
    );

    clearForm();
    await loadEmployees();

    if (mounted) {
      Navigator.pop(context);
    }
  }

  Future<void> deleteEmployee(int id) async {
    await employeeService.delete(id);
    await loadEmployees();
  }

  void clearForm() {
    namaController.clear();
    jabatanController.clear();
    gajiController.clear();
  }

  void showEditDialog(EmployeeModel employee) {
    namaController.text = employee.nama;
    jabatanController.text = employee.jabatan;
    gajiController.text = employee.gaji.toString();

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
                clearForm();
              },
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                updateEmployee(employee.id!);
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
      backgroundColor: cream,
      appBar: AppBar(
        title: const Text(
          "Data Karyawan",
          style: TextStyle(color: Colors.white),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: greenColor,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: cream),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
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
                style: ElevatedButton.styleFrom(backgroundColor: greenColor),
                onPressed: addEmployee,
                child: const Text(
                  "Tambah Karyawan",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: employeeList.isEmpty
                  ? const Center(child: Text("Belum ada data karyawan"))
                  : ListView.builder(
                      itemCount: employeeList.length,
                      itemBuilder: (context, index) {
                        final employee = employeeList[index];

                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: greenColor,
                              child: Text(
                                employee.nama.isNotEmpty
                                    ? employee.nama
                                          .substring(0, 1)
                                          .toUpperCase()
                                    : "?",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            title: Text(employee.nama),
                            subtitle: Text(
                              "${employee.jabatan} • Rp ${employee.gaji}",
                            ),

                            // PERBAIKAN NAVIGASI DI SINI: Menggunakan GajiDetailPage
                            onTap: () {
                              if (employee.id != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GajiDetailPage(
                                      employeeId: employee.id!,
                                    ),
                                  ),
                                );
                              }
                            },

                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.orange,
                                  ),
                                  onPressed: () => showEditDialog(employee),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () => deleteEmployee(employee.id!),
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
