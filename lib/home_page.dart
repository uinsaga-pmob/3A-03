import 'package:flutter/material.dart';
import 'package:pabrik_kayu/gaji.dart';
import 'package:pabrik_kayu/laporan.dart';
import 'package:pabrik_kayu/profil.dart';
import 'package:pabrik_kayu/style.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _homepagestate();
}

class _homepagestate extends State<HomePage> {
  @override
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(),
              title: Text("Profesi"),
              subtitle: Text("Username"),
              titleTextStyle: TextStyle(
                color: greenColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              subtitleTextStyle: TextStyle(
                color: greenColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 72,
                  width: 153,
                  decoration: BoxDecoration(
                    color: greenColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Input Hari ini",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        Text(
                          "10",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 30),
                Container(
                  height: 72,
                  width: 150,
                  decoration: BoxDecoration(
                    color: greenColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Pendapatan Bulanan",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        Text(
                          "3.000.000",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 20),
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
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Profil()),
                  ),
                  child: Containerhome(
                    title: "Profile",
                    subtitle: "Data Pribadi, Kehadiran, Tarif",
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Laporan()),
                  ),
                  child: Containerhome(
                    title: "Laporan",
                    subtitle: "Katul, Kayu Lapis, Tongkat",
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Gaji()),
                  ),
                  child: Containerhome(
                    title: "Gaji",
                    subtitle: "Manajemen Pembayaran Gaji ",
                  ),
                ),

                SizedBox(height: 20),
                Container(
                  width: 337,
                  height: 100,
                  decoration: BoxDecoration(
                    color: greenColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Diagram"),
                  ),
                ),
              ],
            ),
          ],
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
      margin: EdgeInsets.only(top: 20),
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
