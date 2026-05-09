import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../application/add_transaction_provider.dart';

class TypeTransaction extends ConsumerStatefulWidget {
  const TypeTransaction({super.key});

  @override
  ConsumerState<TypeTransaction> createState() => _TypeTransactionState();
}

class _TypeTransactionState extends ConsumerState<TypeTransaction> {
  void _selectType(TransactionType type) {
    ref.read(transactionTypeProvider.notifier).state = type;
  }

  Widget _buildTypeCard({
    required TransactionType type,
    required IconData icon,
    required String label,
    required bool isSelected,
  }) {
    final borderColor = isSelected
        ? (type == TransactionType.expense ? Colors.red : Colors.green)
        : Colors.transparent;

    return Expanded(
      child: GestureDetector(
        onTap: () => _selectType(type),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C1E),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor, width: 2),
          ),
          child: Column(
            children: [
              Icon(icon, color: type == TransactionType.expense ? Colors.red : Colors.green),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedType = ref.watch(transactionTypeProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ТИП ТРАНЗАКЦИИ',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildTypeCard(
                type: TransactionType.expense,
                icon: Icons.arrow_downward,
                label: 'Расход',
                isSelected: selectedType == TransactionType.expense,
              ),
              const SizedBox(width: 8),
              _buildTypeCard(
                type: TransactionType.income,
                icon: Icons.arrow_upward,
                label: 'Доход',
                isSelected: selectedType == TransactionType.income,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
