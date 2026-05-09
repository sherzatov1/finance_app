import 'package:finance_app/features/application/dolgi/debt_model.dart';
import 'package:finance_app/features/application/dolgi/debt_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class DebtList extends ConsumerWidget {
  const DebtList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final debts = ref.watch(debtsProvider);

    return Column(
      children: debts.map((d) => DebtItem(debt: d)).toList(),
    );
  }
}

class DebtItem extends ConsumerWidget {
  final Debt debt;

  const DebtItem({super.key, required this.debt});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedId = ref.watch(selectedDebtProvider);
    final isSelected = selectedId == debt.id;

    final progress = debt.amount == 0
        ? 0.0
        : (debt.paidAmount / debt.amount).clamp(0.0, 1.0);


    return GestureDetector(
      onTap: () {
        ref.read(selectedDebtProvider.notifier).state = debt.id;
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF2A2A3D)
              : const Color(0xFF232323),
          borderRadius: BorderRadius.circular(16),
          border: isSelected
              ? Border.all(color: const Color(0xFF706BFF), width: 2)
              : null,
        ),
        child: Row(
          children: [
            const CircleAvatar(radius: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(debt.title,
                      style: const TextStyle(color: Colors.white)),
                  const SizedBox(height: 4),
                  Text(
                    '\$${debt.paidAmount.toStringAsFixed(0)} / \$${debt.amount.toStringAsFixed(0)}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 6),
                  LinearProgressIndicator(value: progress),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}