import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../left_screen_finance/expense_control/expense_model.dart';

class BudgetsNotifier extends StateNotifier<List<BudgetCategory>> {
  BudgetsNotifier() : super([
    BudgetCategory(
      id: '1',
      name: 'Еда',
      title: '🍔 Еда',
      plannedAmount: 300.0,
      spentAmount: 250.0,
      month: DateTime.now(),
    ),
    BudgetCategory(
      id: '2',
      name: 'Транспорт',
      title: '🚗 Транспорт',
      plannedAmount: 100.0,
      spentAmount: 80.0,
      month: DateTime.now(),
    ),
    BudgetCategory(
      id: '3',
      name: 'Развлечения',
      title: '🎬 Развлечения',
      plannedAmount: 150.0,
      spentAmount: 200.0,
      month: DateTime.now(),
    ),
  ]);

  void addCategory(BudgetCategory category) {
    state = [...state, category];
  }

  void removeCategory(String id) {
    state = state.where((c) => c.id != id).toList();
  }

  void updateSpent(String id, double spent) {
    state = [
      for (final category in state)
        category.id == id 
          ? category.copyWith(spentAmount: spent) 
          : category,
    ];
  }
}

final budgetsProvider = StateNotifierProvider<BudgetsNotifier, List<BudgetCategory>>((ref) => BudgetsNotifier());

final totalPlannedProvider = Provider<double>((ref) {
  final budgets = ref.watch(budgetsProvider);
  return budgets.fold<double>(0.0, (sum, cat) => sum + cat.plannedAmount);
});

final totalSpentProvider = Provider<double>((ref) {
  final budgets = ref.watch(budgetsProvider);
  return budgets.fold<double>(0.0, (sum, cat) => sum + cat.spentAmount);
});

final totalOverrunProvider = Provider<double>((ref) {
  final budgets = ref.watch(budgetsProvider);
  return budgets.fold<double>(0.0, (sum, cat) => sum + cat.overrun);
});

final selectedCategoryProvider = StateProvider<String?>((ref) => null);

