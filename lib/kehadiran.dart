import 'package:flutter/material.dart';
import 'package:pabrik_kayu/style.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class Kehadiran extends StatefulWidget {
  const Kehadiran({super.key});

  @override
  State<Kehadiran> createState() => _KehadiranState();
}

class _KehadiranState extends State<Kehadiran> {

  String? selectedKaryawan;
  String? selectedStatus;

  List<String> daftarKaryawan = [];

  final List<String> statusList = [
    "Hadir",
    "Izin",
    "Sakit",
    "Alpha"
  ];

  String tanggal =
      DateTime.now().toString().substring(0,10);

  String jam =
    "${DateTime.now().hour}:${DateTime.now().minute}";

  @override
  void initState() {
    super.initState();

    getKaryawan();
}

Future<void> getKaryawan() async {
  try {
    final db = await openDatabase(
      path.join(await getDatabasesPath(), 'pabrik_kayu_v2.db'),
    );

    final data = await db.query('employees');

    print(  data.toString()+"----------------------fffff----------------------------------");

    setState(() {
      daftarKaryawan = data
          .map((item) => item['nama'].toString())
          .toList();
    });

  } catch (e) {
    print("e");
  }
}
  void simpanAbsensi() {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "$selectedKaryawan berhasil absen",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    print(daftarKaryawan.toString()+"--------------------------------------------------------");

    return Scaffold(
      backgroundColor: cream,

      appBar: AppBar(
        title: Text(
          "Absensi",
          style: TextStyle(
            color: greenColor,
          ),
        ),
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
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
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
              initialValue: selectedStatus,
              decoration: const InputDecoration(
                labelText: "Status",
                border: OutlineInputBorder(),
              ),
              items: statusList.map((item){
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (value){
                setState(() {
                  selectedStatus=value;
                });
              },
            ),

            const SizedBox(height: 15),

            ListTile(
              title: Text("Tanggal"),
              subtitle: Text(tanggal),
            ),

            ListTile(
              title: Text("Jam Masuk"),
              subtitle: Text(jam),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: simpanAbsensi,
                child: const Text(
                  "Absen"
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}