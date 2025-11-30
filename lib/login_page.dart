import 'package:flutter/material.dart';
import 'package:pabrik_kayu/lihat_laporan.dart';
import 'package:pabrik_kayu/style.dart';
import 'package:pabrik_kayu/daftar_akun.dart';



class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Masuk Akun',
      home: Scaffold(
        backgroundColor: Color(0xffF8F6F1),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(30),
            height: 500,
            width: 300,
            decoration: BoxDecoration(
              color: greenColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            
              // Judul Halaman Masuk
            children:<Widget> [
              Text(
                "Masuk",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              
              SizedBox(height: 10),
              textfieldcostom("username", hint: "Username",),
              SizedBox(height: 10),

              textfieldcostom("Password", hint: "Password", obscureText: true,),
              
              SizedBox(height: 20),
              Container(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => lihat_laporan())),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: greenColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Colors.white),
                    ),
                  ),
                  child: const Text(
                    "Konfirmasi",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ),
              SizedBox(height: 20),
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Belum punya akun?  ",
                  style: TextStyle(color: Colors.white,
                  fontSize: 12),
                  ),
                    GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DaftarAkun(),
                      ),
                    ),
                    child: const Text(
                      "daftar",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
            
          )
        )
      ),
    );
  }
}

