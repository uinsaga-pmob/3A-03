import 'package:flutter/material.dart';
import 'package:pabrik_kayu/data_pribadi.dart';
import 'package:pabrik_kayu/kehadiran.dart';
import 'package:pabrik_kayu/kinerja.dart';
import 'package:pabrik_kayu/style.dart';

class Profil extends StatelessWidget {
  const Profil({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      appBar: AppBar(
        title: Text("Profil", style: TextStyle(color: greenColor)),
        centerTitle: true,
        leading: CircleAvatar(
          backgroundColor: greenColor,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: cream),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 221,
              width: 337,
              decoration: BoxDecoration(
                color: greenColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(radius: 55),
                  Text(
                    "Nama Pengguna",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(height: 20),
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
              child: Containerpropil(
                title: "Data Pribadi",
                subtitle: "lihat dan sunting informasi pribadi",
              ),
            ),
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Kehadiran()),
              ),
              child: Containerpropil(
                title: "Kehadiran",
                subtitle: "Jam kerja dan kehadiran ",
              ),
            ),
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Kinerja()),
              ),
              child: Containerpropil(
                title: "Kinerja",
                subtitle: "Kinerja Harian",
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class Containerpropil extends StatelessWidget {
  final String title;
  final String subtitle;
  const Containerpropil({
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
