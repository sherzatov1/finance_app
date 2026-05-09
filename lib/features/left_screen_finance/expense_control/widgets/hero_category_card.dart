import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finance_app/features/application/budget_provider.dart';
import 'package:finance_app/features/left_screen_finance/expense_control/expense_model.dart';

class HeroCategoryCard extends ConsumerWidget {
  const HeroCategoryCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedId = ref.watch(selectedCategoryProvider);
    final categories = ref.watch(budgetsProvider);
    
    if (categories.isEmpty) {
      return const SizedBox.shrink();
    }

    BudgetCategory selectedCategory;
    if (selectedId != null && categories.isNotEmpty) {
      selectedCategory = categories.firstWhere(
        (c) => c.id == selectedId,
        orElse: () => categories[0],
      );
    } else {
      selectedCategory = categories[0];
    }

    final progress = selectedCategory.progress.clamp(0.0, 1.0);
    final color = selectedCategory.overrun > 0 ? Colors.red : const Color(0xFF4CAF50);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [color.withOpacity(0.1), Colors.transparent]),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.3),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.star,
              color: Color(0xFF4CAF50),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  selectedCategory.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${selectedCategory.spentAmount.toStringAsFixed(0)}₽ / ${selectedCategory.plannedAmount.toStringAsFixed(0)}₽',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 100,
            height: 12,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey.shade800,
                valueColor: AlwaysStoppedAnimation(color),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
