import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'add_transaction_provider.dart' show TransactionType, transactionHistoryProvider;

/// Общая сумма расходов за всё время (сумма транзакций типа `expense`).
final totalExpenseProvider = Provider<double>((ref) {
  final history = ref.watch(transactionHistoryProvider);
  return history.fold<double>(0.0, (sum, t) {
    return t.type == TransactionType.expense ? sum + t.amount : sum;
  });
});

/// Общая сумма доходов за всё время (сумма транзакций типа `income`).
final totalIncomeProvider = Provider<double>((ref) {
  final history = ref.watch(transactionHistoryProvider);
  return history.fold<double>(0.0, (sum, t) {
    return t.type == TransactionType.income ? sum + t.amount : sum;
  });
});

