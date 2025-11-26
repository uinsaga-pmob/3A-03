import 'package:flutter/material.dart';
import 'package:pabrik_kayu/lihat_laporan.dart';
import 'package:pabrik_kayu/style.dart';



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
            children: [
              Text(
                "Masuk",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Username', border: OutlineInputBorder(borderRadius: BorderRadius.circular(50))),
              ),
              TextField( 
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => (Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => lihat_laporan()),
                )
                ),
                child: Text('Konfirmasi'),
              ),
            ],
          ),
            
          )
        )
      ),
    );
  }
}

