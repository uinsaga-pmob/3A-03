import 'package:flutter/material.dart';
import 'package:pabrik_kayu/style.dart';
import 'package:pabrik_kayu/dashboard_harian.dart';

class Kinerja extends StatelessWidget {
  const Kinerja({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      appBar: AppBar(title: Text('PT. Genk Solo Sukses')),
      body: SingleChildScrollView(
        child: SafeArea(child: Center(child: DashboardHarian())),
      ),
    );
  }
}
