import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finance_app/features/application/goal_provider.dart';
import 'package:finance_app/features/application/goal_model.dart';

class HeroGoalCard extends ConsumerWidget {
  const HeroGoalCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  final selectedId = ref.watch(selectedGoalProvider);
  final goals = ref.watch(goalsProvider);
  Goal selectedGoal;
  if (selectedId != null && goals.isNotEmpty) {
    selectedGoal = goals.firstWhere(
      (g) => g.id == selectedId,
      orElse: () => goals[0],
    );
  } else if (goals.isNotEmpty) {
    selectedGoal = goals[0];
  } else {
    return const SizedBox(); // no goals
  }

  final progress = selectedGoal.progress.clamp(0.0, 1.0);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF706BFF).withOpacity(0.1),
            Colors.transparent,
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF706BFF).withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF706BFF).withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF706BFF).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.star,
                  color: Color(0xFF706BFF),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedGoal.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${selectedGoal.currentAmount.toStringAsFixed(0)} / \$${selectedGoal.targetAmount.toStringAsFixed(0)}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: Colors.grey.shade800,
              valueColor: const AlwaysStoppedAnimation(Color(0xFF706BFF)),
            ),
          ),
        ],
      ),
    );
  }
}
