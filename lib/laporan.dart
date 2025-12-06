import 'package:flutter/material.dart';
import 'package:pabrik_kayu/data_pribadi.dart';
import 'package:pabrik_kayu/lihat_laporan.dart';
import 'package:pabrik_kayu/style.dart';
import 'package:pabrik_kayu/tambah_laporan.dart';

class Laporan extends StatelessWidget {
  const Laporan({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Laporan")),
      body: Column(
        children: [
          Container(
            height: 184,
            width: 337,
            decoration: BoxDecoration(
              color: greenColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Produksi Hari Ini",
                      style: TextStyle(color: Colors.white, fontSize: 24),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Angkaa", style: TextStyle(color: Colors.white)),
                    Text("Presentase", style: TextStyle(color: Colors.white)),
                    Text("Rating", style: TextStyle(color: Colors.white)),
                  ],
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
          SizedBox(height: 40),
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DataPribadi()),
            ),
            child: Containerlaporan(
              title: "Data Pribadi",
              subtitle: "lihat dan sunting informasi pribadi",
            ),
          ),

          Containerlaporan(
            title: "Kehadiran",
            subtitle: "Jam kerja dan kehadiran ",
          ),
          Containerlaporan(title: "Kinerja", subtitle: "Kinerja Harian"),

          SizedBox(height: 40),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 30),
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TambahLaporan()),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: greenColor,
                    padding: EdgeInsets.all(12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(15),
                    ),
                  ),
                  child: Text(
                    "Tambah Laporan",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => lihat_laporan()),
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
  const Containerlaporan({
    required this.title,
    required this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 73,
      width: 337,
      decoration: BoxDecoration(
        color: greenColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
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
            Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
