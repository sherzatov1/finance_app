import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'goal_model.dart';

class GoalsNotifier extends StateNotifier<List<Goal>> {
  GoalsNotifier() : super([
    Goal(
      id: '1',
      name: 'PlayStation 5',
      title: '🎮 PlayStation 5',
      targetAmount: 500.0,
      currentAmount: 300.0,
      targetDate: DateTime(2024, 12, 31),
    ),
    Goal(
      id: '2',
      name: 'Новый ноутбук',
      title: '💻 Ноутбук MacBook',
      targetAmount: 2000.0,
      currentAmount: 500.0,
      targetDate: DateTime(2025, 6, 30),
    ),
    Goal(
      id: '3',
      name: 'Отпуск на море',
      title: '🏖️ Отпуск',
      targetAmount: 2500.0,
      currentAmount: 1200.0,
      targetDate: DateTime(2025, 3, 15),
    ),
  ]);

  void addGoal(Goal goal) {
    state = [...state, goal];
  }

  void removeGoal(String id) {
    state = state.where((g) => g.id != id).toList();
  }

  void updateCurrentAmount(String id, double amount) {
    state = [
      for (final goal in state)
        goal.id == id 
          ? goal.copyWith(currentAmount: amount) 
          : goal,
    ];
  }
}

final goalsProvider = StateNotifierProvider<GoalsNotifier, List<Goal>>((ref) => GoalsNotifier());

final totalTargetProvider = Provider<double>((ref) {
  final goals = ref.watch(goalsProvider);
  return goals.fold<double>(0.0, (sum, goal) => sum + goal.targetAmount);
});

final totalSavedProvider = Provider<double>((ref) {
  final goals = ref.watch(goalsProvider);
  return goals.fold<double>(0.0, (sum, goal) => sum + goal.currentAmount);
});

final selectedGoalProvider = StateProvider<String?>((ref) => null);

