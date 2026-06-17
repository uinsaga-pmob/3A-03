import 'package:flutter/material.dart';
import 'package:pabrik_kayu/services/laporan_service.dart';
import 'package:pabrik_kayu/gaji_list_page.dart';
import 'package:pabrik_kayu/laporan.dart';
import 'package:pabrik_kayu/profil.dart';
import 'package:pabrik_kayu/style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final laporanService = LaporanService();

  int totalInputHariIni = 0;
  Future<void> loadDashboard() async {
    final total = await laporanService.getTotalHariIni();

    if (!mounted) return;

    setState(() {
      totalInputHariIni = total;
    });
  }

  @override
  void initState() {
    super.initState();
    loadDashboard();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      appBar: AppBar(
        title: Text(
          'PT. Genk Solo Sukses',
          style: TextStyle(color: greenColor),
        ),
        backgroundColor: cream,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 90,
                    width: 180,
                    decoration: BoxDecoration(
                      color: greenColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Input Hari ini",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          Text(
                            totalInputHariIni.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 20),
                  Text(
                    "Main Menu",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: greenColor,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  // 1. MENU KARYAWAN: Diarahkan ke EmployeePage (Data Karyawan)
                  InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Profil()),
                    ),
                    child: const Containerhome(
                      title: "Karyawan",
                      subtitle: "Data Karyawan & Kehadiran Karyawan",
                    ),
                  ),

                  // 2. MENU LAPORAN
                  InkWell(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Laporan(),
                        ),
                      );

                      loadDashboard();
                    },
                    child: const Containerhome(
                      title: "Laporan",
                      subtitle: "Katul, Kayu Lapis, Tongkat",
                    ),
                  ),

                  // 3. MENU GAJI: Diarahkan ke GajiListPage
                  InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GajiListPage(),
                      ),
                    ),
                    child: const Containerhome(
                      title: "Gaji",
                      subtitle: "Manajemen Pembayaran Gaji ",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Containerhome extends StatelessWidget {
  final String title;
  final String subtitle;
  const Containerhome({required this.title, required this.subtitle, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      height: 73,
      width: 337,
      decoration: BoxDecoration(
        color: greenColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
