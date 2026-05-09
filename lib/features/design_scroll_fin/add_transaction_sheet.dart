import 'package:finance_app/features/application/add_transaction_provider.dart';
import 'package:finance_app/features/application/transaction_date_provider.dart';
import 'package:finance_app/features/design_scroll_fin/calendar_opisanie.dart';
import 'package:finance_app/features/design_scroll_fin/chet.dart';
import 'package:finance_app/features/design_scroll_fin/transaction_name_section.dart';
import 'package:finance_app/features/design_scroll_fin/summa_tranc.dart';
import 'package:finance_app/features/design_scroll_fin/type_transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddTransactionSheet extends ConsumerWidget {
  const AddTransactionSheet({super.key});

  void _saveTransaction(BuildContext context, WidgetRef ref) {
    final title = ref.read(transactionTitleProvider).trim();
    final amount = ref.read(transactionAmountProvider);
    final type = ref.read(transactionTypeProvider);
    final date = ref.read(transactionDateTimeProvider);

    if (title.isEmpty || amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Введите название и корректную сумму'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    ref.read(transactionHistoryProvider.notifier).addTransaction(
          title,
          type,
          amount,
          date,
          ref.read(transactionDescriptionProvider),
          ref.read(transactionCategoryProvider),
        );

    // Очистка полей
    ref.read(transactionTitleProvider.notifier).state = '';
    ref.read(transactionAmountProvider.notifier).state = null;
    ref.read(transactionDescriptionProvider.notifier).state = '';
    ref.read(transactionDateTimeProvider.notifier).state = DateTime.now();

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Column(
        children: [
          // 🔥 маленький индикатор (по желанию)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            height: 4,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: const [
                  SizedBox(height: 16),
                  TransactionNameSection(),
                  SizedBox(height: 24),
                  TypeTransaction(),
                  SizedBox(height: 24),
                  Chet(),
                  SizedBox(height: 20),
                  SummaTranc(),
                  SizedBox(height: 24),
                  CalendarOpisanie(),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _saveTransaction(context, ref),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF706BFF),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Сохранить',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

