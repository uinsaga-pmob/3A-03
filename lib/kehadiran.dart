import 'package:flutter/material.dart';
import 'package:pabrik_kayu/style.dart';
import 'package:pabrik_kayu/models/employee_model.dart';
import 'package:pabrik_kayu/models/kehadiran_model.dart';
import 'package:pabrik_kayu/services/employee_service.dart';
import 'package:pabrik_kayu/services/kehadiran_service.dart';

class Kehadiran extends StatefulWidget {
  const Kehadiran({Key? key}) : super(key: key);

  @override
  State<Kehadiran> createState() => _KehadiranState();
}

class _KehadiranState extends State<Kehadiran> {
  final EmployeeService employeeService = EmployeeService();
  final KehadiranService kehadiranService = KehadiranService();

  List<EmployeeModel> daftarKaryawan = [];
  List<Map<String, dynamic>> daftarKehadiran = [];

  EmployeeModel? selectedKaryawan;
  String? selectedStatus;

  final List<String> statusList = ["Hadir", "Izin", "Sakit", "Alpha"];

  String tanggal = DateTime.now().toString().substring(0, 10);
  String jam = "${DateTime.now().hour}:${DateTime.now().minute}";

  // Tambahan: Indikator loading
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Menggabungkan pemanggilan data agar lebih rapi
  Future<void> _loadData() async {
    setState(() {
      isLoading = true;
    });
    try {
      await getKaryawan();
      await getKehadiran();
    } catch (e) {
      print(
        "Error loading data: $e",
      ); // Cek console jika error database masih ada
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> getKaryawan() async {
    final data = await employeeService.getAll();
    setState(() {
      daftarKaryawan = data;
    });
  }

  Future<void> getKehadiran() async {
    final data = await kehadiranService.getKehadiranWithEmployee();
    setState(() {
      daftarKehadiran = data;
    });
  }

  Future<void> simpanAbsensi() async {
    if (selectedKaryawan == null || selectedStatus == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Pilih karyawan dan status terlebih dahulu"),
        ),
      );
      return;
    }

    final data = KehadiranModel(
      employeeId: selectedKaryawan!.id!,
      status: selectedStatus!,
      tanggal: tanggal,
      jamMasuk: jam,
    );

    try {
      await kehadiranService.save(data);
      await getKehadiran(); // Refresh data

      setState(() {
        selectedKaryawan = null;
        selectedStatus = null;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Absensi berhasil disimpan")),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Gagal menyimpan: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream, // Pastikan variabel color ini ada di style.dart
      appBar: AppBar(
        title: Text(
          "Absensi",
          style: TextStyle(color: greenColor),
        ), // Pastikan greenColor ada
        centerTitle: true,
        leading: CircleAvatar(
          backgroundColor: greenColor,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: cream),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            ) // Muncul saat ambil data
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  DropdownButtonFormField<EmployeeModel>(
                    value: selectedKaryawan,
                    decoration: const InputDecoration(
                      labelText: "Pilih Karyawan",
                      border: OutlineInputBorder(),
                    ),
                    items: daftarKaryawan.map((e) {
                      return DropdownMenuItem<EmployeeModel>(
                        value: e,
                        child: Text(e.nama),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedKaryawan = value;
                      });
                    },
                  ),
                  const SizedBox(height: 15),
                  DropdownButtonFormField<String>(
                    value: selectedStatus,
                    decoration: const InputDecoration(
                      labelText: "Status Kehadiran",
                      border: OutlineInputBorder(),
                    ),
                    items: statusList.map((status) {
                      return DropdownMenuItem<String>(
                        value: status,
                        child: Text(status),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedStatus = value;
                      });
                    },
                  ),
                  const SizedBox(height: 15),
                  ListTile(
                    title: const Text("Tanggal"),
                    subtitle: Text(tanggal),
                  ),
                  ListTile(title: const Text("Jam Masuk"), subtitle: Text(jam)),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: simpanAbsensi,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: greenColor,
                      ),
                      child: const Text(
                        "Absen",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Divider(),
                  const Text(
                    "Data Kehadiran",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  // Perbaikan: Tampilkan pesan jika data kosong
                  Expanded(
                    child: daftarKehadiran.isEmpty
                        ? const Center(child: Text("Belum ada data kehadiran."))
                        : ListView.builder(
                            itemCount: daftarKehadiran.length,
                            itemBuilder: (context, index) {
                              final item = daftarKehadiran[index];
                              return Card(
                                child: ListTile(
                                  leading: const Icon(Icons.person),
                                  // PENTING: Pastikan key map ini (nama, status, tanggal, jam_masuk)
                                  // 100% sama dengan hasil query SELECT Anda di DatabaseHelper.
                                  title: Text(item['nama'] ?? 'Tidak ada nama'),
                                  subtitle: Text(
                                    "${item['status'] ?? '-'} • ${item['tanggal'] ?? '-'}",
                                  ),
                                  trailing: Text(item['jam_masuk'] ?? '-'),
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
