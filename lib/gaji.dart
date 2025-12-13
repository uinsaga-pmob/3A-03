import 'package:flutter/material.dart';
import 'package:pabrik_kayu/style.dart';

class Gaji extends StatelessWidget {
  const Gaji({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: cream,
        title: const Text(
          'Gaji',
          style: TextStyle(color: greenColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SalaryCard(),
            const SizedBox(height: 24),

            const Text(
              'Salary Breakdown',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            const BreakdownItem(title: 'Gaji Pokok', value: '0.000'),
            const BreakdownItem(title: 'Lembur', value: '0.000'),
            const BreakdownItem(title: 'Bonus Kinerja', value: '0.000'),
            const BreakdownItem(title: 'Pajak', value: '-0.00', negative: true),
            const BreakdownItem(
              title: 'Asuransi',
              value: '-0.00',
              negative: true,
            ),

            const SizedBox(height: 24),

            const Text(
              'Riwayat',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            const HistoryItem(
              month: 'Oktober 2024',
              date: 'Dibayar Oktober 1, 2024',
              gross: '0.000',
              net: '0.000',
            ),
            const HistoryItem(
              month: 'Agustus 2024',
              date: 'Dibayar Agustus 1, 2024',
              gross: '0.000',
              net: '0.000',
            ),
          ],
        ),
      ),
    );
  }
}

class SalaryCard extends StatelessWidget {
  const SalaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 359,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: greenColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Current Month', style: TextStyle(color: Colors.white)),
          SizedBox(height: 4),
          Text(
            'Oktober 2025',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16),
          Text('Gaji Bersih', style: TextStyle(color: Colors.white)),
          SizedBox(height: 8),
          Text(
            '0.000',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class BreakdownItem extends StatelessWidget {
  final String title;
  final String value;
  final bool negative;

  const BreakdownItem({
    super.key,
    required this.title,
    required this.value,
    this.negative = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            value,
            style: TextStyle(
              color: negative ? Colors.red : Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class HistoryItem extends StatelessWidget {
  final String month;
  final String date;
  final String gross;
  final String net;

  const HistoryItem({
    super.key,
    required this.month,
    required this.date,
    required this.gross,
    required this.net,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: greenColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            month,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(date, style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Gaji Kotor: $gross'), Text('Gaji Bersih: $net')],
          ),
        ],
      ),
    );
  }
}
