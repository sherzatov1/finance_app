import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finance_app/features/application/dolgi/debt_model.dart';
import 'package:finance_app/features/application/dolgi/debt_provider.dart';

class QuickActions extends ConsumerWidget {
  const QuickActions({super.key});

  static const Color accentColor = Color(0xFF706BFF);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedId = ref.watch(selectedDebtProvider);

    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildButton(
              label: 'Добавить долг',
              icon: Icons.add,
              onPressed: () => _showAddDebtDialog(context, ref),
            )),
            const SizedBox(width: 12),
            Expanded(child: _buildButton(
              label: 'Удалить',
              icon: Icons.delete,
              onPressed: selectedId != null ? () {
                ref.read(debtsProvider.notifier).deleteDebt(selectedId);
                ref.read(selectedDebtProvider.notifier).state = null;
              } : null,
            )),
          ],
        ),
        const SizedBox(height: 12),
        _buildButton(
          label: 'Оплатить Долг',
          icon: Icons.payment,
          fullWidth: true,
          onPressed: selectedId != null ? () => _showPaymentDialog(context, ref, selectedId) : null,
        ),
      ],
    );
  }

  Widget _buildButton({
    required String label,
    required IconData icon,
    VoidCallback? onPressed,
    bool fullWidth = false,
  }) {
    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 20, color: Colors.white),
        label: Text(label, style: const TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: accentColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
      ),
    );
  }

  void _showAddDebtDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final amountController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Новый долг'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Название'),
            ),
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
              final debt = Debt(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                name: nameController.text,
                title: nameController.text,
                amount: amount,
                paidAmount: 0.0,
                dueDate: DateTime.now().add(const Duration(days: 30)),
              );
              ref.read(debtsProvider.notifier).addDebt(debt);
              Navigator.pop(context);
            },
            child: const Text('Добавить'),
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
        title: const Text('Платеж'),
        content: TextField(
          controller: amountController,
          decoration: const InputDecoration(labelText: 'Сумма платежа'),
          keyboardType: TextInputType.number,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Отмена')),
          TextButton(
            onPressed: () {
              final amount = double.tryParse(amountController.text) ?? 0.0;
              ref.read(debtsProvider.notifier).updatePaidAmount(id, amount);
              Navigator.pop(context);
            },
            child: const Text('Оплатить'),
          ),
        ],
      ),
    );
  }
}
