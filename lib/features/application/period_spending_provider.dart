import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'add_transaction_provider.dart' show TransactionType, transactionHistoryProvider;

enum SpendPeriodPreset { day, week, month, custom }

class SpendPeriodRange {
  final DateTime from;
  final DateTime to;

  const SpendPeriodRange({required this.from, required this.to});
}

/// Preset фильтра, который выбирается в UI.
final selectedSpendPeriodPresetProvider =
    StateProvider<SpendPeriodPreset>((ref) => SpendPeriodPreset.month);

/// Пользовательские границы диапазона (используются когда preset = custom).
final spendCustomFromProvider = StateProvider<DateTime>(
  (ref) => DateTime.now().subtract(const Duration(days: 30)),
);

final spendCustomToProvider = StateProvider<DateTime>(
  (ref) => DateTime.now(),
);

SpendPeriodRange _resolveRange({
  required SpendPeriodPreset preset,
  required DateTime now,
  required DateTime customFrom,
  required DateTime customTo,
}) {
  final to = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);

  switch (preset) {
    case SpendPeriodPreset.day: {
      final from = DateTime(now.year, now.month, now.day, 0, 0, 0, 0);
      return SpendPeriodRange(from: from, to: to);
    }
    case SpendPeriodPreset.week: {
      final fromBase = DateTime(now.year, now.month, now.day)
          .subtract(const Duration(days: 6));
      final from = DateTime(fromBase.year, fromBase.month, fromBase.day, 0, 0, 0, 0);
      return SpendPeriodRange(from: from, to: to);
    }
    case SpendPeriodPreset.month: {
      final fromBase = DateTime(now.year, now.month, now.day);
      final from = DateTime(fromBase.year, fromBase.month, fromBase.day, 0, 0, 0, 0)
          .subtract(const Duration(days: 30));
      return SpendPeriodRange(from: from, to: to);
    }
    case SpendPeriodPreset.custom: {
      final from = DateTime(customFrom.year, customFrom.month, customFrom.day, 0, 0, 0, 0);
      final toCustom = DateTime(customTo.year, customTo.month, customTo.day, 23, 59, 59, 999);

      if (from.isAfter(toCustom)) {
        return SpendPeriodRange(from: toCustom, to: from);
      }

      return SpendPeriodRange(from: from, to: toCustom);
    }
  }
}

final spendPeriodRangeProvider = Provider<SpendPeriodRange>((ref) {
  final preset = ref.watch(selectedSpendPeriodPresetProvider);
  final now = DateTime.now();
  final customFrom = ref.watch(spendCustomFromProvider);
  final customTo = ref.watch(spendCustomToProvider);

  return _resolveRange(
    preset: preset,
    now: now,
    customFrom: customFrom,
    customTo: customTo,
  );
});

class CategorySpend {
  final String category;
  final double amount;

  const CategorySpend({required this.category, required this.amount});
}

/// Сколько всего потрачено по категориям за выбранный период.
/// Используются только транзакции типа expense.
final spendByCategoryProvider = Provider<List<CategorySpend>>((ref) {
  final history = ref.watch(transactionHistoryProvider);
  final range = ref.watch(spendPeriodRangeProvider);

  final Map<String, double> sumBy = {};

  for (final t in history) {
    if (t.type != TransactionType.expense) continue;
    if (t.date.isBefore(range.from) || t.date.isAfter(range.to)) continue;

    final cat = (t.category == null || t.category!.trim().isEmpty)
        ? 'Без категории'
        : t.category!.trim();

    sumBy[cat] = (sumBy[cat] ?? 0.0) + t.amount;
  }

  final result = sumBy.entries
      .map((e) => CategorySpend(category: e.key, amount: e.value))
      .toList()
    ..sort((a, b) => b.amount.compareTo(a.amount));

  return result;
});

/// Общая сумма расходов за выбранный период.
final totalSpentForPeriodProvider = Provider<double>((ref) {
  final list = ref.watch(spendByCategoryProvider);
  return list.fold<double>(0.0, (sum, e) => sum + e.amount);
});

