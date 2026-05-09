import 'package:finance_app/features/left_screen_finance/dolgi/dolg_sheet/dolg_sheet_screen.dart';
import 'package:flutter/material.dart';

class Dolg extends StatefulWidget {
  const Dolg({super.key});

  @override
  State<Dolg> createState() => _DolgState();
}

class _DolgState extends State<Dolg> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
            onTap: () {
              showDolgSheetScreen(context);
            },
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
                      Icons.money_off,
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
                          'Долги',
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
          );
  }
}