import 'package:flutter/material.dart';

class BuildWeatherDetail extends StatelessWidget {
  const BuildWeatherDetail(
      {super.key,
      required this.icon,
      required this.value,
      required this.label});
  final IconData icon;
  final String value;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(width: 8),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
