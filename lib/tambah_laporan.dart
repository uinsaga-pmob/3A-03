import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PT. Genk Solo Sukses'),
      ),
      body: Center(
        child: ListTile(
          leading: CircleAvatar(),
          title: Text("Profesi"),
          subtitle: Text("Username")
        ),
      ),
    );
  }
}