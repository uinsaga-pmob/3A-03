import 'package:flutter/material.dart';
import 'package:pabrik_kayu/main.dart';



class DaftarAkun extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daftar Akun',
      home: Scaffold(
        backgroundColor: Color(0xffF8F6F1),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Daftar",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Username'),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => (),
                child: Text('Konfirmasi'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
