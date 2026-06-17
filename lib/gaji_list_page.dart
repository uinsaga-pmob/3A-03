import 'package:flutter/material.dart';
import 'package:pabrik_kayu/models/employee_model.dart';
import 'package:pabrik_kayu/services/employee_service.dart';
import 'package:pabrik_kayu/style.dart';
import 'package:pabrik_kayu/gaji.dart'; // Import rincian gaji detail
import 'package:intl/intl.dart';

class GajiListPage extends StatefulWidget {
  const GajiListPage({super.key});

  @override
  State<GajiListPage> createState() => _GajiListPageState();
}

class _GajiListPageState extends State<GajiListPage> {
  final EmployeeService employeeService = EmployeeService();
  List<EmployeeModel> employeeList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadEmployees();
  }

  Future<void> loadEmployees() async {
    final data = await employeeService.getAll();
    if (mounted) {
      setState(() {
        employeeList = data;
        isLoading = false;
      });
    }
  }

  String _formatRupiah(int angka) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(angka);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        title: const Text(
          "Daftar Gaji Karyawan",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: CircleAvatar(
          backgroundColor: greenColor,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: cream),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        backgroundColor: greenColor,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : employeeList.isEmpty
          ? const Center(child: Text("Belum ada data gaji karyawan"))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: employeeList.length,
              itemBuilder: (context, index) {
                final employee = employeeList[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: CircleAvatar(
                      backgroundColor: greenColor,
                      child: Text(
                        employee.nama.isNotEmpty
                            ? employee.nama.substring(0, 1).toUpperCase()
                            : "?",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      employee.nama,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          employee.jabatan,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Gaji Pokok: ${_formatRupiah(employee.gaji)}",
                          style: TextStyle(
                            color: greenColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),

                    // DI SINI PROSES KLIK UNTUK MASUK KE RINCIAN INDIVIDU
                    onTap: () {
                      if (employee.id != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                GajiDetailPage(employeeId: employee.id!),
                          ),
                        );
                      }
                    },
                  ),
                );
              },
            ),
    );
  }
}
