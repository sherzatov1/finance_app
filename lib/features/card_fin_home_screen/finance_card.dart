import 'package:finance_app/features/application/add_transaction_provider.dart';
import 'package:finance_app/features/design_scroll_fin/add_transaction_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FinanceCard extends ConsumerWidget {
  const FinanceCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formattedBalance = ref.watch(formattedTotalBalanceProvider);

    return Padding(
      padding: const EdgeInsets.only(top: 80),
      child: Container(
        height: 195,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF232323),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: const Color(0xFF232323),
                    isScrollControlled: true,
                    builder: (_) {
                      return FractionallySizedBox(
                        heightFactor: 0.5,
                        child: const AddTransactionSheet(),
                      );
                    },
                  );
                },
                child: const Text(
                  '+добавить',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Card',
                  style: TextStyle(fontSize: 35, color: Colors.white),
                ),
                Text(
                  '$formattedBalance \$',
                  style: const TextStyle(fontSize: 35, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 6),
            const Text(
              'ваш счет',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

