import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Belajar Flutter Kelas ',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Halaman Utama", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Center(child: Text("Mulai Belajar Flutter")),
      ),
    );
  }
}
