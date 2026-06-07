import 'package:flutter/material.dart';
import 'package:pabrik_kayu/style.dart';
import 'package:pabrik_kayu/services/kehadiran_service.dart';
import 'package:pabrik_kayu/models/kehadiran_model.dart';

class Kehadiran extends StatefulWidget {
  const Kehadiran({super.key});

  @override
  State<Kehadiran> createState() => _KehadiranState();
}

class _KehadiranState extends State<Kehadiran> {
  String? selectedKaryawan;
  String? selectedStatus;

  List<String> daftarKaryawan = [];

  final kehadiranService = KehadiranService();
  final List<String> statusList = ["Hadir", "Izin", "Sakit", "Alpha"];

  String tanggal = DateTime.now().toString().substring(0, 10);

  String jam = "${DateTime.now().hour}:${DateTime.now().minute}";

  @override
  void initState() {
    super.initState();

    getKaryawan();
  }

  Future<void> getKaryawan() async {
    final data = await KehadiranService.getAll();

    setState(() {
      daftarKaryawan = List<String>.from(data);
    });
  }

  Future<void> simpanAbsensi() async {
    if (selectedKaryawan == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Pilih karyawan terlebih dahulu")),
      );
      return;
    }

    if (selectedStatus == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Pilih status kehadiran")));
      return;
    }

    final kehadiran = KehadiranModel(
      namaKaryawan: selectedKaryawan!,
      status: selectedStatus!,
      tanggal: tanggal,
      jamMasuk: jam,
    );

    await kehadiranService.save(kehadiran);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("$selectedKaryawan berhasil disimpan")),
    );

    setState(() {
      selectedKaryawan = null;
      selectedStatus = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(
      daftarKaryawan.toString() +
          "--------------------------------------------------------",
    );

    return Scaffold(
      backgroundColor: cream,

      appBar: AppBar(
        title: Text("Absensi", style: TextStyle(color: greenColor)),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            DropdownButtonFormField<String>(
              initialValue: selectedKaryawan,
              decoration: const InputDecoration(
                labelText: "Pilih Karyawan",
                border: OutlineInputBorder(),
              ),
              items: daftarKaryawan.map((item) {
                return DropdownMenuItem<String>(value: item, child: Text(item));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedKaryawan = value;
                });
              },
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              initialValue: selectedStatus,
              decoration: const InputDecoration(
                labelText: "Status",
                border: OutlineInputBorder(),
              ),
              items: statusList.map((item) {
                return DropdownMenuItem(value: item, child: Text(item));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedStatus = value;
                });
              },
            ),

            const SizedBox(height: 15),

            ListTile(title: Text("Tanggal"), subtitle: Text(tanggal)),

            ListTile(title: Text("Jam Masuk"), subtitle: Text(jam)),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: simpanAbsensi,
                child: const Text("Absen"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
