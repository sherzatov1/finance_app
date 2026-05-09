import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finance_app/features/application/goal_model.dart';
import 'package:finance_app/features/application/goal_provider.dart';

class QuickActions extends ConsumerWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedId = ref.watch(selectedGoalProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _ActionButton(
                icon: Icons.add_circle_outline,
                label: 'Новая цель',
                color: const Color(0xFF706BFF),
                onTap: () => _showAddGoalDialog(context, ref),
              )),
              if (selectedId != null) ...[
                const SizedBox(width: 12),
                Expanded(child: _ActionButton(
                  icon: Icons.delete_outline,
                  label: 'Удалить',
                  color: Colors.red,
                  onTap: () {
                    ref.read(goalsProvider.notifier).removeGoal(selectedId);
                    ref.read(selectedGoalProvider.notifier).state = null;
                  },
                )),
              ],
            ],
          ),
          const SizedBox(height: 20),
          if (selectedId != null)
            SizedBox(
              width: double.infinity,
              child: _ActionButton(
                icon: Icons.savings_outlined,
                label: 'Добавить сбережения',
                color: const Color(0xFF4CAF50),
                onTap: () => _showPaymentDialog(context, ref, selectedId),
              ),
            ),
        ],
      ),
    );
  }

  Widget _ActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.1),
              color.withOpacity(0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: color.withOpacity(0.2),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showAddGoalDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final amountController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Новая цель'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Название цели'),
            ),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(labelText: 'Целевая сумма'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Отмена')),
          TextButton(
            onPressed: () {
              final amount = double.tryParse(amountController.text) ?? 0.0;
              final goal = Goal(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                name: nameController.text,
                title: nameController.text,
                targetAmount: amount,
                currentAmount: 0.0,
                targetDate: DateTime.now().add(const Duration(days: 365)),
              );
              ref.read(goalsProvider.notifier).addGoal(goal);
              Navigator.pop(context);
            },
            child: const Text('Создать'),
          ),
        ],
      ),
    );
  }

  void _showPaymentDialog(BuildContext context, WidgetRef ref, String id) {
    final amountController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Добавить сбережения'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: amountController,
              decoration: const InputDecoration(labelText: 'Сумма'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Отмена')),
          TextButton(
            onPressed: () {
              final amount = double.tryParse(amountController.text) ?? 0.0;
              ref.read(goalsProvider.notifier).updateCurrentAmount(id, amount);
              Navigator.pop(context);
            },
            child: const Text('Добавить'),
          ),
        ],
      ),
    );
  }
}
