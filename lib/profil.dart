import 'package:flutter/material.dart';
import 'package:pabrik_kayu/style.dart';

void main() {
  runApp(Profil());
}

class Profil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Profil")),
        body: Column(
          children: [
            Center(
              child: Container(
                height: 221,
                width: 337,
                decoration: BoxDecoration(
                  color: greenColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Nama Pengguna",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Angkaa", style: TextStyle(color: Colors.white)),
                        Text(
                          "Presentase",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text("Rating", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40),
            Containerpropil(title: "Data Pribadi", subtitle: "lihat dan sunting informasi pribadi"),
            Containerpropil(title: "Kehadiran", subtitle: "Jam kerja dan kehadiran "),
            Containerpropil(title: "Kinerja", subtitle: "Kinerja Harian"),
            Containerpropil(title: "Aktifitas", subtitle: "Kegiatan"),
          ],
        ),
      ),
    );
  }
}

class Containerpropil extends StatelessWidget {
  final String title ;
  final String subtitle ;
  const Containerpropil({ required this.title, required this.subtitle,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
    );
  }
}
