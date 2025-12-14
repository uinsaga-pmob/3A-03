import 'package:flutter/material.dart';
import 'package:pabrik_kayu/style.dart';
import 'package:camera/camera.dart';
import 'main.dart';

class Kehadiran extends StatefulWidget {
  const Kehadiran({super.key});

  @override
  State<Kehadiran> createState() => _KehadiranState();
}

class _KehadiranState extends State<Kehadiran> {
  late CameraController _controller;
  late Future<void> _initializeCamera;

  @override
  void initState() {
    super.initState();

    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    _controller = CameraController(
      frontCamera,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    _initializeCamera = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    try {
      await _initializeCamera;
      final image = await _controller.takePicture();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Foto berhasil diambil')));

      // image.path → bisa kamu simpan / upload
      print(image.path);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      appBar: AppBar(
        title: Text("Absensi", style: TextStyle(color: greenColor)),
        centerTitle: true,
        leading: CircleAvatar(
          backgroundColor: greenColor,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: cream),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: _initializeCamera,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CameraPreview(_controller),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: greenColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: _takePicture,
                icon: const Icon(Icons.camera_alt, color: Colors.white),
                label: const Text(
                  'Ambil Foto Selfie',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
