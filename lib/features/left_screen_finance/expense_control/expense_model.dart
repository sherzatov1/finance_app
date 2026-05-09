class BudgetCategory {
  final String id;
  final String name;
  final String title;
  final double plannedAmount;
  final double spentAmount;
  final DateTime month;

  BudgetCategory({
    required this.id,
    required this.name,
    required this.title,
    required this.plannedAmount,
    this.spentAmount = 0.0,
    required this.month,
  });

  BudgetCategory copyWith({
    String? id,
    String? name,
    String? title,
    double? plannedAmount,
    double? spentAmount,
    DateTime? month,
  }) {
    return BudgetCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      title: title ?? this.title,
      plannedAmount: plannedAmount ?? this.plannedAmount,
      spentAmount: spentAmount ?? this.spentAmount,
      month: month ?? this.month,
    );
  }

  double get overrun => (spentAmount - plannedAmount).clamp(0.0, double.infinity);
  double get progress => plannedAmount > 0 ? (spentAmount / plannedAmount).clamp(0.0, 1.0) : 0.0;
}
