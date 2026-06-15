import 'package:flutter/material.dart';
import 'package:pabrik_kayu/lihat_laporan.dart';
import 'package:pabrik_kayu/services/laporan_service.dart';
import 'package:pabrik_kayu/style.dart';
import 'dart:io';
// Import package baru
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pabrik_kayu/models/laporan_model.dart';

class TambahLaporan extends StatefulWidget {
  const TambahLaporan({super.key});

  @override
  State<TambahLaporan> createState() => _TambahLaporanState();
}

class _TambahLaporanState extends State<TambahLaporan> {
  final laporanService = LaporanService();
  String? selectedJenis;
  String? fotoPath;
  String? filePath;
  String? fileName; // Untuk menampilkan nama file PDF yang dipilih

  final ImagePicker _picker = ImagePicker();

  // Fungsi ambil foto menggunakan image_picker
  Future<void> ambilFoto() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        fotoPath = image.path;
      });
    }
  }

  // Fungsi pilih file PDF menggunakan file_picker
  Future<void> tambahFile() async {
    FilePickerResult? result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'], // Hanya izinkan PDF
    );

    if (result != null) {
      setState(() {
        filePath = result.files.single.path;
        fileName = result.files.single.name;
      });
    }
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
      filePath: filePath, // Bisa null jika tidak wajib
      tanggal: DateTime.now().toString().substring(0, 10), // Format YYYY-MM-DD
    );

    await laporanService.insert(laporan);

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Laporan berhasil disimpan")));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const LihatLaporan(),
      ), // Pastikan nama class-nya sesuai (huruf besar)
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
            ),

            const SizedBox(height: 30),

            _actionButton(
              icon: Icons.camera_alt_outlined,
              label: 'Ambil Foto',
              onTap: ambilFoto,
            ),

            // Preview Foto
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
              icon: Icons.picture_as_pdf,
              label: 'Tambah File PDF',
              onTap: tambahFile,
            ),

            // Indikator File PDF Terpilih
            if (fileName != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "File terpilih: $fileName",
                  style: TextStyle(
                    color: greenColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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

  // (Fungsi buildJenisProduk dan _actionButton TETAP SAMA seperti kode Anda sebelumnya)
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
