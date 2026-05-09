import 'package:finance_app/features/application/dolgi/debt_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class MainStatusCard extends ConsumerWidget {
  const MainStatusCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final total = ref.watch(totalDebtProvider);
    final paid = ref.watch(totalPaidProvider);

    final progress = total == 0 ? 0.0 : (paid / total).clamp(0.0, 1.0);
    final remaining = total - paid;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF232323),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Выплачено:',
                  style: TextStyle(color: Colors.grey)),
              const Spacer(),
              Text('\$${paid.toStringAsFixed(0)}',
                  style: const TextStyle(color: Colors.white)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text('Общий долг:',
                  style: TextStyle(color: Colors.grey)),
              const Spacer(),
              Text('\$${total.toStringAsFixed(0)}',
                  style: const TextStyle(color: Colors.white)),
            ],
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(value: progress),
          const SizedBox(height: 8),
          Text('Осталось: \$${remaining.toStringAsFixed(0)}',
              style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
