//import 'dart:math';

import 'package:flutter/material.dart';
// import 'package:pabrik_kayu/data_kayu.dart';
//import 'package:pabrik_kayu/welcome_screen.dart';
//import 'package:camera/camera.dart';
// import 'package:pabrik_kayu/data_karyawan.dart';
//import 'package:pabrik_kayu/data_kayu.dart';
// import 'package:pabrik_kayu/data_kayu.dart';
//import 'package:pabrik_kayu/kehadiran.dart';
import 'package:pabrik_kayu/data_kayu.dart';
//import 'package:pabrik_kayu/kehadiran.dart';
//import 'package:sqflite/sqflite.dart';
//import 'package:pabrik_kayu/kehadiran.dart';
import 'package:pabrik_kayu/welcome_screen.dart';
import 'package:pabrik_kayu/gaji.dart';

//late List<CameraDescription> cameras;

//Future<void> main() async {
//WidgetsFlutterBinding.ensureInitialized();
//cameras = await availableCameras();
//runApp(const Kayu());
//}

//class Kayu extends StatelessWidget {
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pabrik Kayu',
      initialRoute: '/gaji',

      routes: {
        '/': (context) => const WelcomeScreen(),
        '/data-kayu': (context) => const DataKayu(),

        // Kirim employeeId tiruan yang ada di database Anda (misal ID: 1 atau 2)
        '/gaji': (context) => const Gaji(employeeId: 1),
      },
    );
  }
}
