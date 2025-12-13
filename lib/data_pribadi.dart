import 'package:flutter/material.dart';
import 'package:pabrik_kayu/style.dart';

class DataPribadi extends StatelessWidget {
  const DataPribadi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Pribadi', style: TextStyle(color: greenColor)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: cream,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _Item(label: 'Nama Pegawai', value: 'Bahlil'),
              _Divider(),

              _Item(label: 'Perusahaan', value: 'PT. Pabrik Kayu'),
              _Divider(),

              _Item(label: 'Nama Lengkap', value: 'Bahlil Lah Dahliat'),
              _Divider(),

              _Item(label: 'Email', value: 'Bahlil@gmail.com'),
              _Divider(),

              _Item(label: 'Telepon', value: '085782134567'),
              _Divider(),

              _Item(label: 'Username', value: 'Bahlil'),
              _Divider(),

              _Item(label: 'Profesi', value: 'Pegawai'),
              _Divider(),

              _Item(label: 'Tanggal Lahir', value: '07/08/1997'),
              _Divider(),

              _Item(label: 'Alamat', value: 'ds. kkk. 03/07 jakarta pusat'),
            ],
          ),
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final String label;
  final String value;

  const _Item({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Divider(height: 1),
    );
  }
}
