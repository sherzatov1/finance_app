import 'package:finance_app/features/card_fin_home_screen/card_finance.dart';
import 'package:finance_app/features/card_fin_home_screen/finance_card.dart';
import 'package:finance_app/features/card_fin_home_screen/transaction_history_list.dart';
import 'package:finance_app/features/left_screen_finance/control_screen.dart';
import 'package:finance_app/features/right_screen_finance/right_screen_finance.dart';
import 'package:flutter/material.dart';

class HomeScreenFinance extends StatefulWidget {
  const HomeScreenFinance({super.key});

  @override
  State<HomeScreenFinance> createState() => _HomeScreenFinanceState();
}

class _HomeScreenFinanceState extends State<HomeScreenFinance> {
  // 🔥 стартуем с главной (центр)
  int _index = 1;

  late final PageController _controller =
      PageController(initialPage: 1);

  void _onTap(int i) {
    setState(() => _index = i);
    _controller.animateToPage(
      i,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF232323),

      body: PageView(
        controller: _controller,
        onPageChanged: (i) => setState(() => _index = i),
        children: [
          // 🔴 0 — Финансы (слева)
          const ControlScreen(),

          // 🟢 1 — Главная (центр)
          Column(
            children: [
              CardFinance(
                child: const Column(
                  children: [
                    SizedBox(height: 40),
                    FinanceCard(),
                  ],
                ),
              ),
              const Expanded(
                child: TransactionHistoryList(),
              ),
            ],
          ),

          // 🔵 2 — Статистика (справа)
          const RightScreenFinance(),
        ],
      ),

      // 🔵 НИЖНИЙ БАР
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: _onTap,
        backgroundColor: const Color(0xFF1C1C1E),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.sell),
            label: "Финансы",
          ),

          // 🔥 центр выделен
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFF706BFF),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.home, color: Colors.white),
            ),
            label: "Главная",
          ),

          const BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: "Статистика",
          ),
        ],
      ),
    );
  }
}