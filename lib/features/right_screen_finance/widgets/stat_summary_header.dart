import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/amount_formatter.dart';
import '../../application/add_transaction_provider.dart';
import '../../application/total_income_expense_provider.dart';

/// =============================================================================
/// 💰 СВОДКА: ОБЩИЙ БАЛАНС / ДОХОДЫ / РАСХОДЫ
/// =============================================================================

class StatSummaryHeader extends ConsumerWidget {
  const StatSummaryHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalIncome = ref.watch(totalIncomeProvider);
    final totalExpense = ref.watch(totalExpenseProvider);
    final balance = ref.watch(totalBalanceProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Общая сводка',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        /// ГЛАВНАЯ КАРТОЧКА — БАЛАНС
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF706BFF),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Текущий баланс',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                formatCompactAmount(balance, useRuLocale: true),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              // Динамику относительно прошлого периода не реализуем в рамках задачи.
            ]
          ),
        ),
        const SizedBox(height: 12),

        /// ДОХОДЫ И РАСХОДЫ — 2 КАРТОЧКИ В РЯД
        Row(
          children: [
            Expanded(
              child: _SummaryCard(
                label: 'Доходы',
                amount: totalIncome,
                icon: Icons.arrow_upward,
                iconColor: Colors.green,
                bgColor: Colors.green.withValues(alpha: 0.15),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _SummaryCard(
                label: 'Расходы',
                amount: totalExpense,
                icon: Icons.arrow_downward,
                iconColor: Colors.red,
                bgColor: Colors.red.withValues(alpha: 0.15),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// =============================================================================
/// ВСПОМОГАТЕЛЬНАЯ КАРТОЧКА ДЛЯ ДОХОДОВ/РАСХОДОВ
/// =============================================================================
class _SummaryCard extends StatelessWidget {
  final String label;
  final double amount;
  final IconData icon;
  final Color iconColor;
  final Color bgColor;

  const _SummaryCard({
    required this.label,
    required this.amount,
    required this.icon,
    required this.iconColor,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    final formatted = formatCompactAmount(amount, useRuLocale: true);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            formatted,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

