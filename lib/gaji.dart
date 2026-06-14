import 'package:flutter/material.dart';
import 'package:pabrik_kayu/style.dart';
import 'package:pabrik_kayu/models/employee_model.dart';
import 'package:pabrik_kayu/services/employee_service.dart';
import 'package:intl/intl.dart';

class Gaji extends StatefulWidget {
  final int? employeeId;

  const Gaji({super.key, this.employeeId});

  @override
  State<Gaji> createState() => _GajiState();
}

class _GajiState extends State<Gaji> {
  final EmployeeService _employeeService = EmployeeService();
  Future<EmployeeModel?>? _employeeFuture;

  @override
  void initState() {
    super.initState();
    // Jalankan service jika employeeId tidak null
    if (widget.employeeId != null) {
      _employeeFuture = _employeeService.getById(widget.employeeId!);
    }
  }

  String _formatRupiah(int angka) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(angka);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      appBar: AppBar(
        title: Text("Gaji", style: TextStyle(color: greenColor)),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: greenColor,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: cream),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      body: SafeArea(
        // Kondisi 1: Jika dibuka langsung dari Home tanpa membawa ID Karyawan
        child: widget.employeeId == null
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Silakan akses halaman ini melalui menu "Data Karyawan" untuk melihat rincian gaji spesifik.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
              )
            : FutureBuilder<EmployeeModel?>(
                future: _employeeFuture,
                builder: (context, snapshot) {
                  // Kondisi 2: Proses Loading data dari database SQLite
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // Kondisi 3: Terjadi error atau data di database kosong
                  if (snapshot.hasError ||
                      !snapshot.hasData ||
                      snapshot.data == null) {
                    return const Center(
                      child: Text(
                        'Data karyawan tidak ditemukan.',
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  // Kondisi 4: Data berhasil diambil dengan aman
                  final karyawan = snapshot.data!;

                  int gajiPokok = karyawan.gaji;
                  int lembur = 250000;
                  int bonusKinerja = 150000;
                  int pajak = 50000;
                  int asuransi = 25000;

                  int gajiKotor = gajiPokok + lembur + bonusKinerja;
                  int gajiBersih = gajiKotor - (pajak + asuransi);

                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const SizedBox(height: 24),

                        // Card Detail Singkat
                        _card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                karyawan.nama,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                karyawan.jabatan,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                              const Divider(color: Colors.white30, height: 24),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _SalaryValue(
                                    title: 'Gaji Kotor',
                                    value: _formatRupiah(gajiKotor),
                                  ),
                                  _SalaryValue(
                                    title: 'Gaji Bersih',
                                    value: _formatRupiah(gajiBersih),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Card Breakdown Rincian Gaji
                        _card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Salary Breakdown',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              _RowItem(
                                label: 'Gaji Pokok',
                                value: _formatRupiah(gajiPokok),
                              ),
                              _RowItem(
                                label: 'Lembur',
                                value: _formatRupiah(lembur),
                              ),
                              _RowItem(
                                label: 'Bonus Kinerja',
                                value: _formatRupiah(bonusKinerja),
                              ),
                              _RowItem(
                                label: 'Pajak',
                                value: '- ${_formatRupiah(pajak)}',
                              ),
                              _RowItem(
                                label: 'Asuransi',
                                value: '- ${_formatRupiah(asuransi)}',
                              ),
                              const Divider(color: Colors.white24),
                              _RowItem(
                                label: 'Gaji Bersih',
                                value: _formatRupiah(gajiBersih),
                                isBold: true,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Card Riwayat Pembayaran Gaji
                        _card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Riwayat',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                'Mei 2026',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                'Dibayar Juni 1, 2026',
                                style: TextStyle(color: Colors.white70),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'April 2026',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: greenColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}

class _SalaryValue extends StatelessWidget {
  final String title;
  final String value;

  const _SalaryValue({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _RowItem extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const _RowItem({
    required this.label,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      color: Colors.white,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(value, style: style),
        ],
      ),
    );
  }
}
