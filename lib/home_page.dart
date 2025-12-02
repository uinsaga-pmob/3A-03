import 'package:flutter/material.dart';
import 'package:pabrik_kayu/style.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PT. Genk Solo Sukses'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(),
              title: Text("Profesi"),
              subtitle: Text("Username"),
              titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Container(
              height: 72,
              width: 153,
              decoration: BoxDecoration(
                color: greenColor,
                borderRadius: BorderRadius.circular(15),
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
            )
            ],
          ),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 90),
              Text("Main Menu", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: greenColor),),
            ],
          ),
          Column(
            children: [
              containerhome("Profile","Data Pribadi, Kehadiran, Tarif"),
              containerhome("Laporan","Katul, Kayu Lapis, Tongkat"),
              containerhome("Gaji", "Manajemen Pembayaran Gaji "),
              SizedBox(height: 20),
              Container(width: 337,height: 200, color: const Color.fromARGB(255, 95, 71, 12)),
            ],
          )
          ],
        ),
      )
    );
  }
}

class containerhome extends StatelessWidget {
  const containerhome(String title, String subtitle, {
    super.key,
  });
  final String title = "";
  final String subtitle = "";
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
        children: [
          Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
          Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.white),),
        ],
      ), 
    );
  }
}