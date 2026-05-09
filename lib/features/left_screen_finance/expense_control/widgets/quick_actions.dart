import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finance_app/features/application/budget_provider.dart';
import 'package:finance_app/features/left_screen_finance/expense_control/expense_model.dart';

class QuickActions extends ConsumerWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedId = ref.watch(selectedCategoryProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _ActionButton(
                icon: Icons.add_circle_outline,
                label: 'Новая категория',
                color: const Color(0xFF706BFF),
                onTap: () => _showAddCategoryDialog(context, ref),
              )),
              if (selectedId != null) ...[
                const SizedBox(width: 12),
                Expanded(child: _ActionButton(
                  icon: Icons.delete_outline,
                  label: 'Удалить',
                  color: Colors.red,
                  onTap: () {
                    ref.read(budgetsProvider.notifier).removeCategory(selectedId);
                    ref.read(selectedCategoryProvider.notifier).state = null;
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
                icon: Icons.attach_money,
                label: 'Добавить расход',
                color: const Color(0xFFFF6B6B),
                onTap: () => _showSpentDialog(context, ref, selectedId),
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
            colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.2), width: 1.5),
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
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showAddCategoryDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final plannedController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Новая категория'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Название категории'),
            ),
            TextField(
              controller: plannedController,
              decoration: const InputDecoration(labelText: 'Плановый бюджет'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Отмена')),
          TextButton(
            onPressed: () {
              final planned = double.tryParse(plannedController.text) ?? 0.0;
              final category = BudgetCategory(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                name: nameController.text,
                title: nameController.text,
                plannedAmount: planned,
                month: DateTime.now(),
              );
              ref.read(budgetsProvider.notifier).addCategory(category);
              Navigator.pop(context);
            },
            child: const Text('Создать'),
          ),
        ],
      ),
    );
  }

  void _showSpentDialog(BuildContext context, WidgetRef ref, String id) {
    final amountController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Добавить расход'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: amountController,
              decoration: const InputDecoration(labelText: 'Сумма расхода'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Отмена')),
          TextButton(
            onPressed: () {
              final amount = double.tryParse(amountController.text) ?? 0.0;
              final categories = ref.read(budgetsProvider);
              final current = categories.firstWhere((c) => c.id == id);
              final newSpent = current.spentAmount + amount;
              ref.read(budgetsProvider.notifier).updateSpent(id, newSpent);
              Navigator.pop(context);
            },
            child: const Text('Добавить'),
          ),
        ],
      ),
    );
  }
}
