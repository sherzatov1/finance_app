import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'amount_formatter.dart';

enum TransactionType { expense, income }

class Transaction {
  final String title;
  final TransactionType type;
  final double amount;
  final DateTime date;
  final String description;
  final String? category;

  const Transaction({
    required this.title,
    required this.type,
    required this.amount,
    required this.date,
    this.description = '',
    this.category,
  });
}

/// Текущее название транзакции (вводится пользователем).
final transactionTitleProvider = StateProvider<String>((ref) => '');

/// Описание транзакции (вводится пользователем).
final transactionDescriptionProvider = StateProvider<String>((ref) => '');

/// Текущий тип транзакции.
final transactionTypeProvider =
    StateProvider<TransactionType>((ref) => TransactionType.expense);

/// Текущая сумма транзакции (вводится пользователем).
final transactionAmountProvider = StateProvider<double?>((ref) => null);

/// Категория транзакции.
final transactionCategoryProvider = StateProvider<String?>((ref) => null);

/// История всех транзакций.
final transactionHistoryProvider =
    StateNotifierProvider<TransactionHistoryNotifier, List<Transaction>>(
  (ref) => TransactionHistoryNotifier(),
);

/// Общий баланс: доходы минус расходы.
final totalBalanceProvider = Provider<double>((ref) {
  final history = ref.watch(transactionHistoryProvider);
  double balance = 0;
  for (final t in history) {
    if (t.type == TransactionType.income) {
      balance += t.amount;
    } else {
      balance -= t.amount;
    }
  }
  return balance;
});

/// Отформатированный баланс для отображения в UI.
final formattedTotalBalanceProvider = Provider<String>((ref) {
  final balance = ref.watch(totalBalanceProvider);
  return formatCompactAmount(balance, useRuLocale: true);
});

class TransactionHistoryNotifier extends StateNotifier<List<Transaction>> {
  TransactionHistoryNotifier() : super([]);

  static List<Transaction> _initialTransactions() {
    return [
      Transaction(
        title: 'Кофе в Starbucks',
        type: TransactionType.expense,
        amount: 5.50,
        date: DateTime.now().subtract(const Duration(hours: 2)),
        description: 'Кофе с собой',
        category: 'Еда',
      ),
      Transaction(
        title: 'Обед в ресторане',
        type: TransactionType.expense,
        amount: 25.0,
        date: DateTime.now().subtract(const Duration(hours: 4)),
        description: 'Обед с коллегой',
        category: 'Еда',
      ),
      Transaction(
        title: 'Такси до работы',
        type: TransactionType.expense,
        amount: 12.0,
        date: DateTime.now().subtract(const Duration(hours: 6)),
        description: 'Утреннее такси',
        category: 'Транспорт',
      ),
      Transaction(
        title: 'Продукты в супермаркете',
        type: TransactionType.expense,
        amount: 45.0,
        date: DateTime.now().subtract(const Duration(days: 1)),
        description: 'Еженедельные покупки',
        category: 'Еда',
      ),
      Transaction(
        title: 'Бензин',
        type: TransactionType.expense,
        amount: 30.0,
        date: DateTime.now().subtract(const Duration(days: 1)),
        description: 'Заправка автомобиля',
        category: 'Транспорт',
      ),
      Transaction(
        title: 'Зарплата',
        type: TransactionType.income,
        amount: 2500.0,
        date: DateTime.now().subtract(const Duration(days: 2)),
        description: 'Месячная зарплата',
        category: null,
      ),
      Transaction(
        title: 'Книги для работы',
        type: TransactionType.expense,
        amount: 80.0,
        date: DateTime.now().subtract(const Duration(days: 3)),
        description: 'Техническая литература',
        category: 'Образование',
      ),
    ];
  }

  void addTransaction(
    String title,
    TransactionType type,
    double amount,
    DateTime date,
    String description,
    String? category,
  ) {
    final trimmedTitle = title.trim();
    if (trimmedTitle.isEmpty || amount <= 0) return;

    final newTransaction = Transaction(
      title: trimmedTitle,
      type: type,
      amount: amount,
      date: date,
      description: description.trim(),
      category: category,
    );

    state = [...state, newTransaction];
  }

  void clear() {
    state = const [];
  }
}

