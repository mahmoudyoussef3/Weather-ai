import 'package:flutter/material.dart';

class BuildAstroDetails extends StatelessWidget {
  const BuildAstroDetails(
      {super.key, required this.label, required this.value});
  final String label, value;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 16),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ],
    );
  }
}
