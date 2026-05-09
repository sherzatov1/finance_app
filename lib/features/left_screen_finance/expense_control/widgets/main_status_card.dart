import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finance_app/features/application/budget_provider.dart';

class MainStatusCard extends ConsumerWidget {
  const MainStatusCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final planned = ref.watch(totalPlannedProvider);
    final spent = ref.watch(totalSpentProvider);
    final overrun = ref.watch(totalOverrunProvider);

    final progress = planned > 0 ? (spent / planned).clamp(0.0, 1.0) : 0.0;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2A2A2A), Color(0xFF1E1E1E)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Контроль бюджета',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 10),
          Text(
            '${spent.toStringAsFixed(0)}₽',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'из ${planned.toStringAsFixed(0)}₽',
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: Colors.grey.shade800,
              valueColor: const AlwaysStoppedAnimation(Color(0xFFFF6B6B)),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Перерасход',
                style: TextStyle(color: Colors.grey.shade400),
              ),
              Text(
                overrun > 0 ? '${overrun.toStringAsFixed(0)}₽' : 'OK',
                style: TextStyle(
                  color: overrun > 0 ? Colors.red : Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
