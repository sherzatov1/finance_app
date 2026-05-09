import 'package:finance_app/features/application/goal_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainStatusCard extends ConsumerWidget {
  const MainStatusCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final target = ref.watch(totalTargetProvider);
    final saved = ref.watch(totalSavedProvider);

    final progress = target == 0 ? 0.0 : (saved / target).clamp(0.0, 1.0);
    final remaining = target - saved;

    return Container(
  padding: const EdgeInsets.all(20),
  decoration: BoxDecoration(
    gradient: const LinearGradient(
      colors: [Color(0xFF2A2A2A), Color(0xFF1E1E1E)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(24),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.4),
        blurRadius: 10,
        offset: const Offset(0, 5),
      ),
    ],
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // 🔹 Заголовок
      const Text(
        'Ваш прогресс',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 14,
        ),
      ),

      const SizedBox(height: 10),

      // 🔥 Главное число
      Text(
        '\$${saved.toStringAsFixed(0)}',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),

      const SizedBox(height: 4),

      Text(
        'из \$${target.toStringAsFixed(0)}',
        style: const TextStyle(color: Colors.grey),
      ),

      const SizedBox(height: 16),

      // 🚀 Прогресс бар
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: LinearProgressIndicator(
          value: progress,
          minHeight: 8,
          backgroundColor: Colors.grey.shade800,
          valueColor: const AlwaysStoppedAnimation(Color(0xFF4CAF50)),
        ),
      ),

      const SizedBox(height: 12),

      // 🔻 Нижняя строка
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Осталось',
            style: TextStyle(color: Colors.grey.shade400),
          ),
          Text(
            '\$${remaining.toStringAsFixed(0)}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ],
  ),
);
  }}
