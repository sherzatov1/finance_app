import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

/// Текущая дата и время транзакции (по умолчанию — сейчас).
final transactionDateTimeProvider = StateProvider<DateTime>(
  (ref) => DateTime.now(),
);

/// Отформатированная дата для отображения в UI (например, "15 июн 2025").
final formattedTransactionDateProvider = Provider<String>((ref) {
  final dateTime = ref.watch(transactionDateTimeProvider);
  return DateFormat('d MMM yyyy', 'ru').format(dateTime);
});

/// Отформатированное время для отображения в UI (например, "14:30").
final formattedTransactionTimeProvider = Provider<String>((ref) {
  final dateTime = ref.watch(transactionDateTimeProvider);
  return DateFormat('HH:mm', 'ru').format(dateTime);
});

