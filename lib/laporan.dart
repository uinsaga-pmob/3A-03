import 'package:flutter/material.dart';



class lihat_laporan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF8F6F1),
        appBar: AppBar(
          title: Text('Lihat Laporan'),
          titleTextStyle: TextStyle(
            color: const Color(0xff386745),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: ListView(
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              title: Text("Nama Barang", style: TextStyle(color: Colors.white)),
              subtitle: Text("Tanggal", style: TextStyle(color: Colors.white),),
              leading: Icon(Icons.image, color: Colors.white, size: 50),
              tileColor: Color(0xff386745),
              trailing: Icon(Icons.download, color: Colors.white,),
            ),
            Divider(
              color: Colors.black
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              title: Text("Nama Barang", style: TextStyle(color: Colors.white)),
              subtitle: Text("Tanggal", style: TextStyle(color: Colors.white),),
              leading: Icon(Icons.image, color: Colors.white, size: 50),
              tileColor: Color(0xff386745),
              trailing: Icon(Icons.download, color: Colors.white,),
            ),
            Divider(
              color: Colors.black
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              title: Text("Nama Barang", style: TextStyle(color: Colors.white)),
              subtitle: Text("Tanggal", style: TextStyle(color: Colors.white),),
              leading: Icon(Icons.image, color: Colors.white, size: 50),
              tileColor: Color(0xff386745),
              trailing: Icon(Icons.download, color: Colors.white,),
            ),
            Divider(
              height: 1,
              color: Colors.black
            ),
          ],
        )
      );
  }
}