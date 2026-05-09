import 'package:flutter/material.dart';

/// =============================================================================
/// 📉 ТРЕНДЫ — НЕДЕЛЯ К НЕДЕЛЕ
/// =============================================================================
/// Показывает динамику расходов за последние 7 дней
///
/// TODO:
/// - Группировка транзакций по дням (date.weekday)
/// - Вычисление суммы расходов за каждый день
/// - Вычисление процента изменения (текущая неделя vs прошлая)
/// - Добавить выбор: неделя / месяц / квартал
/// - Tooltip при нажатии на столбик (сумма за день)
/// =============================================================================

class StatTrends extends StatelessWidget {
  const StatTrends({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: заменить на реальные данные из provider
    // Ключ: день недели, значение: сумма расходов
    final mockDailyExpenses = {
      'Пн': 45.0,
      'Вт': 80.0,
      'Ср': 35.0,
      'Чт': 120.0,
      'Пт': 95.0,
      'Сб': 210.0,
      'Вс': 60.0,
    };

    final maxValue = mockDailyExpenses.values.reduce((a, b) => a > b ? a : b);
    final totalWeek = mockDailyExpenses.values.reduce((a, b) => a + b);
    // TODO: вычислять реальный процент изменения
    const weekChangePercent = 18;
    const isGrowing = true;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Тренды расходов',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: isGrowing
                    ? Colors.red.withValues(alpha: 0.15)
                    // ignore: dead_code
                    : Colors.green.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    // ignore: dead_code
                    isGrowing ? Icons.trending_up : Icons.trending_down,
                    // ignore: dead_code
                    color: isGrowing ? Colors.red : Colors.green,
                    size: 14,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    // ignore: dead_code
                    '${isGrowing ? '+' : ''}$weekChangePercent% за неделю',
                    style: TextStyle(
                      // ignore: dead_code
                      color: isGrowing ? Colors.red : Colors.green,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Всего за неделю: \$${totalWeek.toStringAsFixed(0)}',
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 20),

        /// ГРАФИК — СТОЛБИКИ ПО ДНЯМ НЕДЕЛИ
        SizedBox(
          height: 140,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: mockDailyExpenses.entries.map((entry) {
              final percent = maxValue > 0 ? entry.value / maxValue : 0.0;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      /// ЗНАЧЕНИЕ НАД СТОЛБИКОМ
                      Text(
                        '\$${entry.value.toStringAsFixed(0)}',
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(height: 6),

                      /// СТОЛБИК (анимированный — TODO)
                      Container(
                        width: double.infinity,
                        height: 80 * percent,
                        decoration: BoxDecoration(
                          color: const Color(0xFF706BFF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(height: 8),

                      /// ДЕНЬ НЕДЕЛИ
                      Text(
                        entry.key,
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

