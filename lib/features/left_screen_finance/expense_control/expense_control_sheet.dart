import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finance_app/features/application/budget_provider.dart';

import 'widgets/main_status_card.dart';
import 'widgets/category_list.dart';
import 'widgets/hero_category_card.dart';
import 'widgets/quick_actions.dart';

class ExpenseControlSheet extends StatefulWidget {
  const ExpenseControlSheet({super.key});

  @override
  State<ExpenseControlSheet> createState() => _ExpenseControlSheetState();
}

class _ExpenseControlSheetState extends State<ExpenseControlSheet> {
  static const Color surfaceColor = Color(0xFF1C1C1E);
  static const Color textPrimary = Colors.white;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) => Container(
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Индикатор
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // Заголовок
              Consumer(
                builder: (context, ref, child) {
                  final totalPlanned = ref.watch(totalPlannedProvider);
                  return Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Контроль расходов',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: textPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'План: \$${totalPlanned.toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF706BFF),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 24),
              const MainStatusCard(),
              const SizedBox(height: 24),
              const HeroCategoryCard(),
              const SizedBox(height: 24),
              const CategoryList(),
              const SizedBox(height: 24),
              const QuickActions(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

void showExpenseControlSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => const ExpenseControlSheet(),
  );
}
