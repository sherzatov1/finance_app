import 'package:flutter/material.dart';
import 'widgets/main_status_card.dart';
import 'widgets/debt_list.dart';
import 'widgets/next_payment_card.dart';

import 'widgets/quick_actions.dart';

class DolgSheetScreen extends StatefulWidget {
  const DolgSheetScreen({super.key});

  @override
  State<DolgSheetScreen> createState() => _DolgSheetScreenState();
}

void showDolgSheetScreen(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => const DolgSheetScreen(),
  );
}

class _DolgSheetScreenState extends State<DolgSheetScreen> {
  static const Color surfaceColor = Color(0xFF1C1C1E);
  static const Color textPrimary = Colors.white;
 

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) => Container(
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Индикатор
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // Заголовок
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Долги',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Главный статус
              const MainStatusCard(),
              const SizedBox(height: 24),
              // Список долгов
              Text(
                'Список долгов',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              const DebtList(),
              const SizedBox(height: 24),
              // Ближайший платёж
              const NextPaymentCard(),
              const SizedBox(height: 24),
              // Инсайт
              
              const SizedBox(height: 32),
              // Быстрые действия
              const QuickActions(),
              const SizedBox(height: 24),
              // Нижняя ссылка
             
            ],
          ),
        ),
      ),
    );
  }
}

