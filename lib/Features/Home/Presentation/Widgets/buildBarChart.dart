import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BuildBarChart extends StatelessWidget {
  const BuildBarChart({super.key, required this.data, required this.label});
  final String label;
  final double data;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        SizedBox(
          height: 200,
          child: SfCartesianChart(
            primaryXAxis: const CategoryAxis(),
            series: <BarSeries<double, double>>[
              BarSeries<double, double>(
                dataSource: [data],
                xValueMapper: (_, index) => index + 1.toDouble(),
                yValueMapper: (datum, _) => datum,
                color: Colors.white,
                width: 0.1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
