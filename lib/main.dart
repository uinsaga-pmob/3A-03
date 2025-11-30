import 'package:pabrik_kayu/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(kayu());
}

class kayu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'halaman masuk',
      home: LoginPage(),
    );
  }
}
