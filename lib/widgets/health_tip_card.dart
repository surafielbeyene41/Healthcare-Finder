import 'package:flutter/material.dart';

class HealthTipCard extends StatelessWidget {
  final String tip;

  const HealthTipCard({super.key, required this.tip});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(tip),
      ),
    );
  }
}