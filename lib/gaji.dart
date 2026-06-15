import 'package:flutter/material.dart';
import 'package:pabrik_kayu/style.dart';
import 'package:pabrik_kayu/models/employee_model.dart';
import 'package:pabrik_kayu/services/employee_service.dart';
import 'package:intl/intl.dart';

class GajiDetailPage extends StatefulWidget {
  final int employeeId; // Wajib menerima ID kembali

  const GajiDetailPage({super.key, required this.employeeId});

  @override
  State<GajiDetailPage> createState() => _GajiDetailPageState();
}

class _GajiDetailPageState extends State<GajiDetailPage> {
  final EmployeeService _employeeService = EmployeeService();
  late Future<EmployeeModel?> _employeeFuture;

  @override
  void initState() {
    super.initState();
    _employeeFuture = _employeeService.getById(widget.employeeId);
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
        title: const Text(
          "Rincian Gaji",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: greenColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder<EmployeeModel?>(
          future: _employeeFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

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

            final karyawan = snapshot.data!;

            // Kalkulasi Gaji Tambahan & Potongan (Statis)
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
                  const SizedBox(height: 10),

                  // Card Info Karyawan
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                  // Card Breakdown Rincian
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
                        _RowItem(label: 'Lembur', value: _formatRupiah(lembur)),
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

// Sub-Widget Helper pendukung _SalaryValue dan _RowItem tetap dipertahankan di bawah...
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
