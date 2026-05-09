/// Чистая функция для сокращённого форматирования сумм.
///
/// Примеры:
/// - 1000     → 1K
/// - 15000    → 15K
/// - 1000000  → 1M / 1 млн
/// - 2500000  → 2.5M
/// - 999      → 999
String formatCompactAmount(double amount, {bool useRuLocale = true}) {
  if (amount < 1000) {
    return amount.toStringAsFixed(amount.truncateToDouble() == amount ? 0 : 2);
  }

  if (amount < 1000000) {
    final value = amount / 1000;
    final suffix = useRuLocale ? ' тыс' : 'K';
    return '${_formatValue(value)}$suffix';
  }

  if (amount < 1000000000) {
    final value = amount / 1000000;
    final suffix = useRuLocale ? ' млн' : 'M';
    return '${_formatValue(value)}$suffix';
  }

  final value = amount / 1000000000;
  final suffix = useRuLocale ? ' млрд' : 'B';
  return '${_formatValue(value)}$suffix';
}

/// Убирает лишние нули после запятой.
String _formatValue(double value) {
  final rounded = value.toStringAsFixed(1);
  if (rounded.endsWith('.0')) {
    return value.toInt().toString();
  }
  return rounded;
}
