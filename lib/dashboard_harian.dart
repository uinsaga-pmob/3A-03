import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pabrik_kayu/style.dart';

class DashboardHarian extends StatelessWidget {
  final List<double> dataHarian = [5, 7, 6, 9, 8, 10, 5];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Card(
            color: cream,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                height: 180,
                width: 337,
                child: LineChart(
                  LineChartData(
                    borderData: FlBorderData(show: false),
                    minY: 0,
                    maxY: 15,
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
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
                        color: const Color.fromARGB(255, 56, 103, 69),
                        barWidth: 2,
                        dotData: FlDotData(
                          show: true,
                          getDotPainter: (spot, percent, barData, index) {
                            return FlDotCirclePainter(color: Color(0xff4AEB78));
                          },
                        ),
                        belowBarData: BarAreaData(
                          show: true,
                          color: const Color.fromARGB(148, 56, 103, 69),
                        ),
                      ),
                    ],
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
