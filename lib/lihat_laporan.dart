import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pabrik_kayu/models/laporan_model.dart';
import 'package:pabrik_kayu/services/laporan_service.dart';
import 'package:pabrik_kayu/style.dart';
import 'package:open_file/open_file.dart';

class LihatLaporan extends StatefulWidget {
  const LihatLaporan({super.key});

  @override
  State<LihatLaporan> createState() => _LihatLaporanState();
}

class _LihatLaporanState extends State<LihatLaporan> {
  final LaporanService laporanService = LaporanService();
  List<LaporanModel> daftarLaporan = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });
    try {
      // Pastikan Anda sudah punya method getAll() di LaporanService
      final data = await laporanService.getAll();
      setState(() {
        daftarLaporan = data;
      });
    } catch (e) {
      print("Error ambil laporan: $e");
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // Fungsi membuka file PDF
  Future<void> bukaFilePDF(String? path) async {
    if (path == null || path.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Tidak ada file PDF terlampir")),
      );
      return;
    }

    final result = await OpenFile.open(path);
    if (result.type != ResultType.done) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal membuka file: ${result.message}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      appBar: AppBar(
        title: const Text('Lihat Laporan'),
        titleTextStyle: TextStyle(
          color: greenColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: greenColor), // Warna tombol back
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : daftarLaporan.isEmpty
          ? const Center(child: Text("Belum ada data laporan"))
          : ListView.separated(
              itemCount: daftarLaporan.length,
              separatorBuilder: (context, index) =>
                  const Divider(color: Colors.black, height: 1),
              itemBuilder: (context, index) {
                final laporan = daftarLaporan[index];

                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  tileColor: greenColor, // 0xff386745
                  // Menampilkan gambar dari path lokal perangkat
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                        child: (laporan.foto != null && laporan.foto!.isNotEmpty && File(laporan.foto!).existsSync())
                            ? Image.file(File(laporan.foto!), fit: BoxFit.cover)
                          : const Icon(Icons.broken_image, color: Colors.grey),
                    ),
                  ),
                  title: Text(
                    laporan.jenisProduk,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    laporan.tanggal,
                    style: const TextStyle(color: Colors.white70),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
                    tooltip: "Buka PDF",
                    onPressed: () => bukaFilePDF(laporan.filePath),
                  ),
                );
              },
            ),
    );
  }
}
