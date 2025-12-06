import 'package:flutter/material.dart';
import 'package:pabrik_kayu/home_page.dart';
import 'package:pabrik_kayu/laporan.dart';
import 'package:pabrik_kayu/profil.dart';

void main() {
  runApp(kayu());
}

class kayu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'halaman masuk',
      home: HomePage(),
    );
  }
}
