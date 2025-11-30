import 'package:flutter/material.dart';
import 'package:pabrik_kayu/style.dart';



class lihat_laporan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: cream,
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
            laporan_barang(),
            Divider(
              color: Colors.black,
            ),
            laporan_barang(),
            Divider(
              color: Colors.black,
            ),
            laporan_barang(),
            Divider(
              color: Colors.black,
            ),
          ],
        )
      );
  }
}

class laporan_barang extends StatelessWidget {
  const laporan_barang({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      title: Text("Nama Barangg", style: TextStyle(color: Colors.white)),
      subtitle: Text("Tanggal", style: TextStyle(color: Colors.white),),
      leading: Icon(Icons.image, color: Colors.white, size: 50),
      tileColor: Color(0xff386745),
      trailing: Icon(Icons.download, color: Colors.white,),
    );
  }
}