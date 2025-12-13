import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DashboardHarian extends StatelessWidget {
  final List<double> dataHarian = [
    5,
    7,
    6,
    9,
    8,
    10,
    12,
    11,
    14,
    13,
    10,
    9,
    8,
    7,
    6,
    5,
    7,
    9,
    12,
    11,
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                height: 250,
                child: LineChart(
                  LineChartData(
                    minY: 0,
                    maxY: (dataHarian.reduce((a, b) => a > b ? a : b)) + 2,
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                          interval: 5,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              "H${value.toInt()}",
                              style: const TextStyle(fontSize: 10),
                            );
                          },
                        ),
                      ),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          for (int i = 0; i < dataHarian.length; i++)
                            FlSpot(i.toDouble() + 1, dataHarian[i]),
                        ],
                        isCurved: true,
                        barWidth: 3,
                        dotData: const FlDotData(show: false),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: DataTable(
                columns: const [
                  DataColumn(label: Text("Hari")),
                  DataColumn(label: Text("Nilai")),
                ],
                rows: [
                  for (int i = 0; i < dataHarian.length; i++)
                    DataRow(
                      cells: [
                        DataCell(Text("Hari ${i + 1}")),
                        DataCell(Text(dataHarian[i].toString())),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
