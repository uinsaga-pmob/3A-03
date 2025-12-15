import 'package:flutter/material.dart';
import 'package:pabrik_kayu/style.dart';

class DataPribadi extends StatelessWidget {
  const DataPribadi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greenColor,
      appBar: AppBar(
        backgroundColor: greenColor,
        title: Text("Data Pribadi", style: TextStyle(color: cream)),
        centerTitle: true,
        leading: CircleAvatar(
          backgroundColor: cream,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: greenColor),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: cream,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 24,
                              backgroundColor: Color(0xFFE5D9FF),
                              child: Icon(
                                Icons.person,
                                color: Colors.deepPurple,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Bahlil',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'PT. Pabrik kayu',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      const Text(
                        'Informasi Pegawai',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: greenColor,
                        ),
                      ),

                      const SizedBox(height: 16),

                      _buildField(
                        label: 'Nama Pegawai',
                        value: 'Bahlil Lah Dahlil',
                      ),
                      _buildField(label: 'Email', value: 'Bahlil@gmail.com'),
                      _buildField(label: 'Telepon', value: '085782134567'),
                      _buildField(label: 'Username', value: 'Bahlil'),
                      _buildField(label: 'Profesi', value: 'Pegawai'),
                      _buildField(label: 'Tanggal Lahir', value: '07/08/1997'),
                      _buildField(
                        label: 'Alamat',
                        value: 'ds. kkk. 03/07 jakarta pusat',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '*$label',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 6),
          TextFormField(
            initialValue: value,
            readOnly: true,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: greenColor, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: greenColor, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
