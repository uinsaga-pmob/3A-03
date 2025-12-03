import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

// MODEL DATA
class SalesData {
  final String month;
  final double value;

  SalesData(this.month, this.value);
}

class DiagramPage extends StatefulWidget {
  const DiagramPage({super.key});

  @override
  State<DiagramPage> createState() => _DiagramPageState();
}

class _DiagramPageState extends State<DiagramPage> {
  final TextEditingController monthC = TextEditingController();
  final TextEditingController valueC = TextEditingController();

  List<SalesData> dataList = [];

  void addData() {
    if (monthC.text.isEmpty || valueC.text.isEmpty) return;

    setState(() {
      dataList.add(SalesData(monthC.text, double.parse(valueC.text)));
    });

    monthC.clear();
    valueC.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Input Tabel & Diagram")),
      body: Column(
        children: [
          const SizedBox(height: 10),

          // FORM INPUT
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: monthC,
                    decoration: const InputDecoration(
                      labelText: "Bulan",
                      hintText: "Contoh: Jan",
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: valueC,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: "Penjualan"),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(onPressed: addData, child: const Text("Tambah")),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ============================
          //           TABEL
          // ============================
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: DataTable(
                border: TableBorder.all(color: Colors.black12),
                columns: const [
                  DataColumn(label: Text("Bulan")),
                  DataColumn(label: Text("Penjualan")),
                ],
                rows: dataList
                    .map(
                      (d) => DataRow(
                        cells: [
                          DataCell(Text(d.month)),
                          DataCell(Text(d.value.toString())),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // ============================
          //            DIAGRAM
          // ============================
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: LineChart(
                LineChartData(
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      barWidth: 3,
                      color: Colors.blue,
                      spots: [
                        for (int i = 0; i < dataList.length; i++)
                          FlSpot(i.toDouble(), dataList[i].value),
                      ],
                    ),
                  ],
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() < dataList.length) {
                            return Text(dataList[value.toInt()].month);
                          }
                          return const Text("");
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
