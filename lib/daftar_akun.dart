import 'package:flutter/material.dart';
import 'package:pabrik_kayu/kode_OTP.dart';
import 'package:pabrik_kayu/style.dart';


class DaftarAkun extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: cream,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Container(
              padding: EdgeInsets.all(30),
              height: 800,
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
              textfieldcostom("Nama", hint: "Nama"),
              SizedBox(height: 10),
              textfieldcostom("Emaail", hint: "Email"),
              SizedBox(height: 10),
              textfieldcostom("Kata sandi", hint: "Kata Sandi",obscureText: true),
              SizedBox(height: 10),
              textfieldcostom("Kata Sandi", hint: "Kata Sandi", obscureText: true,),
              SizedBox(height: 10),
              textfieldcostom("Telepon", hint: "Telepon"),
              SizedBox(height: 10),
              textfieldcostom("username", hint: "Username"),
              SizedBox(height: 10),
              textfieldcostom("Profesi", hint: "Profesi"),
              SizedBox(height: 10),
              textfieldcostom("Tanggal Lahir", hint: "Tanggal Lahir"),
              SizedBox(height: 10),
              textfieldcostom("Alamat", hint: "Alamat"),
              SizedBox(height: 10),

              SizedBox(height: 20),
              Container(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => KodeOtp())),
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
            ],
          )), 
          )
        )
      ),
    );
  }
}
