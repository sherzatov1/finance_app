
import 'package:flutter/material.dart';

import 'widgets/stat_summary_header.dart';
import 'widgets/stat_category_chart.dart';

import 'widgets/stat_trends.dart';





/// =============================================================================
/// ГЛАВНЫЙ ЭКРАН СТАТИСТИКИ (right_screen_finance)
/// =============================================================================
/// ЭТОТ ФАЙЛ — ТОЛЬКО UI. Вся логика (Riverpod providers, AI-анализ,
/// вычисления) будет добавлена позже по мере готовности бэкенда.
///
/// TODO:
/// - Подключить фильтрацию по периодам (День/Неделя/Месяц) через StateProvider
/// - Заменить все mock-данные на реальные из transactionHistoryProvider
/// - Добавить pull-to-refresh для обновления аналитики
/// =============================================================================

class RightScreenFinance extends StatelessWidget {
  const RightScreenFinance({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF232323),
      appBar: AppBar(
        backgroundColor: const Color(0xFF232323),
        title: const Text('Статистика'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// TODO: Подключить динамическую смену периода через StateProvider
              
              const SizedBox(height: 20),

              /// 💰 1. Общие расходы и доходы — базовая сводка
              /// TODO: подключить totalBalanceProvider, income/expense providers
              const StatSummaryHeader(),
              
              const SizedBox(height: 24),

              /// 🔥 2. Финансовый рейтинг (0–10)
              /// TODO: формула рейтинга на основе накоплений/соотношения доход-расход
              /// 
              

              /// 📊 3. Категории расходов — самое важное
              /// TODO: заменить mock-данные на реальные из provider с категориями
              const StatCategoryChart(),
              const SizedBox(height: 24),

              /// 🤖 4. AI Инсайты — ответы на 3 вопроса:
              ///    1. Что происходит с деньгами?
              ///    2. Это нормально или плохо?
              ///    3. Что мне делать?
              /// TODO: AI-анализ — сравнение с историей, поиск аномалий, генерация советов
              
              const SizedBox(height: 24),

              /// 📉 5. Тренды — неделя к неделе
              /// TODO: группировка транзакций по дням/неделям, расчёт динамики
              const StatTrends(),
              const SizedBox(height: 24),

              /// ⏳ 6. Прогнозирование — когда закончатся деньги
              /// TODO: линейная экстраполяция на основе средних расходов
              
              const SizedBox(height: 24),

              /// 💡 7. Поведенческий анализ — когда/во сколько тратит пользователь
              /// TODO: анализ часа и дня недели транзакций
             
              const SizedBox(height: 24),

              /// 💳 8. Подписки и регулярные платежи
              /// TODO: выделение регулярных платежей по паттерну названий
              
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

/// =============================================================================
/// ВИДЖЕТ ВЫБОРА ПЕРИОДА (День / Неделя / Месяц)
/// =============================================================================
/// TODO: сделать интерактивным — переключение через StateProvider,
/// фильтрация всех нижних виджетов по выбранному периоду.
/// =============================================================================
