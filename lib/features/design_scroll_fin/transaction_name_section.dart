import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../application/add_transaction_provider.dart';

class TransactionNameSection extends ConsumerStatefulWidget {
  const TransactionNameSection({super.key});

  @override
  ConsumerState<TransactionNameSection> createState() =>
      _TransactionNameSectionState();
}

class _TransactionNameSectionState
    extends ConsumerState<TransactionNameSection> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTitleChanged(String value) {
    ref.read(transactionTitleProvider.notifier).state = value;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<String>(
      transactionTitleProvider,
      (previous, next) {
        if (_controller.text != next) {
          _controller.text = next;
        }
      },
    );
    final selectedType = ref.watch(transactionTypeProvider);

    final iconData = selectedType == TransactionType.expense
        ? Icons.arrow_downward
        : Icons.arrow_upward;
    final iconColor = selectedType == TransactionType.expense
        ? Colors.red
        : Colors.green;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'КАТЕГОРИЯ И НАЗВАНИЕ',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1C1C1E),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  iconData,
                  color: iconColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C1C1E),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: _controller,
                    style: const TextStyle(color: Colors.white),
                    textInputAction: TextInputAction.done,
                    onChanged: _onTitleChanged,
                    decoration: const InputDecoration(
                      hintText: 'Название транзакции',
                      hintStyle: TextStyle(color: Colors.white54),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
