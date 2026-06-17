import 'package:flutter/material.dart';
import 'package:pabrik_kayu/lihat_laporan.dart';
import 'package:pabrik_kayu/style.dart';
import 'package:pabrik_kayu/tambah_laporan.dart';
import 'package:pabrik_kayu/services/laporan_service.dart';

class Laporan extends StatefulWidget {
  const Laporan({super.key});

  @override
  State<Laporan> createState() => _LaporanState();
}

class _LaporanState extends State<Laporan> {
  final laporanService = LaporanService();

  int totalMasuk = 0;

  double katulPersen = 0;
  double kayuLapisPersen = 0;
  double tongkatPersen = 0;

  @override
  void initState() {
    super.initState();
    loadStatistik();
  }

  Future<void> loadStatistik() async {
    final total = await laporanService.getTotalLaporan();

    final kategori = await laporanService.getKategoriCount();

    if (total == 0) {
      setState(() {
        totalMasuk = 0;
      });
      return;
    }

    setState(() {
      totalMasuk = total;

      katulPersen = ((kategori["Katul"] ?? 0) / total) * 100;

      kayuLapisPersen = ((kategori["Kayu Lapis"] ?? 0) / total) * 100;

      tongkatPersen = ((kategori["Tongkat"] ?? 0) / total) * 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      appBar: AppBar(
        title: Text("Input Kayu", style: TextStyle(color: greenColor)),
        centerTitle: true,
        leading: CircleAvatar(
          backgroundColor: greenColor,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: cream),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 184,
            width: 337,
            decoration: BoxDecoration(
              color: greenColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Produksi Hari Ini",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        height: 28,
                        width: 67,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                        child: Center(
                          child: Text(
                            "Aktif",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(height: 25),
                  Column(
                    children: [
                      Text(
                        totalMasuk.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 52,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Total Masuk",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  // Column(
                  //   children: [
                  //     Text(
                  //       "2",
                  //       style: TextStyle(
                  //         color: Colors.white,
                  //         fontSize: 24,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //     Text(
                  //       "Proses",
                  //       style: TextStyle(color: Colors.white, fontSize: 15),
                  //     ),
                  //   ],
                  // ),
                  // Column(
                  //   children: [
                  //     Text(
                  //       "80%",
                  //       style: TextStyle(
                  //         color: Colors.white,
                  //         fontSize: 24,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //     Text(
                  //       "Presentase",
                  //       style: TextStyle(color: Colors.white, fontSize: 15),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
          SizedBox(height: 45),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 35),
                child: Text(
                  "Kategori Keluaran",
                  style: TextStyle(
                    color: greenColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Containerlaporan(
            title: "Katul",
            subtitle: "Serutan Kayu dan Serbuk Gergaji",
            presentase: "${katulPersen.toStringAsFixed(1)}%",
          ),

          Containerlaporan(
            title: "Kayu Lapis",
            subtitle: "Lembaran Kayu",
            presentase: "${kayuLapisPersen.toStringAsFixed(1)}%",
          ),
          Containerlaporan(
            title: "Tongkat",
            subtitle: "Batang Tengah Sisa Pemotongan",
            presentase: "${tongkatPersen.toStringAsFixed(1)}%",
          ),

          SizedBox(height: 35),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 35),
                child: Text(
                  "Laporan",
                  style: TextStyle(
                    color: greenColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 30),
                child: ElevatedButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TambahLaporan(),
                      ),
                    );

                    loadStatistik(); // refresh setelah kembali
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: greenColor,
                    padding: EdgeInsets.all(12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(15),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.add, size: 25, color: Colors.white),
                      Text(
                        "Tambah Laporan",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LihatLaporan()),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: greenColor,
                  padding: EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(15),
                  ),
                ),
                child: Text(
                  "Lihat laporan",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Containerlaporan extends StatelessWidget {
  final String title;
  final String subtitle;
  final String presentase;
  const Containerlaporan({
    required this.title,
    required this.subtitle,
    required this.presentase,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 73,
      width: 337,
      decoration: BoxDecoration(
        color: const Color.fromARGB(139, 0, 0, 0),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ],
            ),
            SizedBox(width: 30),
            Container(
              height: 39,
              width: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.white, width: 1),
              ),
              child: Center(
                child: Text(
                  presentase,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
