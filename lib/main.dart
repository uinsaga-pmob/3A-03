import 'package:flutter/material.dart';
import 'package:pabrik_kayu/welcome_screen.dart';
import 'package:camera/camera.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const Kayu());
}

class Kayu extends StatelessWidget {
  const Kayu({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'halaman masuk',
      home: WelcomeScreen(),
    );
  }
}
