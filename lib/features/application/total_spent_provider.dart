import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'analytics_category_provider.dart';

/// Deprecated: используйте [totalExpensesProvider] из analytics_category_provider
/// 
/// Оставлена для обратной совместимости. Переходите на [totalExpensesProvider].
final totalSpentProvider = Provider<double>((ref) {
  return ref.watch(totalExpensesProvider);
});