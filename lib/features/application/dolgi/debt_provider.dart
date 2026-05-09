import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'debt_model.dart';

class DebtsNotifier extends StateNotifier<List<Debt>> {
  DebtsNotifier() : super([
    Debt(
      id: '1',
      name: 'Кредит на авто',
      title: 'Автокредит',
      amount: 800.0,
      paidAmount: 200.0,
      dueDate: DateTime(2024, 12, 31),
    ),
    Debt(
      id: '2',
      name: 'Кредитная карта',
      title: 'Кредитка Visa',
      amount: 400.0,
      paidAmount: 100.0,
      dueDate: DateTime(2024, 11, 15),
    ),
  ]);

  void addDebt(Debt debt) {
    state = [...state, debt];
  }

  void removeDebt(String id) {
    state = state.where((d) => d.id != id).toList();
  }

  void deleteDebt(String id) => removeDebt(id);

  void updatePaidAmount(String id, double paid) {
    state = [
      for (final debt in state)
        debt.id == id 
          ? debt.copyWith(paidAmount: paid) 
          : debt,
    ];
  }
}

final debtsProvider = StateNotifierProvider<DebtsNotifier, List<Debt>>((ref) => DebtsNotifier());

final totalDebtProvider = Provider<double>((ref) {
  final debts = ref.watch(debtsProvider);
  return debts.fold<double>(0.0, (sum, debt) => sum + debt.amount);
});

final totalPaidProvider = Provider<double>((ref) {
  final debts = ref.watch(debtsProvider);
  return debts.fold<double>(0.0, (sum, debt) => sum + debt.paidAmount);
});

final selectedDebtProvider = StateProvider<String?>((ref) => null);


