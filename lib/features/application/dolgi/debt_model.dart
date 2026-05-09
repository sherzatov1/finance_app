class Debt {
  final String id;
  final String name;
  final String title;
  final double amount;
  final double paidAmount;
  final DateTime dueDate;

  Debt({
    required this.id,
    required this.name,
    required this.title,
    required this.amount,
    this.paidAmount = 0.0,
    required this.dueDate,
  });

  double get totalAmount => amount - paidAmount;

  Debt copyWith({
    String? id,
    String? name,
    String? title,
    double? amount,
    double? paidAmount,
    DateTime? dueDate,
  }) {
    return Debt(
      id: id ?? this.id,
      name: name ?? this.name,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      paidAmount: paidAmount ?? this.paidAmount,
      dueDate: dueDate ?? this.dueDate,
    );
  }

  double get remainingAmount => amount - paidAmount;
}
