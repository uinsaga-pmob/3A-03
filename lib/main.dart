//import 'dart:math';

import 'package:flutter/material.dart';
// import 'package:pabrik_kayu/data_kayu.dart';
//import 'package:pabrik_kayu/welcome_screen.dart';
//import 'package:camera/camera.dart';
// import 'package:pabrik_kayu/data_karyawan.dart';

import 'package:pabrik_kayu/welcome_screen.dart';
// import 'package:pabrik_kayu/data_kayu.dart';
//import 'package:pabrik_kayu/kehadiran.dart';

//late List<CameraDescription> cameras;

//Future<void> main() async {
//WidgetsFlutterBinding.ensureInitialized();
//cameras = await availableCameras();
//runApp(const Kayu());
//}
import 'package:pabrik_kayu/helpers/database_helper.dart';

Future<void> initDatabase() async {
  await DatabaseHelper.instance.database;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DatabaseHelper.instance.refreshDatabase();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pabrik Kayu',
      home: WelcomeScreen(),
    );
  }
}
