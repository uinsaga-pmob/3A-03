import 'package:flutter/material.dart';
import 'package:pabrik_kayu/daftar_akun.dart';
import 'package:pabrik_kayu/login_page.dart';
import 'package:pabrik_kayu/style.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream, 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: greenColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Color(0x99000000),
                  width: 1,
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              "Pabrik Kayu",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: greenColor,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "selamat datang",
              style: TextStyle(
                fontSize: 14,
                color:greenColor,
              ),
            ),

            const SizedBox(height: 50),
            SizedBox(
              width: 160,
              height: 45,
              child: ElevatedButton(
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage(),
                    ),
                  ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: greenColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Masuk",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Tombol Daftar
            SizedBox(
              width: 160,
              height: 45,
              child: ElevatedButton(
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DaftarAkun(),
                      ),
                    ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: greenColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Daftar",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
