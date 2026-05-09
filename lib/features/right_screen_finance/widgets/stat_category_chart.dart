import 'package:flutter/material.dart';

class StatCategoryChart extends StatelessWidget {
  const StatCategoryChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1D),
        borderRadius: BorderRadius.circular(30),
      ),
      child: const SizedBox.shrink(),
    );
  }
}
