import 'package:flutter/material.dart';
import 'package:pabrik_kayu/style.dart';

class TambahLaporan extends StatelessWidget {
  const TambahLaporan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:cream,
      appBar: AppBar(
        backgroundColor:cream,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: greenColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Tambah Laporan',
          style: TextStyle(
            color: greenColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _itemButton(
              icon: Icons.terrain,
              label: 'Katul',
            ),
            const SizedBox(height: 14),
            _itemButton(
              icon: Icons.layers,
              label: 'Kayu Lapis',
            ),
            const SizedBox(height: 14),
            _itemButton(
              icon: Icons.circle,
              label: 'Tongkat',
            ),
            const SizedBox(height: 30),

            _actionButton(
              icon: Icons.camera_alt_outlined,
              label: 'Ambil Foto',
              onTap: () {},
            ),
            const SizedBox(height: 16),

            _actionButton(
              icon: Icons.insert_drive_file_outlined,
              label: 'Tambah File',
              onTap: () {},
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: 160,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: greenColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  'Kirim',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===== Widget Item =====
  Widget _itemButton({
    required IconData icon,
    required String label,
  }) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: greenColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: cream,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: greenColor),
          ),
          const SizedBox(width: 16),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ===== Widget Action =====
  Widget _actionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: greenColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(height: 4),
              Text(
                label,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
