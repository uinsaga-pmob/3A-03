import 'package:flutter/material.dart';
import 'package:pabrik_kayu/style.dart';

class Kehadiran extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      appBar: AppBar(title: Text('PT. Genk Solo Sukses')),
      body: Center(
        child: ListTile(
          leading: CircleAvatar(),
          title: Text("Profesi"),
          subtitle: Text("Username"),
        ),
      ),
    );
  }
}
