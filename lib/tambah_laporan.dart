import 'package:flutter/material.dart';
import 'package:pabrik_kayu/lihat_laporan.dart';
import 'package:pabrik_kayu/services/laporan_service.dart';
import 'package:pabrik_kayu/style.dart';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:pabrik_kayu/models/laporan_model.dart';

class TambahLaporan extends StatefulWidget {
  const TambahLaporan({super.key});

  @override
  State<TambahLaporan> createState() => _TambahLaporanState();
}

class _TambahLaporanState extends State<TambahLaporan> {
  // buat agar mewarisi fungsi database helper, service, models
  final laporanService = LaporanService();

  String? selectedJenis;

  String? fotoPath;

  String? filePath;

  Future<void> ambilFoto() async {
    final cameras = await availableCameras();

    final camera = cameras.first;

    final controller = CameraController(camera, ResolutionPreset.medium);

    await controller.initialize();

    final image = await controller.takePicture();

    await controller.dispose();

    setState(() {
      fotoPath = image.path;
    });
  }

  Future<void> simpanLaporan() async {
    if (selectedJenis == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Pilih jenis produk")));
      return;
    }

    if (fotoPath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Ambil foto terlebih dahulu")),
      );
      return;
    }

    final laporan = LaporanModel(
      jenisProduk: selectedJenis!,
      foto: fotoPath!,
      filePath: filePath,
      tanggal: DateTime.now().toString(),
    );

    await laporanService.insert(laporan);

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Laporan berhasil disimpan")));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => lihat_laporan()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      appBar: AppBar(
        title: Text("Tambah Laporan", style: TextStyle(color: greenColor)),
        centerTitle: true,
        leading: CircleAvatar(
          backgroundColor: greenColor,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: cream),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            buildJenisProduk(
              value: "Katul",
              title: "Katul",
              imagePath: "assets/logo katul.png",
            ),

            const SizedBox(height: 14),

            buildJenisProduk(
              value: "Kayu Lapis",
              title: "Kayu Lapis",
              imagePath: "assets/logo kayu,triplek.png",
            ),

            const SizedBox(height: 14),

            buildJenisProduk(
              value: "Tongkat",
              title: "Tongkat",
              imagePath: "assets/logo kayu bulet.png",
            ), //ini tongkat
            const SizedBox(height: 30),

            _actionButton(
              icon: Icons.camera_alt_outlined,
              label: 'Ambil Foto',
              onTap: ambilFoto,
            ),
            if (fotoPath != null)
              Container(
                margin: const EdgeInsets.only(top: 15),
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: greenColor),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(File(fotoPath!), fit: BoxFit.cover),
                ),
              ),

            const SizedBox(height: 16),

            _actionButton(
              icon: Icons
                  .insert_drive_file_outlined, //buat agar bisa mengupload data dari file manager. masuk ke database laporan
              label: 'Tambah File',
              onTap: () {},
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: 160,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: greenColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: simpanLaporan,
                child: const Text(
                  'Kirim',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildJenisProduk({
    required String value,
    required String title,
    required String imagePath,
  }) {
    final bool isSelected = selectedJenis == value;

    return InkWell(
      onTap: () {
        setState(() {
          selectedJenis = value;
        });
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: greenColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? const Color.fromARGB(255, 0, 189, 41)
                : Colors.transparent,
            width: 3,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: cream,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(imagePath, fit: BoxFit.contain),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Radio<String>(
              value: value,
              groupValue: selectedJenis,
              activeColor: const Color.fromARGB(255, 28, 255, 7),
              fillColor: WidgetStateProperty.all(Colors.white),
              onChanged: (value) {
                setState(() {
                  selectedJenis = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: greenColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(height: 4),
              Text(label, style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
