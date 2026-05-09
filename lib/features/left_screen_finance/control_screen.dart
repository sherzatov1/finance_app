import 'package:finance_app/features/left_screen_finance/dolgi/dolg.dart';
import 'package:finance_app/features/left_screen_finance/plan_and_savings/plan_screen.dart';
import 'package:finance_app/features/left_screen_finance/expense_control/expense_control_sheet.dart';
import 'package:flutter/material.dart';


/// Экран "Контроль расходов"
/// Кнопка-контейнер, при нажатии открывает bottom sheet
class ControlScreen extends StatefulWidget {
  const ControlScreen({super.key});

  @override
  State<ControlScreen> createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Финансовая курилка', style: TextStyle(color: Colors.white, fontSize: 18),),
        backgroundColor: const Color(0xFF1C1C1E),
      ),
      backgroundColor: const Color(0xFF232323),
      body: Column(
        children: [
          const SizedBox(height: 20),
          
          // === КОНТЕЙНЕР "КОНТРОЛЬ РАСХОДОВ" ===
          // При нажатии открывает bottom sheet
          GestureDetector(
            onTap: () => showExpenseControlSheet(context),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFF1C1C1E),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Иконка
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFF706BFF).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.account_balance_wallet,
                      color: Color(0xFF706BFF),
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  
                  // Текст
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Контроль расходов',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Нажмите для подробностей',
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Стрелка
                  const Icon(
                    Icons.chevron_right,
                    color: Colors.white54,
                    size: 28,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
          PlanScreen(),
          SizedBox(height: 20,),
          const Dolg(),
        ],
      ),
    );
  }
}
