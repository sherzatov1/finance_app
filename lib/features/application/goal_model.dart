class Goal {
  final String id;
  final String name;
  final String title;
  final double targetAmount;
  final double currentAmount;
  final DateTime targetDate;

  Goal({
    required this.id,
    required this.name,
    required this.title,
    required this.targetAmount,
    this.currentAmount = 0.0,
    required this.targetDate,
  });

  Goal copyWith({
    String? id,
    String? name,
    String? title,
    double? targetAmount,
    double? currentAmount,
    DateTime? targetDate,
  }) {
    return Goal(
      id: id ?? this.id,
      name: name ?? this.name,
      title: title ?? this.title,
      targetAmount: targetAmount ?? this.targetAmount,
      currentAmount: currentAmount ?? this.currentAmount,
      targetDate: targetDate ?? this.targetDate,
    );
  }

  double get progress => targetAmount == 0 ? 0.0 : (currentAmount / targetAmount).clamp(0.0, 1.0);
}
