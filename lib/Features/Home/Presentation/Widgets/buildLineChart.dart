import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BuildLineChart extends StatelessWidget {
  const BuildLineChart({super.key, required this.label, required this.data});
  final String label;
  final List<double> data;
  final  color = Colors.blue;
  @override
  Widget build(BuildContext context) {
    return       Column(
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
            series: <LineSeries<double, double>>[
              LineSeries<double, double>(
                color: color,
                dataSource: data,
                xValueMapper: (datum, index) => index+1.toDouble(),
                yValueMapper: (datum, _) => datum,
                markerSettings: const MarkerSettings(isVisible: true),
              ),
            ],
          ),
        ),
      ],
    );

  }
}
